local M = {}

M.on_attach = function(client, bufnr)
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

M.config = {
  on_attach = M.on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

return M
