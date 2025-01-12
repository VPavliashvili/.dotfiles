return function()
    local on_attach = function(bufnr)
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

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client == nil then
                error("client was nil")
                return
            end

            if client.name == "roslyn" then
                on_attach(bufnr)
            end
        end,
    })

    -- require("csharp").setup({
    --     omnisharp = { enable = false },
    --     roslyn = {
    --         enable = true,
    --         cmd_path = vim.fn.exepath("Microsoft.CodeAnalysis.LanguageServer"),
    --     },
    --     dap = {
    --         adapter_name = "handling this manually in plugins.dap.csharp",
    --     },
    -- })
end
