return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    dependencies = { "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
    init = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "vim", "bash", "c", "cpp", "javascript", "json", "lua", "python", "rust" },
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
      }
    end
  },

  {
    'echasnovski/mini.pairs',
    version = false,
    event = "BufReadPost",
    init = function()
      require("mini.pairs").setup {}
    end
  },

  -- Vim plugin for automatically highlighting other uses of the word
  -- under the cursor using either LSP, Tree-sitter, or regex matching.
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",

    init = function()
      local illuminate = require "illuminate"
      vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
      vim.api.nvim_set_keymap(
        "n",
        "<a-n>",
        '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
        { noremap = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<a-p>",
        '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
        { noremap = true }
      )

      illuminate.configure {
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 200,
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "alpha",
          "NvimTree",
          "packer",
          "neogitstatus",
          "Trouble",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "DressingSelect",
          "TelescopePrompt",
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
      }
    end
  },

  {
    'fei6409/log-highlight.nvim',
    event = "VeryLazy",
    config = function()
      require("log-highlight").setup {}
    end
  },
}
