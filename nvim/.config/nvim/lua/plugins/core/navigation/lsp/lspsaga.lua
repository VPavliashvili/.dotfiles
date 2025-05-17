local function config()
    require("lspsaga").setup({
        border_style = "double",
        saga_winblend = 0,
        move_in_saga = { prev = "<C-p>", next = "<C-n>" },
        diagnostic_header = { " ", " ", " ", "ﴞ " },
        preview_lines_above = 0,
        max_preview_lines = 50,
        code_action_icon = "💡",
        code_action_num_shortcut = true,
        code_action_lightbulb = {
            enable = true,
            enable_in_insert = true,
            cache_code_action = true,
            sign = true,
            update_time = 150,
            sign_priority = 20,
            virtual_text = true,
        },
        finder_icons = {
            def = "  ",
            ref = "諭 ",
            link = "  ",
        },
        finder = {
            methods = {
                ["tyd"] = "textDocument/typeDefinition",
            },
        },
        outline = {
            layout = "float",
        },
        finder_request_timeout = 1500,
        finder_action_keys = {
            open = { "o", "<CR>" },
            vsplit = "s",
            split = "i",
            tabe = "t",
            quit = { "q", "<ESC>" },
        },
        code_action_keys = {
            quit = "q",
            exec = "<CR>",
        },
        definition_action_keys = {
            edit = "<C-c>o",
            vsplit = "<C-c>v",
            split = "<C-c>i",
            tabe = "<C-c>t",
            quit = "q",
        },
        rename_action_quit = "q", --<C-c>',
        rename_in_select = true,
        symbol_in_winbar = {
            in_custom = false,
            enable = true,
            separator = " ",
            show_file = true,
            file_formatter = "",
            click_support = false,
        },
        show_outline = {
            win_position = "right",
            win_with = "",
            win_width = 30,
            auto_enter = true,
            auto_preview = true,
            virt_text = "┃",
            jump_key = "<CR>",
            auto_refresh = true,
        },
        custom_kind = {},
        server_filetype_map = {},
        diagnostic = {
            on_insert = false,
            on_insert_follow = false,
            insert_winblend = 0,
            show_code_action = true,
            show_source = true,
            jump_num_shortcut = true,
            max_width = 0.7,
            custom_fix = nil,
            custom_msg = nil,
            text_hl_follow = false,
            border_follow = true,
            keys = {
                exec_action = "o",
                quit = "q",
                go_action = "g",
            },
        },
    })

    vim.keymap.set("n", "gh", "<cmd>Lspsaga finder def+ref+imp+tyd<CR>", { silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
    vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
    vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
    vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

    -- show current diagnostics isntead of jumping to other
    vim.keymap.set("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

    -- Diagnsotic jump
    vim.keymap.set("n", "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    vim.keymap.set("n", "<leader>dn", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

    -- Only jump to error
    vim.keymap.set("n", "<leader>ep", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    vim.keymap.set("n", "<leader>en", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })

    -- Outline
    vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

    -- Hover Doc
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

    -- Call hierarchy
    vim.keymap.set("n", "<leader>hi", "<cmd>Lspsaga incoming_calls<CR>", { silent = true })
    vim.keymap.set("n", "<leader>ho", "<cmd>Lspsaga outgoing_calls<CR>", { silent = true })
end

local function get_plugin_spec()
    return {
        {
            "glepnir/lspsaga.nvim",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
                "nvim-tree/nvim-web-devicons",
            },
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
