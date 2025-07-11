require("dapui").setup()

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
dap.configurations.rust = dap.configurations.cpp
dap.configurations.c = dap.configurations.cpp
