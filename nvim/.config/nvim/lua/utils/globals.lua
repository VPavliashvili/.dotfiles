-- mostly stolen from tj

local function split(pString, pPattern)
    local Table = {} -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(Table, cap)
        end
        last_end = e + 1
        s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
        cap = pString:sub(last_end)
        table.insert(Table, cap)
    end
    return Table
end

-- Save the local require here
local require = require

local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = require
if ok then
    reloader = plenary_reload.reload_module
end

ReloadPlugin = function(...)
    local ok, plenary_reload = pcall(require, "plenary.reload")
    if ok then
        reloader = plenary_reload.reload_module
    end

    return reloader(...)
end

R = function(name)
    ReloadPlugin(name)
    return require(name)
end

PrintPretty = function(v)
    print(vim.inspect(v))
    return v
end

-- dumps lua table into a new buffer
DumpPrettyPrint = function(v)
    local s = vim.inspect(v)
    local output = split(s, '\n')

    vim.api.nvim_command('enew')
    vim.api.nvim_put(output, '', true, true)
end

-- useful when pasting from windows to linux
function FmtNewlines()
  local save = vim.fn.winsaveview()
  vim.cmd("keeppatterns %s/\\s\\+$\\|\\r$//e")
  vim.fn.winrestview(save)
end
