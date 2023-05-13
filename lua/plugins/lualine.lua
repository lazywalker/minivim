return {
  "nvim-lualine/lualine.nvim",
  init = function()
    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = false,
      always_visible = true,
    }

    local diff = {
      "diff",
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }

    local filename = { "filename", path = 2, symbols = { modified = "  ", readonly = "", unnamed = "" } }
    local filetype = { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 1 } }
    local location = { "location", padding = { left = 0, right = 1 }, }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- disabled_filetypes = {
        --   statusline = {},
        --   winbar = {},
        -- },
        disabled_filetypes = { 'NvimTree' },


        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', diagnostics, diff },
        lualine_c = { filename },
        lualine_x = { 'encoding', 'fileformat', filetype },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filename },
        lualine_x = { location },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
