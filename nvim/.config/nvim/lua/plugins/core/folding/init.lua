local function get_plugins_specs()
    local ufo = require("plugins.core.folding.nvim-ufo")

    local plugins = {}
    vim.list_extend(plugins, ufo.get_plugin_spec())

    return plugins
end

return {
    get_plugins_specs = get_plugins_specs,
}
