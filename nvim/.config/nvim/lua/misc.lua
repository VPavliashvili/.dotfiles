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

-- nvim-colorizer
-- Attaches to every FileType mode
require 'colorizer'.setup()

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require 'colorizer'.setup {
    '*'; -- Highlight all files, but customize some others.
    css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
    html = { names = false; } -- Disable parsing "names" like Blue or Gray
}
