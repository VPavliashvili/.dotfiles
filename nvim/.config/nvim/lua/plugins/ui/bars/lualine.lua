local function config()
    local current_line = function()
        local max_line = tostring(vim.fn.line("$"))
        local cur_line = tostring(vim.fn.line("."))

        local cur_col = vim.api.nvim_win_get_cursor(0)[2]
        cur_col = cur_col + 1
        local max_col = vim.fn.strlen(tostring(vim.fn.getline(".")))

        return cur_line .. "/" .. max_line .. " | " .. cur_col .. "/" .. max_col
    end

    require("lualine").setup({
        options = {
            theme = "onedark",
            globalstatus = true,
            component_separators = { left = "▏", right = "▕" },
            section_separators = { left = "▌", right = "▐" },
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

local function get_plugin_spec()
    return {
        {
            "nvim-lualine/lualine.nvim",
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
