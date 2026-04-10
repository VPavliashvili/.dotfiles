local function get_plugin_spec()
    return {
        {
            "isakbm/gitgraph.nvim",
            opts = {
                symbols = {
                    merge_commit = "M",
                    commit = "*",
                },
                format = {
                    timestamp = "%H:%M:%S %d-%m-%Y",
                    fields = { "hash", "timestamp", "author", "branch_name", "tag" },
                },
                hooks = {
                    -- Check diff of a commit
                    on_select_commit = function(commit)
                        vim.notify("CodeDiff " .. commit.hash .. "~ " .. commit.hash)
                        vim.cmd("CodeDiff " .. commit.hash .. "~ " .. commit.hash)
                    end,
                    -- Check diff from commit a -> commit b
                    on_select_range_commit = function(from, to)
                        vim.notify("CodeDiff " .. from.hash .. "~ " .. to.hash)
                        vim.cmd("CodeDiff " .. from.hash .. "~ " .. to.hash)
                    end,
                },
            },
            keys = {
                {
                    "<leader>gl",
                    function()
                        vim.cmd("tabnew")
                        require("gitgraph").draw({}, { all = true, max_count = 5000 })
                    end,
                    desc = "GitGraph - Draw",
                },
            },
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
