
"general configurations
lua require('plugins')
lua require('sets')
lua require('maps')
lua require('telescope_conf')

"lsp and language configurations
lua require('lsp_lua')
lua require('lsp_godot')
lua require('lsp_go')
lua require('lsp_python')
lua require('lsp_tsserver')
lua require('lsp_csharp')
lua require('lsp_json')

"treesitter
lua require('treesitter')

"debuggers
lua require('debuggers')

"misc
lua require('misc')
lua require('statusline')
lua require('web_icons')
lua require('bufline')
lua require('terminal')
lua require('git')

set encoding=utf-8
scriptencoding utf-8

"autocmds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END
