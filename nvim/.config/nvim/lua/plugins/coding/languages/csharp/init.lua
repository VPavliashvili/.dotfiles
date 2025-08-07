local function get_plugins()
    return {
        {
            "seblj/roslyn.nvim",
            ft = "cs",
            opts = {
                exe = vim.fn.exepath("Microsoft.CodeAnalysis.LanguageServer"),
            },
        },
    }
end

local function get_lsp(args)
    local utils = require("utils.helpers")

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(arg)
            local bufnr = arg.buf
            local client = vim.lsp.get_client_by_id(arg.data.client_id)
            if client == nil then
                error("client was nil")
                return
            end

            if client.name == "roslyn" then
                utils.on_attach(client, bufnr)
            end
        end,
    })

    vim.lsp.config("roslyn", {
        cmd = {
            vim.fn.exepath("Microsoft.CodeAnalysis.LanguageServer"),
            "--logLevel",
            "Information",
            "--extensionLogDirectory",
            vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls/logs"),
            "--stdio",
        },
    })

    return nil
end

local function get_null_ls(args)
    -- this is needed because on nixOS csharpier package is named dotnet-csharpier
    -- this function helps make this config compatible with other OSes
    local function get_csharpier_bin()
        local cmd = "csharpier"
        local handle = io.popen("which csharpier 2>/dev/null")
        local result = handle:read("*a")
        handle:close()
        if result ~= "" then
            return "csharpier"
        else
            return "dotnet-csharpier"
        end
    end

    return {
        sources = { args.null_ls.formatting.csharpier.with({
            command = get_csharpier_bin(),
        }) },
    }
end

local function get_cmp(args)
    return {
        setup = {
            filetype = {
                name = "cs",
                sources = {
                    { name = "snippets", group_index = 0 },
                    { name = "nvim_lsp_signature_help", group_index = 1 },
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "buffer", group_index = 2 },
                    { name = "calc", group_index = 4 },
                    { name = "treesitter", group_index = 5 },
                    { name = "path", group_index = 5 },
                },
            },
        },
    }
end

local function get_dap(args)
    return {
        adapter = {
            name = "coreclr",
            config = {
                type = "executable",
                command = vim.fn.exepath("netcoredbg"),
                args = { "--interpreter=vscode" },
            },
        },
        configuration = {
            name = "cs",
            config = {
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
                            path = vim.fn.expand("%:p:h"), -- Start from current file's directory
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

                        local dll_path =
                            string.format("%s/bin/Debug/%s/%s.dll", project_dir, find_net_version_dir(), project_name)
                        print(dll_path)
                        -- -- Look for the dll
                        -- local dll_path = string.format("%s/bin/Debug/net8.0/%s.dll", project_dir, project_name)

                        -- If dll exists, return it, otherwise ask user
                        if vim.fn.filereadable(dll_path) == 1 then
                            return dll_path
                        else
                            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
                        end
                    end,
                },
                {
                    type = "coreclr",
                    name = "Attach",
                    request = "attach",
                    processId = function()
                        return args.dap_utils.pick_process({
                            filter = function(proc)
                                ---@diagnostic disable-next-line: return-type-mismatch
                                return proc.name:match(".*/Debug/.*") and not proc.name:find("vstest.console.dll")
                            end,
                        })
                    end,
                },
            },
        },
    }
end

return {
    get_lsp = get_lsp,
    get_dap = get_dap,
    get_cmp = get_cmp,
    get_null_ls = get_null_ls,
    get_plugins = get_plugins,
}
