local function config() end

local function get_plugin_spec()
    return {
        {
            "OXY2DEV/markview.nvim",
            lazy = false,
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
