local wezterm = require("wezterm")

-- My version of tokyonight-day
-- https://wezfurlong.org/wezterm/config/appearance.html#defining-your-own-colors
-- local my_tokyonight_day = wezterm.get_builtin_color_schemes()["tokyonight_day"]

-- my_tokyonight_day.foreground = "#444444"
-- my_tokyonight_day.background = "#f7f7f7"
-- 
-- -- red
-- my_tokyonight_day.ansi[2] = "#C02020"
-- my_tokyonight_day.brights[2] = "#FF0000"
-- 
-- -- green
-- my_tokyonight_day.ansi[3] = "#008000"
-- my_tokyonight_day.brights[3] = "#20C020"


return {
  color_scheme = "PaperColorLight (Gogh)",
  -- color_schemes = {
  --   my_tokyonight_day = my_tokyonight_day,
  -- },
  -- color_scheme = "my_tokyonight_day",
  enable_tab_bar = false,
  -- To get all system fonts: wezterm ls-fonts --list-system
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font Mono",
    "ComicShannsMono Nerd Font",
    "JetBrainsMono Nerd Font",
  }),
  font_size = 14,
  -- Disable ligature
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- Disable bell
  audible_bell = "Disabled",
  -- Cursor coloring
  force_reverse_video_cursor = true,
}
