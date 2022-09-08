require('onedark').setup {
    style = 'cool',
    transparent = true,

    colors = {
        local_variable = "#ef5f6b",
    },

    highlights = {
        TSVariable = { fg = '$local_variable' },
    },
}

require('onedark').load()
