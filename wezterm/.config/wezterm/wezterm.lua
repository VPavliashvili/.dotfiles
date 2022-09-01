local wezterm = require 'wezterm';
local act = wezterm.action

local fonts = {
    caskaydia_cove = 'Caskaydia Cove Nerd Font Mono',
    fira_code = 'FiraCode Nerd Font Mono',
    jetbrains_mono = 'JetBrainsMono Nerd Font Mono',
    awesome = 'Font Awesome 6 Free Solid',
    hack_nerd = 'Hack 1337',
    hack_mono = 'Hack Nerd Font Mono'
}
-- == != --> <-- => ==> <== <= >= ~=
return {
    font = wezterm.font(fonts.jetbrains_mono),
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
