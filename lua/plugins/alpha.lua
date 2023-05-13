return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  init = function()
    local alpha = require "alpha"
    local startify = require "alpha.themes.startify"
    alpha.setup(startify.opts)
  end
}
