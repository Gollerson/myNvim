-- Einfache Remaps für die existierenden LazyVim Keybindings
return {
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      {
        "gj",
        function()
          pcall(vim.cmd, "normal! ]m")
          vim.cmd("normal! zt") -- Zeile nach oben (z-top)
        end,
        desc = "Next function",
      },
      {
        "gk",
        function()
          pcall(vim.cmd, "normal! [m")
          vim.cmd("normal! zt")
        end,
        desc = "Previous function",
      },
      {
        "gJ",
        function()
          pcall(vim.cmd, "normal! ]]")
          vim.cmd("normal! zt")
        end,
        desc = "Next class",
      },
      {
        "gK",
        function()
          pcall(vim.cmd, "normal! [[")
          vim.cmd("normal! zt")
        end,
        desc = "Previous class",
      },
    },
  },
}
