-- dumps output of a passed internal/external command into new buffer
-- does not work for lua command
vim.api.nvim_create_user_command("DumpCmdOutput", function(param)
    local args = param.fargs
    local command = table.concat(args, " ")

    if string.sub(command, 1, 1) ~= "!" then
        -- e.g DumpCmdOutput !ls
        local cmd = string.format("vert new|pu=execute('%s')", command)
        vim.cmd(cmd)
    else
        -- e.g DumpCmdOutput ls
        local cmd = string.format("vert new | r %s", command)
        vim.cmd(cmd)
    end
end, { nargs = "*", bang = true })
