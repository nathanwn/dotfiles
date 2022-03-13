return function()
  vim.keymap.set("n", "<Leader>vo", require("symbols-outline").toggle_outline)
end
