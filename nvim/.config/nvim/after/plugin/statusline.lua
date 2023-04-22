local current_line = function()
    local max = tostring(vim.fn.line("$"))
    local cur = tostring(vim.fn.line("."))
    return cur .. "/" .. max
end

local current_time = function()
    return os.date(" %H:%M", os.time())
end

require('lualine').setup {
    options = {
        theme = 'onedark'
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', current_time },
        lualine_y = { 'filetype' },
        lualine_z = { current_line }
    },
    extensions = { 'nvim-tree' },
}

-- Turn off lualine inside nvim-tree
vim.cmd [[
  au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]]

-- Trigger rerender of status line every second for clock
if _G.Statusline_timer == nil then
    _G.Statusline_timer = vim.loop.new_timer()
else
    _G.Statusline_timer:stop()
end
_G.Statusline_timer:start(0, 1000 * 60, vim.schedule_wrap(
    function() vim.api.nvim_command('redrawstatus') end))
