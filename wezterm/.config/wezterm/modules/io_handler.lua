local M = {}

local function list_all_files(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "' .. directory .. '"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

local function ends_with(str, ending)
    return ending == "" or str:sub(- #ending) == ending
end

local function is_image(str)
    return (ends_with(str, ".png") or ends_with(str, ".jpg")) and str ~= "." and str ~= ".."
end

function M.get_image_files(dir_path)
    local all_files = list_all_files(dir_path)
    local filtered = {}

    for _, value in ipairs(all_files) do
        if is_image(value) then
            table.insert(filtered, value)
        end
    end

    return filtered
end

return M
