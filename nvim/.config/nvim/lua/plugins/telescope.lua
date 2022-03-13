return function()
  require("telescope").setup({
    defaults = {
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
      },
      file_ignore_patterns = {
        ".git",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
  })
  require("telescope").load_extension("fzf")

  local keys = require("utils").keys
  keys.map("n", "<Leader>ff", [[<cmd>lua require('telescope.builtin').find_files({ previewer=false })<CR>]])
  keys.map(
    "n",
    "<Leader>fF",
    [[<cmd>lua require('telescope.builtin').find_files({ previewer=false, hidden=true })<CR>]]
  )
  keys.map("n", "<Leader>fb", [[<cmd>lua require('telescope.builtin').buffers({ previewer=false })<CR>]])
  keys.map("n", "<Leader>fc", [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
  keys.map("n", "<Leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
  keys.map("n", "<Leader>fG", [[<cmd>lua require('telescope.builtin').live_grep({ hidden=true })<CR>]])
  keys.map("n", "<Leader>fH", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
  keys.map("n", "<Leader>fK", [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
  keys.map(
    "n",
    "<Leader>f.",
    [[<cmd>lua require('telescope.builtin').find_files({ cwd=vim.fn.getenv("HOME").."/dotfiles", hidden=true })<CR>]]
  )
end
