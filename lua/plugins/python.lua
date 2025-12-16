return {
  -- Python LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        ruff_lsp = {
          on_attach = function(client, bufnr)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end,
        },
      },
    },
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "dockerfile",
        "bash",
        "json",
        "yaml",
        "toml",
        "lua",
        "vim",
        "markdown",
      },
    },
  },

  -- Mason for LSP/DAP/Linter installation
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff-lsp",
        "debugpy",
        "black",
        "isort",
      },
    },
  },

  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
      },
    },
  },

  -- Linting with nvim-lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },
}
