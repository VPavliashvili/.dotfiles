return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'preservim/nerdcommenter'
    use 'flazz/vim-colorschemes'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'lukas-reineke/indent-blankline.nvim'

    --lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'

    use 'habamax/vim-godot'
end)
