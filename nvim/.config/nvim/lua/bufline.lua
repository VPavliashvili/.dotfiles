require("bufferline").setup {
    options = {
        numbers = "both",
        indicator = {
            style = "underline"
        }
    }
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

