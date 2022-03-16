local builtins = require("null-ls").builtins

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
}
