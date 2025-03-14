local function get_plugins_specs()
    local blame = require("plugins.core.git.blame-nvim")
    local diffview = require("plugins.core.git.diffview-nvim")
    local gitsigns = require("plugins.core.git.gitsigns")
    local gitgraph = require("plugins.core.git.gitgraph")

    local plugins = {}
    vim.list_extend(plugins, blame.get_plugin_spec())
    vim.list_extend(plugins, diffview.get_plugin_spec())
    vim.list_extend(plugins, gitsigns.get_plugin_spec())
    vim.list_extend(plugins, gitgraph.get_plugin_spec())

    return plugins
end

return {
    get_plugins_specs = get_plugins_specs,
}
