local completion = require("plugins.coding.completion")
local dap = require("plugins.coding.dap")
local language_configs = require("plugins.coding.languages")
local linting = require("plugins.coding.linting")

local function get_lazy_specs(args)
    local plugins = {
        {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("ibl").setup({
                    scope = {
                        enabled = false,
                    },
                })
            end,
        },
        {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end,
        },
    }

    vim.list_extend(plugins, dap.get_plugins_specs())
    vim.list_extend(plugins, linting.get_plugins_setups())
    vim.list_extend(plugins, completion.get_plugins_setups())
    vim.list_extend(plugins, language_configs.get_plugins_setups({}))

    return plugins
end

return {
    get_lazy_specs = get_lazy_specs,
}
