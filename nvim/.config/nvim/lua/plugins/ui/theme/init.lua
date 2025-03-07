local function get_plugins_specs()
    local onedarkpro = require("plugins.ui.theme.onedarkpro")

    local plugins = {}
    vim.list_extend(plugins, onedarkpro.get_plugin_spec())

    return plugins
end

return {
    get_plugins_specs = get_plugins_specs,
}
