-- LEADER
vim.g.mapleader=' '

-- Jump half screen w/ center
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap=true } )
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap=true } )

-- Close all but current buffer
vim.keymap.set('n', '<leader>bb', ':%bd|e#<CR>')

-- LSP Keymaps (Some are also saved in telescope-file-browser for those that need telescope UI
-- Jump to where the symbol/interface is defined
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
-- Jump to the concrete implementation(s)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
-- Code Actions
vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, { desc = 'Get Code Actions' })
