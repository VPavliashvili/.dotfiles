local function get_plugins_specs()
    local explorer = require("plugins.core.navigation.explorer")
    local fuzzy_finder = require("plugins.core.navigation.fuzzy-finder")
    local lsp = require("plugins.core.navigation.lsp")

    local plugins = {}
    vim.list_extend(plugins, explorer.get_plugins_setups())
    vim.list_extend(plugins, fuzzy_finder.get_plugins_setups())
    vim.list_extend(plugins, lsp.get_plugins_setups())

    return plugins
end

return {
    get_plugins_specs = get_plugins_specs,
}
