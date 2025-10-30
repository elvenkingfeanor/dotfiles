-- Translator
local S = minetest.get_translator("grass_string")

-- Grass String
minetest.register_craftitem("grass_string:grass_string", {
    description = S("Grass String"),
    inventory_image = "grass_string.png",
    groups = { flammable = 2, thread = 1, string = 1 }
})

-- Craft
minetest.register_craft({
    output = "grass_string:grass_string",
    recipe = {
        {"group:grass", "group:grass", "group:grass"},
        {"group:grass", "group:grass", "group:grass"},
        {"group:grass", "group:grass", "group:grass"}
    }
})

-- Grass String -> Normal String
minetest.register_craft({
    type = "shapeless",
    output = "farming:string",
    recipe = {"grass_string:grass_string"}
})