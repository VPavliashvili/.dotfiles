local function config()
    vim.keymap.set("n", "<leader>gd", function()
        vim.cmd(":DiffviewOpen")
    end)

    vim.keymap.set("n", "<leader>gc", function()
        vim.cmd("DiffviewClose")

        if vim.g.user_counter and vim.g.user_counter > 0 then
            local tab_no = vim.fn.tabpagenr()
            vim.cmd(tab_no .. "tabclose!")

            vim.g.user_counter = vim.g.user_counter - 1
        end
    end)

    vim.keymap.set("n", "<leader>gh", function()
        vim.cmd(":DiffviewFileHistory")
    end)
end

local function get_plugin_spec()
    return {
        {
            "sindrets/diffview.nvim",
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
