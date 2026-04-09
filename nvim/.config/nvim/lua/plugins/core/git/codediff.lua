local function config()
    vim.keymap.set("n", "<leader>gd", function()
        vim.cmd(":CodeDiff")
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
                        quit = "<leader>gc",
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
