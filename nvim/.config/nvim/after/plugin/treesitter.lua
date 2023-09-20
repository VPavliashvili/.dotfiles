local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.hypr = {
    install_info = {
        url = "https://github.com/luckasranarison/tree-sitter-hypr",
        files = { "src/parser.c" },
        branch = "master",
    },
    filetype = "hypr",
}

require 'nvim-treesitter.configs'.setup {
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
        enable = true
    },
}
