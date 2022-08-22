local wezterm = require 'wezterm';
local slideshow = require 'modules.slideshow_manager'
local act = wezterm.action

local fonts = {
    caskaydia_cove = 'Caskaydia Cove Nerd Font Mono',
    fira_code = 'Fira Code Nerd Font',
    jetbrains_mono = 'JetBrains Mono Nerd Font',
}

local function run_slideshow()
    return slideshow.get_wallpaper()
end

return {
    font = wezterm.font(fonts.jetbrains_mono),
    font_size = 11,
    color_scheme = "MaterialDesignColors",
    warn_about_missing_glyphs = false,
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_background_image = run_slideshow(),
    keys = {
        { key = "k", mods = "CTRL|SHIFT", action = act.ScrollByLine(-5) },
        { key = "j", mods = "CTRL|SHIFT", action = act.ScrollByLine(5) },
    }
}
