local lsp_base = require('lsp_base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
}
lsp_base.setup_cmp(sources)

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

lspconfig.gopls.setup {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
    on_attach = lsp_base.on_attach,
    capabilities = lsp_base.capabilities,
    flags = lsp_base.flags,
}
