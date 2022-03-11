local M = {};

M.luafmt = {
  formatCommand = "luafmt ${-i:tabWidth} --stdin",
  formatStdin = true
}

M.prettier  = {
  formatCommand = "prettier --stdin --stdin-filepath ${INPUT}",
  formatStdin = true
}

-- npm add --global prettier_d_slim
-- Doesn't work for some reason...
M.prettier_d  = {
  formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}",
  formatStdin = true
}

M.prettierd = {
  formatCommand = 'prettierd "${INPUT}"',
  formatStdin = true,
  -- env = {
  --   string.format('PRETTIERD_DEFAULT_CONFIG=%s', vim.fn.expand('~/.config/nvim/utils/linter-config/.prettierrc.json')),
  -- },
}

-- python
M.python_black = {
  formatCommand = "black --quiet -",
  formatStdin = true
}

M.python_isort = {
  formatCommand = "isort --quiet -",
  formatStdin = true
}

return M;
