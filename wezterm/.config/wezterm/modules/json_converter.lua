local json = require("JSON")
-- encode is giving string(same as Serialize)
-- decode is giving table(same as Deserialize)

local Json_Converter = {}

Json_Converter.new = function()
    local self = {}

    function self.serialize(table_value)
        if table_value == nil then
            return nil
        end

        local json_str = json:encode(table_value)
        return json_str
    end

    function self.deserialize(json_str)
        if json_str == nil then
            return nil
        end

        local as_table = json:decode(json_str)
        return as_table
    end

    return self
end

return Json_Converter
