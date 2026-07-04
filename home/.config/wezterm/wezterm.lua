local wezterm = require("wezterm")
local act = wezterm.action

-- To get all system fonts: wezterm ls-fonts --list-system
local font_family
-- font_family = "BlexMono Nerd Font"
-- font_family = "Comic Mono"
-- font_family = "Consolas 7NF"
-- font_family = "Consolas"
-- font_family = "Cousine Nerd Font"
-- font_family = "Google Sans Code"
-- font_family = "IBM Plex Mono"
-- font_family = "Inconsolata Nerd Font"
-- font_family = "JetBrainsMono Nerd Font"
-- font_family = "Menlo"
-- font_family = "MesloLGM Nerd Font"
-- font_family = "Monaco"
-- font_family = "Mononoki Nerd Font"
-- font_family = "Mononoki"
-- font_family = "NotoSansM Nerd Font"
-- font_family = "RecMonoLinear Nerd Font"
-- font_family = "RobotoMono Nerd Font"
font_family = "JetBrains Mono"
local font_with_fallback = {
  font_family,
}
local font_size = 17
local line_height = 1.1

-- https://wezfurlong.org/wezterm/colorschemes/index.html
local color_scheme
color_scheme = "catppuccin-latte"
-- color_scheme = "NvimLight"
-- color_scheme = "Tokyo Night Storm"

local config = {
  check_for_updates = false,
  color_scheme = color_scheme,
  -- color_scheme = "PaperColor Light (base16)",
  -- color_scheme = "Papercolor Light (Gogh)",
  enable_tab_bar = false,
  font = wezterm.font_with_fallback(font_with_fallback),
  font_size = font_size,
  line_height = line_height,
  -- Disable ligature
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- Disable bell
  audible_bell = "Disabled",
  -- Cursor coloring
  force_reverse_video_cursor = true,
  -- font_rules = {
  --   {
  --     font = wezterm.font_with_fallback(font_with_fallback),
  --     intensity = "Bold",
  --     weight = "Regular",
  --   },
  -- },
}

config.keys = {
  {
    key = "F11",
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = "%",
    mods = "CTRL|SHIFT",
    action = act.SplitHorizontal({
      -- domain = 'CurrentPaneDomain'
    }),
  },
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = act.PaneSelect({ alphabet = "hl12345" }),
  },
  {
    key = "n",
    mods = "CTRL|SHIFT",
    action = act.SpawnTab("DefaultDomain"),
  },
  {
    key = "x",
    mods = "CTRL|SHIFT",
    action = act.CloseCurrentPane({ confirm = true }),
  },
  { key = "h", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
  { key = ":", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },
}

if wezterm.hostname() == "ubox" then
  -- https://github.com/wezterm/wezterm/issues/3774
  config.freetype_load_flags = "NO_HINTING"
  -- https://github.com/wezterm/wezterm/issues/3565
  config.front_end = "OpenGL"
end

if wezterm.target_triple == "aarch64-apple-darwin" then
  -- Tweak font on mac
  -- config.front_end = 'OpenGL'
  -- config.freetype_load_target = 'Light'
  -- config.freetype_render_target = 'HorizontalLcd'
  config.freetype_load_flags = "NO_HINTING"
  -- config.cell_width = 0.9
end

return config
