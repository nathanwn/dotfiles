local options = { noremap = true, silent = true }

local keymap = function(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts or options);
end

local keymap_buf = function(mode, key, cmd, opts)
  vim.api.nvim_buf_set_keymap('n', key, cmd, opts or options);
end

-- Reload init.lua
keymap('n', '<F12>', ':luafile ~/.config/nvim/init.lua<CR>');

-- Indentation
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Ensure `a` in normal-mode to work properly
keymap('n', 'e', 'he')

-- Terminal
keymap('n', '<Leader>tv', ':vsplit | terminal<CR>')
keymap('n', '<Leader>ts', ':split | terminal<CR>')
keymap('t', '<C-[>', '<C-\\><C-n>')

-- Resize splits
keymap('n', '<C-s><C-k>', ':resize -1<CR>')
keymap('n', '<C-s><C-j>', ':resize +1<CR>')
keymap('n', '<C-s><C-h>', ':vertical resize -1<CR>')
keymap('n', '<C-s><C-l>', ':vertical resize -1<CR>')
