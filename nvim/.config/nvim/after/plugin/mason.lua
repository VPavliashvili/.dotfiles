require("mason").setup({
    ui = {
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "double",
    }
})

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "gopls", "pyright", "jsonls" },
}
