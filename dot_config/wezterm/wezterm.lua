local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()
local act = wezterm.action

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
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
-- TODO #mac install location is different on MacOS
config.default_prog = { "C:\\Users\\mike\\scoop\\shims\\nu.EXE" }

config.keys = {}

-- Tab management
local tab_mod <const> = 'ALT'
-- Create a new tab.
table.insert(config.keys, {
  key = '=',
  mods = tab_mod,
  action = act.SpawnTab 'CurrentPaneDomain',
})
-- Delete the current tab.
table.insert(config.keys, {
  key = '-',
  mods = tab_mod,
  action = act.CloseCurrentTab { confirm = false }, 
})
-- Select tab by number.
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = tab_mod,
    action = act.ActivateTab(i - 1),
  })
end
table.insert(config.keys, {
  key = '0',
  mods = tab_mod,
  action = act.ActivateTab(9),
})
-- Go to last tab.
table.insert(config.keys, {
  key = 'l',
  mods = tab_mod,
  action = act.ActivateLastTab, 
})

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window{}
	window:gui_window():maximize()
end)

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

-- and finally, return the configuration to wezterm
return config
