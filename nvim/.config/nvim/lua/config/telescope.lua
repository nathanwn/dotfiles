require('telescope').load_extension('fzf')

require('telescope').setup{
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    },
    file_ignore_patterns = {
      ".git",
      "node_modules"
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

vim.api.nvim_set_keymap('n', '<Leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ previewer=false, hidden=true })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fF', [[<cmd>lua require('telescope.builtin').find_files({ previewer=false, hidden=true })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', [[<cmd>lua require('telescope.builtin').buffers({ previewer=false })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fc', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fH', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f.', [[<cmd>lua require('telescope.builtin').find_files({ cwd=vim.fn.getenv("HOME").."/dotfiles", hidden=true })<CR>]], { noremap = true, silent = true })
