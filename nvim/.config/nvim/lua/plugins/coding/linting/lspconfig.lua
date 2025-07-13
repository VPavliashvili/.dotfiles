local function config()
    require("lspconfig.ui.windows").default_options.border = "single"

    local lsp_configs = require("plugins.coding.languages").get_lsp_configs()

    for k, cfg in pairs(lsp_configs) do
        if cfg == nil or cfg.name == nil then
            goto continue
        end

        require("lspconfig")[cfg.name].setup(cfg.setup)
        ::continue::
    end
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
