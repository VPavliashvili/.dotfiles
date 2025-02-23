return function(args)
    require("lspconfig").gopls.setup({
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
        on_attach = args.on_attach,
        capabilities = args.capabilities
    })
end
