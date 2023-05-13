return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    require("which-key").setup {}
  end
}
