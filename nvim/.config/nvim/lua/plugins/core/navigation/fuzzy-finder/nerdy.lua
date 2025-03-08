local function get_plugin_spec()
    return {
        {
            "https://github.com/2KAbhishek/nerdy.nvim",
            dependencies = {
                "stevearc/dressing.nvim",
                "nvim-telescope/telescope.nvim",
            },
            config = function()
                local telescope = require("telescope")
                telescope.load_extension("nerdy")
                -- this will be the command
                -- telescope.extensions.nerdy.nerdy,
            end,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
