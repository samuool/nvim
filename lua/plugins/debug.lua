return {
  { "rcarriga/nvim-dap-ui", enabled = false },
  {
    "MironPascalCaseFan/debugmaster.nvim",
     -- osv is needed if you want to debug neovim lua code. Also can be used 
     -- as a way to quickly test-drive the plugin without configuring debug adapters 
    dependencies = { "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind", "jay-babu/mason-nvim-dap.nvim" },
    config = function()
      local dm = require("debugmaster")

      vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
      vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

      dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code
      local dap = require("dap")

      -- Specified debug adapter handlers
      local js_debug_handler = function()
        local js_debug = vim.fn.stdpath("data")
        .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
        for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
          dap.adapters[adapter] = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            executable = {
              command = "node",
              args = { js_debug, "${port}", "127.0.0.1" },
            },
          }
        end

        for _, filetype in ipairs({ "javascript", "javascriptreact" }) do
          dap.configurations[filetype] = {
            {
              name = "Node.js: Launch current file",
              type = "pwa-node",
              request = "launch",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              console = "integratedTerminal",
              skipFiles = { "<node_internals>/**" },
            },
            {
              name = "Node.js: Attach to process",
              type = "pwa-node",
              request = "attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              skipFiles = { "<node_internals>/**" },
            },
            {
              name = "Jest: Debug current test file (nvim must be open in root directory of project)",
              type = "pwa-node",
              request = "launch",
              program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
              -- Required by Jest for native ES module tests (import/export).
              runtimeArgs = { "--experimental-vm-modules" },
              -- Keep tests in the debugger's process and run only this file.
              args = {
                "--runInBand",
                "--runTestsByPath",
                "${file}",
                "--watchAll=false",
                -- Allow time to inspect paused async tests before Jest times out.
                "--testTimeout=3600000",
              },
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              console = "integratedTerminal",
              skipFiles = { "<node_internals>/**" },
            },
            {
              name = "Chrome: Launch web app",
              type = "pwa-chrome",
              request = "launch",
              url = function()
                return vim.fn.input("App URL: ", "http://localhost:3000")
              end,
              webRoot = "${workspaceFolder}",
              sourceMaps = true,
            },
          }
        end
      end

      require("mason-nvim-dap").setup({
        ensure_installed = {"js"},
        automatic_installation = false,
        handlers = {
          js = js_debug_handler
        },
      })

    end
  }
}
