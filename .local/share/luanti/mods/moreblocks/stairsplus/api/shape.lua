local f = string.format

local api = stairsplus.api

api.registered_on_register_shapes = {}
api.registered_shapes = {}
api.shapes_by_group = {}

function api.register_on_register_shape(func)
	table.insert(api.registered_on_register_shapes, func)
end

function api.register_shape(name, def)
	stairsplus.log("info", "registering shape %q", name)
	def.shape_groups = def.shape_groups or {}
	api.registered_shapes[name] = def

	for group in pairs(def.shape_groups) do
		local shapes = api.shapes_by_group[group] or {}
		table.insert(shapes, name)
		api.shapes_by_group[group] = shapes
	end

	for _, func in ipairs(api.registered_on_register_shapes) do
		func(name, def)
	end
end

function api.register_shape_group(shape_group, shapes)
	for _, shape in ipairs(shapes) do
		api.registered_shapes[shape].shape_groups[shape_group] = 1
	end
	api.shapes_by_group[shape_group] = shapes
end

function api.guess_shape(node_name)
	local mod, namepart = node_name:match("^([^:]+):([^:]+)$")
	if not (mod and namepart) then
		return
	end
	for name, def in pairs(api.registered_shapes) do
		local pattern = def.name_format:gsub("%%s", "(.*)")
		local matched = namepart:match(pattern)
		if matched and minetest.registered_nodes[f("%s:%s", mod, matched)] then
			return name
		end
	end
end
