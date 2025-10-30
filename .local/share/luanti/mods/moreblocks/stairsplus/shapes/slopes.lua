local box_slope = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 },
		{ -0.5, -0.25, -0.25, 0.5, 0, 0.5 },
		{ -0.5, 0, 0, 0.5, 0.25, 0.5 },
		{ -0.5, 0.25, 0.25, 0.5, 0.5, 0.5 },
	},
}

local box_slope_half = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
		{ -0.5, -0.375, -0.25, 0.5, -0.25, 0.5 },
		{ -0.5, -0.25, 0, 0.5, -0.125, 0.5 },
		{ -0.5, -0.125, 0.25, 0.5, 0, 0.5 },
	},
}

local box_slope_half_raised = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, 0.125, 0.5 },
		{ -0.5, 0.125, -0.25, 0.5, 0.25, 0.5 },
		{ -0.5, 0.25, 0, 0.5, 0.375, 0.5 },
		{ -0.5, 0.375, 0.25, 0.5, 0.5, 0.5 },
	},
}

local box_slope_inner = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 },
		{ -0.5, -0.5, -0.25, 0.5, 0, 0.5 },
		{ -0.5, -0.5, -0.5, 0.25, 0, 0.5 },
		{ -0.5, 0, -0.5, 0, 0.25, 0.5 },
		{ -0.5, 0, 0, 0.5, 0.25, 0.5 },
		{ -0.5, 0.25, 0.25, 0.5, 0.5, 0.5 },
		{ -0.5, 0.25, -0.5, -0.25, 0.5, 0.5 },
	},
}

local box_slope_inner_half = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
		{ -0.5, -0.375, -0.25, 0.5, -0.25, 0.5 },
		{ -0.5, -0.375, -0.5, 0.25, -0.25, 0.5 },
		{ -0.5, -0.25, -0.5, 0, -0.125, 0.5 },
		{ -0.5, -0.25, 0, 0.5, -0.125, 0.5 },
		{ -0.5, -0.125, 0.25, 0.5, 0, 0.5 },
		{ -0.5, -0.125, -0.5, -0.25, 0, 0.5 },
	},
}

local box_slope_inner_half_raised = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, 0.125, 0.5 },
		{ -0.5, 0.125, -0.25, 0.5, 0.25, 0.5 },
		{ -0.5, 0.125, -0.5, 0.25, 0.25, 0.5 },
		{ -0.5, 0.25, -0.5, 0, 0.375, 0.5 },
		{ -0.5, 0.25, 0, 0.5, 0.375, 0.5 },
		{ -0.5, 0.375, 0.25, 0.5, 0.5, 0.5 },
		{ -0.5, 0.375, -0.5, -0.25, 0.5, 0.5 },
	},
}

local box_slope_outer = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 },
		{ -0.5, -0.25, -0.25, 0.25, 0, 0.5 },
		{ -0.5, 0, 0, 0, 0.25, 0.5 },
		{ -0.5, 0.25, 0.25, -0.25, 0.5, 0.5 },
	},
}

local box_slope_outer_half = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
		{ -0.5, -0.375, -0.25, 0.25, -0.25, 0.5 },
		{ -0.5, -0.25, 0, 0, -0.125, 0.5 },
		{ -0.5, -0.125, 0.25, -0.25, 0, 0.5 },
	},
}

local box_slope_outer_half_raised = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, -0.5, 0.5, 0.125, 0.5 },
		{ -0.5, 0.125, -0.25, 0.25, 0.25, 0.5 },
		{ -0.5, 0.25, 0, 0, 0.375, 0.5 },
		{ -0.5, 0.375, 0.25, -0.25, 0.5, 0.5 },
	},
}

stairsplus.api.register_shape("slope", {
	name_format = "slope_%s",
	description = "@1 Slope",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 4, -- 1/2 node
	drawtype = "mesh",
	mesh = "stairsplus_slope.obj",
	collision_box = box_slope,
	selection_box = box_slope,
})

stairsplus.api.register_shape("slope_half", {
	name_format = "slope_%s_half",
	description = "@1 1/2 Slope",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 2, -- 1/4 node, complement of slope_half_raised
	drawtype = "mesh",
	mesh = "stairsplus_slope_half.obj",
	collision_box = box_slope_half,
	selection_box = box_slope_half,
})

stairsplus.api.register_shape("slope_half_raised", {
	name_format = "slope_%s_half_raised",
	description = "@1 1/2 Slope Raised",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 6, -- 3/4 node, complement of slope_half
	drawtype = "mesh",
	mesh = "stairsplus_slope_half_raised.obj",
	collision_box = box_slope_half_raised,
	selection_box = box_slope_half_raised,
})

stairsplus.api.register_shape("slope_inner", {
	name_format = "slope_%s_inner",
	description = "@1 Slope Inner",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 5, -- 2/3 nodes, complement of slope_outer
	drawtype = "mesh",
	mesh = "stairsplus_slope_inner.obj",
	collision_box = box_slope_inner,
	selection_box = box_slope_inner,
})

