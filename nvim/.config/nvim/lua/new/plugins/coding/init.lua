local language_configs = require("languages")

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<leader>sg", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>fm", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

local function get_lazy_specs(args)
    return {
        plugins = {
            {
                "mfussenegger/nvim-dap",
                dependencies = {
                    "rcarriga/nvim-dap-ui",
                    "nvim-neotest/nvim-nio",
                    "theHamsta/nvim-dap-virtual-text",
                },
                config = function()
                    require("dapui").setup()
                    require("nvim-dap-virtual-text").setup({})

                    local dap = require("dap")
                    local dap_utils = require("dap.utils")

                    -- Set up debug keymaps
                    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
                    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
                    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
                    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
                    vim.keymap.set("n", "<leader>tb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

                    local dapui = require("dapui")
                    dap.listeners.before.attach.dapui_config = function()
                        dapui.open()
                    end
                    dap.listeners.before.launch.dapui_config = function()
                        dapui.open()
                    end
                    dap.listeners.before.event_terminated.dapui_config = function()
                        dapui.close()
                    end
                    dap.listeners.before.event_exited.dapui_config = function()
                        dapui.close()
                    end

                    local dap_configs = language_configs.get_dap_configs({ dap_utils = dap_utils })
                    for k, cfg in pairs(dap_configs) do
                        dap.adapters[cfg.adapter.name] = cfg.adapter.config
                        dap.configurations[cfg.configuration.name] = cfg.configuration.config
                    end
                end,
            },
            {
                {
                    "nvimtools/none-ls.nvim",
                    config = function()
                        local null_ls = require("null-ls")

                        local null_ls_sources = language_configs.get_null_ls_configs({ null_ls = null_ls.builtins })
                        local sources = {}
                        for k, src in pairs(null_ls_sources) do
                            table.insert(sources, src)
                        end

                        null_ls.setup({
                            sources = sources,
                            on_attach = on_attach,
                        })
                    end,
                },
            },
        },
    }
end

return {
    get_lazy_specs = get_lazy_specs,
}
