local lsp_base = require('lsp.base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
}
lsp_base.setup_cmp(sources)

local lspconfig = require "lspconfig"

local port = os.getenv('GDScript_Port') or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
local pipe = '/tmp/godot.pipe'

lspconfig.gdscript.setup {
    cmd = cmd,
    filetypes = { "gd", "gdscript", "gdscript3" },
    on_attach = function(client, bufnr)
        lsp_base.on_attach(client, bufnr)
        vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
    end,
    capabilities = lsp_base.capabilities,
    flags = lsp_base.flags,
}
