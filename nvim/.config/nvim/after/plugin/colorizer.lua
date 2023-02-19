require 'colorizer'.setup {
    --'*'; -- Highlight all files, but customize some others.
    javascript = { names = false, },
    css = { rgb_fn = true, }, -- Enable parsing rgb(...) functions in css.
    html = { names = false, }, -- Disable parsing "names" like Blue or Gray

    go = { names = false, },
    gdscript = { names = false, },
    lua = { names = false, },
}
