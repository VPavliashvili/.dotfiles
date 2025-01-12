return function()
    local dap = require("dap")
    local dap_utils = require("dap.utils")

    -- Debug adapter configuration
    dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.exepath("netcoredbg"),
        args = { '--interpreter=vscode' }
    }

    -- Debug configurations
    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "Launch",
            request = "launch",
            program = function()
                -- First, try to find the .csproj file
                local project_path = vim.fs.find(function(name)
                    return name:match("%.csproj$")
                end, {
                    upward = true,
                    stop = vim.loop.os_homedir(),
                    path = vim.fn.expand('%:p:h') -- Start from current file's directory
                })[1]

                if not project_path then
                    vim.notify("Could not find .csproj file", vim.log.levels.ERROR)
                    return
                end

                -- Get project directory
                local project_dir = vim.fn.fnamemodify(project_path, ":h")
                local project_name = vim.fn.fnamemodify(project_path, ":t:r")

                -- -- Build the project first
                -- local build_cmd = string.format("dotnet build %s", project_path)
                -- vim.fn.system(build_cmd)

                local function find_net_version_dir()
                    local base_path = project_dir .. "/bin/Debug"
                    local net_dirs = vim.fs.find("net*", { type = "directory", path = base_path })
                    return net_dirs[1] and vim.fn.fnamemodify(net_dirs[1], ":t") or "net8.0"
                end

                local dll_path = string.format("%s/bin/Debug/%s/%s.dll",
                    project_dir, find_net_version_dir(), project_name)
                print(dll_path)
                -- -- Look for the dll
                -- local dll_path = string.format("%s/bin/Debug/net8.0/%s.dll", project_dir, project_name)

                -- If dll exists, return it, otherwise ask user
                if vim.fn.filereadable(dll_path) == 1 then
                    return dll_path
                else
                    return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end
            end,
        },
        {
            type = "coreclr",
            name = "Attach",
            request = "attach",
            processId = function()
                return dap_utils.pick_process({
                    filter = function(proc)
                        ---@diagnostic disable-next-line: return-type-mismatch
                        return proc.name:match(".*/Debug/.*") and not proc.name:find("vstest.console.dll")
                    end,
                })
            end,
        },
    }
end
