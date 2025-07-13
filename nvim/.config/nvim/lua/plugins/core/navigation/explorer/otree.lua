local function config()
    require("Otree").setup({
        float = {
            center = true,
            width_ratio = 0.4,
            height_ratio = 0.7,
            padding = 2,
            cursorline = true,
            border = "rounded",
        },
    })

    vim.keymap.set("n", "<leader>ex", ":Otree <CR>")
end

local function get_plugin_spec()
    return {
        {
            "Eutrius/Otree.nvim",
            lazy = false,
            dependencies = {
                "stevearc/oil.nvim",
                "nvim-tree/nvim-web-devicons",
            },
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
