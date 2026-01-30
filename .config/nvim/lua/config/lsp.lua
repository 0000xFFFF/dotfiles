-- config/lsp.lua
require("mason").setup()

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
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "dap" },
    },
})

-- Get default capabilities from cmp
local def_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Optional: toggle virtual text
local virtual_text_enabled = false
vim.diagnostic.config({ virtual_text = virtual_text_enabled, underline = false })

-- Global on_attach function for keymaps
local lsp_keymaps = function(client, bufnr)
    local opts = { buffer = bufnr, remap = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>lre", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>lrf", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<F3>", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "<F5>", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>t", function()
        virtual_text_enabled = not virtual_text_enabled
        vim.diagnostic.config({ virtual_text = virtual_text_enabled })
    end, opts)
    vim.keymap.set("n", "<leader>pde", vim.diagnostic.enable, opts)
    vim.keymap.set("n", "<leader>pdd", vim.diagnostic.disable, opts)
end

-- Setup clangd using the new API
vim.lsp.config('clangd', {
    capabilities = def_capabilities,
    on_attach = lsp_keymaps,
    cmd = { "clangd", "--compile-commands-dir=build" },
    root_markers = { "compile_commands.json", ".git" },
})
vim.lsp.enable('clangd')

-- Setup other servers using the new API
local servers = { "lua_ls", "cssls", "rust_analyzer", "html", "ts_ls", "gopls" }
for _, server in ipairs(servers) do
    local config = {
        on_attach = lsp_keymaps,
        capabilities = def_capabilities,
    }

    if server == "lua_ls" then
        config.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                }
            }
        }
    end

    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

vim.lsp.config("basedpyright", {
    capabilities = def_capabilities,
    on_attach = lsp_keymaps,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "strict", -- try "standard" if too noisy
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
})
vim.lsp.enable("basedpyright")
