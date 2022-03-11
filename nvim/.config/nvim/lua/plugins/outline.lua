return function()
  -- outline
  local keys = require('utils').keys;
  keys.map('n', '<Leader>vo', ':SymbolsOutline<CR>')
end
