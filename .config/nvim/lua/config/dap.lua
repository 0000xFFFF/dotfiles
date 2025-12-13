local dap = require('dap')

-- gdb setup
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
        setupCommands = {
            { text = "-enable-pretty-printing" }
        },
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
vim.keymap.set("n", "<leader>dd", function() dapui.toggle() end, { desc = "Toggle DAP UI" })

-- Basic debugging controls
vim.keymap.set("n", "<F9>", function() dap.continue() end, { desc = "DAP Continue" })
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "DAP Continue" })

vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP Step Over" })
vim.keymap.set("n", "<leader>ds", function() dap.step_over() end, { desc = "DAP Step Over" })

vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP Step Into" })
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "DAP Step Into" })

vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP Step Out" })
vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "DAP Step Out" })

-- Quit debugger
vim.keymap.set("n", "<leader>dq", function()
    dap.clear_breakpoints()
    dapui.close()
    dap.terminate()
end, { desc = "Terminate Debugger" })

-- Breakpoints
vim.keymap.set("n", "<F7>", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })

vim.keymap.set("n", "<leader><F7>", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Conditional Breakpoint" })

-- REPL
vim.keymap.set("n", "<F8>", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })

-- autocomplete
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

require("nvim-dap-virtual-text").setup {
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,            -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
    all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- @param buf number
    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, buf, stackframe, node, options)
        -- by default, strip out new line characters
        if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value:gsub("%s+", " ")
        else
            return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
        end
    end,
    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

    -- experimental features:
    all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}
