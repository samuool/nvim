return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See below for loading types from plugins (like lazy.nvim)
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "neovim/nvim-lspconfig" },
}
