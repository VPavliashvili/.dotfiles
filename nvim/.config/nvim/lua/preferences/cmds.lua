-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})

-- avoid inserting comments on new line in any language
-- for now commenting this out, I am not sure I was this feature disabled
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])
