return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
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
}
