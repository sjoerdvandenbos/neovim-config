return {
  "HUAHUAI23/nvim-quietlight",
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme quietlight]])
    vim.cmd([[highlight clear ColorColumn]])
  end,
}
