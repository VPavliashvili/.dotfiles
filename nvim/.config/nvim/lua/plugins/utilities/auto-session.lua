local function config()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    require("auto-session").setup({
        auto_create = function()
            local cmd = "git rev-parse --is-inside-work-tree"
            return vim.fn.system(cmd) == "true\n"
        end,
    })
end

local function get_plugin_spec()
    return {
        {
            "rmagatti/auto-session",
            lazy = false,
            config = config,
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
