local function setup()
    local current_line = function()
        local max = tostring(vim.fn.line("$"))
        local cur = tostring(vim.fn.line("."))

        local col = vim.api.nvim_win_get_cursor(0)[2]
        col = col + 1

        return cur .. "/" .. max .. " | " .. col
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
            lualine_x = { "encoding", "fileformat" },
            lualine_y = { "filetype" },
            lualine_z = { current_line },
        },
    })
end

return setup
