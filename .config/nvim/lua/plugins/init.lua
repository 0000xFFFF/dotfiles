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
            "rcarriga/cmp-dap", -- Autocompletion
        },
        config = function()
            require("config.dap") -- Adjust path to match your file location
        end,
    },


    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = false, -- disable inline suggestions
                },
                panel = {
                    enabled = false,
                },
            })
        end,
    },

    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },

    {
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            dependencies = {
                { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
                { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
            },
            build = "make tiktoken",                            -- Only on MacOS or Linux
            opts = {
                -- See Configuration section for options
            },
            keys = {
                { "<leader>zc", ":CopilotChat<CR>",         mode = "n", desc = "Chat with Copilot" },
                { "<leader>ze", ":CopilotChatExplain<CR>",  mode = "v", desc = "Explain Code" },
                { "<leader>zr", ":CopilotChatReview<CR>",   mode = "v", desc = "Review Code" },
                { "<leader>zf", ":CopilotChatFix<CR>",      mode = "v", desc = "Fix Code Issues" },
                { "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code" },
                { "<leader>zd", ":CopilotChatDocs<CR>",     mode = "v", desc = "Generate Docs" },
                { "<leader>zt", ":CopilotChatTests<CR>",    mode = "v", desc = "Generate Tests" },
                { "<leader>zm", ":CopilotChatCommit<CR>",   mode = "n", desc = "Generate Commit Message" },
                { "<leader>zs", ":CopilotChatCommit<CR>",   mode = "v", desc = "Generate Commit for Selection" },
            },
        },
    }

}
