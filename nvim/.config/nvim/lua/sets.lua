vim.cmd [[
filetype plugin indent on
" don't need set cursorline anymore
" because of cursorline plugin setup in misc.lua
set number
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nobackup
set incsearch
set scrolloff=4
set signcolumn=yes  
set nowritebackup
set noswapfile
set mouse=

set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set foldmethod=manual
]]

vim.opt.termguicolors = true
