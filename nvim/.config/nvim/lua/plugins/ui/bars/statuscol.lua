local function config()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
        -- foldfunc = "builtin",
        -- setopt = true,
        relculright = true,
        segments = {
            { text = { builtin.foldfunc } },
            { text = { "%s" } },
            { text = { builtin.lnumfunc, " " } },
        },
    })
end

local function get_plugin_spec()
    return {
        {
            "luukvbaal/statuscol.nvim",
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
