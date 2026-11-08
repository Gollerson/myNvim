-- codevoice.nvim
-- Pushes the live editor context (buffer, cursor, selection, diagnostics) to
-- the local codevoice daemon and toggles the voice session.
local function default_url()
  if vim.uv.fs_stat("/.dockerenv") then
    return "http://host.docker.internal:8765"
  end
  return "http://127.0.0.1:8765"
end

local url = vim.g.codevoice_url or default_url()
local root = vim.fn.expand(vim.g.codevoice_root or vim.fn.getcwd())

local function post(path, body)
  vim.fn.jobstart({
    "curl",
    "-sS",
    "-m",
    "3",
    "-X",
    "POST",
    url .. path,
    "-H",
    "Content-Type: application/json",
    "-d",
    vim.json.encode(body),
  }, { stdout_buffered = false, stderr_buffered = false })
end

local function post_status(path, body)
  local out = vim.fn.system({
    "curl",
    "-sS",
    "-m",
    "3",
    "-o",
    "/dev/null",
    "-w",
    "%{http_code}",
    "-X",
    "POST",
    url .. path,
    "-H",
    "Content-Type: application/json",
    "-d",
    vim.json.encode(body),
  })
  return tonumber(out) or 0
end

local function denied(file)
  local name = vim.fn.fnamemodify(file, ":t")
  return name == ".env"
    or name:match("%.env%.")
    or name:match("%.pem$")
    or name:match("%.key$")
    or name:match("id_rsa")
    or name:match("credential")
    or name:match("secret")
end

local function mode_name()
  local mode = vim.fn.mode(1)
  if mode:sub(1, 1) == "i" then
    return "insert"
  elseif mode:match("[vV\22]") then
    return "visual"
  elseif mode:sub(1, 1) == "R" then
    return "replace"
  end
  return "normal"
end

local severity = { [1] = "error", [2] = "warning", [3] = "info", [4] = "hint" }
local pending_selection = nil

local function visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  if start_pos[1] == 0 or end_pos[1] == 0 or start_pos[1] ~= vim.api.nvim_get_current_buf() then
    return nil
  end
  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]
  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end
  local lines = vim.api.nvim_buf_get_text(
    0,
    start_line - 1,
    start_col - 1,
    end_line - 1,
    end_col,
    {}
  )
  return table.concat(lines, "\n")
end

local function push_context()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" or not vim.startswith(file, root) or denied(file) then
    return
  end
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local total = vim.api.nvim_buf_line_count(0)
  local first = math.max(1, line - 200)
  local last = math.min(total, line + 200)
  local buffer = vim.api.nvim_buf_get_lines(0, first - 1, last, false)
  local diagnostics = {}
  for _, item in ipairs(vim.diagnostic.get(0)) do
    diagnostics[#diagnostics + 1] = {
      line = item.lnum + 1,
      severity = severity[item.severity] or "info",
      message = item.message,
    }
    if #diagnostics >= 20 then
      break
    end
  end
  local selection = pending_selection
  pending_selection = nil
  post("/context", {
    root = root,
    file = file,
    line = line,
    mode = mode_name(),
    buffer_start = first,
    buffer = buffer,
    selection = selection,
    diagnostics = diagnostics,
  })
end

local timer = vim.uv.new_timer()
local function schedule_push()
  timer:stop()
  timer:start(
    250,
    0,
    vim.schedule_wrap(function()
      push_context()
    end)
  )
end

local group = vim.api.nvim_create_augroup("Codevoice", { clear = true })
vim.api.nvim_create_autocmd(
  { "TextChanged", "TextChangedI", "BufEnter", "CursorHold", "BufWritePost" },
  { group = group, callback = schedule_push }
)
vim.api.nvim_create_autocmd("ModeChanged", {
  group = group,
  callback = function(args)
    local old = args.match:match("^([^:]+):")
    local new = args.match:match(":([^:]+)$")
    if not old or not old:match("[vV\22]") or (new and new:match("[vV\22]")) then
      return
    end
    local selection = visual_selection()
    if selection and selection ~= "" then
      pending_selection = selection
      schedule_push()
    end
  end,
})

local session = false
local read_aloud = false

local function toggle_session()
  local next_state = not session
  local code = post_status("/ptt", { on = next_state })
  if code == 200 then
    session = next_state
    vim.notify("codevoice: " .. (session and "listening" or "off"))
  elseif code == 409 then
    vim.notify("codevoice: daemon is running without --voice", vim.log.levels.WARN)
  else
    vim.notify("codevoice: daemon not reachable at " .. url, vim.log.levels.WARN)
  end
end

local function toggle_read_aloud()
  local next_state = not read_aloud
  local code = post_status("/read_aloud", { on = next_state })
  if code == 200 then
    read_aloud = next_state
    vim.notify("codevoice: read aloud " .. (read_aloud and "on" or "off"))
  else
    vim.notify("codevoice: daemon not reachable", vim.log.levels.WARN)
  end
end

local function stop_speech()
  post("/stop", {})
end

local function focus()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" or not vim.startswith(file, root) then
    return
  end
  local line = vim.api.nvim_win_get_cursor(0)[1]
  post("/focus", { root = root, file = file, line = line })
end

vim.keymap.set("n", "<leader>vj", toggle_session, { desc = "codevoice: voice session" })
vim.keymap.set("n", "<leader>vr", toggle_read_aloud, { desc = "codevoice: read aloud" })
vim.keymap.set("n", "<leader>vx", stop_speech, { desc = "codevoice: stop speech" })
vim.keymap.set("n", "<leader>vc", focus, { desc = "codevoice: send focus" })

vim.api.nvim_create_user_command("CodevoiceContext", push_context, {})
vim.api.nvim_create_user_command("CodevoiceFocus", focus, {})
vim.api.nvim_create_user_command("CodevoiceStop", stop_speech, {})
vim.api.nvim_create_user_command("CodevoiceSession", toggle_session, {})
vim.api.nvim_create_user_command("CodevoiceReadAloud", toggle_read_aloud, {})
vim.api.nvim_create_user_command("CodevoiceSay", function(opts)
  post("/say", { text = opts.args })
end, { nargs = "+" })

-- Prime the daemon with the current buffer as soon as the module loads.
schedule_push()
