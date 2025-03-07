local function get_specs()
    local coding_module = require("plugins.coding")
    local core_module = require("plugins.core")
    local ui_module = require("plugins.ui")

    local specs = {}

    vim.list_extend(specs, coding_module.get_lazy_specs())
    vim.list_extend(specs, core_module.get_lazy_specs())
    vim.list_extend(specs, ui_module.get_lazy_specs())

    return specs
end

return {
    get_specs = get_specs,
}