stairsplus.api.register_shape("slope_outer", {
	name_format = "slope_%s_outer",
	description = "@1 Slope Outer",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 3, -- 1/3 nodes, complement of slope_inner
	drawtype = "mesh",
	mesh = "stairsplus_slope_outer.obj",
	collision_box = box_slope_outer,
	selection_box = box_slope_outer,
})

stairsplus.api.register_shape("slope_inner_cut", {
	name_format = "slope_%s_inner_cut",
	description = "@1 Slope Inner Cut",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 7, -- 5/6 nodes, complement of slope_outer_cut
	drawtype = "mesh",
	mesh = "stairsplus_slope_inner_cut.obj",
	collision_box = box_slope_inner,
	selection_box = box_slope_inner,
})

stairsplus.api.register_shape("slope_outer_cut", {
	name_format = "slope_%s_outer_cut",
	description = "@1 Slope Outer Cut",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 1, -- 1/6 nodes, complement of slope_inner_cut
	drawtype = "mesh",
	mesh = "stairsplus_slope_outer_cut.obj",
	collision_box = box_slope_outer,
	selection_box = box_slope_outer,
})

stairsplus.api.register_shape("slope_inner_half", {
	name_format = "slope_%s_inner_half",
	description = "@1 Slope Inner Half",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 3, -- 1/3 nodes, complement of slope_outer_half to make slab_8
	drawtype = "mesh",
	mesh = "stairsplus_slope_inner_half.obj",
	collision_box = box_slope_inner_half,
	selection_box = box_slope_inner_half,
})

stairsplus.api.register_shape("slope_outer_half", {
	name_format = "slope_%s_outer_half",
	description = "@1 Slope Outer Half",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 1, -- 1/6 nodes, complement of slope_inner_half to make slab_8
	drawtype = "mesh",
	mesh = "stairsplus_slope_outer_half.obj",
	collision_box = box_slope_outer_half,
	selection_box = box_slope_outer_half,
})

stairsplus.api.register_shape("slope_inner_cut_half", {
	name_format = "slope_%s_inner_cut_half",
	description = "@1 Slope Inner Cut Half",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 3, -- 11/12 nodes, complement of slope_outer_cut_half to make slab_8
	drawtype = "mesh",
	mesh = "stairsplus_slope_inner_cut_half.obj",
	collision_box = box_slope_inner_half,
	selection_box = box_slope_inner_half,
})

stairsplus.api.register_shape("slope_outer_cut_half", {
	name_format = "slope_%s_outer_cut_half",
	description = "@1 Slope Outer Cut Half",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 1, -- 1/12 nodes, complement of slope_inner_cut_half to make slab_8
	drawtype = "mesh",
	mesh = "stairsplus_slope_outer_cut_half.obj",
	collision_box = box_slope_outer_half,
	selection_box = box_slope_outer_half,
})

stairsplus.api.register_shape("slope_inner_half_raised", {
	name_format = "slope_%s_inner_half_raised",
	description = "@1 Slope Inner Half Raised",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 7, -- 5/6 nodes, complement of slope_outer_half to make node
	drawtype = "mesh",
	mesh = "stairsplus_slope_inner_half_raised.obj",
	collision_box = box_slope_inner_half_raised,
	selection_box = box_slope_inner_half_raised,
})

stairsplus.api.register_shape("slope_inner_cut_half_raised", {
	name_format = "slope_%s_inner_cut_half_raised",
	description = "@1 Slope Inner Cut Half Raised",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 7, -- 11/12 nodes, complement of slope_outer_cut_half to make node
	drawtype = "mesh",
	mesh = "stairsplus_slope_inner_cut_half_raised.obj",
	collision_box = box_slope_inner_half_raised,
	selection_box = box_slope_inner_half_raised,
})

stairsplus.api.register_shape("slope_outer_half_raised", {
	name_format = "slope_%s_outer_half_raised",
	description = "@1 Slope Outer Half Raised",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 5, -- 2/3 nodes, BUT slab_8 + slope_outer_half, complement of slope_inner_half to make node
	drawtype = "mesh",
	mesh = "stairsplus_slope_outer_half_raised.obj",
	collision_box = box_slope_outer_half_raised,
	selection_box = box_slope_outer_half_raised,
})

stairsplus.api.register_shape("slope_outer_cut_half_raised", {
	name_format = "slope_%s_outer_cut_half_raised",
	description = "@1 Slope Outer Cut Half Raised",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 3, -- 1/3 nodes, complement of slope_outer_cut_half to make slope
	drawtype = "mesh",
	mesh = "stairsplus_slope_outer_cut_half_raised.obj",
	collision_box = box_slope_outer_half_raised,
	selection_box = box_slope_outer_half_raised,
})

stairsplus.api.register_shape("slope_cut", {
	name_format = "slope_%s_cut",
	description = "@1 Slope Cut",
	shape_groups = { slope = 1, legacy = 1 },
	eighths = 4, -- 1/2 nodes, self complement
	drawtype = "mesh",
	mesh = "stairsplus_slope_cut.obj",
	collision_box = box_slope_outer,
	selection_box = box_slope_outer,
})
