local function setup()
    local current_line = function()
        local max = tostring(vim.fn.line("$"))
        local cur = tostring(vim.fn.line("."))

        local col = vim.api.nvim_win_get_cursor(0)[2]
        col = col + 1

        return cur .. "/" .. max .. " | " .. col
    end

    local current_time = function()
        return os.date(" %H:%M", os.time())
    end

    require("lualine").setup({
        options = {
            theme = "onedark",
            globalstatus = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { { "filename", path = 3 } },
            lualine_x = { "encoding", "fileformat", current_time },
            lualine_y = { "filetype" },
            lualine_z = { current_line },
        },
    })

    -- Trigger rerender of status line every second for clock
    if _G.Statusline_timer == nil then
        _G.Statusline_timer = vim.loop.new_timer()
    else
        _G.Statusline_timer:stop()
    end
    _G.Statusline_timer:start(
        0,
        1000 * 60,
        vim.schedule_wrap(function()
            vim.api.nvim_command("redrawstatus")
        end)
    )
end

return setup
