local M = {}

M.editor = {}

function M.editor.set_buf_indent(tabsize)
  vim.bo.tabstop = tabsize
  vim.bo.shiftwidth = tabsize
  vim.bo.softtabstop = tabsize
end

return M
