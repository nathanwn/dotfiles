-- Reload init.lua
vim.api.nvim_set_keymap('n', '<F12>', ':luafile ~/.config/nvim/init.lua<CR>', { noremap = true })

-- Indentation
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- Ensure `a` in normal-mode to work properly
vim.api.nvim_set_keymap('n', 'e', 'he', { noremap = true })

-- Terminal
vim.api.nvim_set_keymap('n', '<Leader>tv', ':vsplit | terminal<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ts', ':split | terminal<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-[>', '<C-\\><C-n>', { noremap = true })
