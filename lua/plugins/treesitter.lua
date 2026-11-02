return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    ts.install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
      "html",
      "yaml",
      "latex",
      "python",
      "javascript",
      "typescript",
      "bash",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang then
          -- Some filetypes have no installed parser.
          pcall(vim.treesitter.start, args.buf, lang)
        end
      end,
    })
  end,
}
