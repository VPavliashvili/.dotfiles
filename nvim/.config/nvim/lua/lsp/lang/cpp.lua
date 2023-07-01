local lsp_base = require('lsp.base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
}

local lspconfig = require "lspconfig"

lspconfig.ccls.setup {
    init_options = {
        compilationDatabaseDirectory = "build",
        index = {
            threads = 0,
        },
        clang = {
            excludeArgs = { "-frounding-math" },
        },
    }
}
