local builtins = require("null-ls").builtins

local should_attach = function(bufnr)
  local disabled_filetypes = { "cpp" }

  for _, ft in ipairs(disabled_filetypes) do
    if vim.api.nvim_buf_get_option(bufnr, "filetype") == ft then
      return false
    end
  end

  return true
end

return {
  sources = {
    -- Lua
    builtins.formatting.stylua,
    -- JS/TS
    builtins.diagnostics.eslint_d,
    builtins.completion.spell,
    builtins.formatting.prettierd,
    -- Python
    builtins.formatting.black,
    builtins.formatting.isort,
    builtins.diagnostics.flake8,
    builtins.diagnostics.mypy,
  },
  diagnostics_format = "[#{c}] #{m} (#{s})",
  should_attach = should_attach,
}
