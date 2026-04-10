local function config()
    vim.keymap.set("n", "<leader>gd", function()
        vim.cmd(":CodeDiff")
    end)

    vim.keymap.set("n", "<leader>gh", function()
        vim.cmd(":CodeDiff history %")
    end)
end

local function get_plugin_spec()
    config()

    return {
        {
            "esmuellert/codediff.nvim",
            cmd = "CodeDiff",
            opts = {
                explorer = {
                    view_mode = "tree",
                },
                history = {
                    view_mode = "tree",
                },
                keymaps = {
                    view = {
                        toggle_stage = "s",
                    },
                },
            },
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
