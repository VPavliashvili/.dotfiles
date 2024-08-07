local function setup()
    require("gitsigns").setup({
        signs = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    })

    local function contains(tab, val)
        for _, value in ipairs(tab) do
            if value == val then
                return true
            end
        end

        return false
    end

    local opened_buffers = function()
        local indexes = {}
        for i = 1, vim.fn.bufnr("$") do
            if vim.fn.buflisted(i) == 1 then
                table.insert(indexes, i)
            end
        end
        return indexes
    end

    local before = {}
    local after = {}

    vim.keymap.set("n", "<leader>gd", function()
        before = opened_buffers()
        vim.cmd(":DiffviewOpen")
    end)

    vim.keymap.set("n", "<leader>gc", function()
        after = opened_buffers()
        if #before == 0 then
            return
        end

        local to_be_closed = {}
        for _, value in ipairs(after) do
            if not contains(before, value) then
                table.insert(to_be_closed, value)
            end
        end

        vim.cmd("DiffviewClose")

        for _, bufindex in ipairs(to_be_closed) do
            vim.cmd("bdelete" .. tostring(bufindex))
        end
        before = {}
        after = {}
    end)

    vim.keymap.set("n", "<leader>gh", function()
        before = opened_buffers()
        vim.cmd(":DiffviewFileHistory")
    end)
end
return setup
