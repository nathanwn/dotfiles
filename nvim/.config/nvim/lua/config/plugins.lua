vim.api.nvim_exec(
  [[
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
  ]],
  false
)

vim.fn['plug#begin']()
  -- UTILITIES
  -- Git
  vim.cmd [[ Plug 'tpope/vim-fugitive' ]]
  vim.cmd [[ Plug 'mhinz/vim-signify' ]]
  -- Tmux
  vim.cmd [[ Plug 'christoomey/vim-tmux-navigator' ]]
  -- Undo
  vim.cmd [[ Plug 'mbbill/undotree' ]]
  -- Treesitter
  vim.cmd [[ Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' } ]]
  vim.cmd [[Plug 'nvim-treesitter/playground']]

  -- THEMES
  vim.cmd [[ Plug 'NLKNguyen/papercolor-theme' ]]
  vim.cmd [[ Plug 'hoob3rt/lualine.nvim' ]]

  -- FUZZY-FINDING
  -- fzf
  vim.cmd [[ Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } ]]
  vim.cmd [[ Plug 'junegunn/fzf.vim' ]]
  vim.cmd [[ Plug 'airblade/vim-rooter' ]]
  -- Telescope
  vim.cmd [[ Plug 'nvim-lua/popup.nvim' ]]
  vim.cmd [[ Plug 'nvim-lua/plenary.nvim' ]]
  vim.cmd [[ Plug 'nvim-telescope/telescope.nvim' ]]
  vim.cmd [[ Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } ]]
  vim.cmd [[ Plug 'kyazdani42/nvim-web-devicons' ]]

  -- LSP & AUTOCOMPLETE
  -- Lsp
  vim.cmd [[ Plug 'neovim/nvim-lspconfig' ]]
  -- Autocomplete
  vim.cmd [[ Plug 'hrsh7th/nvim-compe' ]]
  -- Snippets
  vim.cmd [[ Plug 'L3MON4D3/LuaSnip' ]]
  vim.cmd [[ Plug 'rafamadriz/friendly-snippets' ]]

  -- LANGUAGE-SPECIFIC
  -- Colorizer
  vim.cmd [[ Plug 'chrisbra/Colorizer' ]]
  -- TS, React
  vim.cmd [[ Plug 'leafgarland/typescript-vim' ]]
  vim.cmd [[ Plug 'peitalin/vim-jsx-typescript' ]]
  -- Emmet
  vim.cmd [[ Plug 'mattn/emmet-vim' ]]
  -- Go
  vim.cmd [[ Plug 'fatih/vim-go' ]]
vim.fn['plug#end']()

-- Theme
vim.opt.background = 'light'
vim.cmd [[ colorscheme PaperColor ]]
-- airline
-- vim.g.airline_theme = 'papercolor'
-- lualine
require('lualine').setup {
  options = {theme = 'papercolor_light'}
}

-- tmux-navigator
vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap('n', '<C-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true })

-- vim-go
vim.g.go_def_mode = 'gopls'
vim.g.go_info_mode = 'gopls'
vim.g.go_def_mapping_enabled = false  -- prevent conflict with coc

-- vim-fugitive
-- . git diff select left/right
vim.api.nvim_set_keymap('n', '<Leader>g,', ':diffget //2<CR>', { noremap = true } )
vim.api.nvim_set_keymap('n', '<Leader>g.', ':diffget //3<CR>', { noremap = true } )

-- undotree
vim.api.nvim_set_keymap('n', '<Leader>ud', ':UndotreeToggle<CR>', { noremap = true, silent = true })
