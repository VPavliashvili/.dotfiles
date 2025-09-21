local function config()
    require("lspconfig.ui.windows").default_options.border = "single"
    require("plugins.coding.languages").init_lsp_configs()
end

local function get_plugin_spec()
    return {
        {
            "neovim/nvim-lspconfig",
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
