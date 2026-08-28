local function config()
    local function attach(bufnr, lang)
        -- returns false if the parser is missing instead of throwing error
        if not vim.treesitter.language.add(lang) then
            return false
        end
        vim.treesitter.start(bufnr, lang)
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        return true
    end

    local parsers = {
        "bash",
        "c",
        "c_sharp",
        "cpp",
        "gdscript",
        "go",
        "goctl",
        "godot_resource",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "hyprlang",
        "sway",
        "kdl",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "powershell",
        "python",
        "vim",
        "vimdoc",
        "yaml",
        "sql",
        "ssh_config",
        "json",
        "jsonc",
        "editorconfig",
        "javascript",
        "typescript",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "glsl",
        "fsharp",
        "css",
        "scss",
        "html",
        "xml",
        "toml",
    }

    vim.treesitter.language.register("c_sharp", "cs")
    local timeout = 30000 -- 30 seconds

    local installed = require("nvim-treesitter").get_installed("parsers")
    local to_install = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
    end, parsers)

    if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
    end

    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local lang = vim.treesitter.language.get_lang(args.match)
            if not lang then
                return
            end
            if attach(args.buf, lang) then
                return
            end

            -- at this point language is missing so installing first
            -- and then attaching after that
            require("nvim-treesitter").install(lang):wait(timeout)
            attach(args.buf, lang)
        end,
    })
end

local function get_plugin_spec()
    return {
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            config = config,
            build = ":TSUpdate",
        },
    }
end

return {
    get_plugin_spec = get_plugin_spec,
}
