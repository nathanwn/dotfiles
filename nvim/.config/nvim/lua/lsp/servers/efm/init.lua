local formatters = require('lsp.servers.efm.formatters')
local linters = require('lsp.servers.efm.linters')

local languages = {
  -- lua = {luafmt},
  typescript = { formatters.prettierd, linters.eslint_d },
  javascript = { formatters.prettierd, linters.eslint_d },
  typescriptreact = { formatters.prettierd, linters.eslint_d },
  ['typescript.tsx'] = { formatters.prettierd, linters.eslint_d },
  javascriptreact = { formatters.prettierd, linters.eslint_d },
  ['javascript.jsx'] = { formatters.prettierd, linters.eslint_d },
  vue = { formatters.prettierd, linters.eslint_d },
  json = { formatters.prettierd },
  html = { formatters.prettierd },
  scss = { formatters.prettierd },
  css = { formatters.prettierd },
  python = { formatters.python_black, formatters.python_isort, linters.flake8 },
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
      default_on_attach(client, bufnr)
    end
  }
end
