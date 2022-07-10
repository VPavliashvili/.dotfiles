local lsp_base = require('lsp_base')

local sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
}
lsp_base.setup_cmp(sources)

vim.cmd [[
let g:godot_executable = 'C:\ProgramData\chocolatey\bin\godot.exe'
func! GodotSettings() abort
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end


set completeopt=menu,menuone,noselect
]]

require 'lspconfig'.gdscript.setup{
    on_attach = lsp_base.on_attach,
    capabilities = lsp_base.capabilities,
    flags = lsp_base.flags,
}




