return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      -- Persist the chosen colorscheme across restarts
      { "<leader>uC", function() require("config.colorscheme").pick() end, desc = "Colorscheme with Preview" },
    },
  },
}
