-- Treat sway config fragments (binds, styles, etc.) as swayconfig so they get
-- the same syntax highlighting as sway/config. nvim's built-in detection only
-- matches paths ending in "/sway/config", so we extend it to cover the rest of
-- ~/.config/sway/configs/.
vim.filetype.add({
  filename = {
    ['config'] = function(path)
      if path:match('/sway/config$') or path:match('/sway/configs/') then
        return 'swayconfig'
      end
    end,
  },
  pattern = {
    ['.*'] = function(path)
      if path:match('/sway/configs/[^/]+$') then
        return 'swayconfig'
      end
    end,
  },
})
