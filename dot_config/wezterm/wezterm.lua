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
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	local main_screen = wezterm.gui.screens().main
	window:gui_window():set_position(background_padding, background_padding)
	window:gui_window():set_inner_size(
		main_screen.width - background_padding * 2,
		main_screen.height - background_padding * 2 - taskbar_height
	)
end)

-- TODO #mac install location is different on MacOS
config.default_prog = { "C:\\Users\\mike\\scoop\\shims\\nu.EXE" }

-- and finally, return the configuration to wezterm
return config
