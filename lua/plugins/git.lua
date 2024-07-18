return {
  {
    "tanvirtin/vgit.nvim",
    event = "Bufenter",
    dependencies = { "nvim-lua/plenary.nvim" },

    init = function()
      require("vgit").setup {}
    end
  },

  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = "BufReadPre",
  --   init = function()
  --     require("gitsigns").setup {
  --       signs = {
  --         add = { text = '+' },
  --         change = { text = '~' },
  --         delete = { text = '_' },
  --         topdelet = { text = '=' },
  --         changeddelete = { text = '~' },
  --       },
  --     }
  --   end
  -- },
}
