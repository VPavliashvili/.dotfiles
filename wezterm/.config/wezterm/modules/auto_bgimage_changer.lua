local M = {}

local json_handler = require("modules.json_handler")

local home = os.getenv("HOME")
local update_wallpaper_interval_in_minutes = 1

local image_names = {
    arthas = "arthas.jpg",
    vin = "vin.jpg",
    skaven = "skaven.jpg",
    ilidown = "ilidown.png",
}

local function get_wallpapers_path()
    local relative = "/Pictures/wallpapers/terminal/"

    return home .. relative
end

local function get_timestamp()
    local seconds_since_epoch = os.time()
    --local current_time = os.date("*t", seconds_since_epoch)

    --return current_time
    return seconds_since_epoch
end

local function get_image_name()
    local current_timestamp = get_timestamp()

    if #image_names == 1 then
        local images = {}
        for _, v in pairs(image_names) do
            table.insert(images, v)
        end
		local res = images[1]
        json_handler.write_to_json_file(res, current_timestamp)
        print("image returned " .. res)
        return res
    end

    local saved_data = json_handler.read_from_json_file()

    local needUpdate = false
    if saved_data == nil then
        needUpdate = true
        print("last saved data is null")
    else
        local last_timestamp = saved_data.timestamp

        local diff = current_timestamp - last_timestamp
        needUpdate = (diff / 60) >= update_wallpaper_interval_in_minutes

        print(current_timestamp)
        print(last_timestamp)
        print(diff)
    end

    local result
    if needUpdate then
        math.randomseed(os.time())

        local images = {}
        if saved_data ~= nil then
            for _, v in pairs(image_names) do
                if v ~= saved_data.image then
                    table.insert(images, v)
                end
            end
        else
            for _, v in pairs(image_names) do
                table.insert(images, v)
            end
        end

        local index = math.random(#images)
        print(images)
        print("random index: " .. index)
        result = images[index]

        json_handler.write_to_json_file(result, current_timestamp)
        print("update data function run")
    end

    print(result)

    if result == nil then
        result = saved_data.image
    end
    return result
end

function M.get_wallpapaer()
    return get_wallpapers_path() .. get_image_name()
end

return M
