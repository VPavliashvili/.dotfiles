-- local function config()
--     vim.keymap.set("n", "<leader>ex", ":Fyler kind=float<CR>")
-- end

local function get_plugin_spec()
    vim.keymap.set("n", "<leader>ex", ":Fyler kind=float<CR>")

    return {
        {
            "A7Lavinraj/fyler.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            branch = "stable",
            opts = { -- check the default options in the README.md
                icon_provider = "nvim-web-devicons",
            },
            -- config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
