-- Reload init.lua
vim.keymap.set("n", "<F12>", ":luafile ~/.config/nvim/init.lua<CR>")

-- Indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Ensure `a` in normal-mode to work properly
vim.keymap.set("n", "e", "he")

-- Terminal
vim.keymap.set("n", "<Leader>vt", ":vsplit | terminal<CR>")
vim.keymap.set("n", "<Leader>vT", ":split | terminal<CR>")
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>")

-- Resize splits
vim.keymap.set("n", "<C-s><C-k>", ":resize -1<CR>")
vim.keymap.set("n", "<C-s><C-j>", ":resize +1<CR>")
vim.keymap.set("n", "<C-s><C-h>", ":vertical resize -1<CR>")
vim.keymap.set("n", "<C-s><C-l>", ":vertical resize +1<CR>")

-- Remap for word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
