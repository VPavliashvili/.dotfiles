--color scheme
require('color_scheme')

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

require 'colorizer'.setup {
    --'*'; -- Highlight all files, but customize some others.
    javascript = { names = false; };
    css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
    html = { names = false; }; -- Disable parsing "names" like Blue or Gray

    go = { names = false; };
    gdscript = { names = false; };
    lua = { names = false; };
}

require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

-- open/close FTerm
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
