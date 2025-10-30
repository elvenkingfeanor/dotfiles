--Hand Mineable Stone
minetest.register_node("sticks_stones:stones", {
  description = "Loose Stone",
  drawtype = "mesh",
  mesh = "sticks_stones_stone.obj",
  tiles = {"default_stone.png"},
  selection_box = {
    type = "fixed",
    fixed = {-0.2, -0.5, -0.144, 0.2, -0.38, 0.144},
  },
  walkable = false,
  paramtype = "light",
  sunlight_propagates = true,
  buildable_to = true,
  drop = "default:cobble",
  groups = {oddly_breakable_by_hand = 3, stone = 1, not_in_creative_inventory = 1, attached_node = 1},
})

--Hand Mineable Desert Stone
minetest.register_node("sticks_stones:desert_stones", {
  description = "Loose Desert Stone",
  drawtype = "mesh",
  mesh = "sticks_stones_stone.obj",
  tiles = {"default_desert_stone.png"},
  selection_box = {
    type = "fixed",
    fixed = {-0.2, -0.5, -0.144, 0.2, -0.38, 0.144},
  },
  walkable = false,
  paramtype = "light",
  sunlight_propagates = true,
  buildable_to = true,
  drop = "default:desert_cobble",
  groups = {oddly_breakable_by_hand = 3, stone = 1, not_in_creative_inventory = 1, attached_node = 1},
})

dofile(minetest.get_modpath("sticks_stones").."/decoration.lua")


--Craft a stick from 3 leaves
minetest.register_craft({
  output = "default:stick",
  recipe = {{"group:leaves", "group:leaves", "group:leaves"}},
})

--Craft 3 sticks from 9 leaves
minetest.register_craft({
  output = "default:stick 3",
  recipe = {
    {"group:leaves", "group:leaves", "group:leaves"},
    {"group:leaves", "group:leaves", "group:leaves"},
    {"group:leaves", "group:leaves", "group:leaves"},
  },
})

--Craft a stick from 3 dry shrubs
minetest.register_craft({
  output = "default:stick",
  recipe = {{"default:dry_shrub", "default:dry_shrub", "default:dry_shrub"}},
})

--Craft 3 sticks from 9 dry shubs
minetest.register_craft({
  output = "default:stick 3",
  recipe = {
    {"default:dry_shrub", "default:dry_shrub", "default:dry_shrub"},
    {"default:dry_shrub", "default:dry_shrub", "default:dry_shrub"},
    {"default:dry_shrub", "default:dry_shrub", "default:dry_shrub"},
  },
})
