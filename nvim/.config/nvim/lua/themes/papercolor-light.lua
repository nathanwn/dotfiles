return function()
  vim.opt.background = 'light'
  vim.cmd [[ colorscheme PaperColor ]]
  require('plugins/lualine')('papercolor_light')

  vim.cmd [[ hi pandocAtxHeader     guifg=#AF005F ctermfg=125 gui=bold term=bold ]]
  vim.cmd [[ hi pandocAtxHeaderMark guifg=#AF005F ctermfg=125 ]]
  vim.cmd [[ hi pandocAtxStart      guifg=#AF005F ctermfg=125 ]]
end
