local M = {}

local is_enabled = false

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
