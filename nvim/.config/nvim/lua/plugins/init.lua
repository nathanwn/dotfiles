return require('packer').startup(function(use)
  -- Packer manages itself
  use { 'wbthomason/packer.nvim' }

  -- UTILITIES
  -- Core plugins
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  -- Git
  use { 'tpope/vim-fugitive' }
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = require('plugins/gitsigns'),
  }
  -- Tmux
  use { 'christoomey/vim-tmux-navigator' }
  -- Undo
  use { 'mbbill/undotree' }
  -- Outline
  use { 'simrat39/symbols-outline.nvim' }
  -- Explorer Tree
  use { 'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = require('plugins/nvim-tree'),
  }
  -- Colorizer
  use { 'chrisbra/Colorizer' }
  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require('plugins/treesitter')
  }
  -- use { 'nvim-treesitter/playground' }

  -- THEMES
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use { 'NLKNguyen/papercolor-theme',
    requires = { 'nvim-lualine/lualine.nvim' },
    config = require('themes/papercolor-light')
  }

  -- FUZZY-FINDING
  use { 'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = require('plugins/telescope')
  }
  use { "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  }

  -- LSP
  use { 'neovim/nvim-lspconfig',
    requires = { 'scalameta/nvim-metals' },
    config = require('lsp')
  }
  use { 'scalameta/nvim-metals',
    requires = { "nvim-lua/plenary.nvim" }
  }

  -- AUTOCOMPLETE
  -- use { 'hrsh7th/nvim-compe' }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-omni' },
      -- Snippets
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = require('plugins/cmp')
  }

  -- LANGUAGE-SPECIFIC
  -- TS, React
  use { 'leafgarland/typescript-vim' }
  use { 'peitalin/vim-jsx-typescript' }
  -- Emmet
  use { 'mattn/emmet-vim' }
  -- Go
  use { 'fatih/vim-go',
    config = require('plugins/vim-go')
  }
  -- Markdown
  use { 'plasticboy/vim-markdown' }
  -- Pandoc
  use { 'vim-pandoc/vim-pandoc',
    requires = { 'vim-pandoc/vim-pandoc-syntax' },
    config = require('plugins/vim-pandoc')
  }
  -- Prisma
  use { 'pantharshit00/vim-prisma',
    ft = { 'prisma' },
  }
  -- Tex
  use { 'lervag/vimtex',
    ft = { 'tex' },
    config = require('plugins/vimtex')
  }

  -- GRAMMAR CHECKER
  use { 'rhysd/vim-grammarous' }

  -- Auto-install
  if packer_bootstrap then
    require('packer').sync()
  end
end)
