local function get_plugins(args)
    return {
        {
            "folke/neodev.nvim",
            config = function()
                require("neodev").setup({})
            end,
            opts = {},
        },
        -- {
        --     "folke/lazydev.nvim",
        --     ft = "lua",
        --     opts = {
        --         library = {
        --             { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        --         },
        --     },
        --     dependencies = {
        --         "nvim-lua/plenary.nvim",
        --     },
        -- },
    }
end

local function init_lsp(args)
    local utils = require("utils.helpers")

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(arg)
            local bufnr = arg.buf
            local client = vim.lsp.get_client_by_id(arg.data.client_id)
            if client == nil then
                error("client was nil")
                return
            end

            if client.name == "lua_ls" then
                utils.on_attach(client, bufnr)
            end
        end,
    })

    vim.lsp.config("lua_ls", {
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath("config")
                    and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
                then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    version = "LuaJIT",
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
            })
        end,
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = {
                    workspaceEvent = "OnChange",
                    globals = {
                        "describe",
                        "before_each",
                        "it",
                        "mock",
                        "assert",
                    },
                    groupSeverity = {
                        strong = "Warning",
                        strict = "Warning",
                    },
                    groupFileStatus = {
                        ["ambiguity"] = "Opened",
                        ["await"] = "Opened",
                        ["codestyle"] = "None",
                        ["duplicate"] = "Opened",
                        ["global"] = "Opened",
                        ["luadoc"] = "Opened",
                        ["redefined"] = "Opened",
                        ["strict"] = "Opened",
                        ["strong"] = "Opened",
                        ["type-check"] = "Opened",
                        ["unbalanced"] = "Opened",
                        ["unused"] = "Opened",
                    },
                    unusedLocalExclude = { "_*" },
                },
                telemetry = {
                    enable = false,
                },
            },
        },
        capabilites = utils.get_lsp_capabilities,
    })
    vim.lsp.enable("lua_ls")
end

local function get_null_ls(args)
    return {
        sources = { args.null_ls.formatting.stylua },
    }
end

local function get_dap(args)
    -- example
    -- specs.dap = {
    --     adapter = {
    --         name = "adaptername",
    --         config = {
    --             type = "executable",
    --             command = vim.fn.exepath("samplepath"),
    --             args = { "--samplearg=sample" },
    --         },
    --     },
    --     configuration = {
    --         name = "cs", --[[ .e.g csharp ]]
    --         config = { { some stuff }, { also some stuff } }
    --     }
    -- }
    return {}
end

local function get_cmp(args)
    return {
        setup = {
            filetype = {
                name = "lua",
                sources = {
                    { name = "calc",                    group_index = 0 },
                    { name = "lazydev",                 group_index = 0 },
                    { name = "snippets",                group_index = 0 },
                    { name = "nvim_lsp",                group_index = 1 },
                    { name = "nvim_lua",                group_index = 1 },
                    { name = "nvim_lsp_signature_help", group_index = 1 },
                    { name = "treesitter",              group_index = 2 },
                    { name = "path",                    group_index = 2 },
                    { name = "buffer",                  group_index = 2 },
                },
            },
        },
    }
end

return {
    init_lsp = init_lsp,
    get_dap = get_dap,
    get_cmp = get_cmp,
    get_null_ls = get_null_ls,
    get_plugins = get_plugins,
}
