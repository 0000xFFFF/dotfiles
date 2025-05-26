-- config/lsp.lua

-- Mason setup for managing LSP servers
require("mason").setup()
-- require("mason-lspconfig").setup({
--     ensure_installed = {
--         "lua_ls",
--         "clangd",
--         "arduino_language_server",
--         "bashls",
--         "cssls",
--         "html",
--         "lua_ls",
--         "pylsp",
--         "rust_analyzer",
--         "ts_ls",
--         "vimls"
--     },
--     automatic_installation = true,
-- })

-- Setup nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item

        ['<C-n>'] = cmp.mapping.select_next_item(),        -- Next item
        ['<C-p>'] = cmp.mapping.select_prev_item(),        -- Previous item

        -- Scroll docs inside the autocomplete popup
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),

        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Tab/S-Tab disabled
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
})

-- LSP Config
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Optional: toggle virtual text
local virtual_text_enabled = false
vim.diagnostic.config({ virtual_text = virtual_text_enabled, underline = false })

-- Global on_attach
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = true }

    local keymap = vim.keymap.set
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "<leader>pws", vim.lsp.buf.workspace_symbol, opts)
    keymap("n", "[d", vim.diagnostic.goto_next, opts)
    keymap("n", "]d", vim.diagnostic.goto_prev, opts)
    keymap("n", "<leader>pca", vim.lsp.buf.code_action, opts)
    keymap({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
    keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
    keymap("n", "<F4>", vim.lsp.buf.code_action, opts)
    keymap("n", "<leader>pr", vim.lsp.buf.references, opts)
    keymap("n", "<leader>r", vim.lsp.buf.rename, opts)
    keymap("n", "<F2>", vim.lsp.buf.rename, opts)
    keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    keymap("n", "<leader>?", vim.diagnostic.open_float, opts)

    keymap("n", "<leader>t", function()
        virtual_text_enabled = not virtual_text_enabled
        vim.diagnostic.config({ virtual_text = virtual_text_enabled })
    end, opts)

    keymap("n", "<leader>pde", vim.diagnostic.enable, opts)
    keymap("n", "<leader>pdd", vim.diagnostic.disable, opts)
end

local servers = { "clangd", "pylsp", "lua_ls" }

for _, server in ipairs(servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    if server == "lua_ls" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                }
            }
        }
    end

    lspconfig[server].setup(opts)
end
