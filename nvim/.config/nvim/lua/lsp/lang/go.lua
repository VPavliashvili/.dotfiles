local lsp_base = require('lsp.base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
}
lsp_base.setup_cmp(sources)

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

lspconfig.gopls.setup {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.mod", ".git"),
    single_file_support = true,
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