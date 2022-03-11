return function()
  -- tmux-navigator
  local keys = require('utils').keys;
  vim.g.tmux_navigator_no_mappings = 1
  keys.map('n', '<C-h>', ':TmuxNavigateLeft<CR>')
  keys.map('n', '<C-j>', ':TmuxNavigateDown<CR>')
  keys.map('n', '<C-k>', ':TmuxNavigateUp<CR>')
  keys.map('n', '<C-l>', ':TmuxNavigateRight<CR>')
  keys.map('n', '<C-\\>', ':TmuxNavigatePrevious<CR>')
end
