local function get_plugins()
    return {
        {
            {
                "uga-rosa/ccc.nvim",
            },
        },
    }
end

local function get_lsp(args)
    local utils = require("utils.helpers")
    local capabilites = utils.get_lsp_capabilities()
    capabilites.textDocument.completion.completionItem.snippetSupport = true

    local cssls = {
        filetype = "css",
        name = "cssls",
        setup = {
            capabilites = utils.get_lsp_capabilities,
            on_attach = utils.on_attach,
        },
    }

    vim.lsp.enable("stylelint_lsp")

    return cssls
end

local function get_null_ls(args)
    return {
        sources = { args.null_ls.formatting.prettier },
    }
end

local function get_cmp(args)
    return {
        setup = {
            filetype = {
                name = "html",
                sources = {
                    { name = "nvim_lsp", group_index = 0 },
                    { name = "snippets", group_index = 1 },
                    { name = "treesitter", group_index = 2 },
                    { name = "path", group_index = 2 },
                    { name = "buffer", group_index = 2 },
                    { name = "calc", group_index = 3 },
                },
            },
        },
    }
end

local function get_dap(args)
    return {}
end

return {
    get_lsp = get_lsp,
    get_dap = get_dap,
    get_cmp = get_cmp,
    get_null_ls = get_null_ls,
    get_plugins = get_plugins,
}
