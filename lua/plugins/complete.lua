return {
    'saghen/blink.cmp',
    dependencies = {
        'saghen/blink.lib'
    },
    build = function()
        -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
        -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
        require('blink.cmp').build():pwait()
    end,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = 'none',
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ['<C-n>'] = { 'select_next', 'fallback' },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ["<CR>"] = { "accept", "fallback" },
            ["<S-H>"] = { "hide_documentation", "fallback" }
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            ghost_text = {
                enabled = true
            },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },
            documentation = {
                auto_show = true,
                window = {
                    border = 'rounded'
                }
            },
            menu = {
                border = 'rounded',
                auto_show = true,
            },

        },
        cmdline = {
            enabled = true,
            keymap = {
                preset = 'default'
            },
        },

        -- (Default) list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        

        -- Compatability w/ luasnip engine
        snippets = {
            preset = 'luasnip'
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"`
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "lua" },
        appearance = {
            use_nvim_cmp_as_default = true
        }
    },
}
