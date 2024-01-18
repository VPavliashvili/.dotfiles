local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("preferences")
require("utils")

require("lazy").setup({
    {
        "chrishrb/gx.nvim",
        event = { "BufEnter" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = false,
                },
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                --'*'; -- Highlight all files, but customize some others.
                javascript = { names = false },
                css = { rgb_fn = true, hsl_fn = true }, -- Enable parsing rgb(...) functions in css.
                html = { names = false },   -- Disable parsing "names" like Blue or Gray

                go = { names = false },
                gdscript = { names = false },
                lua = { names = false },
            })
        end,
    },
    {
        "yamatsum/nvim-cursorline",
        config = function()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    timeout = 0,
                    number = false,
                },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true },
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local current_line = function()
                local max = tostring(vim.fn.line("$"))
                local cur = tostring(vim.fn.line("."))
                return cur .. "/" .. max
            end

            local current_time = function()
                return os.date(" %H:%M", os.time())
            end

            require("lualine").setup({
                options = {
                    theme = "onedark",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", current_time },
                    lualine_y = { "filetype" },
                    lualine_z = { current_line },
                },
                extensions = { "nvim-tree" },
            })

            -- Turn off lualine inside nvim-tree
            vim.cmd([[
              au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
            ]])

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
        end,
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
        config = function()
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
                },                       -- Override default highlight groups or create your own
                options = {
                    bold = true,         -- Use bold styles?
                    italic = true,       -- Use italic styles?
                    underline = true,    -- Use underline styles?
                    undercurl = true,    -- Use undercurl styles?
                    cursorline = true,   -- Use cursorline highlighting?
                    transparency = false, -- Use a transparent background?
                    terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
                    highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
                },
            })

            vim.cmd("colorscheme onedark")
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        config = function()
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            vim.keymap.set("n", "<leader>v", require("ufo").peekFoldedLinesUnderCursor)

            require("ufo").setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
            })
        end,
        dependencies = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        -- foldfunc = "builtin",
                        -- setopt = true,
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc } },
                            { text = { "%s" } },
                            { text = { builtin.lnumfunc, " " } },
                        },
                    })
                end,
            },
        },
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            local function diagnostics_indicator(_, _, diagnostics)
                local symbols = { error = " ", warning = " ", info = " " }
                local result = {}
                for name, count in pairs(diagnostics) do
                    if symbols[name] and count > 0 then
                        table.insert(result, symbols[name] .. count)
                    end
                end
                result = table.concat(result, " ")
                return #result > 0 and result or ""
            end

            require("bufferline").setup({
                options = {
                    numbers = "both",
                    indicator = {
                        style = "underline",
                    },
                    -- diagnostics = 'nvim_lsp',
                    diagnostics_indicator = diagnostics_indicator,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true,
                        },
                    },
                    show_close_icon = false,
                },
            })

            vim.cmd([[
            "go to next/prev tab/buffer
            nnoremap <silent><S-l> :BufferLineCycleNext<CR>
            nnoremap <silent><S-h> :BufferLineCyclePrev<CR>
            "move tab/buffer physically
            nnoremap <silent><A-l> :BufferLineMoveNext<CR>
            nnoremap <silent><A-h> :BufferLineMovePrev<CR>

            "jump to the buffer number from 1 up to 10
            nnoremap <silent><A-1> <Cmd>BufferLineGoToBuffer 1<CR>
            nnoremap <silent><A-2> <Cmd>BufferLineGoToBuffer 2<CR>
            nnoremap <silent><A-3> <Cmd>BufferLineGoToBuffer 3<CR>
            nnoremap <silent><A-4> <Cmd>BufferLineGoToBuffer 4<CR>
            nnoremap <silent><A-5> <Cmd>BufferLineGoToBuffer 5<CR>
            nnoremap <silent><A-6> <Cmd>BufferLineGoToBuffer 6<CR>
            nnoremap <silent><A-7> <Cmd>BufferLineGoToBuffer 7<CR>
            nnoremap <silent><A-8> <Cmd>BufferLineGoToBuffer 8<CR>
            nnoremap <silent><A-9> <Cmd>BufferLineGoToBuffer 9<CR>
            nnoremap <silent><A-0> <Cmd>BufferLineGoToBuffer 10<CR>
            ]])
        end,
        dependencies = {
            {
                "VPavliashvili/close-buffers.nvim",
                config = function()
                    require("close_buffers").setup({})
                end,
                keys = {
                    { "<S-c>", [[<CMD>lua require('close_buffers').delete({type = 'this', force = true})<CR>]] },
                },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").setup({
                defaults = {
                    -- Default configuration for telescope goes here:
                    -- config_key = value,
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-h>"] = "which_key",
                        },
                    },
                },
            })
            vim.keymap.set("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>')
            vim.keymap.set("n", "<leader>lg", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
            vim.keymap.set("n", "<leader>km", '<cmd>lua require("telescope.builtin").keymaps()<cr>')
            vim.keymap.set("n", "<leader>bf", '<cmd>lua require("telescope.builtin").buffers()<cr>')
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-lua/popup.nvim",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                config = function()
                    require("nvim-web-devicons").setup({
                        color_icons = true,
                        default = true,
                    })
                end,
            },
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        keys = {
            { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
        config = function()
            require("neo-tree").setup({
                window = {
                    position = "float",
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "FabijanZulj/blame.nvim",
        },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    change = {
                        hl = "GitSignsChange",
                        text = "│",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    delete = {
                        hl = "GitSignsDelete",
                        text = "_",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    topdelete = {
                        hl = "GitSignsDelete",
                        text = "‾",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChange",
                        text = "~",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                },
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            })

            local function contains(tab, val)
                for _, value in ipairs(tab) do
                    if value == val then
                        return true
                    end
                end

                return false
            end

            local opened_buffers = function()
                local indexes = {}
                for i = 1, vim.fn.bufnr("$") do
                    if vim.fn.buflisted(i) == 1 then
                        table.insert(indexes, i)
                    end
                end
                return indexes
            end

            local before = {}
            local after = {}

            vim.keymap.set("n", "<leader>gd", function()
                before = opened_buffers()
                vim.cmd(":DiffviewOpen")
            end)

            vim.keymap.set("n", "<leader>gc", function()
                after = opened_buffers()
                if #before == 0 then
                    return
                end

                local to_be_closed = {}
                for _, value in ipairs(after) do
                    if not contains(before, value) then
                        table.insert(to_be_closed, value)
                    end
                end

                vim.cmd("DiffviewClose")

                for _, bufindex in ipairs(to_be_closed) do
                    vim.cmd("bdelete" .. tostring(bufindex))
                end
                before = {}
                after = {}
            end)

            vim.keymap.set("n", "<leader>gh", function()
                before = opened_buffers()
                vim.cmd(":DiffviewFileHistory")
            end)
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "BufEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-calc",
            "amarakon/nvim-cmp-fonts",
            "hrsh7th/cmp-nvim-lua",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                    documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            --elseif luasnip.expand_or_jumpable() then
                            --luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "calc" },
                    { name = "luasnip" },
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "folke/trouble.nvim",
                config = function()
                    vim.keymap.set("n", "<leader>xx", function()
                        require("trouble").toggle()
                    end)
                    vim.keymap.set("n", "<leader>xw", function()
                        require("trouble").toggle("workspace_diagnostics")
                    end)
                    vim.keymap.set("n", "<leader>xd", function()
                        require("trouble").toggle("document_diagnostics")
                    end)
                    vim.keymap.set("n", "<leader>xq", function()
                        require("trouble").toggle("quickfix")
                    end)
                    vim.keymap.set("n", "<leader>xl", function()
                        require("trouble").toggle("loclist")
                    end)
                    vim.keymap.set("n", "gR", function()
                        require("trouble").toggle("lsp_references")
                    end)
                end,
            },
            "b0o/schemastore.nvim",
            {
                "nvimtools/none-ls.nvim",
                config = function()
                    local null_ls = require("null-ls")
                    null_ls.setup({
                        sources = {
                            null_ls.builtins.formatting.black,
                            null_ls.builtins.diagnostics.flake8,
                            null_ls.builtins.formatting.stylua,
                        },
                    })
                end,
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "<leader>sg", vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set("n", "<leader>fm", function()
                    vim.lsp.buf.format({ async = true })
                end, bufopts)
            end

            local setup_cmp = function(completion_sources)
                local cmp = require("cmp")
                local cfg = cmp.get_config()
                -- vim.tbl_deep_extend("keep", cfg.sources, completion_sources)
                for i, x in pairs(completion_sources) do
                    table.insert(cfg.sources, x)
                end
            end

            -- lua ls configuration
            setup_cmp({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lua" },
                {
                    name = "fonts",
                    option = { space_filter = "-" },
                },
            })
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
                on_attach = on_attach,
                capabilities = capabilities,
            })
            --

            -- pyright ls configuration
            setup_cmp({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "nvim_lsp_signature_help" },
            })
            lspconfig.pyright.setup({
                cmd = { "pyright-langserver", "--stdio" },
                fyletypes = { "python" },
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
                single_file_support = true,
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        config = function()
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
        end,
    },
}, {
    ui = {
        border = "double",
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true, -- get a notification when new updates are found
        frequency = 86400, -- check for updates every given seconds amount
    },
})
