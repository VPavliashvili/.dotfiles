local function get_plugins_setups()
    local neotree = require("plugins.core.navigation.explorer.neo-tree")
    local otree = require("plugins.core.navigation.explorer.otree")

    local plugins = {}
    vim.list_extend(plugins, neotree.get_plugin_spec())

    return plugins
end

return {
    get_plugins_setups = get_plugins_setups,
}
