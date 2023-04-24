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

require("lazy").setup({
        'lukas-reineke/indent-blankline.nvim',
        'NvChad/nvim-colorizer.lua',
        'yamatsum/nvim-cursorline',
        'nvim-lualine/lualine.nvim',
        "numToStr/FTerm.nvim",
        {
            'lewis6991/gitsigns.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'sindrets/diffview.nvim',
            }
        },
        {
            "chrishrb/gx.nvim",
            event = { "BufEnter" },
            dependencies = { "nvim-lua/plenary.nvim" },
            config = true,
        },
        {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end,
        },
        {
            "windwp/nvim-autopairs",
            config = function() require("nvim-autopairs").setup {} end
        },
        {
            "olimorris/onedarkpro.nvim",
            priority = 1000 -- Ensure it loads first
        },
        {
            'nvim-treesitter/nvim-treesitter',
            build = function()
                require('nvim-treesitter.install').update({ with_sync = true })
            end,
        },
        {
            'kyazdani42/nvim-tree.lua',
            dependencies = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icons
            },
            tag = 'nightly'                     -- optional, updated every week. (see issue #1193)
        },
        {
            "williamboman/mason.nvim",
            dependencies = {
                "williamboman/mason-lspconfig.nvim",
                "neovim/nvim-lspconfig",
                {
                    "glepnir/lspsaga.nvim",
                    event = "BufRead",
                    -- commit = "66bb067",
                },
                "folke/trouble.nvim",
            },
        },
        {
            'hrsh7th/cmp-nvim-lsp',
            dependencies = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/nvim-cmp',
                {
                    'L3MON4D3/LuaSnip',
                    dependencies = {
                        "rafamadriz/friendly-snippets",
                    },
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end
                },
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-calc',
                "amarakon/nvim-cmp-fonts",
                "hrsh7th/cmp-nvim-lua",
                'onsails/lspkind.nvim',
            },
        },
        {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'jbyuki/one-small-step-for-vimkind',
            'leoluz/nvim-dap-go',
            'nvim-telescope/telescope-dap.nvim',
        },
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-file-browser.nvim',
                'nvim-lua/popup.nvim',
            }
        },
        {
            {
                'akinsho/bufferline.nvim',
                dependencies = {
                    'VPavliashvili/close-buffers.nvim',
                }
            },
        },
        {
            'kevinhwang91/nvim-ufo',
            dependencies = {
                'kevinhwang91/promise-async',
                {
                    "luukvbaal/statuscol.nvim",
                    config = function()
                        local builtin = require("statuscol.builtin")
                        require("statuscol").setup({
                            -- foldfunc = "builtin",
                            -- setopt = true,
                            relculright = true,
                            segments = {
                                { text = { builtin.foldfunc } },
                                { text = { "%s" } },
                                { text = { builtin.lnumfunc, " " } },
                            },
                        })
                    end,
                },
            }
        }
    },
    {
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

require("lsp")
require("debuggers")
