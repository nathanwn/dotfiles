vim.opt.background = 'light'
vim.cmd [[ colorscheme PaperColor ]]

require('lualine').setup {
  options = {
    theme = 'papercolor_light'
  }
}
