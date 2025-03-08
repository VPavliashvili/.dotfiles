local function config()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = actions.preview_scrolling_down,
                    ["<C-k>"] = actions.preview_scrolling_up,
                },
                n = {
                    ["<C-j>"] = actions.preview_scrolling_down,
                    ["<C-k>"] = actions.preview_scrolling_up,
                    ['<c-d>'] = require('telescope.actions').delete_buffer,
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
        },
        pickers = {
            find_files = {
                hidden = true
            }
        }
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
        builtin.buffers({ sort_lastused = true, sort_mru = true, initial_mode = "normal" }, { desc = "list buffers" })
    end)

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

return {
    get_plugin_spec = get_plugin_spec,
}
