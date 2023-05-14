return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    init = function()
      local name = "tokyonight-night"
      local status_ok, _ = pcall(vim.cmd.colorscheme, name)
      if not status_ok then
        return
      end
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

    init = function()
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

    init = function()
      require("mini.statusline").setup {}
    end
  },
  --#endregion
}
