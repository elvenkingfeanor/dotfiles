--[[
Research N' Duplication
Copyright (C) 2020 Noodlemire

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
--]]

--file-specific global storage
rnd.duplication = {}

--Stores each player's current selected duplication page, which is important only so that page selection works at all.
rnd.duplication.currentPage = {}

-- Translation support
local S = minetest.get_translator("rnd")
local F = minetest.formspec_escape


--Create both the player's duplication inventory, and a hidden trash inventory so that items in the survival inventory can be shift-click-dumped.
function rnd.duplication.init(player)
	player:get_inventory():set_size("duplication", 32)
	player:get_inventory():set_size("trash", 1)
end



--Count the amount of items that the player has completely researched, to determine how many pages there are.
local function countComplete(pname)
	local count = 0

	for iname, iprog in pairs(rnd.research.progs[pname]) do
		if rnd.research.complete(pname, iname) then
			count = count + 1
		end
	end

	return count
end

--A version of the pairs() function that sorts keys alphabetically.
local function spairs(t)
	--Collect the keys
	local keys = {}

	for k in pairs(t) do
		keys[#keys + 1] = k
	end

	--Sort them
	table.sort(keys)

	--Return the iterator function
	local i = 0

	return function()
		i = i + 1

		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end

--This function creates the duplication menu.
local function duplication_formspec(player, page, unified)
	local pname = player:get_player_name()

	--Get the player's inventory to look through later.
	local inv = player:get_inventory()

	--Show either the provided page number, or default to the first page.
	rnd.duplication.currentPage[pname] = page or 1

	--An iterator for the upcoming loop
	local i = 1
	--The start point, to determine when to start adding items to the duplication inventory.
	local itemI = (rnd.duplication.currentPage[pname] - 1) * 32 + 1

	--Clear the duplication inventory beforehand.
	inv:set_list("duplication", {})

	--For each item that this player has researched so far...
	for iname, iprog in spairs(rnd.research.progs[pname]) do
		--If research for this item is complete...
		if rnd.research.complete(pname, iname) then
			--If the iterator has reached or passed the starting point...
			if i >= itemI then
				--Create a new itemstack based on the current item's name
				local stack = ItemStack({name = iname})
				--Set its count to this item's specific maximum stack size
				stack:set_count(stack:get_stack_max())

				--Finally, add it to the inventory at the appropriate slot.
				inv:set_stack("duplication", (1 + i - itemI), stack)
			end

			--Iterate now
			i = i + 1

			--If the iterator has made enough progress to fill the entire page, this loop can be exited.
			if i > itemI + 32 then
				break
			end
		end
	end

	----The page number label's text is stored here because it is used more than once.
	local pageString = tostring(rnd.duplication.currentPage[pname]).."/"..tostring(math.max(math.ceil(countComplete(pname) / 32), 1))

	--Show a different inventory layout based on if the unified_inventory is open or not
	local base_inv = rnd.base_inv_formspec
	local btn_height = 4.05
	if unified then
		base_inv = rnd.base_unified_formspec
		btn_height = 3.7
	end

	--With all of the above information, the formspec can be formed here.
	--Note that every time information changes, the menu is reformed.
	--Also, note the extra listring to trash, which enables deletion of items in the survival inventory via shift-clicking.
	return base_inv..
		"button[1.5,"..btn_height..";1,1;frst;<<]"..
		"button[2.5,"..btn_height..";1,1;prev;<]"..
		"button[4.5,"..btn_height..";1,1;next;>]"..
		"button[5.5,"..btn_height..";1,1;last;>>]"..
		"label[3.7,"..(btn_height+0.05)..";"..F(S("Page")).."]"..
		"label["..tostring(3.9 - 0.05 * pageString:len())..","..(btn_height+0.3)..";"..pageString.."]"..
		"list[current_player;duplication;0,-0.1;8,4;]"..
		"listring[current_player;duplication]"..
		"listring[current_player;main]"..
		"listring[current_player;trash]"
end

--This function prevents players from placing anything inside the duplication inventory.
minetest.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
	if (action == "put" and inventory_info.listname == "duplication") or (action == "move" and inventory_info.to_list == "duplication") then
		return 0
	end
end)

