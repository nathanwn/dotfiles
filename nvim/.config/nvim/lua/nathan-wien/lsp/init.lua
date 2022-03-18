return function()
  local nvim_lsp = require("lspconfig")
  local lrequire = require("nathan-wien.utils").local_require
  local default = lrequire("lsp.default")

  -- Make diagnostics less aggressive
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      underline = true,
      virtual_text = {
        spacing = 8,
        -- severity_limit = 'Error',
      },
      signs = false,
      update_in_insert = false,
    }
  )

  vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local configs = {
    -- C++
    clangd = {},
    cmake = lrequire("lsp.servers.cmake"),
    -- JS, TS
    tsserver = lrequire("lsp.servers.tsserver"),
    -- Lua
    sumneko_lua = lrequire("lsp.servers.sumneko_lua"),
    -- JSON
    -- jsonls = lrequire('lsp.servers.jsonls'),
    -- Prisma
    prismals = {},
    -- Python
    pyright = {},
    -- yaml
    yamlls = {},
    -- Formatting
    -- efm = lrequire('lsp.servers.efm'),
  }

  local servers = {}

  -- Servers supported by nvim-lspconfig
  for server_name, server_config in pairs(configs) do
    table.insert(servers, {
      instance = nvim_lsp[server_name],
      config = server_config,
    })
  end

  -- Standalone servers
  table.insert(servers, {
    instance = require("null-ls"),
    config = lrequire("lsp.servers.null-ls"),
  })

  for _, server in ipairs(servers) do
    -- config overrides default_lsp_config
    server.instance.setup(vim.tbl_deep_extend("force", default.config, server.config))
  end

  -- Virtual text coloring
  -- Read: https://neovim.io/doc/user/lsp.html
  vim.cmd([[ hi LspDiagnosticsDefaultHint guifg='#A0A0A0' ]])
end
