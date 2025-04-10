-- require('leap').create_default_mappings()
vim.keymap.set({'n', 'x', 'o'}, '<leader>g', '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, '<leader>G', '<Plug>(leap-backward)')
