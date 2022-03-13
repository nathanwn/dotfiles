return function()
  vim.keymap.set("n", "<Leader>vo", require("symbols-outline").toggle_outline)
  vim.g.symbols_outline = {
    keymaps = {
      hover_symbol = "H",
    },
  }
end
