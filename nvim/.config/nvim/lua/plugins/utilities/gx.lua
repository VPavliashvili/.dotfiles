local function get_plugin_spec()
    return {
        {
            "chrishrb/gx.nvim",
            keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
            cmd = { "Browse" },
            init = function()
                vim.g.netrw_nogx = 1
            end,
            dependencies = { "nvim-lua/plenary.nvim" },
            config = true,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
