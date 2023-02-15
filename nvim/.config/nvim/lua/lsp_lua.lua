local lsp_base = require('lsp_base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
}
lsp_base.setup_cmp(sources)

require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = lsp_base.on_attach,
    capabilities = lsp_base.capabilities,
    flags = lsp_base.flags,
}

