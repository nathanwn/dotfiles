local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil
local lrequire = require("nathan-wien.utils").local_require

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

return require("packer").startup(function(use)
  -- Packer manages itself
  use({ "wbthomason/packer.nvim" })

  -- UTILITIES
  -- Core plugins
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })
  -- Git
  use({
    "tpope/vim-fugitive",
    event = "VimEnter *",
    config = lrequire("plugins/fugitive"),
  })
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = lrequire("plugins/gitsigns"),
  })
  -- Tmux
  use({
    "christoomey/vim-tmux-navigator",
    -- event = 'VimEnter *',
    config = lrequire("plugins/tmux-navigator"),
  })
  -- Undo
  use({
    "mbbill/undotree",
    config = lrequire("plugins/undotree"),
  })
  -- Outline
  use({ "simrat39/symbols-outline.nvim", config = lrequire("plugins/outline") })
  -- Explorer Tree
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = lrequire("plugins/nvim-tree"),
  })
  -- Colorizer
  use({ "chrisbra/Colorizer" })
  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = lrequire("plugins/treesitter"),
  })
  use({
    "nvim-treesitter/playground",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = lrequire("plugins/treesitter-playground"),
  })

  -- THEMES
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({
    "NLKNguyen/papercolor-theme",
    requires = { "nvim-lualine/lualine.nvim" },
    config = lrequire("themes/papercolor-light"),
  })

  -- FUZZY-FINDING
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim" },
    },
    config = lrequire("plugins/telescope"),
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- LSP
  -- LspConfig
  use({
    "neovim/nvim-lspconfig",
    requires = {
      { "scalameta/nvim-metals" },
      { "jose-elias-alvarez/null-ls.nvim" },
    },
    config = lrequire("lsp"),
  })
  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- Rust
  use({
    "simrat39/rust-tools.nvim",
    requires = { "neovim/nvim-lspconfig" },
    config = lrequire("plugins/rust-tools"),
  })
  -- Scala
  use({ "scalameta/nvim-metals", requires = { "nvim-lua/plenary.nvim" } })

  -- DAP
  use({ "mfussenegger/nvim-dap" })
  use({
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = lrequire("dap/ui"),
  })
  use({
    "nvim-telescope/telescope-dap.nvim",
    requires = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
  })
  use({
    "mfussenegger/nvim-dap-python",
    requires = { "mfussenegger/nvim-dap" },
    config = lrequire("dap/python"),
  })
  use({
    "theHamsta/nvim-dap-virtual-text",
    requires = { "mfussenegger/nvim-dap" },
    config = lrequire("dap/virtual-text"),
  })

  -- AUTOCOMPLETE
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-omni" },
      -- Snippets
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = lrequire("plugins/cmp"),
  })

  -- LANGUAGE-SPECIFIC
  -- TS, React
  use({ "leafgarland/typescript-vim" })
  use({ "peitalin/vim-jsx-typescript" })
  -- Emmet
  use({ "mattn/emmet-vim" })
  -- Go
  use({ "fatih/vim-go", config = lrequire("plugins/vim-go") })
  -- Markdown
  use({ "plasticboy/vim-markdown", ft = { "markdown" } })
  -- Pandoc
  use({
    "vim-pandoc/vim-pandoc",
    requires = { "vim-pandoc/vim-pandoc-syntax" },
    config = lrequire("plugins/vim-pandoc"),
  })
  -- Prisma
  use({ "pantharshit00/vim-prisma", ft = { "prisma" } })
  -- Tex
  use({ "lervag/vimtex", ft = { "tex" } })

  -- GRAMMAR CHECKER
  use({ "rhysd/vim-grammarous" })

  -- Auto-install
  if packer_bootstrap then
    require("packer").sync()
  end
end)
