local M = {}

M.editor = {}

function M.editor.set_buf_indent(tabsize)
  vim.bo.tabstop = tabsize
  vim.bo.shiftwidth = tabsize
  vim.bo.softtabstop = tabsize
end

M.local_dir_path = vim.fn.getenv("HOME") .. "/.local/share/nvim"
M.python_venv = vim.fn.getenv("HOME") .. "/.local/share/nvim/venv"

return M
