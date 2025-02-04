-- Requires ripgrep as well as plenary adds comment icons and functions for locating / searching todo comments
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        highlight = {
            multiline = false,
        }
    },
}
