local lsp_base = require('lsp_base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
}
lsp_base.setup_cmp(sources)

local lspconfig = require "lspconfig"

lspconfig.csharp_ls.setup {
    cmd = { "csharp-ls" },
    filetypes = { "cs" },
    init_options = { AutomaticWorkspaceInit = true },
    handlers = {
        ["textDocument/definition"] = require("csharpls_extended").handler,
    },
    on_attach = lsp_base.on_attach,
    capabilities = lsp_base.capabilities,
    flags = lsp_base.flags,
}
