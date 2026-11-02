return {
  { "rcarriga/nvim-dap-ui", enabled = false },
  {
    "MironPascalCaseFan/debugmaster.nvim",
     -- osv is needed if you want to debug neovim lua code. Also can be used 
     -- as a way to quickly test-drive the plugin without configuring debug adapters 
    dependencies = { "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind", },
    config = function()
      local dm = require("debugmaster")
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
      vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
      -- If you want to disable debug mode in addition to leader+d using the Escape key:
      -- vim.keymap.set("n", "<Esc>", dm.mode.disable)
      -- This might be unwanted if you already use Esc for ":noh"
      vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

      dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code
      local dap = require("dap")
      -- Installed with :MasonInstall js-debug-adapter (requires node on PATH).
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
            name = "Jest: Debug current test file",
            type = "pwa-node",
            request = "launch",
            program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
            -- Required by Jest for native ES module tests (import/export).
            runtimeArgs = { "--experimental-vm-modules" },
            -- Keep tests in the debugger's process and run only this file.
            args = { "--runInBand", "--runTestsByPath", "${file}", "--watchAll=false" },
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
  }
}
