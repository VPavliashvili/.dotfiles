local printer = require("modules.printer")

local Directory_Interactor = {}

Directory_Interactor.new = function(directory_path)
    local self = {}

    local function ends_with(str, ending)
        return ending == "" or str:sub(- #ending) == ending
    end

    function self.list_all_files()
        local i, t, popen = 0, {}, io.popen
        local pfile = popen('ls -a "' .. directory_path .. '"')

        if pfile == nil then
            error("could not find any file")
        end

        for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
        end
        pfile:close()
        return t
    end


    local function has_missing_slash(path, file)
        if ends_with(path, "/") == false and ends_with(file, "/") == false then
            return true
        end
    end

    local function has_extra_slash(path, file)
        if ends_with(path, "/") == true and ends_with(file, "/") == true then
            return true
        end
    end

    local function get_fixed_folder_path_if_invalid_slashes(file_name)
        local path = ""

        if has_missing_slash(directory_path, file_name) then
            path = directory_path .. "/"
        elseif has_extra_slash(directory_path, file_name) then
            path = directory_path:sub(1, -2)
        else
            path = directory_path
        end

        return path
    end

    function self.get_files_by_extension(file_extension)
        local all_files = self.list_all_files()
        local filtered = {}

        for _, value in ipairs(all_files) do
            if ends_with(value, file_extension) then
                local path = get_fixed_folder_path_if_invalid_slashes(value)
                local res = path .. value
                table.insert(filtered, res)
            end
        end

        return filtered
    end

    function self.get_file_by_name_with_full_path(name)
        local all_files = self.list_all_files()
        local path = get_fixed_folder_path_if_invalid_slashes(name)
        local exact_file = ""

        for _, value in pairs(all_files) do
            local v = tostring(value)
            if v == name then
                exact_file = value
                break
            end
        end
        if exact_file == "" then
        	printer.print("file " .. name .. " does not exist in dir --> " .. path)
            return nil
        end
		local full_path = path .. exact_file

        return full_path
    end

    function self.write_to_text_file(file_name, content)
        local path = get_fixed_folder_path_if_invalid_slashes(file_name)
        local full_file_path = path .. file_name

        printer.print("filename --> " .. file_name)
        printer.print("folder --> " .. path)
        printer.print("full path --> " .. full_file_path)

        local file = io.open(full_file_path, "w+")
        io.output(file)
        io.write(content)
        if file ~= nil then
            io.close(file)
        end
    end

    return self
end

return Directory_Interactor
