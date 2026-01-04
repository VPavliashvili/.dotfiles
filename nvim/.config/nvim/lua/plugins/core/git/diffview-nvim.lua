local function config()
    vim.keymap.set("n", "<leader>gd", function()
        vim.cmd(":DiffviewOpen")
    end)

    vim.keymap.set("n", "<leader>gc", function()
        local focus_on_diffview = false
        local diffview_buf_prefix = "diffview:"

        local focus_on_gitgraph = false
        local gitgraph_buf_postfix = "GitGraph"

        local windows = vim.api.nvim_tabpage_list_wins(0)
        for _, win in ipairs(windows) do
            local bufnr = vim.api.nvim_win_get_buf(win)
            local filepath = vim.api.nvim_buf_get_name(bufnr)
            if #diffview_buf_prefix <= #filepath and filepath:sub(1, #diffview_buf_prefix) == diffview_buf_prefix then
                focus_on_diffview = true
                break
            end
            if #gitgraph_buf_postfix <= #filepath and filepath:sub(- #gitgraph_buf_postfix) == gitgraph_buf_postfix then
                focus_on_gitgraph = true
                break
            end
        end

        if focus_on_diffview then
            vim.cmd("DiffviewClose")
            return
        end

        if focus_on_gitgraph then
            local tab_no = vim.fn.tabpagenr()
            vim.cmd(tab_no .. "tabclose!")
            return
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
