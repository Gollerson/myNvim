-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Debugging shortcuts using F-keys (standard across most debuggers)
vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<S-F5>", function()
  require("dap").terminate()
end, { desc = "Debug: Stop" })

-- Half-page jumps with cursor centering
vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = "Half page down and center" })
vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = "Half page up and center" })

-- Helper function to ensure Ollama is running
local function ensure_ollama_running(callback)
  -- Check if ollama is running
  vim.fn.jobstart("pgrep -x ollama", {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        -- Already running, execute callback immediately
        if callback then callback() end
      else
        -- Not running, start it
        vim.notify("Starting Ollama...", vim.log.levels.INFO)
        vim.fn.jobstart("ollama serve", {
          detach = true,
          on_exit = function() end,
        })
        -- Wait 2 seconds for Ollama to start, then execute callback
        vim.defer_fn(function()
          vim.notify("Ollama ready!", vim.log.levels.INFO)
          if callback then callback() end
        end, 2000)
      end
    end,
  })
end

-- Override Avante keybindings to auto-start Ollama
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    -- Override the default Avante ask keybinding
    vim.keymap.set({ "n", "v" }, "<leader>aa", function()
      ensure_ollama_running(function()
        vim.cmd("AvanteAsk")
      end)
    end, { desc = "Avante: Ask AI (auto-start Ollama)" })
  end,
})
