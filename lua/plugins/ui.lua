return {
  -- Catppuccin: cross-platform default colorscheme (Linux/macOS/Alpine).
  -- Acts as a transparent fallback so the terminal/compositor background
  -- shows through. On Linux with Noctalia, base16/matugen layers on top
  -- (see lua/matugen.lua, gitignored). Elsewhere catppuccin provides the
  -- colors on its own.
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,    -- load during startup so it is the active colorscheme
    priority = 1000, -- load before all other start plugins

    config = function()
      require("catppuccin").setup({
        transparent_background = true, -- do not render solid bg; let terminal/compositor show through
        flavour = "mocha",             -- latte, frappe, macchiato, mocha
        integrations = {
          nvimtree = true,
          bufferline = true,
          which_key = true,
          mini = { enabled = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
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
