return function()
    require("lspconfig.ui.windows").default_options.border = "single"

    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "<leader>sg", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<leader>fm", function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("plugins.lsp.lua")({ on_attach = on_attach, capabilities = capabilities })
    require("plugins.lsp.cpp")({ on_attach = on_attach, capabilities = capabilities })
    require("plugins.lsp.python")({ on_attach = on_attach, capabilities = capabilities })
    require("plugins.lsp.go")({ on_attach = on_attach, capabilities = capabilities })
end
