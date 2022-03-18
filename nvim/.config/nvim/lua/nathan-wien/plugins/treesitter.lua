return function()
  -- Functionalities
  require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    highlight = { enable = true },
    indent = { enable = false },
  })

  -- Folding
  -- vim.opt.foldmethod = 'expr'
  -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end
