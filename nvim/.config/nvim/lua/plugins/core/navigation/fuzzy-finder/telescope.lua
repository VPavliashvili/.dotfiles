local function config()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")

    local no_titles = function()
        return {
            prompt_title = false,
            results_title = false,
            preview_title = false,
            dynamic_preview_title = false,
        }
    end

    telescope.setup({
        defaults = themes.get_dropdown({
            previewer = true,
            layout_strategy = "vertical",
            layout_config = {
                mirror = true,
                prompt_position = "top",
                height = 0.85,
                width = 0.75,
                preview_height = 0.6,
            },
            borderchars = {
                prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                results = { "─", "│", " ", "│", "├", "┤", "│", "│" },
                preview = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            },
            mappings = {
                i = {
                    ["<C-j>"] = actions.preview_scrolling_down,
                    ["<C-k>"] = actions.preview_scrolling_up,
                },
                n = {
                    ["<C-j>"] = actions.preview_scrolling_down,
                    ["<C-k>"] = actions.preview_scrolling_up,
                    ["<c-d>"] = require("telescope.actions").delete_buffer,
                    ["<C-S-d>"] = function(prompt_bufnr)
                        local action_state = require("telescope.actions.state")
                        local picker = action_state.get_current_picker(prompt_bufnr)

                        picker:delete_selection(function(selection)
                            vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                        end)
                    end,
                    ["q"] = actions.close,
                },
            },
            file_ignore_patterns = {
                "node_modules",
                "^.git/",
                "bin/",
                "obj/",
                ".nx/",
                "cdk.out",
                "dist/",
                "cdk.context.json",
                "tsconfig.tsbuildinfo",
                "package-lock.json",
            },
        }),
        pickers = {
            find_files = vim.tbl_extend("force", no_titles(), { hidden = true }),
            live_grep = vim.tbl_extend("force", no_titles(), {
                additional_args = function(opts)
                    return { "--hidden" }
                end,
            }),
            buffers = no_titles(),
            keymaps = no_titles(),
            lsp_document_symbols = no_titles(),
            lsp_workspace_symbols = no_titles(),
        },
    })

    local builtin = require("telescope.builtin")

    -- Replace Default LSP pickers with telescope
    -- vim.lsp.buf.definition = builtin.lsp_definitions
    -- vim.lsp.buf.references = builtin.lsp_references
    -- vim.lsp.buf.implementation = builtin.lsp_implementations
    -- vim.lsp.buf.type_definition = builtin.lsp_type_definitions
    -- vim.lsp.buf.incoming_calls = builtin.lsp_incoming_calls
    -- vim.lsp.buf.outgoing_calls = builtin.lsp_outgoing_calls

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find from all files" })
    vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "fuzzy find a word" })
    vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "fuzzy find keymaps" })
    vim.keymap.set("n", "<S-t>", function()
        builtin.buffers({ sort_lastused = true, sort_mru = true, initial_mode = "normal" })
    end, { desc = "list buffers" })

    vim.keymap.set("n", "<leader>sy", builtin.lsp_document_symbols, { desc = "lsp symbols inside buffer" })
    -- when needed, this will be overriten for lsp_dynamic_workspace_symbols per distincs file types from ./after/ftplugin/
    vim.keymap.set("n", "<leader>tt", function()
        builtin.lsp_workspace_symbols({
            symbols = { "class", "struct", "interface", "method", "function", "module", "enum" },
        })
    end)
end

local function get_plugin_spec()
    return {
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = config,
        },
    }
end

-- make telescope window non transparent
local telescope_bg = "#282C34"

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        local groups = {
            "TelescopeNormal",
            "TelescopeBorder",
            "TelescopePromptNormal",
            "TelescopePromptBorder",
            "TelescopeResultsNormal",
            "TelescopeResultsBorder",
            "TelescopePreviewNormal",
            "TelescopePreviewBorder",
        }
        for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = telescope_bg })
        end
    end,
})

return {
    get_plugin_spec = get_plugin_spec,
}
