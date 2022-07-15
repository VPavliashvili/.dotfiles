
"general configurations
lua require('plugins')
lua require('sets')
lua require('maps')
lua require('telescope_conf')

"lsp and language configurations
lua require('lsp_lua')
lua require('lsp_godot')
lua require('lsp_go')

"treesitter
lua require('treesitter')

"debuggers
lua require('debuggers')

let g:onedark_config = {
    \ 'style': 'cool',
\}
colorscheme onedark
let g:airline_theme='jellybeans'
hi CursorLine cterm=NONE ctermbg=242
set encoding=utf-8
scriptencoding utf-8
