-- vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.dictionary = {"~/.config/nvim/dicts/english.sh", "~/.config/nvim/dicts/serbian.txt"}
vim.g.mapleader = " "

vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  nbsp = '␣',
-- space = '.',
}

vim.opt.clipboard:append("unnamedplus")

vim.g.have_nerd_font = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


