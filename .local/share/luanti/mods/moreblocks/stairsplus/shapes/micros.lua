stairsplus.api.register_shape("micro_1", {
	name_format = "micro_%s_1",
	description = "@1 1/16 Microblock",
	shape_groups = { micro = 1, legacy = 1 },
	eighths = 1, -- 1/64 nodes, complement of micro_15 to make panel_8
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0, -0.4375, 0.5 },
	},
})

stairsplus.api.register_shape("micro_2", {
	name_format = "micro_%s_2",
	description = "@1 1/8 Microblock",
	shape_groups = { micro = 1, legacy = 1 },
	eighths = 1, -- 1/32 nodes, complement of micro_14 to make panel_8
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0, -0.375, 0.5 },
	},
})

stairsplus.api.register_shape("micro_4", {
	name_format = "micro_%s_4",
	description = "@1 1/4 Microblock",
	shape_groups = { micro = 1, legacy = 1 },
	eighths = 1, -- 1/16 nodes, complement of micro_12 to make panel_8
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0, -0.25, 0.5 },
	},
})

stairsplus.api.register_shape("micro_8", {
	name_format = "micro_%s_8",
	aliases = { "micro_%s", "micro_%s_bottom" },
	description = "@1 Microblock", -- leave out the 1/2 to not confuse people too much...
	shape_groups = { micro = 1, obligatory = 1, legacy = 1 },
	eighths = 1, -- 1/8 nodes
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0, 0, 0.5 },
	},
})

stairsplus.api.register_shape("micro_12", {
	name_format = "micro_%s_12",
	description = "@1 3/4 Microblock",
	shape_groups = { micro = 1, legacy = 1 },
	eighths = 1, -- 3/16 nodes, complement of micro_4 to make panel_8
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0, 0.25, 0.5 },
	},
})

stairsplus.api.register_shape("micro_14", {
	name_format = "micro_%s_14",
	description = "@1 7/8 Microblock",
	shape_groups = { micro = 1, legacy = 1 },
	eighths = 1, -- 7/32 nodes, complement of micro_2 to make panel_8
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0, 0.375, 0.5 },
	},
})

stairsplus.api.register_shape("micro_15", {
	name_format = "micro_%s_15",
	aliases = { "micro_%s_5" },
	description = "@1 15/16 Microblock",
	shape_groups = { micro = 1, legacy = 1 },
	eighths = 1, -- 15/64 nodes, complement of micro_1 to make panel_8
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0, 0.4375, 0.5 },
	},
})
