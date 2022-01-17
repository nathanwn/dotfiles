return function(default_on_attach)
  return {
    on_attach = function(client, bufnr)
      default_on_attach(client, bufnr);

      client.resolved_capabilities.document_formatting = false;
      client.resolved_capabilities.document_range_formatting = false;
    end
  }
end
