vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.mouse = ""
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.smartindent = true
vim.opt["guicursor"] = ""

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})

vim.cmd([[autocmd FileType * set formatoptions-=ro]])
