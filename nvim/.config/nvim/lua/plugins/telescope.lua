local function setup()
    vim.keymap.set("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>')
    vim.keymap.set("n", "<leader>lg", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
    vim.keymap.set("n", "<leader>km", '<cmd>lua require("telescope.builtin").keymaps()<cr>')
    vim.keymap.set("n", "<leader>bf", '<cmd>lua require("telescope.builtin").buffers()<cr>')

    -- this will be overriten for lsp_dynamic_workspace_symbols for go files
    vim.keymap.set(
        "n",
        "<leader>tt",
        '<cmd>lua require("telescope.builtin").lsp_workspace_symbols({ symbols = { "class", "struct", "interface", "method", "function", "module", enum} })<cr>'
    )

    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("media_files")

    require("telescope").setup({
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            mappings = {
                i = {
                    -- map actions.which_key to <C-h> (default: <C-/>)
                    -- actions.which_key shows the mappings for your picker,
                    -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                    -- ["<C-h>"] = "which_key"
                },
            },
            file_ignore_patterns = {
                "^.git/",
            },
        },
        pickers = {
            find_files = {

                hidden = true,
            },
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extensions = {
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure
            file_browser = {
                -- theme = "ivy",
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = true,
                mappings = {
                    ["i"] = {
                        -- your custom insert mode mappings
                    },
                    ["n"] = {
                        -- your custom normal mode mappings
                    },
                },
                toggle_hidden = true,
            },
            media_files = {
                -- filetypes whitelist
                -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                filetypes = { "png", "webp", "jpg", "jpeg", "gif " },
            },
        },
    })
end

return setup
