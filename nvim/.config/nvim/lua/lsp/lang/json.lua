local lsp_base = require('lsp.base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
}
lsp_base.setup_cmp(sources)

local schemas = require 'schemastore'.json.schemas()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.jsonls.setup {
    capabilities = capabilities,
    on_attach = lsp_base.on_attach,
    settings = {
        json = {
            schemas = schemas,
            validate = { enable = true },
        }
    }
}

-- minifying json
vim.keymap.set('n', '<leader>jm', ":%!jq -c <CR>==", { silent = true })
