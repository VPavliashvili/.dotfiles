local Printer = {}

Printer.new = function()
    local self = {}

    local is_enabled = true

    function self.get_status()
        return is_enabled
    end

    function self.enable()
        is_enabled = true
    end

    function self.disable()
        is_enabled = false
    end

    function self.print(message)
        if is_enabled == false then
            return
        end

        print(message)
    end

    return self
end

return Printer
