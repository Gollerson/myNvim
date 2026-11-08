local M = {}

local state_file = vim.fn.stdpath("state") .. "/colorscheme"

function M.get_saved()
  local f = io.open(state_file, "r")
  if not f then
    return nil
  end
  local ok, name = pcall(vim.json.decode, f:read("*a"))
  f:close()
  return ok and name or nil
end

-- Colorscheme plugins are lazy-loaded, so a scheme can be listed by the picker
-- (Snacks globs colors/* across unloaded plugin dirs) while its plugin is not on
-- the runtimepath yet. Find and load the owning plugin before applying.
local function load_colorscheme_plugin(name)
  if #vim.fn.globpath(vim.o.runtimepath, "colors/" .. name .. ".{vim,lua}", false, true) > 0 then
    return
  end
  local spec = require("lazy.core.config").spec
  for _, plugin in pairs(spec.plugins) do
    if not plugin._.loaded and plugin.dir then
      if #vim.fn.globpath(plugin.dir, "colors/" .. name .. ".{vim,lua}", false, true) > 0 then
        require("lazy").load({ plugins = { plugin.name } })
        return
      end
    end
  end
end

function M.set(name)
  if not name or name == "" then
    return
  end
  load_colorscheme_plugin(name)
  if not pcall(vim.cmd.colorscheme, name) then
    vim.notify("Unknown colorscheme: " .. tostring(name), vim.log.levels.WARN)
    return
  end
  vim.fn.mkdir(vim.fn.stdpath("state"), "p")
  local f = io.open(state_file, "w")
  if f then
    f:write(vim.json.encode(name))
    f:close()
  end
end

function M.apply(default)
  pcall(vim.cmd.colorscheme, M.get_saved() or default)
end

--- Open the colorscheme picker and persist the selection.
function M.pick()
  Snacks.picker.colorschemes({
    confirm = function(picker, item)
      picker:close()
      if item then
        -- Stop the previewer's WinClosed handler from restoring the previous
        -- scheme when the picker window closes.
        picker.preview.state.colorscheme = nil
        local name = item.text
        vim.schedule(function()
          M.set(name)
        end)
      end
    end,
  })
end

return M