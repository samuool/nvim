-- This plugin allows support for grep, file browsing, fuzz finding using telescope
return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
        require('telescope').load_extension 'file_browser'
        vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files path=%:p:h <CR>') --Fuzzy finder
        vim.keymap.set('n', '<leader>n', ':Telescope file_browser path=%:p:h select_buffer=true<CR>') --File Browser
        vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep path=%:p:h <CR>') --Live-grep
        vim.keymap.set('n', '<leader>ls', '<cmd>Telescope buffers <CR>') --View buffers
        Move_Config = function()
	        local config_dir = vim.fn.stdpath("config")
            require('telescope').extensions.file_browser.file_browser({
                cwd = config_dir
            })
        end
        vim.api.nvim_create_user_command('Config', Move_Config, {})
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    end
}
