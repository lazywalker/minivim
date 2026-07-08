# minivim

A lightweight IDE-style Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim)
and the [mini.nvim](https://github.com/echasnovski/mini.nvim) ecosystem. Designed
for Neovim 0.11+ (uses the new `vim.lsp.config` / `vim.lsp.enable` LSP API).

## Install

Requires Neovim 0.11+ and a Nerd Font (FantasqueSansM Nerd Font is the default).

```sh
# Arch Linux
paru -S neovim ttf-fantasque-nerd

# back up any existing config, then:
git clone https://github.com/lazywalker/minivim.git ~/.config/nvim
nvim  # plugins auto-install on first launch
```

Open `nvim` and run `:checkhealth` once plugins are installed.

## Structure

```
init.lua                  entry: options → keymaps → autocommands → lazy.nvim
lua/
  options.lua             vim.opt settings
  keymaps.lua             global keymaps (leader = Space)
  autocommands.lua        filetype rules, yank highlight, etc.
  matugen.lua             Noctalia-generated colors (gitignored, see below)
  plugins/
    alpha.lua             startup dashboard
    base16.lua            base16 colorscheme (gitignored, Noctalia-managed)
    cmp.lua               completion (nvim-cmp + LuaSnip)
    comment.lua           mini.comment
    git.lua               vgit.nvim
    highlight.lua         treesitter, rainbow, vim-illuminate, log-highlight
    lsp.lua               mason + nvim-lspconfig (Neovim 0.11+ API)
    navigation.lua        nvim-tree, bufferline
    telescope.lua         fuzzy finder
    ui.lua                catppuccin, mini.indentscope, mini.statusline, mini.icons
    which-key.lua         keymap hints
```

## Theming

Two layers cooperate:

1. **catppuccin** loads at startup as the default colorscheme (`lazy = false`).
2. **base16 + matugen** — when [Noctalia](https://github.com/noctalia) is the
   desktop shell, it renders `lua/matugen.lua` and creates `lua/plugins/base16.lua`
   from its neovim community template, then signals nvim via `SIGUSR1` to hot-reload
   colors without restarting.

Both `matugen.lua` and `base16.lua` are gitignored (Noctalia-managed); on a fresh
checkout without Noctalia, only catppuccin applies.

## LSP

Servers are configured with the Neovim 0.11+ API. `lua_ls` is set up with the nvim
runtime on its workspace path and recognizes `vim`/`hl` globals, so editing this
config (and Hyprland's `.lua` files) gets full completion. `rust_analyzer` is also
wired up. Install more servers via `:Mason`.

## Keymaps (leader = Space)

| Key | Action |
|-----|--------|
| `<leader>e` | toggle file explorer |
| `<leader>ff` | find files (Telescope) |
| `<leader>ft` | live grep |
| `<leader>fb` | buffers |
| `<leader>fp` | projects |
| `<leader>h` | clear search highlight |
| `<leader>lf` | LSP format |
| `<C-h/j/k/l>` | window navigation |
| `<S-h/l>` | prev/next buffer |
| `jj` (insert) | exit to normal |
| `gd / K / gr` | LSP go-to-definition / hover / references |
