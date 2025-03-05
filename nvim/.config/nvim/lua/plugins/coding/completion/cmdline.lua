local function config()
    local cmp = require("cmp")
    local utils = require("utils.helpers")

    local mapping = cmp.mapping.preset.cmdline({
        ["<TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                })
            elseif utils.has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end),
    })

    cmp.setup.cmdline("/", {
        mapping = mapping,
        sources = {
            { name = "nvim_lsp_document_symbol" },
            { name = "buffer" },
        },
    })

    cmp.setup.cmdline(":", {
        mapping = mapping,
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end

local function get_plugin_setup()
    return {
        {

            "hrsh7th/cmp-cmdline",
            config = config,
            dependencies = {
                "hrsh7th/nvim-cmp",
            },
        },
    }
end

return {
    get_plugin_setup = get_plugin_setup,
}
