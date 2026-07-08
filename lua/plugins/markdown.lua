return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "echasnovski/mini.icons", version = false },
    },
    keys = {
      { "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", desc = "Markdown: toggle render", ft = "markdown" },
      { "<leader>mp", "<cmd>RenderMarkdown preview<CR>", desc = "Markdown: preview source", ft = "markdown" },
    },
    opts = {
      heading = {
        sign = true,
        icons = { "\u{f026b} ", "\u{f026c} ", "\u{f026d} ", "\u{f026e} ", "\u{f026f} ", "\u{f0270} " },
      },
    },
  }
}

