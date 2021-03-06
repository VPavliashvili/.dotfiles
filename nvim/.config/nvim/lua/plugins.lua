return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'preservim/nerdcommenter'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'lukas-reineke/indent-blankline.nvim'
    use 'navarasu/onedark.nvim'

    --file explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    --lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'

    use 'habamax/vim-godot'

    --telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'

    --treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        --same as TSUpdate but avoding post installation first run error
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    --debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'jbyuki/one-small-step-for-vimkind'
    use 'leoluz/nvim-dap-go'
    use 'nvim-telescope/telescope-dap.nvim'
end)
