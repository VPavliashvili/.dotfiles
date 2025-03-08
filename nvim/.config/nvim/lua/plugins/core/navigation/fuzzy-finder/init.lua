local function get_plugins_setups()
    local telescope = require("plugins.core.navigation.fuzzy-finder.telescope")
    local nerdy = require("plugins.core.navigation.fuzzy-finder.nerdy")

    local plugins = {}
    vim.list_extend(plugins, telescope.get_plugin_spec())
    vim.list_extend(plugins, nerdy.get_plugin_spec())

    return plugins
end

return {
    get_plugins_setups = get_plugins_setups,
}
