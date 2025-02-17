vim.keymap.set(
    "n",
    "<leader>tt",
    '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols({ symbols = { "class", "struct", "interface", "method", "function", "module", "enum" } })<cr>'
)
