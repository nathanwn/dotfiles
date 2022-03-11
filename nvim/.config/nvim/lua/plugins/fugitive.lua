
return function()
  -- git diff select left/right
  local keys = require('utils').keys;
  keys.map('n', '<Leader>g<', ':diffget //2<CR>')
  keys.map('n', '<Leader>g>', ':diffget //3<CR>')
end
