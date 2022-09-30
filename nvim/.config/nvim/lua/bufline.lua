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
nnoremap <silent><space>l :BufferLineCycleNext<CR>
nnoremap <silent><space>h :BufferLineCyclePrev<CR>

"move tab/buffer physically
nnoremap <silent><space> ml :BufferLineMoveNext<CR>
nnoremap <silent><space> mh :BufferLineMovePrev<CR>
]]

require('close_buffers').setup({})

-- Delete the current buffer
vim.api.nvim_set_keymap(
  'n',
  '<space>k', -- k for kill
  [[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]],
  { noremap = true, silent = true }
)

