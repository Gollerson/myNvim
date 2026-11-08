return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {},
    keys = {
      { "<leader>um", function() require("render-markdown").toggle() end, desc = "Toggle Markdown render" },
    },
  },
}
