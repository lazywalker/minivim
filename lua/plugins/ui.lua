return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
      local name = "catppuccin" -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      pcall(vim.cmd.colorscheme, name)
    end
  },

  --#region
  -- Visualize and work with indent scope
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
  -- Motions (jump to respective border line; if not present - body line)
  -- goto_top = '[i',
  -- goto_bottom = ']i',
  {
    'echasnovski/mini.indentscope',
    version = false,
    event = "VeryLazy",

    config = function()
      require("mini.indentscope").setup {}
    end
  },
  --#endregion

  --#region
  -- Minimal and fast statusline module with opinionated default look
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md
  {
    'echasnovski/mini.statusline',
    version = false,
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },

    config = function()
      require("mini.statusline").setup {}
    end
  },
  --#endregion
}
