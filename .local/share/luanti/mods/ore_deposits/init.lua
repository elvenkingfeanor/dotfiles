-- ore_deposits/init.lua

-- Loads The LUA Files For The Mod

local path = minetest.get_modpath("ore_deposits")

-- Node Registration
dofile(path .. "/ore_nodes.lua")

-- Node Spawning
dofile(path .. "/ore_deposit_spawning.lua")