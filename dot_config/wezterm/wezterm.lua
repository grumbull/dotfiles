-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'Kanagawa (Gogh)'
config.font = wezterm.font_with_fallback({
  {family = 'CaskaydiaCove Nerd Font Mono', scale = 1.0 },
  {family = 'Cascadia Code', scale = 1.0 },
  {family = 'Consolas', scale = 1.0 },
})
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000

-- TODO #mac install location is different on MacOS
config.default_prog = { 'C:\\Users\\mike\\scoop\\shims\\nu.EXE' }

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)


-- and finally, return the configuration to wezterm
return config

