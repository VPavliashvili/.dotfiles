local function get_plugins()
    return {}
end

local function get_lsp(args)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "html",
        callback = function()
            vim.b.did_indent = 1
            vim.opt_local.shiftwidth = 2
            vim.opt_local.tabstop = 2
            vim.opt_local.softtabstop = 2
            vim.opt_local.expandtab = true
            vim.opt_local.smartindent = true
        end,
    })

    local utils = require("utils.helpers")

    vim.lsp.enable("emmet_language_server")

    return {
        filetype = "html",
        name = "html",
        setup = {
            capabilites = utils.get_lsp_capabilities,
            on_attach = utils.on_attach,
        },
    }
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
