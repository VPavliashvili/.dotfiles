local M = {}

local is_enabled = true

function M.get_status()
    return is_enabled
end

function M.enable()
    is_enabled = true
end

function M.disable()
    is_enabled = false
end

function M.print(message)
    if is_enabled == false then
        return
    end

    print(message)
end

return M
