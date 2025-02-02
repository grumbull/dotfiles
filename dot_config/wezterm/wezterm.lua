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

config.disable_default_key_bindings = true
config.keys = {}
table.insert(config.keys, {
  key = 'P',
  mods = 'CTRL|SHIFT',
  action = act.ActivateCommandPalette,
})

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
  key = 'q',
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
  key = '-',
  mods = tab_mod,
  action = act.ActivateLastTab, 
})

-- Pane Management
local pane_mod <const> = 'CTRL|SHIFT'
-- Split into left/right
table.insert(config.keys, {
  key = '+',
  mods = pane_mod,
  action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, 
})
-- Split into top/bottom
table.insert(config.keys, {
  key = '_',
  mods = pane_mod,
  action = act.SplitVertical { domain = 'CurrentPaneDomain' }, 
})
-- Close current pane 
table.insert(config.keys, {
  key = 'q',
  mods = pane_mod,
  action = act.CloseCurrentPane { confirm = false }, 
})
-- Activate pane left
table.insert(config.keys, {
  key = 'h',
  mods = pane_mod,
  action = act.ActivatePaneDirection 'Left', 
})
-- Activate pane right
table.insert(config.keys, {
  key = 'l',
  mods = pane_mod,
  action = act.ActivatePaneDirection 'Right', 
})
-- Activate pane up
table.insert(config.keys, {
  key = 'k',
  mods = pane_mod,
  action = act.ActivatePaneDirection 'Up', 
})
-- Activate pane down
table.insert(config.keys, {
  key = 'j',
  mods = pane_mod,
  action = act.ActivatePaneDirection 'Down', 
})
-- Adjust pane size left
table.insert(config.keys, {
  key = 'LeftArrow',
  mods = pane_mod,
  action = act.AdjustPaneSize {'Left', 5 } 
})
-- Adjust pane size right
table.insert(config.keys, {
  key = 'RightArrow',
  mods = pane_mod,
  action = act.AdjustPaneSize {'Right', 5 } 
})
-- Adjust pane size up
table.insert(config.keys, {
  key = 'UpArrow',
  mods = pane_mod,
  action = act.AdjustPaneSize {'Up', 5 } 
})
-- Adjust pane size down
table.insert(config.keys, {
  key = 'DownArrow',
  mods = pane_mod,
  action = act.AdjustPaneSize {'Down', 5 } 
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
