return function()
  local nvim_lsp = require('lspconfig');

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

  vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Use an default_on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local default_on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { noremap=true, silent=true }

    -- if client.server_capabilities.definitionProvider then
    buf_set_keymap('n', '<Leader>gd', [[<cmd>lua vim.lsp.buf.definition()<CR>]], opts)
    -- end

    -- if client.server_capabilities.declarationProvider then
    buf_set_keymap('n', '<Leader>gD', [[<cmd>lua vim.lsp.buf.declaration()<CR>]], opts)
    -- end

    buf_set_keymap('n', '<Leader>gi', [[<cmd>lua vim.lsp.buf.implementation()<CR>]], opts)

    buf_set_keymap('n', '<Leader>gh', [[<cmd>lua vim.lsp.buf.hover()<CR>]], opts)
    buf_set_keymap('n', '<Leader>gt', "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

    buf_set_keymap('n', '<Leader>rn', [[<cmd>lua vim.lsp.buf.rename()<CR>]], opts)
    buf_set_keymap("n", '<Leader>fm', [[<cmd>lua vim.lsp.buf.formatting_sync()<CR>]], opts)

    -- if client.server_capabilities.codeActionProvider then
    buf_set_keymap('n', '<Leader>ca', [[<cmd>lua vim.lsp.buf.code_action()<CR>]], opts)
    -- end

    buf_set_keymap('n', '<Leader>[d', [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], opts)
    buf_set_keymap('n', '<Leader>]d', [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], opts)
    buf_set_keymap('n', '<Leader>gl', [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]], opts)
    buf_set_keymap('n', '<Leader>gq', [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]], opts)

    -- Workspace management
    buf_set_keymap('n', '<Leader>wa', [[<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>]], opts)
    buf_set_keymap('n', '<Leader>wr', [[<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>]], opts)
    buf_set_keymap('n', '<Leader>wl', [[<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>]], opts)

    buf_set_keymap('n', '<Leader>gr', [[<cmd>lua vim.lsp.buf.references()<CR>]], opts)
    buf_set_keymap('n', '<Leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    buf_set_keymap('n', '<Leader>g*', '<cmd>lua vim.cmd("e"..vim.lsp.get_log_path())<CR>', opts)

    if client.resolved_capabilities.document_formatting then
      vim.cmd [[
        augroup lsp_buf_format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
        augroup END
      ]]
    end

    if client.resolved_capabilities.document_highlight then
      vim.cmd [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> :lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> :lua vim.lsp.buf.clear_references()
        augroup END
      ]]
    end
  end

  local default_lsp_config = {
    on_attach = default_on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }

  local servers = {
    -- C++
    clangd = require('lsp.servers.clangd')(),
    cmake = require('lsp.servers.cmake')(),
    -- JS, TS
    tsserver = require('lsp.servers.tsserver')(default_on_attach),
    -- Lua
    sumneko_lua = require('lsp.servers.sumneko_lua')(),
    -- JSON
    jsonls = require('lsp.servers.jsonls')(default_on_attach),
    -- Prisma
    prismals = require('lsp.servers.prismals')(),
    -- Python
    pyright = require('lsp.servers.pyright')(),
    -- jedi_language_server = require('lsp.servers.jedi')(),
    -- SQL
    -- sqlls = require('lsp.servers.sqlls')(),
    -- yaml
    yamlls = require('lsp.servers.yamlls')(),
    -- Formatting
    efm = require('lsp.servers.efm')(default_on_attach),
  }

  for server, config in pairs(servers) do
    -- config overrides default_lsp_config
    nvim_lsp[server].setup(vim.tbl_deep_extend("force", default_lsp_config, config))
  end

  -- Virtual text coloring
  -- Read: https://neovim.io/doc/user/lsp.html
  vim.cmd [[ hi LspDiagnosticsDefaultHint guifg='#A0A0A0' ]]
end
