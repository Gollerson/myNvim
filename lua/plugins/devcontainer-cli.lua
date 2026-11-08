local devnvim = vim.fn.expand("~/devnvim.sh")

return {
  -- Dev Container CLI integration.
  --
  -- Workflow (start here — the "nice loop"):
  --   <leader>Du  bring the container up *and provision nvim* — the nvim
  --               bin/data volumes + config are mounted and nvim is built into
  --               the volume (delegates to `~/devnvim.sh --no-attach`).
  --   <leader>Dc  connect: attach nvim *inside* the container in a new
  --               Windows Terminal window (delegates to `~/devnvim.sh --attach`),
  --               so LazyVim's LSP stack (pyright / Mason) fires normally and
  --               gd, diagnostics, etc. just work. Opens the current buffer if
  --               it's a real file.
  --   <leader>Ds  exec a bash shell in the container (vertical split)
  --   <leader>De  exec an arbitrary command in the container (prompts)
  --   <leader>Dt  toggle the devcontainer terminal window
  --   <leader>Dd  tear the container down
  --
  -- Leader group: <leader>D (uppercase) — the lowercase <leader>d is the DAP
  -- group. Keys mirror LazyVim conventions (desc => which-key labels).
  {
    "erichlf/devcontainer-cli.nvim",
    dependencies = {
      {
        "akinsho/toggleterm.nvim",
        -- Toggleterm drives the devcontainer terminal windows. We keep it
        -- lazy (only loads when a devcontainer command first spawns a term)
        -- and suppress its global <c-\> toggle, which would collide with
        -- LazyVim's Snacks.terminal bindings (<c-/>/<c-_>). The plugin drives
        -- toggleterm through Terminal:new(), so it never needs open_mapping.
        config = function()
          require("toggleterm").setup({
            open_mapping = false,
            hide_numbers = true,
          })
        end,
        lazy = true,
        keys = {},
      },
    },
    opts = {
      -- Never prompt; "up" just runs.
      interactive = false,
      -- Walk up from cwd to the nearest .devcontainer/ (matches devnvim.sh).
      toplevel = true,
      -- Reuse the existing container across "up" calls for a fast loop;
      -- leave the nvim binary/data volumes intact.
      remove_existing_container = false,
      -- The plugin's default points at the author's private dotfiles repo,
      -- which we do NOT want cloned. "" disables the dotfiles bootstrap
      -- entirely: these containers are provisioned via devcontainer.json
      -- postCreateCommand, not dotfiles.
      dotfiles_repository = "",
      -- Binary invoked when connecting inside the container.
      nvim_binary = "nvim",
      -- Shell used for exec commands inside the container.
      shell = "bash",
    },
    config = function(_, opts)
      require("devcontainer-cli").setup(opts)
      -- Render the <leader>D menu group name nicely in which-key.
      local wk = require("which-key")
      wk.add({ { "<leader>D", group = "devcontainer" } })
    end,
    keys = {
      { "<leader>Du", function()
          require("devcontainer-cli.terminal").spawn(devnvim .. " --no-attach")
        end,
        desc = "Devcontainer: up + provision nvim" },
      { "<leader>Dr", function()
          require("devcontainer-cli.terminal").spawn(devnvim .. " --build --no-attach")
        end,
        desc = "Devcontainer: rebuild + provision nvim" },
      -- Dc is overridden: DevcontainerConnect only spawns external terminals
      -- (tmux/wezterm/alacritty) and hard-quits host nvim (wqa). Instead open a
      -- new Windows Terminal window (GlazeWM tiles it) attaching to the
      -- provisioned nvim inside the container.
      { "<leader>Dc", function()
          local cwd = vim.fn.getcwd()
          local cmd = devnvim .. " --attach"
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
            cmd = cmd .. " " .. vim.fn.shellescape(vim.fn.fnamemodify(bufname, ":."))
          end
          if vim.fn.executable("wt.exe") ~= 1 then
            vim.notify("<leader>Dc needs Windows Terminal (wt.exe)", vim.log.levels.ERROR)
            return
          end
          -- `zsh -ic` (interactive, NOT -l): nvm is loaded from ~/.zshrc, which
          -- a login shell never sources. Without it PATH has no nvm bin dir and
          -- `devcontainer` (npm global) is not found. No `;` anywhere: wt.exe
          -- treats a semicolon as its own command separator and would try to
          -- launch `exec zsh -i` directly. `||` drops to a shell only on error.
          vim.fn.system({
            "wt.exe",
            "-w",
            "new",
            "wsl.exe",
            "-d",
            vim.env.WSL_DISTRO_NAME or "Ubuntu-24.04",
            "--",
            "zsh",
            "-ic",
            "cd " .. vim.fn.shellescape(cwd) .. " && " .. cmd .. " || exec zsh -i",
          })
        end,
        desc = "Devcontainer: connect nvim (new window)" },
      { "<leader>Ds", ":DevcontainerExec cmd='bash' direction='vertical' size='70'<CR>", desc = "Devcontainer: shell (vsplit)" },
      { "<leader>De", ":DevcontainerExec<CR>", desc = "Devcontainer: exec cmd" },
      { "<leader>Dt", "<CMD>DevContainerToggle<CR>", desc = "Devcontainer: toggle term" },
      { "<leader>Dd", ":DevcontainerDown<CR>", desc = "Devcontainer: down" },
    },
  },
}
