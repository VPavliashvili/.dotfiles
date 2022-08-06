local Config_Interactor = {}
local directory_interactor_class = require("modules.directory_interactor")
local json_converter_class = require("modules.json_converter")
local printer = require("modules.printer")

Config_Interactor.new = function(file_name_with_full_path)
    printer.print("passed file in conf_interactor --> " .. file_name_with_full_path)

    local function trim_name_from_file_path(file_path)
        local result = ""
        local has_met = false

        for i = #file_path, 1, -1 do
            local c = file_path:sub(i, i)

            if has_met == true then
                result = result .. c
            end

            if has_met == false and c == "/" then
                has_met = true
            end
        end
        result = result:reverse()
        return result
    end

    local function get_name_from_full_file_path(file_path)
        local result = ""

        for i = #file_path, 1, -1 do
            local c = file_path:sub(i, i)

            if c == "/" then
                return result:reverse()
            end

            result = result .. c
        end
    end

    local self = {}

    local file_name = get_name_from_full_file_path(file_name_with_full_path)
    local dir_name = trim_name_from_file_path(file_name_with_full_path)

    local interactor = directory_interactor_class.new(dir_name)
    local jconvert = json_converter_class.new()

    local function get_config_as_string()

        local file_address = interactor.get_file_by_name_with_full_path(file_name)
        if file_address == nil then
            return nil
        end
        local file = io.open(file_address, "r")
        io.input(file)
        local result = io.read("*a")
        if file ~= nil then
            io.close(file)
        end

        return result
    end

    function self.get_config_data()
        local json_text = get_config_as_string()
        if json_text == nil then
            return nil
        end
        local as_table = jconvert.deserialize(json_text)

        return as_table
    end

    function self.update_config_data(content_as_table)
        local as_json = jconvert.serialize(content_as_table)

        interactor.write_to_text_file(file_name, as_json)
    end

    return self
end

return Config_Interactor
