require('onedark').setup {
    style = 'deep',
    transparent = true,

    colors = {
        local_variable = "#ef5f6b",
        line_number = "#2D6D90",
        line_number_highlighted = "#A5D4DC"
    },

    highlights = {
        ["@variable"] = { fg = '$local_variable' },
        LineNr = { fg = '$line_number' },
        CursorLineNr = { fg = '$line_number_highlighted' }
    },
}

require('onedark').load()
