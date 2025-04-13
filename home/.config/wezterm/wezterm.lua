local wezterm = require("wezterm")
local act = wezterm.action

local font_family
-- font_family = "Consolas 7NF"
-- font_family = "Consolas"
-- font_family = "Cousine Nerd Font"
-- font_family = "JetBrainsMono Nerd Font"
-- font_family = "MesloLGM Nerd Font"
-- font_family = "Inconsolata Nerd Font"
-- font_family = "NotoSansM Nerd Font"
font_family = "RecMonoLinear Nerd Font"
-- font_family = "RobotoMono Nerd Font"

local font_size = 16

if wezterm.hostname() == "ubox" then
  font_size = 11.5
  -- font_size = 12.5
end

-- https://wezfurlong.org/wezterm/colorschemes/index.html
local color_scheme
-- local color_scheme = "Equilibrium Gray Light (base16)"
-- local color_scheme = "Monokai (base16)"
-- local color_scheme = "OneDark (base16)"
-- local color_scheme = "One Dark (Gogh)"
-- local color_scheme = "One Light (base16)"
-- local color_scheme = "Papercolor Light (Gogh)"
-- local color_scheme = "Solarized (dark) (terminal.sexy)"
-- local color_scheme = "Solarized Dark (Gogh)"
color_scheme = "Tokyo Night Storm"

local font_with_fallback = {
  font_family,
  "JetBrainsMono Nerd Font",
  "ComicShannsMono Nerd Font",
  "DejaVuSansMono Nerd Font",
  "FiraCode Nerd Font",
  "Iosevka Nerd Font",
  "JetBrainsMono Nerd Font Mono",
  "RobotoMono Nerd Font",
}

local config = {
  check_for_updates = false,
  color_scheme = color_scheme,
  -- color_scheme = "PaperColor Light (base16)",
  -- color_scheme = "Papercolor Light (Gogh)",
  enable_tab_bar = false,
  -- To get all system fonts: wezterm ls-fonts --list-system
  font = wezterm.font_with_fallback(font_with_fallback),
  font_size = font_size,
  -- Disable ligature
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- Disable bell
  audible_bell = "Disabled",
  -- Cursor coloring
  force_reverse_video_cursor = true,
  font_rules = {
    {
      font = wezterm.font_with_fallback(font_with_fallback),
      intensity = "Bold",
      weight = "Normal",
    },
  },
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

return config
