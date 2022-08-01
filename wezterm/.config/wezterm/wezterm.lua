local wezterm = require 'wezterm';
local background_changer = require 'modules.auto_bgimage_changer'
local act = wezterm.action

local fonts = {
    caskaydia_cove = 'Caskaydia Cove Nerd Font Mono',
    fira_code = 'Fira Code Nerd Font',
    jetbrains_mono = 'JetBrains Mono Nerd Font',
}

return {
    font = wezterm.font(fonts.jetbrains_mono),
    font_size = 11,
    color_scheme = "MaterialDesignColors",
    warn_about_missing_glyphs = false,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    window_background_image = background_changer.get_wallpapaer(),
    keys = {
        { key = "k", mods = "CTRL|SHIFT", action = act.ScrollByLine(-1) },
        { key = "j", mods = "CTRL|SHIFT", action = act.ScrollByLine(1) },
    }
}
