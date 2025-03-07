local function get_lazy_specs()
    local folding = require("plugins.core.folding")
    local navigation = require("plugins.core.navigation")
    local treesitter = require("plugins.core.treesitter")
    local git = require("plugins.core.git")

    local plugins = {}
    vim.list_extend(plugins, treesitter.get_plugins_specs())
    vim.list_extend(plugins, navigation.get_plugins_specs())
    vim.list_extend(plugins, folding.get_plugins_specs())
    vim.list_extend(plugins, git.get_plugins_specs())

    return plugins
end

return {
    get_lazy_specs = get_lazy_specs,
}
