local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- [window]
-- config.window_decorations = 'NONE'
config.window_padding = { left = 8, right = 8, top = 2, bottom = 5 }

-- Alacritty has no tabs, so hide the bar unless you open more than one
config.hide_tab_bar_if_only_one_tab = true

-- [colors]
config.colors = {
  foreground = '#839496',
  background = '#002b36',
  -- order: black, red, green, yellow, blue, magenta, cyan, white
  ansi = {
    '#073642', '#dc322f', '#859900', '#b58900',
    '#268bd2', '#d33682', '#2aa198', '#eee8d5',
  },
  brights = {
    '#002b36', '#cb4b16', '#586e75', '#657b83',
    '#839496', '#6c71c4', '#93a1a1', '#fdf6e3',
  },
}

-- [font]
config.font_size = 13.0
config.font = wezterm.font('SauceCodePro Nerd Font', { weight = 'Medium' })
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font('SauceCodePro Nerd Font', { weight = 'DemiBold' }),
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font('SauceCodePro Nerd Font', { weight = 'DemiBold', italic = true }),
  },
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font('SauceCodePro Nerd Font', { italic = true }),
  },
}

return config
