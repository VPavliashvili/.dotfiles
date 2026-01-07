local function get_plugins()
    return {}
end

local function get_null_ls(args)
    return nil
end

local function get_dap(args)
    return nil
end

local function get_cmp(args)
    return {
        setup = {
            filetype = {
                name = "py",
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

            if client.name == "basedpyright" then
                utils.on_attach(client, bufnr)
            end
        end,
    })

    vim.lsp.enable("basedpyright")
    vim.lsp.enable("ruff")
end

return {
    init_lsp = init_lsp,
    get_dap = get_dap,
    get_cmp = get_cmp,
    get_null_ls = get_null_ls,
    get_plugins = get_plugins,
}
