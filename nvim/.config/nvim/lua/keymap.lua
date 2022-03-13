local keys = require("utils").keys

----------
-- Settings
----------
-- Reload init.lua
keys.map("n", "<F12>", ":luafile ~/.config/nvim/init.lua<CR>")

-- Indentation
keys.map("v", "<", "<gv")
keys.map("v", ">", ">gv")

-- Ensure `a` in normal-mode to work properly
keys.map("n", "e", "he")

-- Terminal
keys.map("n", "<Leader>vt", ":vsplit | terminal<CR>")
keys.map("n", "<Leader>vT", ":split | terminal<CR>")
keys.map("t", "<C-[>", "<C-\\><C-n>")

-- Resize splits
keys.map("n", "<C-s><C-k>", ":resize -1<CR>")
keys.map("n", "<C-s><C-j>", ":resize +1<CR>")
keys.map("n", "<C-s><C-h>", ":vertical resize -1<CR>")
keys.map("n", "<C-s><C-l>", ":vertical resize +1<CR>")

-- Remap for word wrap
keys.map("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keys.map("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
