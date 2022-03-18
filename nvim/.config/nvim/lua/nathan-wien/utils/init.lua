local M = {}

M.editor = {}

M.editor.set_buf_indent = function(tabsize)
  vim.bo.tabstop = tabsize
  vim.bo.shiftwidth = tabsize
  vim.bo.softtabstop = tabsize
end

M.local_require = function(path)
  return require("nathan-wien." .. path)
end

M.local_dir_path = vim.fn.getenv("HOME") .. "/.local/share/nvim"
M.python_venv = vim.fn.getenv("HOME") .. "/.local/share/nvim/venv"

return M
