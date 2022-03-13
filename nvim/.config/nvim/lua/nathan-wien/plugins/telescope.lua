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

  local telescope_builtin = require("telescope.builtin")

  -- vim.keymap.set("n", "<Leader>ff", function()
  --   telescope_builtin.find_files({ previewer = false })
  -- end)
  vim.keymap.set("n", "<Leader>ff", telescope_builtin.find_files)
  vim.keymap.set("n", "<Leader>fF", function()
    telescope_builtin.find_files({ previewer = false, hidden = true })
  end)
  vim.keymap.set("n", "<Leader>fb", function()
    telescope_builtin.buffers({ previewer = false })
  end)
  vim.keymap.set("n", "<Leader>fc", telescope_builtin.current_buffer_fuzzy_find)
  vim.keymap.set("n", "<Leader>fg", telescope_builtin.live_grep)
  vim.keymap.set("n", "<Leader>fG", function()
    telescope_builtin.live_grep({ hidden = true })
  end)
  vim.keymap.set("n", "<Leader>fH", telescope_builtin.help_tags)
  vim.keymap.set("n", "<Leader>fK", telescope_builtin.keymaps)
  vim.keymap.set("n", "<Leader>f.", function()
    telescope_builtin.find_files({
      cwd = vim.fn.getenv("HOME") .. "/dotfiles",
      hidden = true,
    })
  end)
end
