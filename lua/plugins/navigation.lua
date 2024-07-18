return {
  {
    "kyazdani42/nvim-tree.lua",
    event = "VimEnter",
    dependencies = { "kyazdani42/nvim-web-devicons" },

    init = function()
      require("nvim-tree").setup {
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        renderer = {
          icons = {
            glyphs = {
              git = {
                unstaged = "",
                staged = "S",
                unmerged = "",
                renamed = "➜",
                untracked = "U",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
      }
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

}
