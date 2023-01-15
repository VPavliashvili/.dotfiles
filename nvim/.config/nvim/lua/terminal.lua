require 'FTerm'.setup({
    border     = 'double',
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
})

-- open/close FTerm
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

local fterm = require("FTerm")

local lazygit = fterm:new({
    ft = 'fterm_lazygit',
    cmd = "lazygit",
    dimensions = {
        height = 1,
        width = 1
    }
})

local btop = fterm:new({
    ft = 'fterm_btop',
    cmd = "btop",
    dimensions = {
        height = 1,
        width = 1
    }
})

-- Use this to toggle btop in a floating terminal
vim.keymap.set('n', '<space>g', function()
    lazygit:toggle()
end)

vim.keymap.set('n', '<space>bt', function()
    btop:toggle()
end)
