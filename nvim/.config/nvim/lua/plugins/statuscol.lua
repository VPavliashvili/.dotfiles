local function setup()
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

return setup
