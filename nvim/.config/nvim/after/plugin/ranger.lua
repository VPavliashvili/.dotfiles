vim.cmd([[
    " Make Ranger replace Netrw and be the file explorer
    let g:rnvimr_enable_ex = 1

]])

-- image preview does not work on hidpi since 2x scaling brakes the offset

-- vim.keymap.set('n', '<leader>ft', ':RnvimrToggle<CR>')
-- vim.keymap.set('n', '<leader>rs', ':RnvimrResize<CR>')
