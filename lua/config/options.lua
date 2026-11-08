-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs and indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Cursor line
opt.cursorline = false

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
-- Do NOT set g:clipboard to OSC 52: terminals never answer OSC 52 *paste*
-- queries, so "+p waits ~10s and pastes nothing. Instead the
-- devcontainer gets xclip + the host X socket mounted (see ~/devnvim.sh),
-- which gives a real clipboard for both copy and paste.
opt.clipboard:append("unnamedplus")

-- Key timeout
-- LazyVim sets this to 300ms. Pressing <Space> (leader) then pausing longer
-- than that aborts the pending mapping, so space falls back to the default `l`
-- motion and which-key never gets a chance to stay on screen. 1000ms is Vim's
-- default and gives you time to read the popup.
opt.timeoutlen = 1000

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Python provider
vim.g.python3_host_prog = vim.fn.exepath("python3")

-- Colorscheme (persisted: last selected via <leader>uC is remembered)
require("config.colorscheme").apply("tokyonight")
