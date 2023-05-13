return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    dependencies = { "p00f/nvim-ts-rainbow", event = "VeryLazy" },
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
    "windwp/nvim-autopairs",
    event = "BufReadPost",
    init = function()
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')

      npairs.setup {
        check_ts = true,
        ts_config = {
          lua = { 'string' }, -- it will not add a pair on that treesitter node
          javascript = { 'template_string' },
          java = false,       -- don't check treesitter on java
        }
      }

      local ts_conds = require('nvim-autopairs.ts-conds')
      -- press % => %% only while inside a comment or string
      npairs.add_rules {
        Rule("%", "%", "lua")
            :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
        Rule("$", "$", "lua")
            :with_pair(ts_conds.is_not_ts_node({ 'function' }))
      }
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
  }
}
