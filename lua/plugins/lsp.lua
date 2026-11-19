return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function ()
        local mason = require("mason")
        mason.setup({})

        vim.lsp.config("jdtls", {
            cmd = function(dispatchers, config)
                -- Mason's jdtls 1.63.0 requires Java 25 to run the server.
                -- Keep the server JVM separate from the project's JAVA_HOME.
                local java_home = vim.env.JDTLS_JAVA_HOME

                if java_home==nil then
                  vim.notify("JDTLS_JAVA_HOME variable not configured", vim.log.levels.ERROR)
                end

                local root = config.root_dir or vim.fn.getcwd()
                local cache = vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.sha256(root)
                local cmd = {
                    "jdtls",
                    "--java-executable", java_home .. "/bin/java",
                    "-configuration", cache .. "/config",
                    "-data", cache .. "/workspace",
                }

                for arg in (vim.env.JDTLS_JVM_ARGS or ""):gmatch("%S+") do
                    table.insert(cmd, "--jvm-arg=" .. arg)
                end

                return vim.lsp.rpc.start(cmd, dispatchers, {
                    cwd = config.cmd_cwd,
                    env = config.cmd_env,
                    detached = config.detached,
                })
            end,
        })

        local mason_lsp = require('mason-lspconfig')
        mason_lsp.setup({
            ensure_installed = { "lua_ls", "ts_ls", "eslint", "jdtls" },
        })


        local function fix_all(opts)
            opts = opts or {}

            local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
            vim.validate("bufnr", bufnr, "number")

            local client = opts.client or vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })[1]

            if not client then return end

            local request

            if opts.sync then
                request = function(buf, method, params) client:request_sync(method, params, nil, buf) end
            else
                request = function(buf, method, params) client:request(method, params, nil, buf) end
            end

            request(bufnr, "workspace/executeCommand", {
                command = "eslint.applyAllFixes",
                arguments = {
                    {
                        uri = vim.uri_from_bufnr(bufnr),
                        version = vim.lsp.util.buf_versions[bufnr],
                    },
                },
            })
        end

        vim.lsp.config("eslint", {
            settings = {
                -- helps eslint find the configuration file when located in subfolders
                workingDirectories = { mode = "auto" },
            },
            on_attach = function(client, bufnr)
                vim.api.nvim_create_user_command("EslintFixAll", function() fix_all({ client = client, sync = true }) end, {})
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                })
            end
        })
    end
}
