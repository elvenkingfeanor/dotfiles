
-- translation support

local S = core.get_translator("beds")

-- global

beds = {
	mod = "redo",
	player = {},
	bed_position = {},
	pos = {},
	spawn = {},
	respawn = {},
	day_interval = {start = 0.2, finish = 0.805},
	get_translator = S,
	formspec = "size[8,11;true]"
	.. "no_prepend[]"
	.. "bgcolor[#080808BB;true]"
	.. "button_exit[2,10;4,0.75;leave;" .. core.formspec_escape(S("Leave Bed")) .. "]"
}

-- load api, register beds, load player respawn positions

local modpath = core.get_modpath("beds")

dofile(modpath .. "/functions.lua")
dofile(modpath .. "/api.lua")
dofile(modpath .. "/beds.lua")
dofile(modpath .. "/spawns.lua")


print("[MOD] Beds Redo loaded")
