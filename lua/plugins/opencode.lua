-- OpenCode integration (v2). Neovim attaches to the opencode background
-- service; the chat itself is the real opencode TUI in a split.
-- `--continue` matters: without it the TUI opens its home screen and does not
-- show the session that opencode.nvim is prompting.
local opencode_cmd = "opencode --continue"
local terminal_opts = { win = { position = "right", enter = false } }

return {
  {
    "nickjvandyke/opencode.nvim",
    -- main targets OpenCode v2, which is what runs on the host and in the
    -- devcontainer (see ~/devnvim.sh for the container provisioning).
    dependencies = { "folke/snacks.nvim" },
    init = function()
      -- Must be set before `require("opencode")` reads its config.
      vim.g.opencode_opts = {
        server = {
          -- Only used when no running server is found: launching the TUI also
          -- starts the service. devnvim.sh pre-starts it inside the container.
          start = function()
            require("snacks.terminal").open(opencode_cmd, terminal_opts)
          end,
        },
      }
    end,
    keys = {
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ")
        end,
        mode = { "n", "x" },
        desc = "Ask OpenCode",
      },
      {
        "<leader>os",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Select OpenCode prompt",
      },
      {
        "<leader>ol",
        function()
          return require("opencode").operator("@this") .. "_"
        end,
        mode = "n",
        expr = true,
        desc = "Send line to OpenCode",
      },
      {
        "<leader>or",
        function()
          return require("opencode").operator("@this")
        end,
        mode = { "n", "x" },
        expr = true,
        desc = "Send range to OpenCode",
      },
      {
        "<leader>ot",
        function()
          require("snacks.terminal").toggle(opencode_cmd, terminal_opts)
        end,
        -- Normal mode only on purpose: a <leader> mapping in terminal mode makes
        -- nvim wait timeoutlen after every <Space> typed into the shell (README:
        -- "if you use <leader> here, remove 't'"). From inside the terminal use
        -- <C-\><C-n>, then <leader>ot.
        desc = "Toggle OpenCode TUI",
      },
    },
  },
}
