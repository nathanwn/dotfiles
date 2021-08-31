local utils = require('config.lsp.utils');

return function(default_on_attach)
  return {
    on_attach = function(client, bufnr)
      default_on_attach(client, bufnr);
      utils.setFormatOnSave(client);
    end
  }
end
