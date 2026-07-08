return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { 
      "nvim-treesitter/nvim-treesitter", 
      { "echasnovski/mini.icons", version = false },
    },
    opts = {
      heading = {
        sign = true,
        icons = { "\u{f026b} ", "\u{f026c} ", "\u{f026d} ", "\u{f026e} ", "\u{f026f} ", "\u{f0270} " },
      },
    },
  }
}

