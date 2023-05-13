return {
  {
    "kyazdani42/nvim-tree.lua",
    event = "VimEnter",
    dependencies = { "kyazdani42/nvim-web-devicons" },

    init = function()
      require("nvim-tree").setup()
    end
  },

  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
    dependencies = { "famiu/bufdelete.nvim" },
    init = function()
      require("bufferline").setup {
        options = {
          diagnostics = "nvim_lsp",
          offsets = { {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          } },
        },
      }
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    init = function()
      require("gitsigns").setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelet = { text = '=' },
          changeddelete = { text = '~' },
        },
      }
    end
  },
}
