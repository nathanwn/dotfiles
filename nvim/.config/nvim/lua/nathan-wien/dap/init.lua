return function()
  local dap = require("dap")
  vim.keymap.set("n", "<F5>", dap.continue)
  vim.keymap.set("n", "<F7>", dap.step_into)
  vim.keymap.set("n", "<F8>", dap.step_over)
  vim.keymap.set("n", "<F9>", dap.step_out)
end
