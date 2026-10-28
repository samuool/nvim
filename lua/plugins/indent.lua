return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        indent = {
            char='│',
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end= false,
        },
        exclude = {
            filetypes = {
                "help",
                "startify",
                "aerial",
                "alpha",
                "dashboard",
                "lazy",
                "mason",
                "neo-tree",
                "NvimTree",
                "toggleterm",
                "Trouble",
            },
        },
    }
}
