local M = {}

local config_manager_class = require("modules.json_config_file_interactor")
local images_retriver_class = require("modules.image_retriver")
local printer = require("modules.printer")
printer.disable()

local home = os.getenv("HOME")
local next_wallpaper_timer_in_minutes = 60
local json_data_file_name = "data.json"

local function get_json_data_content(img, tmst)
    return {
        image = img,
        timestamp = tmst,
    }
end

local function get_wallpapers_path()
    local relative = "/Pictures/wallpapers/terminal/"
    return home .. relative
end

local function get_data_json_path()
    local relative = "/.config/wezterm/data.json"
    return home .. relative
end

local data_json_interactor = config_manager_class.new(get_data_json_path())
local images_retriver = images_retriver_class.new(get_wallpapers_path())

local function get_all_images_with_full_path()
    local path_to_wallpapers = get_wallpapers_path()

    local image_names = images_retriver.get_image_files()

    local result = {}
    for _, value in pairs(image_names) do
        local next = path_to_wallpapers .. value
        table.insert(result, next)
    end

    return result
end

local function get_timestamp()
    local seconds_since_epoch = os.time()
    return seconds_since_epoch
end

local function save_data(img)
    local content = get_json_data_content(img, get_timestamp())
    data_json_interactor.update_config_data(content)
end

local function handle_only_one_image(images)
    local res = images[1]
    save_data(res)
    printer.print("image returned " .. res)
    return res
end

local function handle_saved_data_absence(images)
    math.randomseed(os.time())

    local index = math.random(#images)
    printer.print(images)
    printer.print("random index: " .. index)
    local result = images[index]

    save_data(result)
    printer.print("persistent data was absent")

    return result
end

local function need_saved_data_update(old_data)
    math.randomseed(os.time())

    local last_timestamp = old_data.timestamp
    local current_timestamp = get_timestamp()

    local diff = current_timestamp - last_timestamp
    local result = (diff / 60) >= next_wallpaper_timer_in_minutes

    printer.print("current timestamp: " .. current_timestamp)
    printer.print("last_timestamp: " .. last_timestamp)
    printer.print("diff: " .. diff)

    if result == true then
        printer.print("wallpaper change required!")
    end

    return result
end

local function handle_need_data_update(images, saved_data)
    local filtered = {}
    for _, v in pairs(images) do
        local val_str = tostring(v)
        local data_str = tostring(saved_data.image)
        if val_str ~= data_str then
            table.insert(filtered, v)
        end
    end

    local index = math.random(#filtered)
    printer.print("update data function run")
    printer.print(filtered)
    printer.print("random index: " .. index)
    local result = filtered[index]
    printer.print("new wallpaper set: " .. result)

    save_data(result)

    return result
end

local function handle_when_walpaper_update_is_not_needed(saved_data)
    local res = ""
    res = saved_data.image

    return res
end

local function get_saved_data_content()
    return data_json_interactor.get_config_data()
end

local function get_image()
    local images = get_all_images_with_full_path()

    if #images == 1 then
        return handle_only_one_image(images)
    end

    local saved_data = get_saved_data_content()

    local need_update = false
    if saved_data == nil then
        printer.print("last saved data is null")
        return handle_saved_data_absence(images)
    else
        need_update = need_saved_data_update(saved_data)
    end

    local result
    if need_update then
        return handle_need_data_update(images, saved_data)
    end

    if result == nil then
        result = handle_when_walpaper_update_is_not_needed(saved_data)
    end
    return result
end

function M.get_wallpapaer()
    return get_image()
end

return M
