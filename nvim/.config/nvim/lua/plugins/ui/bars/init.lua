local function get_plugins_specs()
    local lualine = require("plugins.ui.bars.lualine")
    local statuscol = require("plugins.ui.bars.statuscol")
    local heirline = require("plugins.ui.bars.heirline")

    local plugins = {}
    vim.list_extend(plugins, lualine.get_plugin_spec())
    vim.list_extend(plugins, statuscol.get_plugin_spec())
    vim.list_extend(plugins, heirline.get_plugin_spec())

    return plugins
end

return {
    get_plugins_specs = get_plugins_specs,
}
