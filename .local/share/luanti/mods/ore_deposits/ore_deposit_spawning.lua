-- ore_deposits/ore_deposit_spawning.lua

-- This Is Where The Spawning Mechanics For The Ore Deposits Are
-- This Spawns Coal Ore Deposits On Stone
function default.ore_deposits_ore_deposit_coal_on_stone_spawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "ore_deposits:ore_deposit_coal"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Coal On Stone Spawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 100000,
	action = function(...)
		default.ore_deposits_ore_deposit_coal_on_stone_spawn(...)
	end
})

-- This Despawns Coal Ore Deposits On Stone After Sometime To Combat Overcrowding
function default.ore_deposits_ore_deposit_coal_on_stone_despawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "ore_deposits:ore_deposit_coal" then
		return
	end
	minetest.set_node(pos, {name = "air"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Coal On Stone Despawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 1000,
	action = function(...)
		default.ore_deposits_ore_deposit_coal_on_stone_despawn(...)
	end
})

-- This Spawns Iron Ore Deposits On Stone
function default.ore_deposits_ore_deposit_iron_on_stone_spawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "ore_deposits:ore_deposit_iron"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Iron On Stone Spawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 200000,
	action = function(...)
		default.ore_deposits_ore_deposit_iron_on_stone_spawn(...)
	end
})

-- This Despawns Iron Ore Deposits On Stone After Sometime To Combat Overcrowding
function default.ore_deposits_ore_deposit_iron_on_stone_despawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "ore_deposits:ore_deposit_iron" then
		return
	end
	minetest.set_node(pos, {name = "air"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Iron On Stone Despawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 1000,
	action = function(...)
		default.ore_deposits_ore_deposit_iron_on_stone_despawn(...)
	end
})

-- This Spawns Copper Ore Deposits On Stone
function default.ore_deposits_ore_deposit_copper_on_stone_spawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "ore_deposits:ore_deposit_copper"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Copper On Stone Spawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 200000,
	action = function(...)
		default.ore_deposits_ore_deposit_copper_on_stone_spawn(...)
	end
})

-- This Despawns Copper Ore Deposits On Stone After Sometime To Combat Overcrowding
function default.ore_deposits_ore_deposit_copper_on_stone_despawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "ore_deposits:ore_deposit_copper" then
		return
	end
	minetest.set_node(pos, {name = "air"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Copper On Stone Despawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 1000,
	action = function(...)
		default.ore_deposits_ore_deposit_copper_on_stone_despawn(...)
	end
})

-- This Spawns Tin Ore Deposits On Stone
function default.ore_deposits_ore_deposit_tin_on_stone_spawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "ore_deposits:ore_deposit_tin"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Tin On Stone Spawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 300000,
	action = function(...)
		default.ore_deposits_ore_deposit_tin_on_stone_spawn(...)
	end
})

-- This Despawns Tin Ore Deposits On Stone After Sometime To Combat Overcrowding
function default.ore_deposits_ore_deposit_tin_on_stone_despawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "ore_deposits:ore_deposit_tin" then
		return
	end
	minetest.set_node(pos, {name = "air"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Tin On Stone Despawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 1000,
	action = function(...)
		default.ore_deposits_ore_deposit_tin_on_stone_despawn(...)
	end
})

-- This Spawns Gold Ore Deposits On Stone
function default.ore_deposits_ore_deposit_gold_on_stone_spawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "ore_deposits:ore_deposit_gold"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Gold On Stone Spawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 300000,
	action = function(...)
		default.ore_deposits_ore_deposit_gold_on_stone_spawn(...)
	end
})

-- This Despawns Gold Ore Deposits On Stone After Sometime To Combat Overcrowding
function default.ore_deposits_ore_deposit_gold_on_stone_despawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "ore_deposits:ore_deposit_gold" then
		return
	end
	minetest.set_node(pos, {name = "air"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Gold On Stone Despawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 1000,
	action = function(...)
		default.ore_deposits_ore_deposit_gold_on_stone_despawn(...)
	end
})

-- This Spawns Diamond Ore Deposits On Stone
function default.ore_deposits_ore_deposit_diamond_on_stone_spawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "ore_deposits:ore_deposit_diamond"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Diamond On Stone Spawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 400000,
	action = function(...)
		default.ore_deposits_ore_deposit_diamond_on_stone_spawn(...)
	end
})

-- This Despawns Diamond Ore Deposits On Stone After Sometime To Combat Overcrowding
function default.ore_deposits_ore_deposit_diamond_on_stone_despawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "ore_deposits:ore_deposit_diamond" then
		return
	end
	minetest.set_node(pos, {name = "air"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Diamond On Stone Despawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 1000,
	action = function(...)
		default.ore_deposits_ore_deposit_diamond_on_stone_despawn(...)
	end
})

-- This Spawns Mese Ore Deposits On Stone
function default.ore_deposits_ore_deposit_mese_on_stone_spawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "ore_deposits:ore_deposit_mese"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Mese On Stone Spawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 500000,
	action = function(...)
		default.ore_deposits_ore_deposit_mese_on_stone_spawn(...)
	end
})

-- This Despawns Mese Ore Deposits On Stone After Sometime To Combat Overcrowding
function default.ore_deposits_ore_deposit_mese_on_stone_despawn(pos, node)
	while node.name == "default:stone" do
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "ore_deposits:ore_deposit_mese" then
		return
	end
	minetest.set_node(pos, {name = "air"})
	return true
end

minetest.register_abm({
	label = "Ore Deposits Ore Deposit Mese On Stone Despawn",
	nodenames = {"default:stone"},
	interval = 63,
	chance = 1000,
	action = function(...)
		default.ore_deposits_ore_deposit_mese_on_stone_despawn(...)
	end
})