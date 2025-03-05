local completion = require("plugins.coding.completion")
local dap = require("plugins.coding.dap")
local language_configs = require("plugins.coding.languages")
local linting = require("plugins.coding.linting")

local function get_lazy_specs(args)
    -- this will be used in c# part of the lazy specs
    -- {
    --     "seblj/roslyn.nvim",
    --     ft = "cs",
    --     opts = {
    --         exe = vim.fn.exepath("Microsoft.CodeAnalysis.LanguageServer"), -- this for NixOS
    --     },
    -- },

    local plugins = {}
    vim.list_extend(plugins, dap.get_plugins_specs())
    vim.list_extend(plugins, linting.get_plugins_setups())
    vim.list_extend(plugins, completion.get_plugins_setups())
    vim.list_extend(plugins, language_configs.get_plugins_setups({}))

    return plugins
end

return {
    get_lazy_specs = get_lazy_specs,
}
