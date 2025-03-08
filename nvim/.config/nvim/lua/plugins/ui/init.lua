local function get_lazy_specs()
    local theme = require("plugins.ui.theme")
    local bars = require("plugins.ui.bars")

    local plugins = {}
    vim.list_extend(plugins, theme.get_plugins_specs())
    vim.list_extend(plugins, bars.get_plugins_specs())

    return plugins
end

return {
    get_lazy_specs = get_lazy_specs,
}
