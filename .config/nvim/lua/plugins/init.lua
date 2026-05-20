return {
    -- Packer replacement & core
    { "nvim-lua/plenary.nvim" },

    -- Sensible defaults
    { "tpope/vim-sensible" },
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },

    -- -- File explorers
    -- { "preservim/nerdtree" }, -- replaced with snacks.explorer
    -- { "ryanoasis/vim-devicons" }, -- replaced with snacks.explorer
    -- { "Xuyuanp/nerdtree-git-plugin" }, -- replaced with snacks.explorer

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

    -- Terminal & Navigation
    { "tc50cal/vim-terminal" },
    { "christoomey/vim-tmux-navigator" },

    -- Coding Utilities
    { "lifepillar/pgsql.vim" },
    { "preservim/tagbar" },
    { "mg979/vim-visual-multi" },
    -- { "RRethy/vim-illuminate" }, -- replaced with snacks words

    -- Motion Plugins
    { "jinh0/eyeliner.nvim" },
    {
        "https://codeberg.org/andyg/leap.nvim",
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
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "c", "lua", "python", "javascript", "bash", "vim", "vimdoc", "css", "html", "go", "kotlin", "markdown", "make" },
                auto_install = true,
                highlight = {
                    enable = true,
                },
            })
        end,
    },
    -- { "nvim-treesitter/playground" },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.telescope")
        end
    },

    -- LSP
    { "williamboman/mason.nvim", config = true },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        config = function()
            require("config.lsp")
        end,
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
            "rcarriga/cmp-dap", -- Autocompletion
        },
        config = function()
            require("config.dap") -- Adjust path to match your file location
        end,
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = false },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },

    {
        'dmtrKovalenko/fff.nvim',

        build = function()
            require("fff.download").download_or_build_binary()
        end,

        opts = {},
        lazy = false,
        keys = {
            {
                "<leader>f",
                function()
                    require('fff').find_files()
                end,
                desc = 'Find Files',
            },
            {
                "<leader>g",
                function()
                    require('fff').live_grep()
                end,
                desc = 'Live Grep',
            },
        },
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                AARRGGBB = false,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "virtualtext", -- "foreground" | "background" | "virtualtext"
                tailwind = false,
                virtualtext = "■",
            },
        },
    },
}
