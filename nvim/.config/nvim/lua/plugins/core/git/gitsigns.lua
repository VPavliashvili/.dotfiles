local function config()
    require("gitsigns").setup({
        signs = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        preview_config = {
            border = "rounded",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        on_attach = function(bufnr)
            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            local gitsigns = require("gitsigns")

            -- popup window with git info for the current line
            map("n", "<leader>gi", function()
                gitsigns.blame_line({ full = true })
            end)
            map("n", "<leader>bl", function()
                gitsigns.blame()
            end)
        end,
    })
end

local function get_plugin_spec()
    return {
        {
            "lewis6991/gitsigns.nvim",
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