--This function refills the duplication inventory whenever something is removed, and empties the trash slot whenever it is filled.
minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
	--Slightly different means are necessary when items are put in the survival inventory or thrown on the ground
	--due to differences in inventory_info variables when the action is "take" or "move".
	if action == "take" and inventory_info.listname == "duplication" then
		inventory:set_stack("duplication", inventory_info.index, inventory_info.stack)
	elseif action == "move" and inventory_info.from_list == "duplication" then
		local stack = inventory:get_stack(inventory_info.to_list, inventory_info.to_index)
		stack:set_count(stack:get_stack_max())

		inventory:set_stack("duplication", inventory_info.from_index, stack)
	end

	if action == "move" and inventory_info.to_list == "trash" then
		inventory:set_list("trash", {})
	end
end)

--Defines functionality for the page change buttons.
--This function is defined like this because it is used in two different places, one for sfinv and one that is used for /duplicate.
local function on_player_receive_fields_duplication(player, formname, fields, context)
	--If one of the four buttons were pressed...
	if ((unified_inventory and formname == "") or formname == "duplication") and (fields["frst"] or fields["prev"] or fields["next"] or fields["last"]) then
		local pname = player:get_player_name()
		local page = rnd.duplication.currentPage[pname]

		--The first page is always page 1
		if fields["frst"] then
			page = 1
		--Decrease the page number. If it dips below 1, keep it at 1.
		elseif fields["prev"] then
			page = math.max(1, page - 1)
		--Increase the page number. If it exceeds the last page, set it back to the last page.
		elseif fields["next"] then
			page = math.max(1, math.min(math.ceil(countComplete(pname) / 32), page + 1))
		--Get the amount of pages to find the last page.
		elseif fields["last"] then
			page = math.max(math.ceil(countComplete(pname) / 32), 1)
		end

		--When a page changes, the duplication menu has to be reformed.
		--A different method must be used if the sfinv inventory is open, so the tabs still work after the reformation.
		if unified_inventory and formname == "" then
			rnd.duplication.currentPage[pname] = page
			unified_inventory.set_inventory_formspec(player, "duplication")
		elseif sfinv and context then
			rnd.duplication.currentPage[pname] = page
			sfinv.set_player_inventory_formspec(player)
		else
			minetest.show_formspec(pname, "duplication", duplication_formspec(player, page))
		end
	end
end
--This applies the above function to /duplicate.
minetest.register_on_player_receive_fields(on_player_receive_fields_duplication)

--For use when sfinv isn't active.
minetest.register_chatcommand("duplicate", {
	params = "",
	description = S("Open the duplication menu."),
	privs = {},

	func = function(name, param)
		--Block creative players from using it.
		if minetest.settings:get_bool("creative_mode") or (creative and creative.is_enabled_for(name)) then
			minetest.chat_send_player(name, S("Creative Mode players can't use this."))
		else
			minetest.show_formspec(name, "duplication", duplication_formspec(minetest.get_player_by_name(name)))
		end
	end,
})

--When unified_inventory is active, the duplication tab is defined here, using several previously defined functions.
if unified_inventory then
	unified_inventory.register_page("duplication", {
		get_formspec = function(player)
			return {
				formspec = duplication_formspec(player, rnd.duplication.currentPage[player:get_player_name()], true),
				draw_inventory = false,
			}
		end
	})

	unified_inventory.register_button("duplication", {
		type = "image",
		image = "rnd_button_duplication_page.png",
		tooltip = S("Duplicate"),

		condition = function(player)
			return not unified_inventory.is_creative(player)
		end
	})

--When sfinv is active, the duplication tab is defined here, using several previously defined functions.
elseif sfinv then
	sfinv.register_page("duplication", {
		title = S("Duplicate"),

		get = function(self, player, context)
			return sfinv.make_formspec(player, context, duplication_formspec(player, rnd.duplication.currentPage[player:get_player_name()]))
		end,

		is_in_nav = function(self, player, context)
			return not (minetest.settings:get_bool("creative_mode") or (creative and creative.is_enabled_for(player)))
		end,

		on_player_receive_fields = function(self, player, context, fields)
			on_player_receive_fields_duplication(player, context.page, fields, context)

			--When this tab is exited, the player will see the home tab upon seeing the inventory next.
			--This prevents /duplicate from being bugged if it's used after closing the research tab.
			if fields["quit"] then
				sfinv.set_page(player, sfinv.get_homepage_name(player))
			end
		end,
	})
end
