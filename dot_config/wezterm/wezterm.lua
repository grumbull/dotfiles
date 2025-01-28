-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

-- Settings
config.color_scheme = "Kanagawa (Gogh)"
config.font = wezterm.font_with_fallback({
	{ family = "CaskaydiaCove Nerd Font Mono", scale = 1.0 },
	{ family = "Cascadia Code", scale = 1.0 },
	{ family = "Consolas", scale = 1.0 },
})
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000

-- Window startup location
-- TODO #mac, window position might be bad.
local taskbar_height = 75
local background_padding = 100
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window{}
	window:gui_window():maximize()
end)

-- TODO #mac install location is different on MacOS
config.default_prog = { "C:\\Users\\mike\\scoop\\shims\\nu.EXE" }

-- and finally, return the configuration to wezterm
return config
