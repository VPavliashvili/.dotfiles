local function config()
    local fyler = require("fyler")

    fyler.setup({
        integrations = {
            icon = "nvim_web_devicons",
        },
    })
end

local function get_plugin_spec()
    return {
        {
            "A7Lavinraj/fyler.nvim",
            dependencies = "echasnovski/mini.icons",
            cmd = { "Fyler" },
            keys = {
                {
                    "<Space>ex",
                    "<CMD>Fyler kind=floating<CR>",
                    desc = "Open Fyler",
                },
            },
            opts = {
                views = {
                    explorer = {
                        default_explorer = false,
                    },
                },
            },
            lazy = false,
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
