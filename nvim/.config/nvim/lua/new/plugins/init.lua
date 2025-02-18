local coding_specs = require("coding")

local plugins = {}

-- for k, specs_fn in pairs(coding_specs) do
--     table.insert(plugins, )
-- end

return {
    plugins = coding_specs.plugins,
}
