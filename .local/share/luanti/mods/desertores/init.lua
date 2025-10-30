desertores = {}
desertores.registered_ores = {
	-- Coal
	{
		ore            = "default:stone_with_coal",
		clust_scarcity = 8 ^ 3,
		clust_num_ores = 9,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	},
	{
		ore            = "default:stone_with_coal",
		clust_scarcity = 8 ^ 3,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = 64,
		y_min          = -127,
	},
	{
		ore            = "default:stone_with_coal",
		clust_scarcity = 12 ^ 3,
		clust_num_ores = 30,
		clust_size     = 5,
		y_max          = -128,
		y_min          = -31000,
	},

	-- Tin
	{
		ore            = "default:stone_with_tin",
		clust_scarcity = 10 ^ 3,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	},
	{
		ore            = "default:stone_with_tin",
		clust_scarcity = 13 ^ 3,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -64,
		y_min          = -127,
	},
	{
		ore            = "default:stone_with_tin",
		clust_scarcity = 10 ^ 3,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -31000,
	},

	-- Copper
	{
		ore            = "default:stone_with_copper",
		clust_scarcity = 9 ^ 3,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	},
	{
		ore            = "default:stone_with_copper",
		clust_scarcity = 12 ^ 3,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -64,
		y_min          = -127,
	},
	{
		ore            = "default:stone_with_copper",
		clust_scarcity = 9 ^ 3,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -31000,
	},

	-- Iron
	{
		ore            = "default:stone_with_iron",
		clust_scarcity = 9 ^ 3,
		clust_num_ores = 12,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	},
	{
		ore            = "default:stone_with_iron",
		clust_scarcity = 7 ^ 3,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -255,
	},

	-- Gold
	{
		ore            = "default:stone_with_gold",
		clust_scarcity = 13 ^ 3,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	},

	-- Mese crystal
	{
		ore            = "default:stone_with_mese",
		clust_scarcity = 14 ^ 3,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	},

	-- Diamond
	{
		ore            = "default:stone_with_diamond",
		clust_scarcity = 15 ^ 3,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	},

	-- Mese block
	{
		ore            = "default:mese",
		clust_scarcity = 36 ^ 3,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = 31000,
		y_min          = 1025,
	},
	
	-- Diamond block
	{
		ore            = "default:diamondblock",
		wherein        = "default:stone",
		clust_scarcity = 29 ^ 3,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = 31000,
		y_min          = 1025,
	},
	{
		ore            = "default:diamondblock",
		wherein        = {"default:stone", "default:desert_stone"},
		clust_scarcity = 38 ^ 3,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -1024,
		y_min          = -2047,
	},
	{
		ore            = "default:diamondblock",
		wherein        = {"default:stone", "default:desert_stone"},
		clust_scarcity = 29 ^ 3,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -2048,
		y_min          = -31000,
	},
}

--Dense ores and more ores
local moreores_path = core.get_modpath("moreores")
local denseores_path = core.get_modpath("denseores")
local lumpblocks_path = core.get_modpath("lumpblocks")

if moreores_path then
	table.insert(desertores.registered_ores, {
		ore            = "moreores:mineral_silver",
		clust_scarcity = moreores.silver_chunk_size_high ^ 3,
		clust_num_ores = moreores.silver_ore_per_chunk_high,
		clust_size     = moreores.silver_clust_size_high,
		y_min          = moreores.silver_min_depth_high,
		y_max          = moreores.silver_max_depth_high,
	})
	table.insert(desertores.registered_ores, {
		ore            = "moreores:mineral_silver",
		clust_scarcity = moreores.silver_chunk_size ^ 3,
		clust_num_ores = moreores.silver_ore_per_chunk,
		clust_size     = moreores.silver_clust_size,
		y_min          = moreores.silver_min_depth,
		y_max          = moreores.silver_max_depth,
	})
	table.insert(desertores.registered_ores, {
		ore            = "moreores:mineral_silver",
		clust_scarcity = moreores.silver_chunk_size_deep ^ 3,
		clust_num_ores = moreores.silver_ore_per_chunk_deep,
		clust_size     = moreores.silver_clust_size_deep,
		y_min          = moreores.silver_min_depth_deep,
		y_max          = moreores.silver_max_depth_deep
	})
	table.insert(desertores.registered_ores, {
		ore            = "moreores:mineral_mithril",
		clust_scarcity = moreores.mithril_chunk_size_high ^ 3,
		clust_num_ores = moreores.mithril_ore_per_chunk_high,
		clust_size     = moreores.mithril_clust_size_high,
		y_min          = moreores.mithril_min_depth_high,
		y_max          = moreores.mithril_max_depth_high,
	})
