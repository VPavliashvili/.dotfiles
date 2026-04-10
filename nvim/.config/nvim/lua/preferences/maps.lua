-- builtin keymaps
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>nh", vim.cmd.noh, { desc = "remove current highligt" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

vim.keymap.set("n", "<C-j>", "<C-e>")
vim.keymap.set("n", "<C-k>", "<C-y>")

vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", '"+p')

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- this keymap keeps visual mode selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- when searching for a word avoid jumping automatically
vim.keymap.set("n", "*", "*N", { noremap = true })

vim.keymap.set("n", "<leader>gc", function()
    local count = #vim.api.nvim_list_tabpages()
    if count > 1 then
        vim.cmd("tabclose")
    end
end, { desc = "close current tab if its not only" })

vim.keymap.set("n", "<leader>tn", function()
    local buf = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(buf)
    local is_empty = name == ""

    if is_empty then
        -- used for unnamed buffers
        vim.cmd("tabnew")
    else
        -- used for anything else
        vim.cmd("tabnew %")
    end
end, { desc = "create new tab" })
