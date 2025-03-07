local function get_plugin_spec()
    return {
        {
            "FabijanZulj/blame.nvim",
            config = function()
                require("blame").setup()
            end,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
