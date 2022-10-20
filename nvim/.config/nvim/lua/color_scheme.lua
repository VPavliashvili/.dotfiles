require('onedark').setup {
    style = 'deep',
    transparent = true,

    colors = {
        local_variable = "#ef5f6b",
    },

    highlights = {
        ["@variable"] = {fg = '$local_variable'},
    },
}

require('onedark').load()
