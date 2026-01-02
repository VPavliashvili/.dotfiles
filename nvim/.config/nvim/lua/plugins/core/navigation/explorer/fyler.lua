-- local function config()
--     vim.keymap.set("n", "<leader>ex", ":Fyler kind=float<CR>")
-- end

local function get_plugin_spec()
    -- vim.keymap.set("n", "<leader>ex", ":Fyler kind=float<CR>")

    return {
        {
            "A7Lavinraj/fyler.nvim",
            dependencies = "echasnovski/mini.icons",
            cmd = { "Fyler" },
            keys = {
                {
                    "<Space>ex",
                    "<CMD>Fyler kind=float<CR>",
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
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
