return {
  {
    "Saghen/blink.cmp",
    version = "1.*", -- lock to v1 stable (v2 is a breaking-changes rewrite)
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      { "echasnovski/mini.icons", version = false },
    },

    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      require("blink.cmp").setup({
        completion = {
          ghost_text = { enabled = true },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = 'rounded' },
          },
          list = { selection = { preselect = true, auto_insert = false } },
          menu = {
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "source_name" },
              },
              components = {
                kind_icon = {
                  text = function(ctx)
                    local icon, _, default = pcall(require("mini.icons").get, "lsp", ctx.kind)
                    return (icon and not default) and icon .. " " or ctx.kind .. " "
                  end,
                },
              },
            },
          },
        },

        -- Keymap: keep the nvim-cmp muscle memory (C-j/k navigate, C-b/f scroll docs,
        -- C-Space open, C-e close, CR accept, Tab/S-Tab select + snippet jump).
        keymap = {
          preset = "default",
          ["<C-b>"] = { "scroll_documentation_up" },
          ["<C-f>"] = { "scroll_documentation_down" },
          ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide" },
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        },

        -- Sources: replaces cmp-nvim-lsp / cmp-path / cmp-buffer / cmp_luasnip
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },

        -- Reuse the already-installed LuaSnip engine + friendly-snippets
        snippets = { preset = "luasnip" },

        -- Command-line completion (replaces cmp-cmdline)
        cmdline = {
          keymap = { preset = "default" },
          completion = { menu = { auto_show = true } },
        },

        appearance = { nerd_font_variant = "mono" },

        -- Fallback to the Lua fuzzy matcher when the Rust prebuilt binary is
        -- unavailable (e.g. remote servers / musl / offline). Performs slightly
        -- worse but stays functional everywhere this config runs.
        fuzzy = { implementation = "lua" },
      })
    end,
  },
}
