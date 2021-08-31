local M = {};

M.luafmt = {
  formatCommand = "luafmt ${-i:tabWidth} --stdin",
  formatStdin = true
}

M.prettier  = {
  formatCommand = "./node_modules/.bin/prettier --stdin --stdin-filepath ${INPUT}",
  formatStdin = true
}

-- npm add --global prettier_d_slim
-- Doesn't work for some reason...
M.prettier_d  = {
  formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}",
  formatStdin = true
}

return M;
