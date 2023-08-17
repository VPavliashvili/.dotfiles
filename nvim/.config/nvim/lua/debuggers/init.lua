--keymaps
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")
--F17 is equivalent to Shift-F5
vim.keymap.set("n", "<F17>", ":lua require'dap'.terminate()<CR>")


--debugger vizualizers initializations
require("nvim-dap-virtual-text").setup()
require("dap-go").setup()
require("dapui").setup()

--setup dappUi
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

--configure actual languages
--local dap = require "dap"
dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
        host = function()
            local value = vim.fn.input('Host [127.0.0.1]: ')
            if value ~= "" then
                return value
            end
            return '127.0.0.1'
        end,
        port = function()
            local val = tonumber(vim.fn.input('Port: '))
            assert(val, "Please provide a port number")
            return val
        end,
    }
}

dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host, port = config.port })
end

-- c#
dap.adapters.coreclr = {
    type = "executable",
    command = "/usr/bin/netcoredbg",
    args = { "--interpreter=vscode" },
}

vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. '/'
    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end
    local path = vim.fn.input('Path to your *proj file: ', default_path, 'file')
    vim.g['dotnet_last_proj_path'] = path
    local cmd = 'dotnet build -c Debug "' .. path .. '" 2> /tmp/dap-debug-nvim-dotnet.log'
    print('\n')
    print('Cmd to execute: ' .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
        print('\nBuild: ' .. vim.g.gsign('✔️ ', 'OK'))
    else
        print('\nBuild: ' .. vim.g.gsign('❌', 'ERR') .. '(code: ' .. f .. ')')
    end
end

vim.g.dotnet_get_dll_path = function()
    local request = function()
        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end

    if vim.g['dotnet_last_dll_path'] == nil then
        vim.g['dotnet_last_dll_path'] = request()
    else
        if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()
        end
    end
    return vim.g['dotnet_last_dll_path']
end

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        console = "integratedTerminal",
        program = function()
            if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
                vim.g.dotnet_build_project()
            end
            return vim.g.dotnet_get_dll_path()
        end,
    },
}
