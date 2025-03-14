# term.nvim

Stupidly simple togglable terminal for Neovim

## Feaatures

Fullscreen terminal that you can toggle open and closed. The terminal persists
until you exit (or `^D`) the terminal, or exit nvim itself.

Nothing else, really. This is just an opinionated wrapper around `:tab|terminal`.

## Setup

Install example using `lazy.nvim`:

```lua
{
    'cameron-wags/term.nvim',
    lazy = true,
    config = true,
    cmd = {
        'Term',
    }
}
```

This plugin is made with custom keybinds in mind. For example, here are mine:

```lua
vim.keymap.set('n', '<leader>;', vim.cmd 'Term', { desc = 'Terminal - open' })
-- Toggles the terminal closed by hitting semicolon twice in terminal insert mode.
vim.keymap.set('t', ';;', vim.cmd 'TermClose', { remap = false, desc = 'Terminal - close' })
```
