--color scheme
require('onedark').setup {
    style = 'cool',
    transparent = true,
}
require('onedark').load()

-- nvim-tree
require("nvim-tree").setup()

-- nvim-cursorline
require('nvim-cursorline').setup {
    cursorline = {
        enable = true,
        timeout = 0,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    }
}
