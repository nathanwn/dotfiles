local wezterm = require("wezterm")

return {
  color_scheme = "PaperColorLight (Gogh)",
  enable_tab_bar = false,
  font = wezterm.font("JetBrains Mono Nerd Font"),
  font_size = 11,
  -- Disable ligature
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
}
