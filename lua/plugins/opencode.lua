return {
  "sudo-tee/opencode.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    preferred_picker = "snacks",
    preferred_completion = "blink",
    default_global_keymaps = true,
    default_mode = "build",
    keymap_prefix = "<leader>o",
    opencode_executable = "opencode",

    ui = {
      enable_treesitter_markdown = true,
      position = "right",
      input_position = "bottom",
      window_width = 0.40,
      display_model = true,
      display_context_size = true,
      display_cost = true,
      persist_state = true,
      icons = {
        preset = "nerdfonts",
      },
    },

    context = {
      enabled = true,
      current_file = {
        enabled = true,
        show_full_path = true,
      },
      selection = {
        enabled = true,
      },
      diagnostics = {
        info = false,
        warning = true,
        error = true,
        only_closest = false,
      },
    },
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },
    "saghen/blink.cmp",
    "folke/snacks.nvim",
  },
}
