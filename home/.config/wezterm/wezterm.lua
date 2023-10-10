local wezterm = require("wezterm")

return {
  color_scheme = "PaperColorLight (Gogh)",
  enable_tab_bar = false,
  font = wezterm.font_with_fallback({
    "ComicShannsMono Nerd Font",
    "JetBrainsMono Nerd Font",
  }),
  font_size = 13,
  -- Disable ligature
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- Cursor coloring
  force_reverse_video_cursor = true,
}
