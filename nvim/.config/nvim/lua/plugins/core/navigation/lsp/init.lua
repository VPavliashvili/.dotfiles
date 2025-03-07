local function get_plugins_setups()
    local lspsaga = require("plugins.core.navigation.lsp.lspsaga")

    local plugins = {}
    vim.list_extend(plugins, lspsaga.get_plugin_spec())

    return plugins
end

return {
    get_plugins_setups = get_plugins_setups,
}
