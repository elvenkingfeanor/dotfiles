-- for registering variants of a specific node
local api = stairsplus.api

local table_set_all = futil.table.set_all
local table_sort_keys = futil.table.sort_keys

local S = stairsplus.S

local default_align_style = stairsplus.settings.default_align_style
local silence_group_overrides = stairsplus.settings.silence_group_overrides

api.nodes_by_shape = {}
api.shapes_by_node = {}

api.node_by_shaped_node = {}
api.shape_by_shaped_node = {}

api.registered_singles = {}
api.registered_on_register_singles = {}

function api.register_on_register_single(func)
	table.insert(api.registered_on_register_singles, func)
end

local function check_node_validity(node_def, meta)
	local type_ = node_def.type
	if not meta.ignore_type and type_ ~= "node" then
		error(("cannot register non-node %q w/ stairsplus"):format(node_def.name))
	end

	local drawtype = node_def.drawtype
	if
		not meta.ignore_drawtype
		and (
			drawtype == "airlike"
			or drawtype == "liquid"
			or drawtype == "flowingliquid"
			or drawtype == "torchlike"
			or drawtype == "signlike"
			or drawtype == "plantlike"
			or drawtype == "firelike"
			or drawtype == "fencelike"
			or drawtype == "raillike"
			or drawtype == "nodebox"
			or drawtype == "mesh"
			or drawtype == "plantlike_rooted"
		)
	then
		error(("cannot register %q w/ drawtype %q w/ stairsplus"):format(node_def.name, drawtype))
	end

	local paramtype2 = node_def.paramtype2
	if
		not meta.ignore_paramtype2
		and (
			paramtype2 == "flowingliquid"
			or paramtype2 == "wallmounted"
			or paramtype2 == "leveled"
			or paramtype2 == "degrotate"
			or paramtype2 == "meshoptions"
			or paramtype2 == "color"
			or paramtype2 == "colorwallmounted"
			or paramtype2 == "glasslikeliquidlevel"
			or paramtype2 == "colordegrotate"
		)
	then
		error(("cannot register %q w/ paramtype2 %q w/ stairsplus"):format(node_def.name, paramtype2))
	end
end

function api.format_name(node, shape)
	local mod, name = node:match("^([^:]+):(.*)$")
	local shape_def = api.registered_shapes[shape]
	return ("%s:%s"):format(mod, shape_def.name_format:format(name))
end

