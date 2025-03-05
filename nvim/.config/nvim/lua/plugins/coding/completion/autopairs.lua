local function config()
    require("nvim-autopairs").setup({
        check_ts = true,
    })

    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local function get_plugin_setup()
    return {
        {
            "windwp/nvim-autopairs",
            dependencies = {
                "hrsh7th/nvim-cmp",
                "nvim-treesitter/nvim-treesitter",
            },
            config = config,
        },
    }
end

return {
    get_plugin_setup = get_plugin_setup,
}
