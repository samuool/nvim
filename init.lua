-- Loading mappings
require('config.keymaps')

-- Basic Configurations 
vim.go.guicursor = "n-v-sm:block,i-t-ci-ve-c:ver25,r-cr-o:hor20,a:Cursor"
vim.wo.relativenumber=true
vim.wo.number=true
vim.wo.numberwidth=1

-- Remove swap files
vim.cmd('set noswapfile')

-- Space Indenting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Keep cursor in the middle of the screen
vim.opt.scrolloff= 999
vim.opt.cursorline = true

-- Load Lazy plugins
require('config.lazy')

-- Set theme
require('config.theme')

-- Diagnostic preferences
require('config.diagnostics')
