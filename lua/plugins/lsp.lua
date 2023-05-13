return {
  {
    "williamboman/mason.nvim",
    event = "BufReadPre",
    dependencies = { "williamboman/mason-lspconfig.nvim", lazy = true },
    init = function()
      require("mason").setup {
        ui = {
          icons = {
            package_installed = "√",
            package_pending = "→",
            package_uninstalled = "×",
          },
        },
      }

      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
        },
      }
    end
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
  }
}
