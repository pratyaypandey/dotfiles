# Neovim Key Bindings Reference

## General Navigation
- `<leader>e` - Toggle file explorer (NvimTree)
- `<leader>E` - Focus file explorer
- `<C-s>` - Save file (works in insert and normal mode)

## File Management
- `<leader>e` - Toggle file explorer
- `<leader>E` - Focus file explorer

## Code Formatting
- `<leader>f` - Format buffer
- `:Format` - Format current buffer or selection

## Diagnostics and LSP
- `<leader>xx` - Toggle diagnostics (Trouble)
- `<leader>xX` - Toggle buffer diagnostics (Trouble)
- `<leader>cs` - Toggle symbols (Trouble)
- `<leader>cl` - Toggle LSP definitions/references (Trouble)
- `<leader>xL` - Toggle location list (Trouble)
- `<leader>xQ` - Toggle quickfix list (Trouble)

## Productivity
- `<leader>ht` - Toggle Hardtime (vim habit training)
- `<leader>?` - Show buffer local keymaps (which-key)

## LaTeX Specific
- `<C-l>` - Insert LaTeX line break (`\\`) in .tex files

## UltiSnips Snippets
- `<Tab>` - Expand snippet or jump forward
- `<S-Tab>` - Jump backward in snippet

## Completion
- `<Tab>` - Select next completion item
- `<CR>` - Confirm completion

## Netrw (fallback file explorer)
- `<leader>e` - Toggle horizontal file explorer
- `<leader>E` - Toggle vertical file explorer

## Leader Key
The leader key is set to `<Space>` by default.

## Notes
- Hardtime is enabled by default to improve vim habits
- Arrow keys are disabled in normal, visual, and insert modes
- Use `h`, `j`, `k`, `l` for navigation instead
- Hardtime can be toggled with `<leader>ht` 