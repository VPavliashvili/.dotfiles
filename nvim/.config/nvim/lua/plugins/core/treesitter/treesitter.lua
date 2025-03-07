local function config()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
        indent = {
            enable = true,
        },
        endwise = {
            enable = true,
        },
    })
end

local function get_plugin_spec()
    return {
        {
            "nvim-treesitter/nvim-treesitter",
            config = config,
            dependencies = {
                "RRethy/nvim-treesitter-endwise",
            },
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
