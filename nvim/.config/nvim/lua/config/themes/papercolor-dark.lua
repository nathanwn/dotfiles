vim.opt.background = 'dark'
vim.cmd [[ colorscheme PaperColor ]]

require('lualine').setup {
  options = {
    theme = 'papercolor_dark'
  }
}
