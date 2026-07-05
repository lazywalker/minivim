return {
  {
    "tanvirtin/vgit.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("vgit").setup {}
    end
  },
}
