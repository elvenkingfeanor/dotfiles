--[[
Drowning logic is implemented in PlayerSAO::step() in src/server/player_sao.cpp.  There is no global flag (like drowningEnable) or value (like maxBreath) that can be changed easily by a user or a lua mod to disable drowning.

The correct way to solve this problem would be to add such configuration options to the game code.  I will try to add this feature and get it merged, but it will take time.  Meanwhile this mod makes it a lot more fun to explore underwater :)

This script edits nodes to disable drowning.  It's less resource intensive and potentially less buggy than some other options (like periodically upping the breath on a player) but perhaps not as effective in certain corner cases.
]]--

local function make_water_breathable()
	local num_modified_nodes = 0

	for nodename,nodedef in pairs(minetest.registered_nodes)
	do
		--[[
		The minetest.registered_nodes lua table is a _copy_ of what the game engine sees.	Modifying it does NOT affect actual in-engine gameplay.
		
		Instead we have to re-register the node again after editing it, using a special syntax (":" in front of the node name) to tell the engine that we want to overwrite the existing definition.  See https://forum.minetest.net/viewtopic.php?t=4418 (and beware that not all of the answers there work).	
		]]--
		if nodedef ~= nil and nodedef.drowning ~= 0
		then
			print("nodrown: Disabling drowning on node " .. nodename)
			nodedef.drowning = 0
			minetest.register_node(":" .. nodename, nodedef)
			num_modified_nodes = num_modified_nodes + 1
		end
	end
	
	print("nodrown: Modified " .. num_modified_nodes .. " nodes")
end

--[[
We can't modify nodes when this init.lua is run, because it might run before some other mods register their nodes.

The normal way to fix this is to add the other mods to our mod's dependency list (which forces them to load before us), but then we would need a unique version of the nodrown mod to suit every other mod and mod combination (impossible).

We can't make our node edits during gameplay.  That leads to weird behaviours (water not spreading) and errors like this:

	2023-06-10 21:35:17: ERROR[Server]: Not allowing to place CONTENT_IGNORE while trying to replace "air" at (222,-106,286) (block (13,-7,17))

Luckily minetest.register_on_mods_loaded() seems to save the day.  It's a bit hacky (other mods could potentially use it to register nodes, which takes us back to square one) but it seems to work.
]]--
minetest.register_on_mods_loaded(make_water_breathable)
