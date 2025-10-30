-- cottonseed_oil/init.lua
-- Powerful fertilizer from cotton seed
--[[
    Copyright (c) 2018-2019  H. V. Smacker
    Copyright (c) 2024  1F616EMO

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
]]

local S = minetest.get_translator("cottonseed_oil")

minetest.register_craftitem("cottonseed_oil:cottonseed_oil", {
    description = S("Cottonseed Oil Fertilizer"),
    inventory_image = "cottonseed_oil.png",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then
            return
        end
        if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
            return
        end
        if not bonemeal.is_creative(user:get_player_name()) then
            itemstack:take_item()
        end
        bonemeal:on_use(pointed_thing.under, 4)
        return itemstack
    end,
})

minetest.register_alias("technic:cottonseed_oil", "cottonseed_oil:cottonseed_oil") 

minetest.register_craft({
    type = "fuel",
    recipe = "cottonseed_oil:cottonseed_oil",
    burntime = 20,
})

if minetest.registered_items["farming:seed_cotton"] then
    if minetest.get_modpath("technic") then
        technic.register_extractor_recipe({
            input = { "farming:seed_cotton 4" },
            output = "cottonseed_oil:cottonseed_oil"
        })
    else
        minetest.register_craft({
            type = "shapeless",
            recipe = {
                "farming:seed_cotton",
                "farming:seed_cotton",
                "farming:seed_cotton",
                "farming:seed_cotton"
            },
            output = "cottonseed_oil:cottonseed_oil"
        })
    end
else
    minetest.log("warning", "[cottonseed_oil] Cotton not found, disabling craft recipes.")
end