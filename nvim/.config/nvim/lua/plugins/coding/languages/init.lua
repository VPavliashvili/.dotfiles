local language_specs = {}

local lua = require("new.plugins.coding.languages.lua")

table.insert(language_specs, lua)

local function get_lsp_configs(args)
    local lspconfigs = {}
    for k, specs in pairs(language_specs) do
        local lsp = specs.get_lsp(args)
        table.insert(lspconfigs, { name = lsp.name, setup = lsp.setup })
    end

    return lspconfigs
end

local function get_dap_configs(args)
    local dap_configs = {}
    for k, specs in pairs(language_specs) do
        local dap_specs = specs.get_dap(args)
        if dap_specs == nil or next(dap_specs) == nil then
            goto continue
        end

        table.insert(dap_configs, {
            adapter = {
                name = dap_specs.adapter.name,
                config = dap_specs.adapter.config,
            },
            configuration = {
                name = dap_specs.configuration.name,
                config = dap_specs.configuration.config,
            },
        })
        ::continue::
    end

    return dap_configs
end

local function get_cmp_configs(args)
    local cmp_configs = {}
    for k, specs in pairs(language_specs) do
        local cmp = specs.get_cmp(args)

        table.insert(cmp_configs, cmp.setup)
    end

    return cmp_configs
end

local function get_null_ls_configs(args)
    local null_ls_sources = {}
    for k, specs in pairs(language_specs) do
        local null_ls = specs.get_null_ls(args)

        null_ls_sources = vim.tbl_extend("keep", null_ls_sources, null_ls.sources)
    end

    return null_ls_sources
end

local function get_plugins_setups(args)
    local plugins = {}
    for k, specs in pairs(language_specs) do
        local incoming = specs.get_plugins(args)

        plugins = vim.tbl_deep_extend("keep", plugins, incoming)
    end

    return plugins
end

return {
    get_lsp_configs = get_lsp_configs,
    get_dap_configs = get_dap_configs,
    get_cmp_configs = get_cmp_configs,
    get_null_ls_configs = get_null_ls_configs,
    get_plugins_setups = get_plugins_setups,
}
