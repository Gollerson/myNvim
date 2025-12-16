# Neovim Python IDE Setup Guide

This Neovim configuration provides a complete Python development environment with debugging, linting, and Docker support.

## Features

- **LSP (Language Server Protocol)**: Pyright for Python type checking and IntelliSense
- **Linting & Formatting**: Ruff for fast Python linting and formatting
- **Debugging**: Full debugging support with nvim-dap and debugpy
- **Docker**: Attach to running Docker containers for debugging
- **Auto-completion**: Intelligent code completion with nvim-cmp
- **File Explorer**: Neo-tree file browser
- **Fuzzy Finding**: Telescope for finding files and searching code
- **Git Integration**: Gitsigns for git status in the gutter
- **Syntax Highlighting**: Treesitter for better syntax highlighting

## Key Bindings

### Leader Key
The leader key is `Space` by default.

### File Navigation
- `<leader>e` - Toggle file explorer
- `<leader>fe` - Focus file explorer
- `<leader>ff` - Find files (fuzzy finder)
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - Show open buffers
- `<leader>fr` - Recent files
- `<leader>fs` - Document symbols
- `<leader>fS` - Workspace symbols

### Debugging
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Set conditional breakpoint
- `<leader>dc` - Continue/Start debugging
- `<leader>di` - Step into
- `<leader>do` - Step out
- `<leader>dO` - Step over
- `<leader>dr` - Toggle REPL
- `<leader>dt` - Terminate debugging session
- `<leader>du` - Toggle debug UI
- `<leader>de` - Evaluate expression under cursor

### Code Actions
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

### Comments
- `gcc` - Toggle comment on current line
- `gc` (visual mode) - Toggle comment on selection

### Window Navigation
- `<C-h>` - Move to left window
- `<C-j>` - Move to window below
- `<C-k>` - Move to window above
- `<C-l>` - Move to right window

## Python Debugging

### Local Debugging
1. Open a Python file
2. Set breakpoints with `<leader>db`
3. Start debugging with `<leader>dc`
4. Use step commands to navigate through code

### Docker Container Debugging

To debug Python code running in a Docker container:

1. **In your Docker container**, modify your Python script to wait for debugger:
```python
import debugpy

# Start debugpy server
debugpy.listen(("0.0.0.0", 5678))
print("Waiting for debugger attach...")
debugpy.wait_for_client()
print("Debugger attached!")

# Your code here
```

2. **Expose the debug port** in your docker-compose.yml or docker run command:
```yaml
ports:
  - "5678:5678"
```

3. **In Neovim**, select the "Attach to Docker container" configuration when starting the debugger
4. Enter the host (default: localhost) and port (default: 5678)
5. Set the local and remote code paths for path mapping

### Example Docker Setup

docker-compose.yml:
```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "5678:5678"  # Debug port
    volumes:
      - .:/app
    command: python app.py
```

Python script with debugpy:
```python
import debugpy

debugpy.listen(("0.0.0.0", 5678))
debugpy.wait_for_client()

# Your application code
def main():
    print("Hello from Docker!")
    # Set breakpoints in Neovim and step through this code

if __name__ == "__main__":
    main()
```

## Ruff Linting and Formatting

Ruff is configured to:
- Lint your Python code on save
- Format your code automatically

To manually format:
- Use the built-in format command: `:lua vim.lsp.buf.format()`

Configure ruff in your project with a `pyproject.toml`:
```toml
[tool.ruff]
line-length = 88
target-version = "py312"

[tool.ruff.lint]
select = ["E", "F", "I"]
```

## First Time Setup

When you first open Neovim, it will:
1. Install all plugins automatically (this may take a few minutes)
2. Install LSP servers, formatters, and linters via Mason

Wait for all installations to complete before using the editor.

## Useful Commands

- `:Mason` - Open Mason to manage LSP servers and tools
- `:Lazy` - Open Lazy plugin manager
- `:checkhealth` - Check Neovim health and configuration
- `:LspInfo` - Show LSP server information
- `:Telescope` - Open Telescope picker

## Troubleshooting

### LSP not working
1. Run `:LspInfo` to check if the server is attached
2. Run `:Mason` to ensure pyright and ruff-lsp are installed
3. Run `:checkhealth` to diagnose issues

### Debugging not working
1. Ensure debugpy is installed: `pipx list`
2. Check DAP configuration: `:lua =require('dap').configurations.python`
3. For Docker debugging, ensure the port is exposed and debugpy is listening

### Plugins not loading
1. Run `:Lazy` to see plugin status
2. Try `:Lazy sync` to update/reinstall plugins
3. Check for errors with `:messages`

## Customization

All configuration files are in `~/.config/nvim/lua/`:
- `config/options.lua` - Editor options
- `config/keymaps.lua` - Custom keybindings
- `plugins/` - Plugin configurations

Add or modify files in these directories to customize your setup.
