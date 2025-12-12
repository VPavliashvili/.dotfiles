local function config() end

local function get_plugin_spec()
    return {
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = "cd app && npx --yes yarn install",
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
