local function get_lazy_specs()
    local gx = require("plugins.utilities.gx")
    local auto_session = require("plugins.utilities.auto-session")
    local colorizer = require("plugins.utilities.colorizer")
    local markdown_preview = require("plugins.utilities.markview_preview")
    -- local markview = require("plugins.utilities.markview")

    local plugins = {
        {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
                require("which-key").setup({})
            end,
        },
        {
            "RRethy/vim-illuminate",
        },
    }

    vim.list_extend(plugins, gx.get_plugin_spec())
    vim.list_extend(plugins, auto_session.get_plugin_spec())
    vim.list_extend(plugins, colorizer.get_plugin_spec())
    vim.list_extend(plugins, markdown_preview.get_plugin_spec())

    return plugins
end

return {
    get_lazy_specs = get_lazy_specs,
}
