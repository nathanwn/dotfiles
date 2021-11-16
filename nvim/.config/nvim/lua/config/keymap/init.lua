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
keys.map('n', '<Leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ previewer=false, hidden=true })<CR>]])
keys.map('n', '<Leader>fF', [[<cmd>lua require('telescope.builtin').find_files({ previewer=false, hidden=false })<CR>]])
keys.map('n', '<Leader>fP', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
keys.map('n', '<Leader>fb', [[<cmd>lua require('telescope.builtin').buffers({ previewer=false })<CR>]])
keys.map('n', '<Leader>fc', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
keys.map('n', '<Leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
keys.map('n', '<Leader>fG', [[<cmd>lua require('telescope.builtin').live_grep({ hidden=true })<CR>]])
keys.map('n', '<Leader>fH', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
keys.map('n', '<Leader>f.', [[<cmd>lua require('telescope.builtin').find_files({ cwd=vim.fn.getenv("HOME").."/dotfiles", hidden=true })<CR>]])

-- Lsp
keys.map('n', '<Leader>gd', "<cmd>lua vim.lsp.buf.definition()<CR>")

keys.map('n', '<Leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

keys.map('n', '<Leader>gi', "<cmd>lua vim.lsp.buf.implementation()<CR>")

keys.map('n', '<Leader>gh', "<cmd>lua vim.lsp.buf.hover()<CR>")
keys.map('n', '<Leader>gt', "<cmd>lua vim.lsp.buf.type_definition()<CR>")

keys.map('n', '<Leader>rn', "<cmd>lua vim.lsp.buf.rename()<CR>")
keys.map("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")

keys.map('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

keys.map('n', '<Leader>[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
keys.map('n', '<Leader>]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
keys.map('n', '<Leader>gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
keys.map('n', '<Leader>gq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')

keys.map('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
keys.map('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
keys.map('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

keys.map('n', '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
keys.map('n', '<Leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')


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
keys.map('n', '<Leader>vts', ':split | terminal<CR>')
keys.map('t', '<C-[>', '<C-\\><C-n>')

-- Resize splits
keys.map('n', '<C-s><C-k>', ':resize -1<CR>')
keys.map('n', '<C-s><C-j>', ':resize +1<CR>')
keys.map('n', '<C-s><C-h>', ':vertical resize -1<CR>')
keys.map('n', '<C-s><C-l>', ':vertical resize +1<CR>')

-- Remap for word wrap
keys.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keys.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
