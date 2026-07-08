return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { { "echasnovski/mini.icons", version = false } },
  config = function()
    local alpha = require "alpha"
    local startify = require "alpha.themes.startify"
    alpha.setup(startify.opts)
  end
}
