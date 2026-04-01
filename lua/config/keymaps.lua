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

-- Toggle Pyright LSP on/off
vim.keymap.set("n", "<leader>lp", function()
  local clients = vim.lsp.get_active_clients()
  local pyright_running = false
  for _, client in ipairs(clients) do
    if client.name == "pyright" then
      pyright_running = true
      client.stop()
      vim.notify("Pyright stopped", vim.log.levels.INFO)
      break
    end
  end
  if not pyright_running then
    vim.lsp.start({
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
    })
    vim.notify("Pyright started", vim.log.levels.INFO)
  end
end, { desc = "Toggle Pyright LSP" })

-- LSP rename
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename" })
  end,
})

-- Half-page jumps with cursor centering
vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = "Half page down and center" })
vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = "Half page up and center" })

