local function get_plugins(args)
    return {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    }
end

local function get_lsp(args)
    -- nvim-lspconfig setup
    return {
        name = "lua_ls",
        setup = {
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
            on_attach = args.on_attach,
            capabilites = args.capabilites,
        },
    }
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
    specs = {
        get_lsp = get_lsp,
        get_dap = get_dap,
        get_cmp = get_cmp,
        get_null_ls = get_null_ls,
        get_plugins = get_plugins,
    },
}
