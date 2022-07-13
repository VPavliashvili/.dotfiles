return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'preservim/nerdcommenter'
    use 'flazz/vim-colorschemes'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'lukas-reineke/indent-blankline.nvim'

    --lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'

    use 'habamax/vim-godot'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

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
end)
