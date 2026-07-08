return {
  {
    "williamboman/mason.nvim",
    event = "BufReadPre",
    dependencies = { "williamboman/mason-lspconfig.nvim", lazy = true },
    config = function()
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
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Neovim 0.11+ provides a new LSP API: vim.lsp.config / vim.lsp.enable
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            -- Make the nvim runtime available to lua_ls so editing nvim config
            -- (init.lua, lua/**) gets vim.* completion and no false warnings.
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
              globals = { 'vim', 'hl' },
            },
          },
        },
      })
      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust_analyzer'] = {}
        }
      })
      vim.lsp.enable({ 'lua_ls', 'rust_analyzer' })

      -- Global diagnostic mappings (work in every buffer, not just LSP).
      -- All LSP/diagnostic actions live under <leader>l for consistency.
      -- See `:help vim.diagnostic.*` and `:help vim.lsp.buf.*`
      vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'LSP: line diagnostics' })
      vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'LSP: previous diagnostic' })
      vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'LSP: next diagnostic' })
      vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist, { desc = 'LSP: diagnostics list' })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer-local mappings (only valid once the server attaches).
          -- Jump keys (gd/gD/gi/gr) and hover (K) stay as single keys — that is
          -- the cross-tool convention (VSCode/vim/LSP) and worth keeping.
          local b = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
            vim.tbl_extend('force', b, { desc = 'LSP: go to declaration' }))
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
            vim.tbl_extend('force', b, { desc = 'LSP: go to definition' }))
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', b, { desc = 'LSP: hover doc' }))
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
            vim.tbl_extend('force', b, { desc = 'LSP: go to implementation' }))
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', b, { desc = 'LSP: references' }))
          -- LSP actions under <leader>l
          vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action,
            vim.tbl_extend('force', b, { desc = 'LSP: code action' }))
          vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename,
            vim.tbl_extend('force', b, { desc = 'LSP: rename symbol' }))
          vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help,
            vim.tbl_extend('force', b, { desc = 'LSP: signature help' }))
        end,
      })
    end
  }
}
