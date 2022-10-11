--color scheme
require('color_scheme')

-- nvim-tree
require("nvim-tree").setup()
vim.cmd [[
:NvimTreeFocus
]]

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

require 'colorizer'.setup {
    --'*'; -- Highlight all files, but customize some others.
    javascript = { names = false; };
    css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
    html = { names = false; }; -- Disable parsing "names" like Blue or Gray

    go = { names = false; };
    gdscript = { names = false; };
    lua = { names = false; };
}
