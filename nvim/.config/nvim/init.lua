local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("preferences")
require("utils")
require("filetypes")

require("lazy").setup({
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = false,
                },
            })
        end,
    },
    {
        -- dir = "~/sourceCode/lua/json-nvim/",
        "VPavliashvili/json-nvim",
        ft = "json",
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    },
    {
        "chrishrb/gx.nvim",
        event = { "BufEnter" },
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        config = require("plugins.telescope"),
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-lua/popup.nvim",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = require("plugins.treesitter"),
    },
    {
        "akinsho/bufferline.nvim",
        config = require("plugins.bufferline"),
        dependencies = {
            "VPavliashvili/close-buffers.nvim",
            config = function()
                require("close_buffers").setup({})
            end,
            keys = {
                { "<S-c>", [[<CMD>lua require('close_buffers').delete({type = 'this', force = true})<CR>]] },
            },
        },
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
        config = require("plugins.onedarkpro"),
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = require("plugins.colorizer"),
        dependencies = {
            "NTBBloodbath/color-converter.nvim",
        },
    },
    {
        "RRethy/vim-illuminate",
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = require("plugins.lualine"),
    },
    {
        "luukvbaal/statuscol.nvim",
        config = require("plugins.statuscol"),
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        config = require("plugins.ufo"),
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "sindrets/diffview.nvim",
            "FabijanZulj/blame.nvim",
        },
        config = require("plugins.git"),
    },
    {
        "kyazdani42/nvim-web-devicons",
        config = require("plugins.devicons"),
    },
    {
        "kyazdani42/nvim-tree.lua",
        config = require("plugins.nvimtree"),
    },
    {
        "hrsh7th/nvim-cmp",
        config = require("plugins.cmp"),
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-calc",
            "amarakon/nvim-cmp-fonts",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp",
            "onsails/lspkind.nvim",
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
    },
    {
        "nvimtools/none-ls.nvim",
        config = require("plugins.none_ls"),
    },
    {
        "glepnir/lspsaga.nvim",
        config = require("plugins.lspsaga"),
    },
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup({})
        end,
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        config = require("plugins.lsp"),
    },
    {
        "folke/trouble.nvim",
        config = require("plugins.trouble"),
    },
}, {
    ui = {
        border = "double",
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true,     -- get a notification when new updates are found
        frequency = 86400, -- check for updates every given seconds amount
    },
})
