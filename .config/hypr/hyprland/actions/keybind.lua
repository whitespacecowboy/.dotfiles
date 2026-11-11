local mainMod = "MOD1"
local browser = "zen-browser"
local fileManager = "yazi"
local calculator = "numbat"
local menu = "rofi -show drun"
local terminal = "ghostty"
local SCRIPT_PATH="$HOME/.config/shell/scripts/"


hl.bind(
	mainMod .. " + return",
	hl.dsp.exec_cmd(terminal)
)

hl.bind(
	mainMod .. " + W",
	hl.dsp.window.close(),
	{ submap_universal = true }
)

hl.bind(
	mainMod .. " + N",
	hl.dsp.exec_cmd(browser)
)

hl.bind(
	mainMod .. " + P",
	hl.dsp.exec_cmd(browser .. " --private-window")
)

hl.bind(
	mainMod .. " + Y",
	hl.dsp.exec_cmd(terminal .. " -e zsh -c " .. fileManager)
)

hl.bind(
	mainMod .. " + E",
	hl.dsp.exec_cmd(menu)
)

hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen(),
	{ submap_universal = true }
)

hl.bind(
	"Print",
	hl.dsp.exec_cmd("flameshot full -c -p $HOME/Media/Pictures/Screenshots/")
)

hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd("flameshot gui --last-region -c -p $HOME/Media/Pictures/Screenshots/")
)

hl.bind(
	mainMod .. " + V",
	hl.dsp.window.float({ action = "toggle" })
)

hl.bind(
	mainMod .. " + Z",
	hl.dsp.exec_cmd("hyprlock")
)

hl.bind(
	mainMod .. " + S",
	hl.dsp.layout("togglesplit")
) -- dwindle only


hl.bind(
	mainMod .. " + H",
	hl.dsp.focus({ direction = "left" }),
	{ submap_universal = true }
)

hl.bind(
	mainMod .. " + L",
	hl.dsp.focus({ direction = "right" }),
	{ submap_universal = true }
)

hl.bind(
	mainMod .. " + K",
	hl.dsp.focus({ direction = "up" }),
	{ submap_universal = true }
)

hl.bind(
	mainMod .. " + J",
	hl.dsp.focus({ direction = "down" }),
	{ submap_universal = true }
)

for i = 1, 10 do
	local key = i % 10
	hl.bind(
		mainMod .. " + " .. key,
		hl.dsp.focus({ workspace = i }),
		{ submap_universal = true }
	)

	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ submap_universal = true }
	)
end

hl.bind(
	mainMod .. " + T",
	hl.dsp.workspace.toggle_special("magic"),
	{ submap_universal = true }
)

hl.bind(
	mainMod .. " + A",
	hl.dsp.focus({ workspace = "e-1" }),
	{ submap_universal = true }
)

hl.bind(
	mainMod .. " + D",
	hl.dsp.focus({ workspace = "e+1" }),
	{ submap_universal = true }
)


hl.bind(
	mainMod .. " + mouse_down",
	hl.dsp.focus({ workspace = "e+1" })
)

hl.bind(
	mainMod .. " + mouse_up",
	hl.dsp.focus({ workspace = "e-1" })
)

hl.bind(
	mainMod .. " + mouse:272",
	hl.dsp.window.drag(),
	{ mouse = true }
)

hl.bind(
	mainMod .. " + mouse:273",
	hl.dsp.window.resize(),
	{ mouse = true }
)

hl.bind(
	mainMod .. " + M",
	hl.dsp.submap("move"),
	{ submap_universal = true }
)

hl.define_submap("move", function()
	hl.bind("H", hl.dsp.window.move({ direction = "left" }))
	hl.bind("J", hl.dsp.window.move({ direction = "down" }))
	hl.bind("K", hl.dsp.window.move({ direction = "up" }))
	hl.bind("L", hl.dsp.window.move({ direction = "right" }))
	hl.bind("C", hl.dsp.window.center())
	-- TODO: add keybind to move all the windows of a workspace
	--			to another workspace.

	for i = 1, 10, 1 do
		local workspaceIndex = i % 10
		hl.bind(tostring(workspaceIndex), hl.dsp.window.move({ workspace = i }))
		hl.bind("SHIFT + " .. workspaceIndex, hl.dsp.window.move({ workspace = i, follow = false }))
	end

	hl.bind("A", hl.dsp.window.move({ workspace = "-1" }))
	hl.bind("D", hl.dsp.window.move({ workspace = "+1" }))
	hl.bind("T", hl.dsp.window.move({ workspace = "special:magic" }))
	hl.bind("SHIFT + T", hl.dsp.window.move({ workspace = "special:magic", follow = false }))

	hl.bind("catchall", hl.dsp.submap("move"))
	hl.bind("I", hl.dsp.submap("reset"))
end)

