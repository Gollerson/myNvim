-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Debugging shortcuts using F-keys (standard across most debuggers)
vim.keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F9>", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<S-F5>", function() require("dap").terminate() end, { desc = "Debug: Stop" })
