local function config()
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup({})

    local dap = require("dap")
    local dap_utils = require("dap.utils")
    local dap_configs = require("plugins.coding.languages").get_dap_configs({ dap_utils = dap_utils, dap = dap })

    vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "⛔", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "⚙️", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "DapStoppedSign", linehl = "DapStopped", numhl = "" })

    -- Set up debug keymaps
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

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

    for k, cfg in pairs(dap_configs) do
        dap.adapters[cfg.adapter.name] = cfg.adapter.config
        dap.configurations[cfg.configuration.name] = cfg.configuration.config
    end
end

local function get_plugins_specs()
    return {
        {
            "mfussenegger/nvim-dap",
            dependencies = {
                "rcarriga/nvim-dap-ui",
                "nvim-neotest/nvim-nio",
                "theHamsta/nvim-dap-virtual-text",
            },
            config = config,
        },
    }
end

return {
    get_plugins_specs = get_plugins_specs,
}
