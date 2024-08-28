local wezterm = require("wezterm")

local config = {
  check_for_updates = false,
  -- color_scheme = "tokyonight_day",
  -- color_scheme = "PaperColor Light (base16)",
  color_scheme = "Papercolor Light (Gogh)",
  enable_tab_bar = false,
  -- To get all system fonts: wezterm ls-fonts --list-system
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
    "ComicShannsMono Nerd Font",
    "DejaVuSansMono Nerd Font",
    "RobotoMono Nerd Font",
    "Iosevka Nerd Font",
    "FiraCode Nerd Font",
  }),
  font_size = 11,
  -- Disable ligature
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- Disable bell
  audible_bell = "Disabled",
  -- Cursor coloring
  force_reverse_video_cursor = true,
}

config.keys = {
  {
    key = "F11",
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
