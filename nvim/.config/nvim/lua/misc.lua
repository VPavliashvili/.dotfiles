--color scheme
require('onedark').setup {
    style = 'cool',
    transparent = true,
}
require('onedark').load()

--lualine
require('lualine').setup {
    options = {
        theme = 'onedark'
    }
}

-- nvim-tree
require("nvim-tree").setup()
