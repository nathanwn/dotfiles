local default = require("nathan-wien.lsp.default")

return {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    default.on_attach(client, bufnr)
  end,
}
