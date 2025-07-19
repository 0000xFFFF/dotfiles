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
vim.g.mapleader = " "

vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
-- space = '.',
}

vim.opt.clipboard:append("unnamedplus")
