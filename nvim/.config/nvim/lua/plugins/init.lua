local coding_module = require("new.plugins.coding")

local coding_plugins = coding_module.get_lazy_specs({})

return {
    get_coding_plugins = function()
        return coding_plugins
    end,
}
