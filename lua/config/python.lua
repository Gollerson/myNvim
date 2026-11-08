-- Shared Python interpreter resolution for the devcontainer workflow.
--
-- nvim runs inside a devcontainer (launched by ~/devnvim.sh), where the
-- interpreter that owns the repo's dependencies differs per project:
--   * video-analyzer keeps a venv at /home/sxs/.venv (outside the workspace)
--   * people-detection-plugin installs deps into the image's system python
--
-- NOTE: ~/devnvim.sh overrides PATH for the nvim process, so `python3` on
-- PATH is the *system* python, never the venv.
--
-- Resolution order for the project interpreter:
--   1. a `venv`/`.venv` found in the project (walked up from cwd)
--   2. the video-analyzer container venv at /home/sxs/.venv
--   3. `python3` from PATH
local M = {}

local VENV_NAMES = { ".venv", "venv" }

---@return string
function M.detect_python()
  local dir = vim.fn.getcwd()
  while dir ~= "/" and dir ~= "" do
    for _, name in ipairs(VENV_NAMES) do
      local candidate = dir .. "/" .. name .. "/bin/python"
      if vim.fn.executable(candidate) == 1 then
        return candidate
      end
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  -- video-analyzer's Dockerfile creates its venv at $HOME/.venv = /home/sxs/.venv,
  -- which sits outside the bind-mounted workspace root. Absent in other containers.
  local container_venv = "/home/sxs/.venv/bin/python"
  if vim.fn.executable(container_venv) == 1 then
    return container_venv
  end

  local system = vim.fn.exepath("python3")
  return system ~= "" and system or "python3"
end

---@param python string
---@return boolean
function M.has_debugpy(python)
  vim.fn.system({ python, "-c", "import debugpy" })
  return vim.v.shell_error == 0
end

--- Interpreter to use for nvim-dap (must have debugpy installed).
--- Prefers the project interpreter; falls back to the debugpy installed by
--- mason (persisted in the nvim data volume).
---@return string
function M.debug_python()
  local python = M.detect_python()
  if M.has_debugpy(python) then
    return python
  end
  return vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
end

return M
