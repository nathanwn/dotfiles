local formatters = require('config.lsp.formatters');
local linters = require('config.lsp.linters');
local utils = require('config.lsp.utils');

local formatter = formatters.prettier;
local linter = linters.eslint_d;

local languages = {
  --lua = {luafmt},
  typescript = {formatter, linter},
  javascript = {formatter, linter},
  typescriptreact = {formatter, linter},
  ['typescript.tsx'] = {formatter, linter},
  javascriptreact = {formatter, linter},
  ['javascript.jsx'] = {formatter, linter},
  vue = {formatter, linter},
  yaml = {formatter},
  json = {formatter},
  html = {formatter},
  scss = {formatter},
  css = {formatter},
  markdown = {formatter},
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
