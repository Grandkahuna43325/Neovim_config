require("dapui").setup({
    element_mappings = {},
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    layouts = {
        -- {
        --     elements = {
        --         {
        --             id = "scopes",
        --             size = 0.5,
        --         },
        --         {
        --             id = "breakpoints",
        --             size = 0.25,
        --         },
        --     },
        --     position = "left",
        --     size = 40,
        -- },
        {
            elements = {
                {
                    id = "watches",
                    size = 1.0,
                },
            },
            position = "bottom",
            size = 15,
        },
    },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
    },
})

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dap.adapters.gdb = {
    type = "executable",
    command = vim.fn.system("which gdb"):gsub("\n", "") or "/usr/bin/gdb", -- adjust as needed, must be absolute path
    name = "gdb",
    args = { "-i", "dap", "-ex", "set follow-fork-mode child", "-ex", "set detach-on-fork off" },
}

dap.adapters.codelldb = {
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    name = "codelldb",
}

dap.configurations.rust = {
    {
        name = "Launch File",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        initCommands = function()
            local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
            local script_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_lookup.py"
            local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"
            return {
                ("command script import '%s'"):format(script_file),
                ("command source '%s'"):format(commands_file),
            }
        end,
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
    },
}
dap.configurations.c = dap.configurations.cpp
