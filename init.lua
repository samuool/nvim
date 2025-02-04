-- Loading mappings
require('config.keymaps')

-- Basic Configurations 
vim.opt.guicursor=""
vim.wo.relativenumber=true
vim.wo.number=true
vim.wo.numberwidth=1

-- Remove swap files
vim.cmd('set noswapfile')

-- Space Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Keep cursor in the middle of the screen
vim.opt.scrolloff= 999

-- Load Lazy plugins
require('config.lazy')

-- Set theme
require('config.theme')

-- Enable keystroke recording 
vim.cmd('ShowkeysToggle')

-- Enable line blame on start
vim.cmd('Gitsigns toggle_current_line_blame')
