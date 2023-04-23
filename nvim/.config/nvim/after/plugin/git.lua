require('gitsigns').setup {
    signs      = {
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
}

local function contains(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local opened_buffers = function()
    local indexes = {}
    for i = 1, vim.fn.bufnr("$") do
        if vim.fn.buflisted(i) == 1 then
            table.insert(indexes, i)
        end
    end
    return indexes
end

local before = {}
local after = {}

vim.keymap.set('n', '<leader>gd', function()
    before = opened_buffers()
    vim.cmd(':DiffviewOpen')
end)

vim.keymap.set('n', '<leader>gc', function()
    after = opened_buffers()

    local to_be_closed = {}
    for _, value in ipairs(after) do
        if not contains(before, value) then
            table.insert(to_be_closed, value)
        end
    end

    vim.cmd('DiffviewClose')

    for _, bufindex in ipairs(to_be_closed) do
        vim.cmd('bdelete' .. tostring(bufindex))
    end
    before = {}
    after = {}
end)

vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory<CR>')
