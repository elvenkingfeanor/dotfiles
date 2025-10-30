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

--Mod-specific global variable
rnd = {}

--MP = Mod Path
rnd.mp = minetest.get_modpath(minetest.get_current_modname())..'/'



--If default is loaded, grab its hotbar background image
local hotbar_bg = ""

if default then
	hotbar_bg = default.get_hotbar_bg(0,5.2)
end

--The size and player inventory menu, used for both the research and duplication menus
rnd.base_inv_formspec = "size[8,9.1]"..
			"list[current_player;main;0,5.2;8,1;]"..
			"list[current_player;main;0,6.35;8,3;8]"..
			hotbar_bg

if unified_inventory then
	rnd.base_unified_formspec = 
			"list[current_player;main;0,4.5;8,4;]"
end



--A custom API file that I find a little more convenient than the usual mod storage API.
dofile(rnd.mp.."storage.lua")

--All of the functionality of the research menu
dofile(rnd.mp.."research.lua")

--All of the functionality of the duplication menu
dofile(rnd.mp.."duplication.lua")
