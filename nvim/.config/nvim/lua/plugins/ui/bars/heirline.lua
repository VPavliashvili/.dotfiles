local function config()
    local function get_lualine_colors()
        local lualine_a_normal = vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })

        return {
            fg = lualine_a_normal.fg and string.format("#%06x", lualine_a_normal.fg) or "NONE",
            bg = lualine_a_normal.bg and string.format("#%06x", lualine_a_normal.bg) or "NONE",
        }
    end

    local utils = require("heirline.utils")

    local Tabpage = {
        provider = function(self)
            return "  " .. self.tabnr .. "  "
        end,
        hl = function(self)
            if not self.is_active then
                return "TabLine"
            else
                -- return "TabLineSel"
                local lualine_colors = get_lualine_colors()
                return { fg = lualine_colors.fg, bg = lualine_colors.bg, bold = true }
            end
        end,
    }

    local Align = { provider = "%=" }

    local TabPages = {
        { provider = " " },
        utils.make_tablist(Tabpage),
        { provider = " " },
        Align,
        { provider = " " },
    }

    require("heirline").setup({
        tabline = TabPages,
    })

    -- this act as condition for showing
    -- tabline when more than one tab is opened
    -- https://github.com/nvim-lualine/lualine.nvim/issues/395#issuecomment-1312371694
    vim.o.showtabline = 1
end

local function get_plugin_spec()
    return {
        {
            "rebelot/heirline.nvim",
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
