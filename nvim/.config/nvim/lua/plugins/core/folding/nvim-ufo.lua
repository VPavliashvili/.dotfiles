local function config()
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
        end,
    })

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "<leader>v", require("ufo").peekFoldedLinesUnderCursor)
end

local function get_plugin_spec()
    return {
        {
            "kevinhwang91/nvim-ufo",
            dependencies = {
                "kevinhwang91/promise-async",
            },
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
