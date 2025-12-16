return {
  -- DAP (Debug Adapter Protocol) core
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
        },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },

      -- Virtual text for debugging
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- Python debugging support
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
          -- Setup debugpy path
          local debugpy_path = vim.fn.exepath("debugpy-adapter")
          if debugpy_path == "" then
            debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
          end
          require("dap-python").setup(debugpy_path)
        end,
      },
    },

    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },

    config = function()
      local dap = require("dap")

      -- Configure icons
      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DiagnosticHint", linehl = "debugPC", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "⭕", texthl = "DiagnosticError", linehl = "", numhl = "" })

      -- Docker attach configuration for Python
      dap.configurations.python = dap.configurations.python or {}
      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach to Docker container",
        connect = {
          host = function()
            return vim.fn.input("Host [localhost]: ", "localhost")
          end,
          port = function()
            return tonumber(vim.fn.input("Port [5678]: ", "5678"))
          end,
        },
        pathMappings = {
          {
            localRoot = function()
              return vim.fn.input("Local code folder: ", vim.fn.getcwd(), "file")
            end,
            remoteRoot = function()
              return vim.fn.input("Container code folder: ", "/app", "file")
            end,
          },
        },
      })
    end,
  },
}
