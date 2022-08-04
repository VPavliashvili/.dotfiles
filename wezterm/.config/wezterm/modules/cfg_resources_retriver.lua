local Config_Manager = {}
local directory_interactor_class = require("modules.directory_interactor")
local json_converter_class = require("modules.json_converter")

Config_Manager.new = function(directory_path)
    print("passed dir in cnf_retriver --> " .. directory_path)

    local self = {}
    local interactor = directory_interactor_class.new(directory_path)
    local jconvert = json_converter_class.new()

    local function get_config_as_string(file_name)
        --local file_address = interactor.get_file_by_exact_name(file_name)
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

    function self.get_config_data(file_name)
        local json_text = get_config_as_string(file_name)
        if json_text == nil then
            return nil
        end
        local as_table = jconvert.deserialize(json_text)

        return as_table
    end

    function self.update_config_data(file_name, content_as_table)
        --local data = convert_to_json_text(next_image, next_timestamp)
        local as_json = jconvert.serialize(content_as_table)
        --local file_address = interactor.get_file_with_exact_name(file_name)

        interactor.write_to_text_file(file_name, as_json)
        --local file = io.open(file_address, "w+")

        --io.output(file)
        --io.write(as_json)
        --if file ~= nil then
        --io.close(file)
        --end
    end

    return self
end

return Config_Manager

--local M = {}

--local home = os.getenv("HOME")
--local json_conf = home .. "/.config/wezterm/data.json"

--local function get_json_as_text_from_file()
--local file = io.open(json_conf, "r")
--io.input(file)
--local result = io.read("*a")
--if (file ~= nil) then
--io.close(file)
--end

--return result
--end

--function M.read_from_json_file()
--local json_text = get_json_as_text_from_file()
--if json_text == nil then
--return nil
--end
--local as_table = json:decode(json_text)

--return as_table
--end

--local function convert_to_json_text(next_image, next_timestamp)
--local val = {
--image = next_image,
--timestamp = next_timestamp
--}

--local result = json:encode(val)
--return result
--end

--local function write_to_json_file(next_image, next_timestamp)
--local data = convert_to_json_text(next_image, next_timestamp)

--local file = io.open(json_conf, "w+")
--io.output(file)
--io.write(data)
--if file ~= nil then
--io.close(file)
--end
--end

--return M
