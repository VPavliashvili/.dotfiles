local wezterm = require 'wezterm';
local act = wezterm.action

local fonts = {
    caskaydia_cove = 'Caskaydia Cove Nerd Font Mono',
    fira_code = 'Fira Code Nerd Font',
    --jetbrains_mono = 'JetBrains Mono Nerd Font',
    jetbrains_mono = 'JetBrainsMono Nerd Font Mono'
}

return {
    font = wezterm.font(fonts.jetbrains_mono),
    font_size = 11,
    warn_about_missing_glyphs = false,
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    window_background_opacity = 0.8,
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        { key = "k", mods = "CTRL|SHIFT", action = act.ScrollByLine(-5) },
        { key = "j", mods = "CTRL|SHIFT", action = act.ScrollByLine(5) },
    }
}
