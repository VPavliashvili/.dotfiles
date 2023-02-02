vim.cmd [[
"drag line up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi

"scroll screen up and down maps
nnoremap <C-k> <C-y>
nnoremap <C-j> <C-e>

"hide highlighings
nnoremap <space>nh :noh<CR>

"Nvim Tree external maps
nnoremap <leader>ft :NvimTreeFocus<CR>
nnoremap <leader>rt :NvimTreeRefresh<CR>
nnoremap <leadeR>tt :NvimTreeToggle<CR>

"yanking
vnoremap <space>y "+y
nnoremap <space>p "+p
vnoremap <space>p "+p

"json formatter
autocmd FileType json nnoremap <leader>jq :%!jq<CR>==
]]
