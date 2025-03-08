local function config()
    require("neo-tree").setup({
        window = {
            position = "float",
        },
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
    })

    vim.keymap.set("n", "<leader>ex", ":Neotree toggle<CR>")
end

local function get_plugin_spec()
    return {
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            },
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
