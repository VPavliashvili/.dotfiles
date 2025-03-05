local capabilities
local function get_lsp_capabilities()
    if capabilities then
        return capabilities
    end

    local success, cmp_lsp = pcall(require, "cmp_nvim_lsp")

    if not success then
        vim.notify("Failed to load cmp_nvim_lsp", vim.log.levels.ERROR)
        return
    end

    capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    return capabilities
end

local function on_attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<leader>sg", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>fm", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

local function has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    has_words_before = has_words_before,
    get_lsp_capabilities = get_lsp_capabilities,
    on_attach = on_attach,
}
