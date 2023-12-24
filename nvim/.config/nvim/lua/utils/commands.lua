-- dumps output of a passed internal/external command into new buffer
vim.api.nvim_create_user_command('DumpCmdOutput', function(param)
    local args = param.fargs
    local command = table.concat(args, ' ')

    if string.sub(command, 1, 1) ~= '!' then
        local cmd = string.format("vert new|pu=execute('%s')", command)
        vim.cmd(cmd)
    else
        local cmd = string.format('vert new | r %s', command)
        vim.cmd(cmd)
    end
end, { nargs = '*', bang = true })
