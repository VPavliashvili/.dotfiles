local json = require("JSON")
-- encode is giving string(same as Serialize)
-- decode is giving table(same as Deserialize)

local M = {}

local home = os.getenv("HOME")
local json_conf = home .. "/.config/wezterm/conf.json"

local function get_json_as_text_from_file()
    local file = io.open(json_conf, "r")
    io.input(file)
    local result = io.read("*a")
    if (file ~= nil) then
        io.close(file)
    end

    return result
end

function M.read_from_json_file()
    local json_text = get_json_as_text_from_file()
    if json_text == nil then
        return nil
    end
    local as_table = json:decode(json_text)

    return as_table
end

local function convert_to_json_text(next_image, next_timestamp)
    local val = {
        image = next_image,
        timestamp = next_timestamp
    }

    local result = json:encode(val)
    return result
end

function M.write_to_json_file(next_image, next_timestamp)
    local data = convert_to_json_text(next_image, next_timestamp)

    local file = io.open(json_conf, "w+")
    io.output(file)
    io.write(data)
    if file ~= nil then
        io.close(file)
    end
end

return M
