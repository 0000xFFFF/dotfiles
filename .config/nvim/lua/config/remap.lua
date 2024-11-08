vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")       -- J        = put line below next to current line
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- CTRL + d = page down and center
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- CTRL + u = page up and center
vim.keymap.set("n", "n", "nzzzv")       --
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- copy
vim.keymap.set("n", "<leader>Y", [["+Y]])        -- copy
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

--vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)                            -- SPACE + f = format page with lsp

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])   -- SPACE + s = substring current selected word
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })                -- SPACE + x = make current file executable

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/config/packer.lua<CR>");

vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)
