-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    use('tpope/vim-sensible')            -- auto load, type search, ...
    use('tpope/vim-surround')            -- Surrounding ysw)
    use('preservim/nerdtree')            -- NerdTree
    use('ryanoasis/vim-devicons')        -- Developer Icons
    use('Xuyuanp/nerdtree-git-plugin')   -- ...
    use('tpope/vim-commentary')          -- For Commenting gcc & gc
    use('airblade/vim-gitgutter')        -- which line has been changed
    use('vim-airline/vim-airline')       -- Status bar
    use('lifepillar/pgsql.vim')          -- PSQL Pluging needs :SQLSetType pgsql.vim
    use('ap/vim-css-color')              -- CSS Color Preview
    use('rafi/awesome-vim-colorschemes') -- more color schemes
    use('tc50cal/vim-terminal')          -- Vim Terminal
    use('preservim/tagbar')              -- Tagbar for code navigation
    use('mg979/vim-visual-multi')        -- CTRL + N for multiple cursors
    use('christoomey/vim-tmux-navigator')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('ggandor/leap.nvim')
    use('jinh0/eyeliner.nvim')
    use('RRethy/vim-illuminate')

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- hex colors
    use {
        'RRethy/vim-hexokinase',
        run = 'make hexokinase'
    }

    -- -- rose-pine colorscheme
    -- use( {
    -- 	'rose-pine/neovim',
    -- 	as = 'rose-pine',
    -- 	config = function()
    -- 		vim.cmd('colorscheme rose-pine')
    -- 	end
    -- })
    --
    -- use {'neoclide/coc.nvim', branch = 'release'}

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }


    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
end)
