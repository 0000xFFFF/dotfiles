vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", ':edit .<CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")       -- J        = put line below next to current line
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- CTRL + d = page down and center
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- CTRL + u = page up and center
vim.keymap.set("n", "n", "nzzzv")       --
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- copy
vim.keymap.set("n", "<leader>Y", [["+Y]])          -- copy
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

--vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader><F2>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- substring current selected word
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })                 -- make current file executable

vim.keymap.set({ "n", "v", "x" }, ":", ";")
vim.keymap.set({ "n", "v", "x" }, ";", ":")

vim.keymap.set("n", "<leader>s-", "<cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>s|", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
