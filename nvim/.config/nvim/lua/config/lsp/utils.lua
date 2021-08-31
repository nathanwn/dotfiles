local M = {};

M.setFormatOnSave = function(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[
      augroup Format
          autocmd! * <buffer>
          autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
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

return M;
