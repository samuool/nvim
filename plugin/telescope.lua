-- Load file browser extension
require('telescope').load_extension 'file_browser'

-- Telescope keybindings
vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files path=%:p:h <CR>') --Fuzzy finder
vim.keymap.set('n', '<leader>n', ':Telescope file_browser path=%:p:h select_buffer=true<CR>') --File Browser
vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep path=%:p:h <CR>') --Live-grep
vim.keymap.set('n', '<leader>ls', '<cmd>Telescope buffers <CR>') --View buffers 
-- Bind command to move to config path
Move_Config = function()
	local config_dir = vim.fn.stdpath("config")
	require('telescope').extensions.file_browser.file_browser({
		cwd = config_dir
	})
end

vim.api.nvim_create_user_command('Config', Move_Config, {})
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
