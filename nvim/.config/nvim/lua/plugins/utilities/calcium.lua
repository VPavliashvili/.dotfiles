local function get_plugin_spec()
    return {
        {
            "necrom4/calcium.nvim",
            cmd = { "Calcium" },
            opts = {},
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
