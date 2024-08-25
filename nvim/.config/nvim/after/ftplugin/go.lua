-- best could have done is this
-- also see this for instructions
-- https://github.com/nvim-telescope/telescope.nvim/pull/2584
vim.keymap.set(
    "n",
    "<leader>tt",
    '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols({ symbols = { "class", "struct", "interface", "method", "function", "module", enum} })<cr>'
)
