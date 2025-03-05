local function get_plugins_setups()
    local cmp = require("plugins.coding.completion.cmp-nvim")
    local cmdline = require("plugins.coding.completion.cmdline")
    local autopair = require("plugins.coding.completion.autopairs")

    local plugins = {}
    vim.list_extend(plugins, cmp.get_plugin_setup())
    vim.list_extend(plugins, cmdline.get_plugin_setup())
    vim.list_extend(plugins, autopair.get_plugin_setup())

    return plugins
end

return {
    get_plugins_setups = get_plugins_setups,
}
