return {
  {
    'echasnovski/mini.comment',
    version = false,
    event = "BufRead",
    config = function()
      require("mini.comment").setup {}
    end
  },
}
