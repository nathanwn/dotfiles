local keys = require('utils').keys;

----------
-- Plugins
----------
-- vim-fugitive
-- . git diff select left/right
keys.map('n', '<Leader>g<', ':diffget //2<CR>')
keys.map('n', '<Leader>g>', ':diffget //3<CR>')

-- tmux-navigator
vim.g.tmux_navigator_no_mappings = 1
keys.map('n', '<C-h>', ':TmuxNavigateLeft<CR>')
keys.map('n', '<C-j>', ':TmuxNavigateDown<CR>')
keys.map('n', '<C-k>', ':TmuxNavigateUp<CR>')
keys.map('n', '<C-l>', ':TmuxNavigateRight<CR>')
keys.map('n', '<C-\\>', ':TmuxNavigatePrevious<CR>')

-- nvimtree
keys.map('n', '<C-e>', ':NvimTreeToggle<CR>')

-- undotree
keys.map('n', '<Leader>ud', ':UndotreeToggle<CR>')

-- outline
keys.map('n', '<Leader>ol', ':SymbolsOutline<CR>')

----------
-- Settings
----------
-- Reload init.lua
keys.map('n', '<F12>', ':luafile ~/.config/nvim/init.lua<CR>');

-- Indentation
keys.map('v', '<', '<gv')
keys.map('v', '>', '>gv')

-- Ensure `a` in normal-mode to work properly
keys.map('n', 'e', 'he')

-- Terminal
keys.map('n', '<Leader>tv', ':vsplit | terminal<CR>')
keys.map('n', '<Leader>ts', ':split | terminal<CR>')
keys.map('t', '<C-[>', '<C-\\><C-n>')

-- Resize splits
keys.map('n', '<C-s><C-k>', ':resize -1<CR>')
keys.map('n', '<C-s><C-j>', ':resize +1<CR>')
keys.map('n', '<C-s><C-h>', ':vertical resize -1<CR>')
keys.map('n', '<C-s><C-l>', ':vertical resize +1<CR>')
