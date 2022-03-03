-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Indentation
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- Characters
vim.opt.list = true;
vim.opt.listchars = {
  tab = '» ',
  trail = '␣',
  extends = '▶',
  precedes = '◀',
  -- eol = '⏎'
}
-- Error bells
vim.opt.errorbells = false
-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Scrolling
vim.opt.scrolloff = 8
-- Undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.getenv("HOME")..'/.local/share/nvim/undodir'
vim.opt.undofile = true
-- Wrap
vim.opt.linebreak = true
-- Cursor
vim.opt.guicursor = ''
-- Mouse
vim.opt.mouse = 'a'
-- Load project-wise vim settings
vim.opt.exrc = true
-- Backspace issue
vim.opt.backspace = { 'indent', 'eol', 'start' }
-- Clipboard
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }
-- Termcolor
vim.opt.termguicolors = true
-- Buffers
vim.opt.hidden = true
-- Latex
vim.g.tex_flavor = 'latex'
