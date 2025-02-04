-- Telescope (dependency for telescope file browsing plugin. Provides grep and fzf)
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
}
