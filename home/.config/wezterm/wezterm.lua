local wezterm = require("wezterm")

-- My version of tokyonight-day
-- https://wezfurlong.org/wezterm/config/appearance.html#defining-your-own-colors
-- local my_tokyonight_day = wezterm.get_builtin_color_schemes()["tokyonight_day"]

-- my_tokyonight_day.foreground = "#444444"
-- my_tokyonight_day.background = "#f7f7f7"

-- -- red
-- my_tokyonight_day.ansi[2] = "#C02020"
-- my_tokyonight_day.brights[2] = "#FF0000"

-- -- green
-- my_tokyonight_day.ansi[3] = "#008000"
-- my_tokyonight_day.brights[3] = "#20C020"

-- https://wezfurlong.org/wezterm/colorschemes/index.html
local color_scheme = "PaperColorLight (Gogh)"

return {
  check_for_updates = false,
  color_scheme = color_scheme,
  -- color_scheme = "Tokyo Night",
  -- color_schemes = {
  --   my_tokyonight_day = my_tokyonight_day,
  -- },
  -- color_scheme = "my_tokyonight_day",
  enable_tab_bar = false,
  -- To get all system fonts: wezterm ls-fonts --list-system
  font = wezterm.font_with_fallback({
    "DejaVuSansMono Nerd Font",
    "ComicShannsMono Nerd Font",
    "JetBrainsMono Nerd Font",
    "RobotoMono Nerd Font",
    "Iosevka Nerd Font",
    "FiraCode Nerd Font",
    "JetBrainsMono Nerd Font Mono",
  }),
  font_size = 11,
  -- Disable ligature
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- Disable bell
  audible_bell = "Disabled",
  -- Cursor coloring
  force_reverse_video_cursor = true,
}
