-- This file handles all LSP configuration for all supported languages
-- Be sure to install a recent version of node (mason will use npm for some language servers)
return {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v3.x',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim"
    },
    config = function()
        -- Setup neodev initially to overwrite lspconfig for vim config development
        require('neodev').setup({})
        local lsp_zero = require('lsp-zero')

        -- Setup code actions for lsp-zero plugin
        local setup_code_actions = function()
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
                local opts = {buffer = bufnr}
                vim.keymap.set('n', '<Leader>ce', vim.lsp.buf.code_action, opts)
            end)
        end

        local setup_client_capabilities = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        end

        local setup_mason = function()
            require('mason').setup({})
        end

        local register_lsps = function()
            require('mason-lspconfig').setup({
                ensure_installed = {'lua_ls', 'pyright', 'eslint', 'ts_ls', 'jsonls'},
                automatic_installation=true,
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    lua_ls=function()
                        require('lspconfig').lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = {"vim"},
                                    },
                                },
                            },
                        })
                    end,
                    eslint=function()
                        require('lspconfig').eslint.setup({
                            settings = {
                                format = false,
                                workingDirectory = {
                                    mode = 'location'
                                }
                            },
                        })
                    end,
                    ts_ls=function ()
                        require('lspconfig').ts_ls.setup({
                            init_options={
                                preferences={
                                    importModuleSpecifierEnding='js'
                                }
                            }
                        })
                    end,
                    pyright=function()
                        require('lspconfig').pyright.setup({
                        })
                    end,
                },
            })
        end
        local setup_cmp = function()
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp_action.tab_complete(),
                    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
                    ['<CR>'] = cmp.mapping.confirm({select = false})
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end
        -- Execution order
        setup_code_actions()
        setup_client_capabilities()
        setup_mason()
        setup_cmp()
        register_lsps()
    end
}
