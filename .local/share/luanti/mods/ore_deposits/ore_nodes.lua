-- ore_nodes/init.lua

-- These Are The Nodes That Will Spawn Randomly On Soil And Sand
-- Coal Ore Deposit
minetest.register_node("ore_deposits:ore_deposit_coal", {
	description = ("Coal Ore Deposit"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.25, 0.4375},
			{-0.375, -0.25, -0.4375, 0.375, 0.0625, 0.375},
			{-0.3125, 0.0625, -0.375, 0.375, 0.375, 0.3125},
			{-0.25, 0.375, -0.375, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"ore_deposits_coal.png"
	},
	groups = {ore_deposit_coal = 1, cracky = 3},
	drop = {
		max_items = 7,
		items = {
			{
				items = {"default:cobble"},
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone_with_coal"},
			},
			{
				items = {"default:stone_with_coal"},
				rarity = 3,
			},
			{
				items = {"default:coal_lump"},
				rarity = 3,
			},
			{
				items = {"default:coal_lump"},
				rarity = 3,
			}
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_stone_defaults()
})

-- Iron Ore Deposit
minetest.register_node("ore_deposits:ore_deposit_iron", {
	description = ("Iron Ore Deposit"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.25, 0.4375},
			{-0.3125, -0.25, -0.4375, 0.375, 0.0625, 0.375},
			{-0.3125, 0.0625, -0.375, 0.375, 0.375, 0.3125},
			{-0.25, 0.375, -0.375, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"ore_deposits_iron.png"
	},
	groups = {ore_deposit_iron = 1, cracky = 2},
	drop = {
		max_items = 7,
		items = {
			{
				items = {"default:cobble"},
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone_with_iron"},
			},
			{
				items = {"default:stone_with_iron"},
				rarity = 3,
			},
			{
				items = {"default:iron_lump"},
				rarity = 3,
			},
			{
				items = {"default:iron_lump"},
				rarity = 3,
			}
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_stone_defaults()
})

-- Copper Ore Deposit
minetest.register_node("ore_deposits:ore_deposit_copper", {
	description = ("Copper Ore Deposit"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.25, 0.4375},
			{-0.375, -0.25, -0.4375, 0.375, 0.0625, 0.4375},
			{-0.375, 0.0625, -0.375, 0.3125, 0.375, 0.3125},
			{-0.3125, 0.375, -0.3125, 0.25, 0.5, 0.25},
		}
	},
	tiles = {
		"ore_deposits_copper.png"
	},
	groups = {ore_deposit_copper = 1, cracky = 2},
	drop = {
		max_items = 7,
		items = {
			{
				items = {"default:cobble"},
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone_with_copper"},
			},
			{
				items = {"default:stone_with_copper"},
				rarity = 3,
			},
			{
				items = {"default:copper_lump"},
				rarity = 3,
			},
			{
				items = {"default:copper_lump"},
				rarity = 3,
			}
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_stone_defaults()
})

-- Tin Ore Deposit
minetest.register_node("ore_deposits:ore_deposit_tin", {
	description = ("Tin Ore Deposit"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.25, 0.4375},
			{-0.4375, -0.25, -0.375, 0.375, 0.0625, 0.375},
			{-0.375, 0.0625, -0.3125, 0.375, 0.375, 0.3125},
			{-0.375, 0.375, -0.3125, 0.3125, 0.5, 0.25},
		}
	},
	tiles = {
		"ore_deposits_tin.png"
	},
	groups = {ore_deposit_tin = 1, cracky = 2},
	drop = {
		max_items = 7,
		items = {
			{
				items = {"default:cobble"},
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone_with_tin"},
			},
			{
				items = {"default:stone_with_tin"},
				rarity = 3,
			},
			{
				items = {"default:tin_lump"},
				rarity = 3,
			},
			{
				items = {"default:tin_lump"},
				rarity = 3,
			}
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_stone_defaults()
})

-- Gold Ore Deposit
minetest.register_node("ore_deposits:ore_deposit_gold", {
	description = ("Gold Ore Deposit"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.25, 0.4375},
			{-0.375, -0.25, -0.375, 0.4375, 0.0625, 0.375},
			{-0.375, 0.0625, -0.3125, 0.375, 0.375, 0.3125},
			{-0.3125, 0.375, -0.25, 0.375, 0.5, 0.3125},
		}
	},
	tiles = {
		"ore_deposits_gold.png"
	},
	groups = {ore_deposit_gold = 1, cracky = 2},
	drop = {
		max_items = 7,
		items = {
			{
				items = {"default:cobble"},
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone_with_gold"},
			},
			{
				items = {"default:stone_with_gold"},
				rarity = 3,
			},
			{
				items = {"default:gold_lump"},
				rarity = 3,
			},
			{
				items = {"default:gold_lump"},
				rarity = 3,
			}
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_stone_defaults()
})

-- Diamond Ore Deposit
minetest.register_node("ore_deposits:ore_deposit_diamond", {
	description = ("Diamond Ore Deposit"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.25, 0.4375},
			{-0.375, -0.25, -0.375, 0.4375, 0.0625, 0.4375},
			{-0.375, 0.0625, -0.3125, 0.375, 0.375, 0.375},
			{-0.3125, 0.375, -0.25, 0.3125, 0.5, 0.3125},
		}
	},
	tiles = {
		"ore_deposits_diamond.png"
	},
	groups = {ore_deposit_diamond = 1, cracky = 1},
	drop = {
		max_items = 7,
		items = {
			{
				items = {"default:cobble"},
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone_with_diamond"},
			},
			{
				items = {"default:stone_with_diamond"},
				rarity = 3,
			},
			{
				items = {"default:diamond"},
				rarity = 3,
			},
			{
				items = {"default:diamond"},
				rarity = 3,
			}
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_stone_defaults()
})

-- Mese Ore Deposit
minetest.register_node("ore_deposits:ore_deposit_mese", {
	description = ("Mese Ore Deposit"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.25, 0.4375},
			{-0.375, -0.25, -0.375, 0.4375, 0.0625, 0.4375},
			{-0.3125, 0.0625, -0.3125, 0.375, 0.375, 0.375},
			{-0.25, 0.375, -0.3125, 0.375, 0.5, 0.375},
		}
	},
	tiles = {
		"ore_deposits_mese.png"
	},
	groups = {ore_deposit_mese = 1, cracky = 1},
	drop = {
		max_items = 7,
		items = {
			{
				items = {"default:cobble"},
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone"},
				rarity = 3,
			},
			{
				items = {"default:stone_with_mese"},
			},
			{
				items = {"default:stone_with_mese"},
				rarity = 3,
			},
			{
				items = {"default:mese_crystal"},
				rarity = 3,
			},
			{
				items = {"default:mese_crystal"},
				rarity = 3,
			}
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_stone_defaults()
})