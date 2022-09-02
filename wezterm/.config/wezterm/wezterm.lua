local wezterm = require 'wezterm';
local act = wezterm.action

-- == != --> <-- => ==> <== <= >= ~=
return {
    font_size = 11,
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    window_background_opacity = 0.8,
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        { key = "k", mods = "CTRL|SHIFT", action = act.ScrollByLine(-5) },
        { key = "j", mods = "CTRL|SHIFT", action = act.ScrollByLine(5) },
    }
}
