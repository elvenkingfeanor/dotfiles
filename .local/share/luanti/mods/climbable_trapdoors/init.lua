local MAKE_CLOSED_DOORS_CLIMBABLE = false

local override = {
	climbable = true
}

minetest.override_item("doors:trapdoor_open", override)
minetest.override_item("doors:trapdoor_steel_open", override)

if MAKE_CLOSED_DOORS_CLIMBABLE then
	minetest.override_item("doors:trapdoor", override)
	minetest.override_item("doors:trapdoor_steel", override)
end

if minetest.registered_items["xpanes:trapdoor_steel_bar"] then
	minetest.override_item("xpanes:trapdoor_steel_bar_open", override)
	if MAKE_CLOSED_DOORS_CLIMBABLE then
		minetest.override_item("xpanes:trapdoor_steel_bar", override)
	end
end