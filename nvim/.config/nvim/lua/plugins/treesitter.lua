local function setup()
    require("nvim-treesitter.configs").setup({
        -- -- ensure_installed = {
        -- --     "c", "lua", "vim", "vimdoc", "c_sharp", "go", "gomod", "gosum", "gowork",
        -- --     "json", "markdown", "markdown_inline", "bash", "html", "json5", "python"
        -- -- },
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
    })
end

return setup
