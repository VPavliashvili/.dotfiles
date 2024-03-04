local function setup()
    require("onedarkpro").setup({
        colors = {
            line_number = "#2D6D90",
            line_number_highlighted = "#A5D4DC",
            nvim_tree_root_folder = "#e0a63b",
            nvim_tree_folder_name = "#4f9ac6",
            nvim_tree_folder_icon = "#4f9ac6",
            nvim_tree_openedFolder_name = "#95e8e5",
            red = "#e06c75",
            blue = "#61afef",
            cyan = "#56b6c2",
            yellow = "#e5c07b",
            purple = "#c678dd",
            orange = "#d19a66",
        }, -- Override default colors or create your own
        highlights = {
            LineNr = { fg = "${line_number}" },
            CursorLineNr = { fg = "${line_number_highlighted}" },
            NvimTreeRootFolder = { fg = "${nvim_tree_root_folder}" },
            NvimTreeFolderName = { fg = "${nvim_tree_folder_name}" },
            NvimTreeFolderIcon = { fg = "${nvim_tree_folder_name}" },
            NvimTreeOpenedFolderName = { fg = "${nvim_tree_openedFolder_name}" },
            -- go modification
            ["@punctuation.bracket.go"] = { fg = "${orange}" },
        }, -- Override default highlight groups or create your own
        filetypes = {
            -- Override which filetype highlight groups are loaded
            -- See the 'Configuring filetype highlights' section for the available list
        },
        plugins = { -- Override which plugin highlight groups are loaded
            -- See the 'Supported plugins' section for the available list
        },
        options = {
            bold = true, -- Use bold styles?
            italic = true, -- Use italic styles?
            underline = true, -- Use underline styles?
            undercurl = true, -- Use undercurl styles?
            cursorline = true, -- Use cursorline highlighting?
            transparency = true, -- Use a transparent background?
            terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
            highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
        },
    })

    vim.cmd("colorscheme onedark")
end

return setup
