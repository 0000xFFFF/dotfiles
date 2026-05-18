-- config/lsp.lua

-- ============================================================================
-- Mason
-- ============================================================================

require("mason").setup()

-- ============================================================================
-- nvim-cmp
-- ============================================================================

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"]      = cmp.mapping.confirm({ select = true }),
        ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
        ["<C-n>"]     = cmp.mapping.select_next_item(),
        ["<C-p>"]     = cmp.mapping.select_prev_item(),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
        ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "dap" },
    }),
})

-- ============================================================================
-- Capabilities
-- ============================================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ============================================================================
-- Diagnostics
-- ============================================================================

local virtual_text_enabled = false

vim.diagnostic.config({
    virtual_text     = virtual_text_enabled,
    underline        = false,
    update_in_insert = false,
    severity_sort    = true,
    float            = { border = "rounded" },
})

-- ============================================================================
-- Keymaps via LspAttach
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)

        vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>lre", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>lrf", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<F3>", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)

        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set("n", "<F5>", function() vim.lsp.buf.format({ async = true }) end, opts)

        vim.keymap.set("n", "<leader>t", function()
            virtual_text_enabled = not virtual_text_enabled
            vim.diagnostic.config({ virtual_text = virtual_text_enabled })
        end, opts)

        vim.keymap.set("n", "<leader>pde", function() vim.diagnostic.enable() end, opts)
        vim.keymap.set("n", "<leader>pdd", function() vim.diagnostic.disable() end, opts)
    end,
})

-- ============================================================================
-- Mason bin path helper
-- ============================================================================

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

local function bin(name)
    return mason_bin .. name
end

-- ============================================================================
-- Default config for all servers
-- ============================================================================

vim.lsp.config("*", {
    capabilities = capabilities,
})

-- ============================================================================
-- Server configs
-- ============================================================================

vim.lsp.config("clangd", {
    cmd          = { bin("clangd"), "--compile-commands-dir=build" },
    filetypes    = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", "CMakeLists.txt", ".git" },
})

vim.lsp.config("lua_ls", {
    cmd          = { bin("lua-language-server") },
    filetypes    = { "lua" },
    root_markers = { ".luarc.json", ".git" },
    settings     = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
            telemetry   = { enable = false },
        },
    },
})

vim.lsp.config("ts_ls", {
    cmd          = { bin("typescript-language-server"), "--stdio" },
    filetypes    = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
})

vim.lsp.config("gopls", {
    cmd          = { bin("gopls") },
    filetypes    = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.mod", "go.work", ".git" },
})

vim.lsp.config("rust_analyzer", {
    cmd          = { bin("rust-analyzer") },
    filetypes    = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
})

vim.lsp.config("basedpyright", {
    cmd          = { bin("basedpyright-langserver"), "--stdio" },
    filetypes    = { "python" },
    root_markers = { "pyproject.toml", "setup.py", ".git" },
    settings     = {
        basedpyright = {
            analysis = {
                typeCheckingMode       = "standard",
                autoSearchPaths        = true,
                useLibraryCodeForTypes = true,
                diagnosticMode         = "workspace",
            },
        },
    },
})

vim.lsp.config("cssls", {
    cmd          = { bin("vscode-css-language-server"), "--stdio" },
    filetypes    = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
})

vim.lsp.config("html", {
    cmd          = { bin("vscode-html-language-server"), "--stdio" },
    filetypes    = { "html" },
    root_markers = { "package.json", ".git" },
})

vim.lsp.config("jsonls", {
    cmd          = { bin("vscode-json-language-server"), "--stdio" },
    filetypes    = { "json", "jsonc" },
    root_markers = { ".git" },
})

-- ============================================================================
-- Enable all servers
-- ============================================================================

vim.lsp.enable({
    "clangd",
    "lua_ls",
    "ts_ls",
    "gopls",
    "rust_analyzer",
    "basedpyright",
    "cssls",
    "html",
    "jsonls",
})
