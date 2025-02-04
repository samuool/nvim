-- LEADER
vim.g.mapleader=' '

-- Jump half screen w/ center
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap=true } )
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap=true } )

-- Close all but current buffer
vim.keymap.set('n', '<leader>bb', ':%bd|e#<CR>')

