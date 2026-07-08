return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    config = function()
      -- nvim-treesitter (main branch) only manages parser installation.
      -- Highlight/indent/fold are enabled via the built-in vim.treesitter.start()
      -- (the old nvim-treesitter.configs.setup { highlight = ... } is gone).
      require('nvim-treesitter').setup {
        ensure_installed = { "vim", "bash", "c", "cpp", "javascript", "json", "lua", "python", "rust", "markdown", "markdown_inline" },
      }

      -- Enable treesitter highlight/indent/fold on every filetype that has a
      -- parser installed. Neovim-native way; pcall guards filetypes without one.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- rainbow-delimiters needs treesitter highlight running (see the
      -- FileType autocmd above). Default strategy colors nested delimiters.
      require('rainbow-delimiters.setup').setup {}
    end,
  },

  {
    'echasnovski/mini.pairs',
    version = false,
    event = "BufReadPost",
    config = function()
      require("mini.pairs").setup {}
    end
  },

  -- Vim plugin for automatically highlighting other uses of the word
  -- under the cursor using either LSP, Tree-sitter, or regex matching.
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",

    config = function()
      local illuminate = require "illuminate"
      vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
      vim.keymap.set("n", "<a-n>", function() require("illuminate").next_reference { wrap = true } end, { desc = "Illuminate: next reference" })
      vim.keymap.set("n", "<a-p>", function() require("illuminate").next_reference { reverse = true, wrap = true } end, { desc = "Illuminate: previous reference" })

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
