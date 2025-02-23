return function(arg)
    require("lspconfig").pyright.setup({
        on_attach = arg.on_attach,
        capablities = arg.capablities,
    })
end
