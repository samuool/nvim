-- This plugin allows support for grep, file browsing, fuzz finding using telescope
return {
        "nvim-telescope/telescope.nvim",
    version='0.2.1',
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
        require('telescope').load_extension 'file_browser'

        -- Set keymaps for built in Telescope actions
        -- Fuzzy finder
        vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files path=%:p:h hidden=true<CR>')
        -- File Browser
        vim.keymap.set('n', '<leader>n', ':Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>')
        -- Live-grep
        vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep path=%:p:h <CR>')
        -- Diagnostics
        vim.keymap.set('n', '<leader>e', '<cmd>Telescope diagnostics bufnr=0<CR>')
        vim.keymap.set('n', '<leader>h', "<cmd>lua require('telescope.builtin').lsp_document_symbols({ symbols='function' })<CR>")
        -- View Buffers
        vim.keymap.set('n', '<leader>b', "<cmd>Telescope buffers<CR>")
        -- Get References
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>')
        -- Get Document Symbols
        vim.keymap.set('n', 'ga', '<cmd>Telescope lsp_document_symbols<CR>')

        -- Create "Config" command
        Move_Config = function()
	        local config_dir = vim.fn.stdpath("config")
            require('telescope').extensions.file_browser.file_browser({
                cwd = config_dir
            })
        end
        vim.api.nvim_create_user_command('Config', Move_Config, {})

        -- Load the extension to intercept vim.ui.select calls
        require("telescope").load_extension("ui-select")
    end
}
