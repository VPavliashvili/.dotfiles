local function get_plugins_setups()
    local none_ls = require("plugins.coding.linting.none-ls")
    local lspconfig = require("plugins.coding.linting.lspconfig")

    local plugins = {}
    vim.list_extend(plugins, none_ls.get_plugin_spec())
    vim.list_extend(plugins, lspconfig.get_plugin_spec())

    return plugins
end

return {
    get_plugins_setups = get_plugins_setups,
}
