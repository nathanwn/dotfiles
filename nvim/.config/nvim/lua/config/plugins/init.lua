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
  -- Prerequisites for a lot of things
  vim.cmd [[ Plug 'nvim-lua/popup.nvim' ]]
  vim.cmd [[ Plug 'nvim-lua/plenary.nvim' ]]

  -- Git
  vim.cmd [[ Plug 'tpope/vim-fugitive' ]]
  vim.cmd [[ Plug 'lewis6991/gitsigns.nvim' ]]
  -- Tmux
  vim.cmd [[ Plug 'christoomey/vim-tmux-navigator' ]]
  -- Undo
  vim.cmd [[ Plug 'mbbill/undotree' ]]
  -- Outline
  vim.cmd [[ Plug 'simrat39/symbols-outline.nvim' ]]
  -- Explorer Tree
  vim.cmd [[ Plug 'kyazdani42/nvim-web-devicons' ]]
  vim.cmd [[ Plug 'kyazdani42/nvim-tree.lua' ]]
  -- Colorizer
  vim.cmd [[ Plug 'chrisbra/Colorizer' ]]
  -- Treesitter
  vim.cmd [[ Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' } ]]
  vim.cmd [[ Plug 'nvim-treesitter/playground' ]]

  -- THEMES
  vim.cmd [[ Plug 'NLKNguyen/papercolor-theme' ]]
  vim.cmd [[ Plug 'monsonjeremy/onedark.nvim' ]]
  vim.cmd [[ Plug 'lifepillar/vim-solarized8' ]]
  vim.cmd [[ Plug 'hoob3rt/lualine.nvim' ]]

  -- FUZZY-FINDING
  -- fzf
  vim.cmd [[ Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } ]]
  vim.cmd [[ Plug 'junegunn/fzf.vim' ]]
  vim.cmd [[ Plug 'airblade/vim-rooter' ]]
  -- Telescope
  vim.cmd [[ Plug 'nvim-telescope/telescope.nvim' ]]
  vim.cmd [[ Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } ]]
  vim.cmd [[ Plug 'kyazdani42/nvim-web-devicons' ]]

  -- LSP & AUTOCOMPLETE
  -- Lsp
  vim.cmd [[ Plug 'neovim/nvim-lspconfig' ]]
  vim.cmd [[ Plug 'scalameta/nvim-metals' ]]
  -- Autocomplete
  vim.cmd [[ Plug 'hrsh7th/nvim-cmp' ]]
  vim.cmd [[ Plug 'hrsh7th/cmp-nvim-lsp' ]]
  vim.cmd [[ Plug 'hrsh7th/cmp-buffer' ]]
  vim.cmd [[ Plug 'hrsh7th/cmp-path' ]]
  vim.cmd [[ Plug 'hrsh7th/cmp-cmdline' ]]
  vim.cmd [[ Plug 'hrsh7th/cmp-omni' ]]
  -- Snippets
  vim.cmd [[ Plug 'hrsh7th/cmp-vsnip' ]]
  vim.cmd [[ Plug 'hrsh7th/vim-vsnip' ]]
  vim.cmd [[ Plug 'rafamadriz/friendly-snippets' ]]

  -- LANGUAGE-SPECIFIC
  -- TS, React
  vim.cmd [[ Plug 'leafgarland/typescript-vim' ]]
  vim.cmd [[ Plug 'peitalin/vim-jsx-typescript' ]]
  -- Emmet
  vim.cmd [[ Plug 'mattn/emmet-vim' ]]
  -- Go
  vim.cmd [[ Plug 'fatih/vim-go' ]]
  -- Markdown
  vim.cmd [[ Plug 'plasticboy/vim-markdown' ]]
  -- Pandoc
  vim.cmd [[ Plug 'vim-pandoc/vim-pandoc' ]]
  vim.cmd [[ Plug 'vim-pandoc/vim-pandoc-syntax' ]]
  -- Prisma
  vim.cmd [[ Plug 'pantharshit00/vim-prisma' ]]
  -- Tex
  vim.cmd [[ Plug 'lervag/vimtex', { 'for': 'tex' } ]]

  -- GRAMMAR CHECKER
  vim.cmd [[ Plug 'rhysd/vim-grammarous' ]]
vim.fn['plug#end']()

-- gitsigns
require('gitsigns').setup()

-- nvimtree
require('nvim-tree').setup({
  filters = {
    custom = {
        '.git',
      -- python
      '__pycache__',
      -- latex
      '*.aux', '*.bbl', '*.blg', '*.bcf',
      '*.fdb_latexmk', '*.fls', '*.glo', '*.ist',
      '*.lof', '*.log', '*.lot', '*.synctex.gz',
      '*.toc',
    }
  }
})

-- theme
-- require('config.themes.onedark')
require('config.themes.papercolor-light')

-- rooter
vim.g.rooter_patterns = {
  '.git',
  '*.pandoc',
  'requirements.txt',
  'main.tex',
}

-- vim-go
vim.g.go_def_mode = 'gopls'
vim.g.go_info_mode = 'gopls'
vim.g.go_def_mapping_enabled = false  -- prevent conflict with coc/lsp

-- pandoc
vim.cmd [[ let g:pandoc#command#templates_file=expand("$HOME")."/.config/nvim/settings/vim-pandoc-templates" ]]
vim.cmd [[ let g:pandoc#spell#enabled = 0 ]]

require "config.plugins.treesitter"
require "config.lsp"
require "config.plugins.cmp"
-- require "config.plugins.compe"
require "config.plugins.telescope"
require "config.plugins.vimtex"
