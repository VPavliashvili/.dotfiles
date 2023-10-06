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
        show_close_icon = false,
    },
}

vim.cmd [[
"go to next/prev tab/buffer
nnoremap <silent><S-l> :BufferLineCycleNext<CR>
nnoremap <silent><S-h> :BufferLineCyclePrev<CR>
"move tab/buffer physically
nnoremap <silent><A-l> :BufferLineMoveNext<CR>
nnoremap <silent><A-h> :BufferLineMovePrev<CR>

"jump to the buffer number from 1 up to 10
nnoremap <silent><A-1> <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><A-2> <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><A-3> <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><A-4> <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><A-5> <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><A-6> <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><A-7> <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><A-8> <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><A-9> <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent><A-0> <Cmd>BufferLineGoToBuffer 10<CR>
]]

require('close_buffers').setup({})

-- Delete the current buffer
vim.api.nvim_set_keymap(
    'n',
    '<S-c>',
    [[<CMD>lua require('close_buffers').delete({type = 'this', force = true})<CR>]],
    { noremap = true, silent = true }
)

