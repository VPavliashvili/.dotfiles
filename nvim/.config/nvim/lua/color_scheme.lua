require("onedarkpro").setup({
    colors = {
        line_number = "#2D6D90",
        line_number_highlighted = "#A5D4DC",
        nvim_tree_root_folder = "#e0a63b",
        nvim_tree_folder_name = "#4f9ac6",
        nvim_tree_folder_icon = "#4f9ac6",
        nvim_tree_openedFolder_name = "#95e8e5",
    }, -- Override default colors or create your own
    highlights = {
        LineNr = { fg = "${line_number}" },
        CursorLineNr = { fg = "${line_number_highlighted}" },
        NvimTreeRootFolder = { fg = "${nvim_tree_root_folder}" },
        NvimTreeFolderName = { fg = "${nvim_tree_folder_name}" },
        NvimTreeFolderIcon = { fg = "${nvim_tree_folder_name}" },
        NvimTreeOpenedFolderName = { fg = "${nvim_tree_openedFolder_name}" },
    }, -- Override default highlight groups or create your own
    filetypes = { -- Override which filetype highlight groups are loaded
        -- See the 'Configuring filetype highlights' section for the available list
    },
    plugins = { -- Override which plugin highlight groups are loaded
        -- See the 'Supported plugins' section for the available list
    },
    --styles = { -- For example, to apply bold and italic, use "bold,italic"
    --types = "NONE", -- Style that is applied to types
    --numbers = "NONE", -- Style that is applied to numbers
    --strings = "NONE", -- Style that is applied to strings
    --comments = "NONE", -- Style that is applied to comments
    --keywords = "NONE", -- Style that is applied to keywords
    --constants = "NONE", -- Style that is applied to constants
    --functions = "NONE", -- Style that is applied to functions
    --operators = "NONE", -- Style that is applied to operators
    --variables = "NONE", -- Style that is applied to variables
    --conditionals = "NONE", -- Style that is applied to conditionals
    --virtual_text = "NONE", -- Style that is applied to virtual text
    --},
    options = {
        bold = true, -- Use bold styles?
        italic = true, -- Use italic styles?
        underline = true, -- Use underline styles?
        undercurl = true, -- Use undercurl styles?

        cursorline = true, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
    }
})

vim.cmd("colorscheme onedark")
