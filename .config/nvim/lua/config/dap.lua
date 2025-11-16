local dap = require('dap')

dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '-i', 'dap' },
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c


local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui"] = function()
    dapui.close()
end

-- DAP UI toggle
vim.keymap.set("n", "<F6>", function() dapui.toggle() end, { desc = "Toggle DAP UI" })

-- Basic debugging controls
vim.keymap.set("n", "<F9>", function() dap.continue() end, { desc = "DAP Continue" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP Step Out" })

-- Breakpoints
vim.keymap.set("n", "<F7>", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader><F7>", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Conditional Breakpoint" })

-- REPL
vim.keymap.set("n", "<F8>", function() dap.repl.toggle() end, { desc = "Toggle REPL" })

-- In your DAP config
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-repl",
    callback = function()
        require('cmp').setup.buffer({
            sources = {
                { name = 'dap' }
            }
        })
    end,
})
