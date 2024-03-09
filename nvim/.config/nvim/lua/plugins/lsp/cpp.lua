return function(arg)
    require("lspconfig").clangd.setup({
        cmd = {
            "clangd",
            "--offset-encoding=utf-16",
        },
        on_attach = function(client, bufnr)
            client.server_capabilities.signatureHelpProvider = false
            arg.on_attach(client, bufnr)
        end,
        capabilities = arg.capabilities,
    })
end
