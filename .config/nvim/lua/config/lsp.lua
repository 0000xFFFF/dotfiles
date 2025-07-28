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
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item

        ['<C-n>'] = cmp.mapping.select_next_item(),        -- Next item
        ['<C-p>'] = cmp.mapping.select_prev_item(),        -- Previous item

        -- Scroll docs inside the autocomplete popup
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),

        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
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
local lsp_keymaps = function(client, bufnr)
    local opts = { buffer = bufnr, remap = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>pws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>pca", vim.lsp.buf.code_action, opts)
    vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>pr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float, opts)

    vim.keymap.set("n", "<leader>t", function()
        virtual_text_enabled = not virtual_text_enabled
        vim.diagnostic.config({ virtual_text = virtual_text_enabled })
    end, opts)

    vim.keymap.set("n", "<leader>pde", vim.diagnostic.enable, opts)
    vim.keymap.set("n", "<leader>pdd", vim.diagnostic.disable, opts)
end

require 'lspconfig'.clangd.setup {
    capabilities = capabilities,
    on_attach = lsp_keymaps,
    cmd = { "clangd", "--compile-commands-dir=build" },
    root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
}
require 'lspconfig'.gopls.setup {
    capabilities = capabilities,
    on_attach = lsp_keymaps,
}
require 'lspconfig'.pyright.setup {
    capabilities = capabilities,
    on_attach = lsp_keymaps,
}

