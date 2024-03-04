return function()
    local keymap = vim.keymap.set

    require("lspsaga").setup({
        border_style = "double",
        saga_winblend = 0,
        -- when cursor in saga window you config these to move
        move_in_saga = { prev = "<C-p>", next = "<C-n>" },
        diagnostic_header = { " ", " ", " ", "ﴞ " },
        -- preview lines above of lsp_finder
        preview_lines_above = 0,
        -- preview lines of lsp_finder and definition preview
        max_preview_lines = 50,
        -- use emoji lightbulb in default
        code_action_icon = "💡",
        -- if true can press number to execute the codeaction in codeaction window
        code_action_num_shortcut = true,
        -- same as nvim-lightbulb but async
        code_action_lightbulb = {
            enable = true,
            enable_in_insert = true,
            cache_code_action = true,
            sign = true,
            update_time = 150,
            sign_priority = 20,
            virtual_text = true,
        },
        -- finder icons
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
        -- finder do lsp request timeout
        -- if your project is big enough or your server very slow
        -- you may need to increase this value
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
        -- show symbols in winbar must nightly
        -- in_custom mean use lspsaga api to get symbols
        -- and set it to your custom winbar or some winbar plugins.
        -- if in_cusomt = true you must set in_enable to false
        symbol_in_winbar = {
            in_custom = false,
            enable = true,
            separator = " ",
            show_file = true,
            -- define how to customize filename, eg: %:., %
            -- if not set, use default value `%:t`
            -- more information see `vim.fn.expand` or `expand`
            -- ## only valid after set `show_file = true`
            file_formatter = "",
            click_support = false,
        },
        -- show outline
        show_outline = {
            win_position = "right",
            --set special filetype win that outline window split.like NvimTree neotree
            -- defx, db_ui
            win_with = "",
            win_width = 30,
            auto_enter = true,
            auto_preview = true,
            virt_text = "┃",
            jump_key = "<CR>",
            -- auto refresh when change buffer
            auto_refresh = true,
        },
        -- custom lsp kind
        -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
        custom_kind = {},
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- like server_filetype_map = { metals = { "sbt", "scala" } }
        server_filetype_map = {},
        diagnostic = {
            on_insert = false,
            on_insert_follow = false,
            insert_winblend = 0,
            show_code_action = true,
            show_source = true,
            jump_num_shortcut = true,
            --1 is max
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

    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga finder def+ref+imp+tyd<CR>", { silent = true })

    -- Code action
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

    -- Rename
    keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

    -- Peek Definition
    -- you can edit the definition file in this flaotwindow
    -- also support open/vsplit/etc operation check definition_action_keys
    -- support tagstack C-t jump back
    keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

    -- Show line diagnostics
    keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

    -- Show cursor diagnostic
    keymap("n", "<leader>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

    -- Diagnsotic jump can use `<c-o>` to jump back
    keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

    -- Only jump to error
    keymap("n", "[E", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    keymap("n", "]E", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })

    -- Outline
    keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

    -- Hover Doc
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

    keymap("n", "<leader>hi", "<cmd>Lspsaga incoming_calls<CR>", { silent = true })
    keymap("n", "<leader>ho", "<cmd>Lspsaga outgoing_calls<CR>", { silent = true })
end
