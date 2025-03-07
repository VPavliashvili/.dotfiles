local function config()
    require("neo-tree").setup({
        window = {
            position = "float",
        },
    })

    vim.keymap.set("n", "<leader>ex", ":Neotree toggle<CR>")
end

local function get_plugins_setups()
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
    get_plugins_setups = get_plugins_setups,
}
