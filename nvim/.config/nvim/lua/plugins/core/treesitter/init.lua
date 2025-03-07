local function get_plugins_specs()
    local treesitter = require("plugins.core.treesitter.treesitter")

    local plugins = {}
    vim.list_extend(plugins, treesitter.get_plugin_spec())

    return plugins
end

return {
    get_plugins_specs = get_plugins_specs,
}
