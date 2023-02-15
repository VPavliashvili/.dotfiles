local HEIGHT_RATIO = 0.88 -- You can change this
local WIDTH_RATIO = 0.25 -- You can change this too

local function openfile(node)
    local nt_api = require("nvim-tree.api")
    nt_api.node.open.edit(node)
    nt_api.tree.focus()
end

-- nvim-tree
require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    sync_root_with_cwd = true,
    view = {
        relativenumber = true,
        float = {
            enable = true,
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2)
                    - vim.opt.cmdheight:get()

                return {
                    border = "rounded",
                    relative = "editor",
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
        },
        width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
    },
    -- filters = {
    --   custom = { "^.git$" },
    -- },
    -- renderer = {
    --   indent_width = 1,
    -- },
})
vim.cmd [[
:NvimTreeFocus
]]
local opts = { noremap = true, silent = false }
vim.keymap.set('n', '<space>o', openfile, opts)
