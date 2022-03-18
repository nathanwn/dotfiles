return function()
  vim.opt.background = "dark"
  vim.cmd([[ colorscheme PaperColor ]])
  require("nathan-wien.plugins.lualine")("papercolor_dark")
end
