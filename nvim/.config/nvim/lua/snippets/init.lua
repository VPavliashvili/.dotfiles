local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local get_file_name = function()
    local filename = vim.fn.expand("%:t:r")
    return filename ~= "" and filename or "ClassName"
end

-- csharp
ls.add_snippets("cs", {
    s({
        trig = "propr",
        desc = "Creates a property with required keyword, available in C# 11 or higher",
    }, {
        t("public required "),
        i(1, "int"),
        t(" "),
        i(0, "MyProperty"),
        t({ " { get; set; }" }),
    }),
    s({
        trig = "intfc",
        dscr = "Creates an interface with modifier",
    }, {
        i(1, "public"),
        t(" interface "),
        i(2, "IName"),
        t({ "", "{", "    " }),
        i(0, " "),
        t({ "", "}" }),
    }),
    s({
        trig = "clwi",
        dscr = "Creates a class which impelements an interface",
    }, {
        i(1, "public"),
        t(" class "),
        i(2, get_file_name()),
        t(" : "),
        i(3, "IInterface"),
        t({ "", "{", "    " }),
        i(0, " "),
        t({ "", "}" }),
    }),
    s({
        trig = "clstatic",
        dscr = "Creates a static class with modifier",
    }, {
        i(1, "public"),
        t(" static class "),
        i(2, "ClassName"),
        t({ "", "{", "    " }),
        i(0, " "),
        t({ "", "}" }),
    }),
    s({
        trig = "method_extension",
        dscr = "Creates an extension method",
    }, {
        i(1, "public"),
        t(" static "),
        i(2, "void"),
        t(" "),
        i(3, "MyMethod"),
        t("(this "),
        i(4, "object"),
        t(" "),
        i(5, "target"),
        t(")"),
        t({ "", "{", "    " }),
        i(0, " "),
        t({ "", "}" }),
    }),
})
