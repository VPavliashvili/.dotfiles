local wezterm = require 'wezterm';
local act = wezterm.action

return {
    font = wezterm.font("JetBrains Mono Nerd Font"),
    color_scheme = "MaterialDesignColors",
    warn_about_missing_glyphs = false,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    --window_background_image = "./Desktop/vin.jpg",
    keys = {
        { key = "k", mods = "SHIFT", action = act.ScrollByLine(-1) },
        { key = "j", mods = "SHIFT", action = act.ScrollByLine(1) },
    }
}

