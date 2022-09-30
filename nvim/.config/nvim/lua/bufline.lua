local function diagnostics_indicator(_, _, diagnostics)
    local symbols = { error = ' ', warning = ' ', info = ' ' }
    local result = {}
    for name, count in pairs(diagnostics) do
        if symbols[name] and count > 0 then
            table.insert(result, symbols[name] .. count)
        end
    end
    result = table.concat(result, ' ')
    return #result > 0 and result or ''
end

require("bufferline").setup {
    options = {
        numbers = "both",
        indicator = {
            style = "underline"
        },
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = diagnostics_indicator,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            },
        },
    },
}

vim.cmd [[
"go to next/prev tab/buffer
nnoremap <silent><S-l> :BufferLineCycleNext<CR>
nnoremap <silent><S-h> :BufferLineCyclePrev<CR>

"move tab/buffer physically
nnoremap <silent><A-l> :BufferLineMoveNext<CR>
nnoremap <silent><A-h> :BufferLineMovePrev<CR>
]]

require('close_buffers').setup({})

-- Delete the current buffer
vim.api.nvim_set_keymap(
    'n',
    '<S-c>', -- k for kill
    [[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]],
    { noremap = true, silent = true }
)
