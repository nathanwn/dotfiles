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

-- View group
-- nvimtree
keys.map('n', '<Leader>ve', ':NvimTreeToggle<CR>')
-- undotree
keys.map('n', '<Leader>vu', ':UndotreeToggle<CR>')
-- outline
keys.map('n', '<Leader>vo', ':SymbolsOutline<CR>')

-- Telescope
keys.map('n', '<Leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ previewer=false })<CR>]])
keys.map('n', '<Leader>fF', [[<cmd>lua require('telescope.builtin').find_files({ previewer=false, hidden=true })<CR>]])
keys.map('n', '<Leader>fb', [[<cmd>lua require('telescope.builtin').buffers({ previewer=false })<CR>]])
keys.map('n', '<Leader>fc', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
keys.map('n', '<Leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
keys.map('n', '<Leader>fG', [[<cmd>lua require('telescope.builtin').live_grep({ hidden=true })<CR>]])
keys.map('n', '<Leader>fH', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
keys.map('n', '<Leader>f.', [[<cmd>lua require('telescope.builtin').find_files({ cwd=vim.fn.getenv("HOME").."/dotfiles", hidden=true })<CR>]])

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
keys.map('n', '<Leader>vt', ':vsplit | terminal<CR>')
keys.map('n', '<Leader>vT', ':split | terminal<CR>')
keys.map('t', '<C-[>', '<C-\\><C-n>')

-- Resize splits
keys.map('n', '<C-s><C-k>', ':resize -1<CR>')
keys.map('n', '<C-s><C-j>', ':resize +1<CR>')
keys.map('n', '<C-s><C-h>', ':vertical resize -1<CR>')
keys.map('n', '<C-s><C-l>', ':vertical resize +1<CR>')

-- Remap for word wrap
keys.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keys.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- CRLF issue
keys.map('n', '\\lf', ':<cmd>%s/\r//g<CR>')