hl.bind(
	mainMod .. " + R",
	hl.dsp.submap("resize"),
	{ submap_universal = true }
)

hl.define_submap("resize", function()
	hl.bind(
		"H",
		hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
		{ repeating = true }
	)

	hl.bind(
		"J",
		hl.dsp.window.resize({ x = 0, y = 10, relative = true }),
		{ repeating = true }
	)

	hl.bind(
		"K",
		hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
		{ repeating = true }
	)

	hl.bind(
		"L",
		hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
		{ repeating = true }
	)


	hl.bind("catchall", hl.dsp.submap("resize"))
	hl.bind("I", hl.dsp.submap("reset"))
end)

hl.bind(
	mainMod .. " + U",
	hl.dsp.submap("utility"),
	{ submap_universal = true}
)

hl.define_submap("utility", "reset", function ()
	hl.bind("R", hl.dsp.exec_cmd(SCRIPT_PATH .. "bluetooth.sh"))

	hl.bind(
		"P",
		hl.dsp.exec_cmd("flameshot full -c -p $HOME/Media/Pictures/Screenshots/")
	)

	hl.bind(
		"S",
		hl.dsp.exec_cmd("flameshot gui --last-region -c -p $HOME/Media/Pictures/Screenshots/")
	)

	hl.bind("A", hl.dsp.submap("audio"))
	hl.bind("B", hl.dsp.submap("brightness"))
	hl.bind("I", hl.dsp.submap("reset"))
end)


hl.define_submap("audio", function()
	hl.bind(
		"N",
		hl.dsp.exec_cmd("playerctl next"),
		{ repeating = true }
	)

	hl.bind(
		"P",
		hl.dsp.exec_cmd("playerctl previous"),
		{ repeating = true }
	)

	hl.bind(
		"T",
		hl.dsp.exec_cmd("playerctl play-pause"),
		{ repeating = true }
	)

	hl.bind(
		"J",
		hl.dsp.exec_cmd(SCRIPT_PATH .. "decrease-volume.sh"),
		{ repeating = true }
	)

	hl.bind(
		"K",
		hl.dsp.exec_cmd(SCRIPT_PATH .. "increase-volume.sh"),
		{ repeating = true }
	)

	hl.bind(
		"M",
		hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
		{ repeating = true }
	)

	hl.bind(
		"SHIFT + M",
		hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
		{ repeating = true }
	)

	hl.bind("catchall", hl.dsp.submap("audio"))
	hl.bind("I", hl.dsp.submap("reset"))
end)

hl.define_submap("brightness", function ()

	hl.bind(
		"J",
		hl.dsp.exec_cmd(SCRIPT_PATH .. "decrease-brightness.sh"),
		{ repeating = true }
	)

	hl.bind(
		"K",
		hl.dsp.exec_cmd(SCRIPT_PATH .. "increase-brightness.sh"),
		{ repeating = true }
	)

	hl.bind("catchall", hl.dsp.submap("brightness"))
	hl.bind("I", hl.dsp.submap("reset"))

end)

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(SCRIPT_PATH .. "increase-volume.sh"),
	{ locked = true, repeating = true, submap_universal = true }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(SCRIPT_PATH .. "decrease-volume.sh"),
	{ locked = true, repeating = true, submap_universal = true }
)

hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true, submap_universal = true }
)


hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true, submap_universal = true }
)

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(SCRIPT_PATH .. "increase-brightness.sh"),
	{ locked = true, repeating = true, submap_universal = true }
)

hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(SCRIPT_PATH .. "decrease-brightness.sh"),
	{ locked = true, repeating = true, submap_universal = true }
)

hl.bind(
	"XF86AudioNext",
	hl.dsp.exec_cmd("playerctl next"),
	{ locked = true, submap_universal = true }
)

hl.bind(
	"XF86AudioPause",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true, submap_universal = true }
)

hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true, submap_universal = true }
)

hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd("playerctl previous"),
	{ locked = true, submap_universal = true }
)

hl.bind(
	"XF86Calculator",
	hl.dsp.exec_cmd(terminal .. " -e sh -c " .. calculator),
	{ locked = true, submap_universal = true }
)


-- hl.bind(
	-- 	"F11",
	-- 	hl.dsp.window.fullscreen_state({
		-- 		internal = -1,
		-- 		client = 2
		-- 	}),
		-- 	{ submap_universal = true }
		-- )
