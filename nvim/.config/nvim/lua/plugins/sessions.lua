return function()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    require("auto-session").setup({
        auto_create = function()
            local cmd = "git rev-parse --is-inside-work-tree"
            return vim.fn.system(cmd) == "true\n"
        end,
    })
end
