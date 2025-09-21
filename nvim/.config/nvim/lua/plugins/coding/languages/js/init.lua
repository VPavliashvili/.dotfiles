local function get_plugins()
    return {}
end

local function init_lsp(args)
    local utils = require("utils.helpers")

    vim.lsp.enable("ts_ls")

    vim.lsp.config("eslint", {
        on_attach = utils.on_attach,
        capabilites = utils.get_lsp_capabilities,
    })
    vim.lsp.enable("eslint")
end

local function get_null_ls(args)
    return {
        sources = {
            args.null_ls.formatting.prettier,
        },
    }
end

local function get_cmp(args)
    return {
        setup = {
            filetype = {
                name = "html",
                sources = {
                    { name = "nvim_lsp",   group_index = 0 },
                    { name = "snippets",   group_index = 1 },
                    { name = "treesitter", group_index = 2 },
                    { name = "path",       group_index = 2 },
                    { name = "buffer",     group_index = 2 },
                    { name = "calc",       group_index = 3 },
                },
            },
        },
    }
end

local function get_dap(args)
    return {}
end

return {
    init_lsp = init_lsp,
    get_dap = get_dap,
    get_cmp = get_cmp,
    get_null_ls = get_null_ls,
    get_plugins = get_plugins,
}
