-- this filetype detection tries to avoid
-- setting ':set filetype=json' manually
-- when file does not have an extention
-- and might be a json file
-- !! requires jq isntalled on the syste

local function get_buffer_content_as_string()
    local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
    return table.concat(content, "\n")
end

local function is_valid_json(input)
    local found_error
    local cmd
    local result
    cmd = string.format("echo '%s' | jq -e .", input)
    result = vim.fn.system(cmd)

    found_error = result:find("error")

    return found_error == nil or found_error == 0
end

vim.filetype.add({
    pattern = {
        [".*"] = function(path, bufnr, ext)
            if not ext:find("%.") then
                local content = get_buffer_content_as_string()
                if #content > 0 and is_valid_json(content) then
                    return "json"
                end
            end
        end,
    },
})
