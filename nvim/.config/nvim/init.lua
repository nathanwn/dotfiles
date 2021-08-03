-- Concise way to escape termcodes
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local NVIM_PATH = vim.fn.getenv("HOME")..'/.config/nvim';

-------------------------------------------------------------------------------
-- Leader
-------------------------------------------------------------------------------
vim.g.mapleader = t'<Space>'
vim.g.maplocalleader = t'<Space>'

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
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
  -- vim.cmd [[ Plug 'vim-airline/vim-airline' ]]
  -- vim.cmd [[ Plug 'vim-airline/vim-airline-themes' ]]
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
-- Characters
vim.opt.list = true;
vim.opt.listchars = {
  tab = '» ',
  trail = '␣',
  extends = '▶',
  precedes = '◀',
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
vim.opt.undodir = NVIM_PATH..'/undodir'
vim.opt.undofile = true
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

-------------------------------------------------------------------------------
-- Plugin settings
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------
-- Functionalities
require('nvim-treesitter.configs').setup {
    ensure_installed = 'maintained',
    highlight = { enable = true },
    indent = { enable = true },
}

-- Folding
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- C++ patch
require('nvim-treesitter.parsers').get_parser_configs().cpp = {
  install_info = {
    url = "~/bin/tree-sitter-cpp",
    files = { "src/parser.c", "src/scanner.cc" },
    generate_requires_npm = true,
  },
  maintainers = { "@theHamsta" },
}

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
  buf_set_keymap('n', '<Leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<Leader>hv', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  buf_set_keymap('n', '<Leader>[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<Leader>]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Workspace management
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local lsp_servers = {
  "pyright",     -- python
  "tsserver",    -- typescript
}
for _, lsp in ipairs(lsp_servers) do
  nvim_lsp[lsp].setup {
    on_attach = lsp_on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Lua custom server
local sumneko_root_path = vim.fn.getenv("HOME").."/bin/lang-servers/lua-language-server"
local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Virtual text coloring
-- Read: https://neovim.io/doc/user/lsp.html
vim.cmd [[ hi LspDiagnosticsDefaultHint guifg='#A0A0A0' ]]

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

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

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

require('telescope').setup{
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

vim.api.nvim_set_keymap('n', '<Leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ previewer = false })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fF', [[<cmd>lua require('telescope.builtin').find_files({ previewer = false, hidden=true })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', [[<cmd>lua require('telescope.builtin').buffers({ previewer = false })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fc', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fH', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f.', [[<cmd>lua require('telescope.builtin').find_files({ cwd=vim.fn.getenv("HOME").."/dotfiles", hidden=true })<CR>]], { noremap = true, silent = true })

-------------------------------------------------------------------------------
-- Key bindings
-------------------------------------------------------------------------------
-- Reload init.lua
vim.api.nvim_set_keymap('n', '<F12>', ':luafile ~/.config/nvim/init.lua<CR>', { noremap = true })

-- Indentation
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- Ensure `a` in normal-mode to work properly
vim.api.nvim_set_keymap('n', 'e', 'he', { noremap = true })
