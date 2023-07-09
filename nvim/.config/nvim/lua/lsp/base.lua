local instance = {}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
instance.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'sg', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
end

instance.flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

instance.capabilities = require('cmp_nvim_lsp').default_capabilities()

instance.setup_cmp = function(completion_sources)
    local cmp = require('cmpconf')
    cmp.setup_for_lsp(completion_sources)
end

return instance
