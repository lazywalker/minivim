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
  options.lua             vim.opt settings + SSH OSC52 clipboard fallback
  keymaps.lua             global keymaps (leader = Space)
  autocommands.lua        filetype rules, yank highlight, etc.
  matugen.lua             Noctalia-generated colors (gitignored, see below)
  plugins/
    base16.lua            base16 colorscheme (gitignored, Noctalia-managed)
    cmp.lua               completion (nvim-cmp + LuaSnip + mini.icons)
    comment.lua           mini.comment
    git.lua               gitsigns.nvim
    highlight.lua         treesitter, rainbow-delimiters, mini.pairs, vim-illuminate
    lsp.lua               mason + nvim-lspconfig (Neovim 0.11+ API)
    markdown.lua          render-markdown.nvim
    navigation.lua        nvim-tree, bufferline
    telescope.lua         fuzzy finder
    ui.lua                catppuccin, mini.starter, mini.indentscope, mini.statusline
    which-key.lua         keymap hints
```

## Theming

Two layers cooperate:

1. **catppuccin** loads at startup as the default colorscheme (`lazy = false`,
   transparent background). Cross-platform default on Linux / macOS / Alpine.
2. **base16 + matugen** — when [Noctalia](https://github.com/noctalia-dev/noctalia)
   is the desktop shell (Linux), it renders `lua/matugen.lua` and creates
   `lua/plugins/base16.lua` from its neovim community template, then signals
   nvim via `SIGUSR1` to hot-reload colors without restarting.

Both `matugen.lua` and `base16.lua` are gitignored (Noctalia-managed); on a
fresh checkout without Noctalia, only catppuccin applies.

## LSP

Servers are configured with the Neovim 0.11+ API (`vim.lsp.config` /
`vim.lsp.enable`). `lua_ls` is set up with the nvim runtime on its workspace
path and recognizes `vim`/`hl` globals, so editing this config (and Hyprland's
`.lua` files) gets full completion. `rust_analyzer` is also wired up. Install
more servers via `:Mason`.

## Clipboard over SSH

On a remote server nvim detects `$SSH_CONNECTION` and switches to the built-in
OSC52 clipboard provider, so yanks on the remote host land on the local
terminal's clipboard (supported by kitty / ghostty / alacritty / wezterm). No
extra tooling needed; just ensure OSC52 is enabled in the local terminal.

## Keymaps (leader = Space)

All LSP/diagnostic actions live under `<leader>l` for consistency; git under
`<leader>g`. Press `<leader>` and wait for which-key to pop up.

| Key | Action |
|-----|--------|
| `<leader>e` | toggle file explorer (nvim-tree) |
| `<leader>ff` | find files (Telescope) |
| `<leader>ft` | live grep |
| `<leader>fb` | buffers |
| `<leader>fp` | projects |
| `<leader>ls` / `lS` | LSP document / workspace symbols |
| `<leader>ld` | line diagnostics (float) |
| `<leader>ll` | diagnostics list (location list) |
| `<leader>la` / `lr` / `lf` | LSP code action / rename / format |
| `<leader>ghp` | git hunk preview |
| `<leader>ghu` / `ghd` | git previous / next hunk |
| `<leader>gbp` | git blame line |
| `<leader>mt` / `mp` | markdown toggle render / preview (markdown files only) |
| `<leader>h` | clear search highlight |
| `<C-h/j/k/l>` | window navigation |
| `<S-h/l>` | prev/next buffer |
| `jj` (insert) | exit to normal |
| `gd / gD / gi / gr` | LSP definition / declaration / implementation / references |
| `K` | LSP hover |
| `[d` / `]d` | previous / next diagnostic |
