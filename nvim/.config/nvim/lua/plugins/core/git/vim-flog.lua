local function get_plugin_spec()
    return {
        {
            "rbong/vim-flog",
            dependencies = "tpope/vim-fugitive",
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
