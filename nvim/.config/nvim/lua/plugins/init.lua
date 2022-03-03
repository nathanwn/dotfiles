return require('packer').startup(function(use)
  -- Packer manages itself
  use { 'wbthomason/packer.nvim' }

  -- UTILITIES
  -- Core plugins
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  -- Git
  use { 'tpope/vim-fugitive',
    event = 'VimEnter *',
  }
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
  use { 'nvim-treesitter/playground',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require "nvim-treesitter.configs".setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  }

  -- THEMES
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use { 'NLKNguyen/papercolor-theme',
    requires = { 'nvim-lualine/lualine.nvim' },
    config = require('themes/papercolor-light'),
  }

  -- FUZZY-FINDING
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' },
    },
    config = require('plugins/telescope'),
  }

  -- LSP
  -- LspConfig
  use { 'neovim/nvim-lspconfig',
    requires = { 'scalameta/nvim-metals' },
    config = require('lsp'),
  }
  -- Rust
  use { 'simrat39/rust-tools.nvim',
    requires = 'neovim/nvim-lspconfig',
    config = require('plugins/rust-tools'),
  }
  -- Scala
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
  use { 'plasticboy/vim-markdown',
    ft = { 'markdown' },
  }
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
  }

  -- GRAMMAR CHECKER
  use { 'rhysd/vim-grammarous' }

  -- Auto-install
  if packer_bootstrap then
    require('packer').sync()
  end
end)
