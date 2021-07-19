-- Inspirations:
-- lua guide #1: https://github.com/nanotee/nvim-lua-guide#using-meta-accessors
-- lua guide #2: https://learnxinyminutes.com/docs/lua/
-- telescope: https://www.youtube.com/watch?v=guxLXcG1kzQ
-- ecnerwala's setup: https://github.com/ecnerwala/dotfiles/blob/master/vim/.config/nvim/init.lua
-- blogpost #1: https://oroques.dev/notes/neovim-init/#set-options
-- blogpost #2: https://blog.inkdrop.info/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887

-- Concise way to escape termcodes
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Leader
vim.g.mapleader = t'<Space>'
vim.g.maplocalleader = t'<Space>'

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
vim.fn['plug#begin']()
-- Git
vim.cmd [[ Plug 'tpope/vim-fugitive' ]]
vim.cmd [[ Plug 'airblade/vim-gitgutter' ]]
-- Tmux
vim.cmd [[ Plug 'christoomey/vim-tmux-navigator' ]]
-- Theme
vim.cmd [[ Plug 'NLKNguyen/papercolor-theme' ]]
vim.cmd [[ Plug 'vim-airline/vim-airline' ]]
vim.cmd [[ Plug 'vim-airline/vim-airline-themes' ]]

-- FZF
vim.cmd [[ Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } ]]
vim.cmd [[ Plug 'junegunn/fzf.vim' ]]
vim.cmd [[ Plug 'airblade/vim-rooter' ]]
-- LSP
vim.cmd [[ Plug 'neovim/nvim-lspconfig' ]]
-- Autocomplete
vim.cmd [[ Plug 'hrsh7th/nvim-compe' ]]
-- Telescope
vim.cmd [[ Plug 'nvim-lua/popup.nvim' ]]
vim.cmd [[ Plug 'nvim-lua/plenary.nvim' ]]
vim.cmd [[ Plug 'nvim-telescope/telescope.nvim' ]]
vim.cmd [[ Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } ]]
vim.cmd [[ Plug 'kyazdani42/nvim-web-devicons' ]]

-- TS, React
vim.cmd [[ Plug 'leafgarland/typescript-vim' ]]
vim.cmd [[ Plug 'peitalin/vim-jsx-typescript' ]]
-- Emmet
vim.cmd [[ Plug 'mattn/emmet-vim' ]]
-- Go
vim.cmd [[ Plug 'fatih/vim-go' ]]
vim.fn['plug#end']()

-------------------------------------------------------------------------------
-- Editor settings
-------------------------------------------------------------------------------
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Indentation
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
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
-- vim.opt.undodir = '$HOME/.config/nvim/undodir' -- this is incorrect
vim.opt.undofile = false
-- Cursor
vim.opt.guicursor = ''
-- Mouse
vim.opt.mouse = 'a'
-- Load project-wise vim settings
vim.opt.exrc = true
-- Backspace issue
vim.opt.backspace = { 'indent', 'eol', 'start' }
-- Termcolor
-- vim.opt.termguicolors = true

-------------------------------------------------------------------------------
-- Plugin settings
-------------------------------------------------------------------------------
-- Theme
vim.opt.background = 'light'
vim.cmd [[ colorscheme PaperColor ]]
vim.g.airline_theme = 'papercolor'

-- Tmux
vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap('n', '<silent> <C-h>', ':TmuxNavigateLeft<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<silent> <C-j>', ':TmuxNavigateDown<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<silent> <C-k>', ':TmuxNavigateUp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<silent> <C-l>', ':TmuxNavigateRight<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<silent> <C-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true })

-- vim-go
vim.g.go_def_mode = 'gopls'
vim.g.go_info_mode = 'gopls'
vim.g.go_def_mapping_enabled = false  -- prevent conflict with coc

-- vim-fugitive
-- . git status
-- vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>')
-- . git diff select left/right
vim.api.nvim_set_keymap('n', '<leader>g,', ':diffget //2<CR>', { noremap = true } )
vim.api.nvim_set_keymap('n', '<leader>g.', ':diffget //3<CR>', { noremap = true } )

-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------
local nvim_lsp = require('lspconfig')

-- Make diagnostics less aggressive
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 8,
      -- severity_limit = 'Error',
    },
    signs = false,
    update_in_insert = false,
  }
)

-- Use an lsp_on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = lsp_on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-------------------------------------------------------------------------------
-- Autocomplete
-------------------------------------------------------------------------------
vim.opt.completeopt = { 'menuone', 'noselect' }

require('compe').setup {
  enabled = true,
  autocomplete = true,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
  }
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<CR>', [[ compe#confirm('<CR>') ]], { noremap = true, silent = true, expr = true })

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  else
    return t "<Tab>"
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-------------------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------------------
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
