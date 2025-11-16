return {
    -- Packer replacement & core
    { "nvim-lua/plenary.nvim" },

    -- Sensible defaults
    { "tpope/vim-sensible" },
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },

    -- File explorers
    { "preservim/nerdtree" },
    { "ryanoasis/vim-devicons" },
    { "Xuyuanp/nerdtree-git-plugin" },

    -- Git & Undo tools
    { "airblade/vim-gitgutter" },
    {
        "tpope/vim-fugitive",
        config = function()
            require("config.fugitive")
        end
    },
    {
        "mbbill/undotree",
        config = function()
            require("config.undotree")
        end
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.lazygit")
        end
    },

    -- UI Enhancements
    { "vim-airline/vim-airline" },
    { "ap/vim-css-color" },
    { "rafi/awesome-vim-colorschemes" },
    {
        "RRethy/vim-hexokinase",
        build = "make hexokinase",
    },

    -- Terminal & Navigation
    { "tc50cal/vim-terminal" },
    { "christoomey/vim-tmux-navigator" },

    -- Coding Utilities
    { "lifepillar/pgsql.vim" },
    { "preservim/tagbar" },
    { "mg979/vim-visual-multi" },
    { "RRethy/vim-illuminate" },

    -- Motion Plugins
    { "jinh0/eyeliner.nvim" },
    {
        "ggandor/leap.nvim",
        config = function()
            require("config.leap")
        end
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.harpoon")
        end
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    { "nvim-treesitter/playground" },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.telescope")
        end
    },

    -- LSP and Autocompletion
    { "williamboman/mason.nvim",          config = true }, -- `config = true` will call require("mason").setup()
    { "williamboman/mason-lspconfig.nvim" },               -- No immediate config needed if lsp.lua handles it
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim", -- For completion icons
        },
        config = function()
            require("config.lsp")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
        end
    },

    -- Colorscheme
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("config.colors")
        end
    },

    -- Debugger
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "rcarriga/cmp-dap",  -- Autocompletion
        },
        config = function()
            require("config.dap") -- Adjust path to match your file location
        end,
    }
}
