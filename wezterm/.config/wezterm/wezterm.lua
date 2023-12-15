local wezterm = require 'wezterm';
local act = wezterm.action

-- == != --> <-- => ==> <== <= >= ~=
return {
    font_size = 11,
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    window_background_opacity = 0.8,
    hide_tab_bar_if_only_one_tab = true,
    enable_wayland = false,
    font = wezterm.font_with_fallback {
        'JetBrainsMono NF',
        'Hack Nerd Font Mono',
        'Hack Nerd Font Propo',
        'Font Awesome 6 Free Solid',
        'Font Awesome 6 Brands 10',
        'Font Awesome 6 Free',
        'Noto Color Emoji',
    },
    keys = {
        { key = "k", mods = "CTRL|SHIFT", action = act.ScrollByLine(-5) },
        { key = "j", mods = "CTRL|SHIFT", action = act.ScrollByLine(5) },
    }
}
