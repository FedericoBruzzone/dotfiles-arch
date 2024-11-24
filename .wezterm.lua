-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font 'Iosevka'
config.window_decorations = 'NONE' -- In arch with KDE resize with win+right click
config.scrollback_lines = 10000
config.enable_scroll_bar = true
config.adjust_window_size_when_changing_font_size = false

-- and finally, return the configuration to wezterm
return config

-- NOT USED
-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
--
-- config.window_background_opacity = 0.5
-- config.text_background_opacity = 0.5
