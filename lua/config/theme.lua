function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='white'})
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white'})
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='white'})
end

-- SET COLORSCHEME
vim.cmd('colorscheme bamboo')
LineNumberColors()
