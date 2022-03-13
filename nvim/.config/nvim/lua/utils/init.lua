local M = {}

M.editor = {}

function M.editor.set_buf_indent(tabsize)
  vim.bo.tabstop = tabsize
  vim.bo.shiftwidth = tabsize
  vim.bo.softtabstop = tabsize
end

M.keys = {}

local keymap_options = { noremap = true, silent = true }

function M.keys.map(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts or keymap_options)
end

function M.keys.buf_map(mode, key, cmd, opts)
  vim.api.nvim_buf_set_keymap(mode, key, cmd, opts or keymap_options)
end

return M
