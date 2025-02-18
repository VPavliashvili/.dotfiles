-- ensure lazy.nvim installation
(function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
end)()

local plugins = require("plugins")

-- local plugins = {}
-- vim.list_extend(plugins, plugins_specs.plugins)
vim.list_extend(plugins, {
    -- plugins which are not separated and I want to install 'inline' from this location
    -- goes here, e.g.
    -- {
    --     -- dir = "~/sourceCode/lua/json-nvim/",
    --     "VPavliashvili/json-nvim",
    --     ft = "json",
    -- },
})

require("lazy").setup(plugins, {
    ui = {
        border = "double",
    },
    checker = {
        enabled = true,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = false, -- get a notification when new updates are found
        frequency = 86400, -- check for updates every given seconds amount
    },
})
