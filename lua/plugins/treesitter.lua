-- File: ~/.config/nvim/lua/plugins/treesitter.lua (For lazy.nvim)
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- Modern branch
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    -- 1. Configure the core plugin (only accepts install_dir now)
    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- 2. Explicitly install your preferred parsers
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
      "bash"
    })

    -- 3. Modern built-in syntax highlighting (Built directly into Neovim)
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang then
          pcall(vim.treesitter.start, args.buf, lang)
        end
      end,
    })
  end,
}
