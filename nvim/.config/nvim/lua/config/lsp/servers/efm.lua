local formatters = require('config.lsp.formatters');
local linters = require('config.lsp.linters');
local utils = require('config.lsp.utils');

local languages = {
  -- lua = {luafmt},
  typescript = { formatters.prettier, linters.eslint_d },
  javascript = { formatters.prettier, linters.eslint_d },
  typescriptreact = { formatters.prettier, linters.eslint_d },
  ['typescript.tsx'] = { formatters.prettier, linters.eslint_d },
  javascriptreact = { formatters.prettier, linters.eslint_d },
  ['javascript.jsx'] = { formatters.prettier, linters.eslint_d },
  vue = { formatters.prettier, linters.eslint_d },
  json = { formatters.prettier },
  html = { formatters.prettier },
  scss = { formatters.prettier },
  css = { formatters.prettier },
  python = { formatters.python_black },
}

return function(default_on_attach)
  return {
    filetypes = vim.tbl_keys(languages),
    init_options = {
      documentFormatting = true
    },
    settings = {
      rootMarkers = { "package.json", ".git" },
      lintDebounce = 500,
      languages = languages
    },
    on_attach = function(client, bufnr)
      default_on_attach(client, bufnr);
      utils.setFormatOnSave(client);
    end
  }
end
