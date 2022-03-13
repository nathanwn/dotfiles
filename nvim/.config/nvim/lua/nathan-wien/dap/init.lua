-- DAP
local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<Leader>dg", dap.continue)
vim.keymap.set("n", "<Leader>dj", dap.step_into)
vim.keymap.set("n", "<Leader>dl", dap.step_over)
vim.keymap.set("n", "<Leader>dk", dap.step_out)
vim.keymap.set("n", "<Leader>dh", dap.repl.open)
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
