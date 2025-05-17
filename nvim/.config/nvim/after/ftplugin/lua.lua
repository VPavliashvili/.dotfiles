vim.keymap.set("n", "<leader>tl", "<cmd>PlenaryBustedFile %<CR>")

-- asuming I am working on nvim plugin and nvim cwd is on plugins root directory
vim.keymap.set("n", "<leader>td", "<cmd>PlenaryBustedDirectory ./tests<CR>")
