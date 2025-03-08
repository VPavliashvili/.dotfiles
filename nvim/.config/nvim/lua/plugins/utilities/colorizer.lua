local function config()
    require("colorizer").setup({
        --'*'; -- Highlight all files, but customize some others.
        javascript = { names = false },
        css = { rgb_fn = true, hsl_fn = true }, -- Enable parsing rgb(...) functions in css.
        html = { names = false },               -- Disable parsing "names" like Blue or Gray

        go = { names = false },
        gdscript = { names = false },
        lua = { names = false },
    })
end

local function get_plugin_spec()
    return {
        {
            "norcalli/nvim-colorizer.lua",
            config = config,
            dependencies = {
                "NTBBloodbath/color-converter.nvim",
            },
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
