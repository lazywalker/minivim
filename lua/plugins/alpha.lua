return {
  {
    "echasnovski/mini.starter",
    version = false,
    event = "VimEnter",
    config = function()
      -- mini.starter: replaces alpha-nvim. Opinionated startup screen with
      -- recent files and actions; no extra dependency (mini ecosystem).
      require("mini.starter").setup {}
    end,
  },
}
