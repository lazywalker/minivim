-- Force transparency on side-panel / plugin Normal highlights after any
-- colorscheme applies. Works for both catppuccin (fallback) and base16/matugen
-- (Noctalia). catppuccin already sets transparent_background = true, but some
-- plugin integrations still paint a solid bg (e.g. NvimTree); this strips it
-- so the terminal/compositor background shows through uniformly.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("TransparentHighlights", { clear = true }),
  callback = function()
    local groups = {
      "Normal",
      "NormalNC",
      "NvimTreeNormal",
      "NvimTreeNormalNC",
      "NvimTreeBackground",
      "BufferLineFill",
      "BufferLineBackground",
      "BufferLineTabVisible",
      "BufferLineTabSelected",
      "SignColumn",
      "VertSplit",
      "WinSeparator",
    }
    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "NONE" })
    end
  end,
})

-- mini.statusline: when Noctalia/matugen is active (Linux), recolor the
-- statusline from base16 so it matches the Noctalia palette instead of
-- catppuccin's. Mode segments keep a colored block (signals current mode),
-- the other segments go transparent. On macOS/Alpine without matugen this
-- is skipped and catppuccin's defaults remain.
--
-- Applied on ColorScheme (startup, catppuccin load) and also re-applied on
-- SIGUSR1, because Noctalia's wallpaper refresh rewrites lua/matugen.lua and
-- signals nvim — but base16-colorscheme.setup() does NOT fire ColorScheme,
-- so without the explicit signal handler the bar would stay on the old colors
-- until nvim is restarted.
local function apply_noctalia_statusline()
  if not pcall(require, "matugen") then return end
  local ok, colors = pcall(function() return require("base16-colorscheme").colors end)
  if not ok or not colors then return end

  local hi = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end
  -- Mode segments: Noctalia color block with the surface as foreground
  hi("MiniStatuslineModeNormal",  { bg = colors.base0D, fg = colors.base00 }) -- primary blue
  hi("MiniStatuslineModeInsert",  { bg = colors.base0B, fg = colors.base00 }) -- green
  hi("MiniStatuslineModeVisual",  { bg = colors.base0E, fg = colors.base00 }) -- purple
  hi("MiniStatuslineModeCommand", { bg = colors.base09, fg = colors.base00 }) -- orange
  hi("MiniStatuslineModeReplace", { bg = colors.base08, fg = colors.base00 }) -- red
  -- Non-mode segments: transparent bg, Noctalia foreground
  hi("MiniStatuslineFilename", { bg = "NONE", fg = colors.base05 })
  hi("MiniStatuslineDevinfo",  { bg = "NONE", fg = colors.base03 })
  hi("MiniStatuslineFileinfo", { bg = "NONE", fg = colors.base03 })
  hi("MiniStatuslineNormal",   { bg = "NONE", fg = colors.base05 })
  hi("MiniStatuslineInactive", { bg = "NONE", fg = colors.base03 })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("MiniStatuslineTheme", { clear = true }),
  callback = apply_noctalia_statusline,
})

-- Re-apply after Noctalia wallpaper refreshes. base16-colorscheme.setup() (run
-- by matugen.lua's own SIGUSR1 handler) does not fire ColorScheme, so this
-- separate handler is what actually updates the bar on theme reloads. The
-- defer lets matugen's handler finish base16.setup() first.
local sig = vim.uv.new_signal()
if sig then
  sig:start("sigusr1", vim.schedule_wrap(function()
    vim.defer_fn(apply_noctalia_statusline, 50)
  end))
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})
-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeAutoClose", { clear = true }),
  nested = true,
  callback = function()
    if vim.fn.winnr("$") == 1 and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr() then
      vim.cmd "quit"
    end
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.enable(true, { bufnr = 0 })
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    -- Style mini.cursorword's highlight (underlines the word under cursor).
    vim.cmd "hi MiniCursorword term=underline cterm=underline gui=underline"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})
