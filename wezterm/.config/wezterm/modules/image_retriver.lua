local printer = require("modules.printer")

local directory_interactor_class = require("modules.directory_interactor")

local Images_Retriver = {}

Images_Retriver.new = function(dir_path)
    printer.print("passed dir path in img_retriver --> " .. dir_path)

    local self = {}
    local interactor = directory_interactor_class.new(dir_path)

    local function merge_tables(t1, t2)
        for i = 1, #t2 do
            t1[#t1 + 1] = t2[i]
        end
        return t1
    end

    function self.get_image_files()
        local pngs = interactor.get_files_by_extension(".png")
        local jpgs = interactor.get_files_by_extension(".jpg")
        local images = merge_tables(pngs, jpgs)

        return images
    end

    return self
end

return Images_Retriver
