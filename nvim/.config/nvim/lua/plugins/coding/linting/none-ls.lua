local function config()
    local null_ls = require("null-ls")
    local utils = require("utils.helpers")
    local null_ls_sources = require("plugins.coding.languages").get_null_ls_configs({ null_ls = null_ls.builtins })

    local sources = {}
    for k, src in pairs(null_ls_sources) do
        table.insert(sources, src)
    end

    null_ls.setup({
        sources = sources,
        on_attach = utils.on_attach,
    })
end

local function get_plugin_spec()
    return {
        {
            "nvimtools/none-ls.nvim",
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