end

if denseores_path then
	table.insert(desertores.registered_ores, {
		ore            = "denseores:large_mese_ore",
		wherein        = "default:stone_with_mese",
		clust_scarcity = 14,
		clust_num_ores = 2,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = -64,
	})
	table.insert(desertores.registered_ores, {
		ore            = "denseores:large_diamond_ore",
		wherein        = "default:stone_with_diamond",
		clust_scarcity = 14,
		clust_num_ores = 2,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = -128,
	})
	table.insert(desertores.registered_ores, {
		ore            = "default:mese",
		wherein        = "denseores:large_mese_ore",
		clust_scarcity = 36,
		clust_num_ores = 1,
		clust_size     = 1,
		y_min          = -31000,
		y_max          = -64,
	})
	table.insert(desertores.registered_ores, {
		ore            = "default:diamondblock",
		wherein        = "denseores:large_diamond_ore",
		clust_scarcity = 38,
		clust_num_ores = 1,
		clust_size     = 1,
		y_min          = -31000,
		y_max          = -128,
	})
end

if moreores_path and denseores_path then
	table.insert(desertores.registered_ores, {
		ore            = "denseores:large_mithril_ore",
		wherein        = "moreores:mineral_mithril",
		clust_scarcity = 12,
		clust_num_ores = 2,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = 64,
	})
	table.insert(desertores.registered_ores, {
		ore            = "denseores:large_silver_ore",
		wherein        = "moreores:mineral_silver",
		clust_scarcity = 12,
		clust_num_ores = 2,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = 64,
	})
	
	if lumpblocks_path then
		table.insert(desertores.registered_ores, {
			ore            = "lumpblocks:mithril_block",
			wherein        = "denseores:large_mithril_ore",
			clust_scarcity = 39,
			clust_num_ores = 1,
			clust_size     = 1,
			y_min          = -31000,
			y_max          = 64,
		})
	end
end

if moreores_path and lumpblocks_path then
	table.insert(desertores.registered_ores, {
		ore            = "lumpblocks:mithril_block",
		wherein        = {"default:stone", "default:desert_stone"},
		clust_scarcity = 39 ^ 3,
		clust_num_ores = 2,
		clust_size     = 1,
		y_min          = moreores.mithril_min_depth_high,
		y_max          = moreores.mithril_max_depth_high,
	})
	table.insert(desertores.registered_ores, {
		ore            = "lumpblocks:mithril_block",
		wherein        = {"default:stone", "default:desert_stone"},
		clust_scarcity = 39 ^ 3,
		clust_num_ores = 2,
		clust_size     = 1,
		y_min          = moreores.mithril_min_depth,
		y_max          = moreores.mithril_max_depth,
	})
	table.insert(desertores.registered_ores, {
		ore            = "lumpblocks:mithril_block",
		wherein        = {"default:stone", "default:desert_stone"},
		clust_scarcity = 30 ^ 3,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = moreores.mithril_min_depth_deep,
		y_max          = moreores.mithril_max_depth_deep,
	})
end

for _, def in ipairs(desertores.registered_ores) do
	def.ore_type = def.ore_type or "scatter"
	def.wherein = def.wherein or {
		"default:desert_stone", 
		"default:sandstone", 
		"default:desert_sandstone", 
		"default:silver_sandstone", 
		"default:permafrost", 
		"default:permafrost_with_moss", 
		"default:permafrost_with_stones",
		"default:cave_ice",
		"default:gravel"
	}
	core.register_ore(def)
end
