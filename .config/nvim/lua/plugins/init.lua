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

        keys = {
            -- Top Pickers & Explorer
            { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
            { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
            { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
            -- find
            { "<leader>sfb",     function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<leader>sfc",     function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>sff",     function() Snacks.picker.files() end,                                   desc = "Find Files" },
            { "<leader>sfg",     function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
            { "<leader>sfp",     function() Snacks.picker.projects() end,                                desc = "Projects" },
            { "<leader>sfr",     function() Snacks.picker.recent() end,                                  desc = "Recent" },
            -- -- git
            -- { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
            -- { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
            -- { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
            -- { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
            -- { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
            -- { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
            -- { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
            -- -- gh
            -- { "<leader>gi",      function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
            -- { "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
            -- { "<leader>gp",      function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
            -- { "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
            -- Grep
            { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
            { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
            { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
            { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
            { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
            { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
            { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
            { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
            { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
            { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
            { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
            { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
            { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
            { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
            { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
            { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
            { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
            { "<leader>sr",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
            { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
            { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
            -- LSP
            { "<leader>gd",      function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
            { "<leader>gD",      function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
            { "<leader>gr",      function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
            { "<leader>gI",      function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
            { "<leader>gy",      function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
            { "<leader>gai",     function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
            { "<leader>gao",     function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
            { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
            { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },

            {
                '<leader><F3>',
                function()
                    local word = vim.fn.expand('<cword>')
                    require('telescope.builtin').live_grep({ default_text = word })
                end,
                desc = 'Telescope live grep word under cursor'
            },
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
                "<leader>gg",
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
