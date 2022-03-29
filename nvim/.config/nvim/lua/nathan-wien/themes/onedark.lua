return function()
  vim.cmd([[ colorscheme onedark ]])
  require("lualine").setup({
    options = {
      theme = "onedark",
    },
  })
end
