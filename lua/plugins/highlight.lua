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

  -- mini.cursorword: highlight the word under the cursor (replaces vim-illuminate).
  -- For reference jumping use gr (LSP references / telescope).
  {
    'echasnovski/mini.cursorword',
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup {}
    end,
  },

  {
    'fei6409/log-highlight.nvim',
    event = "VeryLazy",
    config = function()
      require("log-highlight").setup {}
    end
  },
}
