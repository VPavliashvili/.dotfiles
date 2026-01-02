local function get_plugins()
    return {}
end

local function init_lsp(args)
    return nil
end

local function get_null_ls(args)
    return {
        sources = { args.null_ls.formatting.alejandra },
    }
end

local function get_cmp(args)
    return {
        setup = {
            filetype = {
                name = "nix",
                sources = {
                    { name = "snippets",                group_index = 0 },
                    { name = "path",                    group_index = 1 },
                    { name = "treesitter",              group_index = 2 },
                    { name = "buffer",                  group_index = 3 },
                    { name = "calc",                    group_index = 4 },
                },
            },
        },
    }
end

local function get_dap(args)
    return nil
end

return {
    init_lsp = init_lsp,
    get_dap = get_dap,
    get_cmp = get_cmp,
    get_null_ls = get_null_ls,
    get_plugins = get_plugins,
}
