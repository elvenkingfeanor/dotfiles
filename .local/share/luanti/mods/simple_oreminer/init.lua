local mt, ms = minetest, minetest.settings
local max_distance = tonumber(ms:get("simple_oreminer.max_distance")) or 40
local max_radius = tonumber(ms:get("simple_oreminer.max_radius")) or 1
local delay = tonumber(ms:get("simple_oreminer.delay")) or 0.01
local reverse = ms:get_bool("simple_oreminer.reverse_modifiers", false)
local prevent_break = ms:get_bool("simple_oreminer.prevent_tool_break", true)
local S = mt.get_translator(mt.get_current_modname())
local privilege = { description = S("Player can mine ores quickly.") }

---@param player mt.PlayerObjectRef
---@return boolean
local function check_modifiers(player)
	local control = player:get_player_control() or {}
	if reverse then
		if not control.aux1 and not control.sneak then
			return false
		end
	else
		if control.aux1 or control.sneak then
			return false
		end
	end
	return true
end

local function set(list)
	local ret = {}
	for _, v in ipairs(list) do
		ret[v] = true
	end
	return ret
end

local ores = set({
	"ethereal:etherium_ore",
	"default:stone_with_tin",
	"default:stone_with_coal",
	"default:stone_with_gold",
	"default:stone_with_iron",
	"default:stone_with_mese",
	"moreores:mineral_silver",
	"default:stone_with_copper",
	"moreores:mineral_mithril",
	"default:stone_with_diamond",
	"ethereal:stone_with_etherium_ore",
	"mcl_deepslate:deepslate_with_coal",
	"mcl_deepslate:deepslate_with_copper",
	"mcl_deepslate:deepslate_with_diamond",
	"mcl_deepslate:deepslate_with_emerald",
	"mcl_deepslate:deepslate_with_gold",
	"mcl_deepslate:deepslate_with_iron",
	"mcl_deepslate:deepslate_with_lapis",
	"mcl_deepslate:deepslate_with_redstone",
	"mcl_deepslate:deepslate_with_redstone_lit",
	"mcl_core:stone_with_coal",
	"mcl_core:stone_with_copper",
	"mcl_core:stone_with_diamond",
	"mcl_core:stone_with_emerald",
	"mcl_core:stone_with_gold",
	"mcl_core:stone_with_iron",
	"mcl_core:stone_with_lapis",
	"mcl_core:stone_with_redstone",
	"mcl_core:stone_with_redstone_lit",
	"ethereal:stone_with_etherium_ore",
	"ethereal:etherium_ore",
	"everness:coral_desert_stone_with_coal",
	"everness:crystal_stone_with_coal",
	"everness:mineral_stone_with_coal",
	"everness:stone_with_pyrite",
	"everness:quartz_ore",
	"technic:mineral_chromium",
	"technic:mineral_lead",
	"technic:mineral_sulfur",
	"technic:mineral_uranium",
	"technic:mineral_zinc",
})

---@param pos mt.Vector
---@param oldnode mt.Node
---@param digger mt.PlayerObjectRef
local function mine_recursive(pos, oldnode, digger)
	if not digger or not digger:is_player() then
		return
	end
	if not check_modifiers(digger) then
		return
	end
	local node_groups = mt.registered_nodes[oldnode.name].groups
	if not node_groups or not ores[oldnode.name] then
		return
	end
	local tool = digger:get_wielded_item()
	if not tool or not tool:get_definition().groups.pickaxe then
		return
	end
	if prevent_break then
		local wear = tool:get_wear()
		local tool_capabilities = tool:get_tool_capabilities()
		local dig_params = mt.get_dig_params(node_groups, tool_capabilities, wear)
		if wear >= 65536 - dig_params.wear * 9 then
			return
		end
	end
	if digger:get_hp() == 0 then
		return
	end
	local d = delay
	if not mt.check_player_privs(digger, "dwarf") then
		minetest.log("error", "long delay")
		d = d * 100
	end
	mt.after(d, function()
		local next_pos = mt.find_node_near(pos, max_radius, oldnode.name)
		if not next_pos then
			return
		end
		local digger_pos = digger:get_pos()
		if not digger_pos then
			return
		end
		if pos:distance(digger_pos) > max_distance then
			return
		end
		mt.node_dig(next_pos, mt.get_node(next_pos), digger)
		mine_recursive(pos, oldnode, digger)
	end)
end

mt.register_privilege("dwarf", privilege)
mt.register_on_dignode(mine_recursive)
