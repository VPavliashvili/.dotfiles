local function get_sources()
    return {
        { name = "nvim_lsp",                group_index = 1 },
        { name = "nvim_lsp_signature_help", group_index = 1 },
        { name = "luasnip",                 group_index = 2 },
        { name = "treesitter",              group_index = 3 },
        { name = "path",                    group_index = 4 },
        { name = "calc",                    group_index = 5 },
        { name = "buffer",                  group_index = 6, keyword_length = 3 },
    }
end

local function get_mappings()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local utils = require("utils.helpers")

    return cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-a>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif utils.has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    })
end

local function config()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                col_offset = -3,
                side_padding = 1,
            },
            documentation = cmp.config.window.bordered(),
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        formatting = {
            format = lspkind.cmp_format(),
        },
        mapping = get_mappings(),
        sources = get_sources(),
    })
end

local function get_plugin_setup()
    return {
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "ray-x/cmp-treesitter",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-calc",
                "hrsh7th/cmp-nvim-lsp-document-symbol",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "saadparwaiz1/cmp_luasnip",
                "onsails/lspkind.nvim",
                {
                    "L3MON4D3/LuaSnip",
                    dependencies = {
                        "rafamadriz/friendly-snippets",
                    },
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                    build = "make install_jsregexp",
                    version = "v2.*",
                },
            },
            config = config,
        },
    }
end

return {
    get_plugin_setup = get_plugin_setup,
}
