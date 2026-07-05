return {
  "nvim-telescope/telescope.nvim",
  event = "BufReadPre",
  cmd = { "Telescope" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup {}
  end
}