function api.register_single(node, shape, overrides, meta)
	if not minetest.registered_nodes[node] then
		error(("node %q is not defined"):format(node))
	end

	if shape ~= "micro_8" and not (api.nodes_by_shape.micro_8 or {})[node] then
		-- always make sure a microblock exists
		api.register_single(node, "micro_8", overrides, meta)
	end

	local shaped_name = api.format_name(node, shape)

	if shape ~= "micro_8" and not api.is_whitelisted(shaped_name) then
		return false
	end

	stairsplus.log("info", "registering %s", shaped_name)

	meta = meta or {}
	overrides = table.copy(overrides or {})

	local node_def = table.copy(minetest.registered_nodes[node])

	check_node_validity(node_def, meta)

	if (api.nodes_by_shape[shape] or {})[node] then
		return -- already registered
	end

	local shape_def = api.registered_shapes[shape]

	local paramtype2
	if node_def.paramtype2 == "colorfacedir" then
		paramtype2 = "colorfacedir"
	else
		paramtype2 = shape_def.paramtype2 or "facedir"
	end

	-- shaped_node definition
	local def = {
		description = S(shape_def.description, node_def.description or node),

		drawtype = shape_def.drawtype,
		mesh = shape_def.mesh,
		node_box = shape_def.node_box,
		collision_box = shape_def.collision_box,
		selection_box = shape_def.selection_box,
		paramtype = shape_def.paramtype or "light",
		paramtype2 = paramtype2,

		light_source = api.scale_light(node_def.light_source, shape_def),
		groups = api.build_groups(node, shape),

		tiles = node_def.tiles,
		overlay_tiles = node_def.overlay_tiles,
		use_texture_alpha = node_def.use_texture_alpha,
		color = node_def.color,
		palette = node_def.palette, -- for coloredfacedir
		stack_max = node_def.stack_max,
		sounds = node_def.sounds,
		is_ground_content = node_def.is_ground_content,
		walkable = node_def.walkable,
		pointable = node_def.pointable,
		diggable = node_def.diggable,
		climbable = node_def.climbable,
		move_resistance = node_def.move_resistance,

		on_place = function(...)
			return api.on_place(...)
		end,
	}

	-- see-through nodes tend to look better if we just use the first tile
	if (node_def.drawtype or ""):match("glass") then
		if #def.tiles > 1 then
			def.tiles = { def.tiles[1] }
		end

		if def.overlay_tiles and #def.overlay_tiles > 1 then
			def.overlay_tiles = { def.overlay_tiles[1] }
		end
	end

	if node_def.short_description then
		def.short_description = S(shape_def.description, node_def.short_description)
	end

	-- if there's a drop defined, and we can drop a shaped version, do so
	if meta.legacy_drop then
		if type(meta.legacy_drop) == "string" then
			local item = api.get_schema_recipe_item(meta.legacy_drop, shape)
			if item then
				def.drop = item
			end
		end
	elseif node_def.drop and type(node_def.drop) == "string" then
		local item = api.get_schema_recipe_item(node_def.drop, shape)
		if item then
			def.drop = item
		end
	end

	if not silence_group_overrides and not meta.allow_override_groups and overrides.groups then
		stairsplus.log(
			"warning",
			"removing group overrides from %s (was %s, will be %s)",
			shaped_name,
			minetest.write_json(overrides.groups),
			minetest.write_json(def.groups)
		)
		overrides.groups = nil
	end

	if not meta.allow_override_drawtype and overrides.drawtype then
		stairsplus.log("warning", "removing drawtype override %s from %s", overrides.drawtype, shaped_name)
		overrides.drawtype = nil
	end

	if not meta.allow_override_paramtype2 and overrides.paramtype2 then
		stairsplus.log("warning", "removing paramtype2 override %s from %s", overrides.paramtype2, shaped_name)
		overrides.paramtype2 = nil
	end

	table_set_all(def, overrides)

	-- set backface_culling and align_style
	local align_style = meta.align_style or default_align_style
	for i, tile in ipairs(def.tiles) do
		if type(tile) == "string" then
			def.tiles[i] = {
				name = tile,
				backface_culling = true,
				align_style = align_style,
			}
		elseif not (tile.animation or tile.color) then
			tile.backface_culling = true
			tile.align_style = align_style
		end
	end

	if def.overlay_tiles then
		for i, tile in ipairs(def.overlay_tiles) do
			if type(tile) == "string" then
				def.overlay_tiles[i] = {
					name = tile,
					backface_culling = true,
					align_style = align_style,
				}
			elseif not (tile.animation or tile.color) then
				tile.backface_culling = true
				tile.align_style = align_style
			end
			def.overlay_tiles[i] = tile
		end
	end

	-- register node
	minetest.register_node(":" .. shaped_name, def)

	-- alias old name formats
	if shape_def.aliases then
		local mod, name = node:match("^([^:]+):(.*)$")
		for _, alias in ipairs(shape_def.aliases) do
			minetest.register_alias(("%s:%s"):format(mod, alias:format(name)), shaped_name)
		end
	end

	local nodes = api.nodes_by_shape[shape] or {}
	nodes[node] = true
	api.nodes_by_shape[shape] = nodes

	local shapes = api.shapes_by_node[node] or {}
	shapes[shape] = true
	api.shapes_by_node[node] = shapes

	api.node_by_shaped_node[shaped_name] = node
	api.shape_by_shaped_node[shaped_name] = shape

	api.node_by_shaped_node[node] = node
	api.shape_by_shaped_node[node] = "node"

	table.insert(api.registered_singles, { node, shaped_name })

	for _, func in ipairs(api.registered_on_register_singles) do
		func(node, shaped_name)
	end

	return shaped_name
end

function api.register_all(node, overrides, meta)
	for shape in pairs(api.registered_shapes) do
		api.register_single(node, shape, overrides, meta)
	end
end

function api.register_singles(node, shapes, overrides, meta)
	for _, shape in ipairs(shapes) do
		api.register_single(node, shape, overrides, meta)
	end
end

function api.register_group(node, shape_group, overrides, meta)
	for _, shape in ipairs(api.shapes_by_group[shape_group] or {}) do
		api.register_single(node, shape, overrides, meta)
	end
end

function api.register_groups(node, shape_groups, overrides, meta)
	for _, group in ipairs(shape_groups) do
		api.register_group(node, group, overrides, meta)
	end
end

function api.get_shapes(node)
	if api.shapes_by_node[node] then
		return table_sort_keys(api.shapes_by_node[node])
	end
end

-- warning: don't mutate the return value
function api.get_shapes_hash(node)
	return api.shapes_by_node[node]
end

-- turn a recipe item into a shape if possible
function api.get_schema_recipe_item(node, shape_or_item)
	if shape_or_item == "" then
		return ""
	end

	local name, count = shape_or_item:match("^([^ ]+) (%d+)")

	if not name then
		name = shape_or_item
	end

	count = tonumber(count)

	if api.registered_shapes[name] then
		name = api.format_name(node, name)
	elseif name == "node" then
		name = node
	elseif not name:match(":") then
		return
	end

	if count then
		return ("%s %s"):format(name, count)
	else
		return name
	end
end

function api.get_micronode(node)
	return api.get_schema_recipe_item(node, "micro_8")
end

function api.get_node_of_shaped_node(shaped_node)
	return api.node_by_shaped_node[shaped_node]
end

function api.get_shape_of_shaped_node(shaped_node)
	return api.shape_by_shaped_node[shaped_node]
end
