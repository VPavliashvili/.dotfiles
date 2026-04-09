local function no_restore_args()
    for _, arg in ipairs(vim.v.argv) do
        if arg == "terminal" or arg == "term" then
            return false
        end
    end
    return true
end

local function config()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    require("auto-session").setup({
        auto_create = function()
            local cmd = "git rev-parse --is-inside-work-tree"
            return vim.fn.system(cmd) == "true\n"
        end,
        auto_restore = no_restore_args(),
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
