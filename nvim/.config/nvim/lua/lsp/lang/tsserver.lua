-- typescript and javascript langauge server
local lsp_base = require('lsp.base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
}
lsp_base.setup_cmp(sources)

local lspconfig = require "lspconfig"

lspconfig.tsserver.setup {
    on_attach = lsp_base.on_attach,
    capabilities = lsp_base.capabilities,
}
