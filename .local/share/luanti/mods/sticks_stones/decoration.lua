minetest.register_decoration({
  deco_type = "simple",
  place_on = {"default:dirt_with_grass"},
  sidelen = 8,
  noise_params = {
    offset = 0,
    scale = 0.001,
    spread = {x = 100, y = 10, z = 100},
    seed = 6252,
    octaves = 3,
    persist = 1.2,
  },
  y_min = 3,
  y_max = 70,
  decoration = "sticks_stones:stones"
})

minetest.register_decoration({
  deco_type = "simple",
  place_on = {"default:desert_sand"},
  sidelen = 8,
  noise_params = {
    offset = 0,
    scale = 0.001,
    spread = {x = 100, y = 10, z = 100},
    seed = 4256,
    octaves = 3,
    persist = 4,
  },
  y_min = 8,
  y_max = 230,
  decoration = "sticks_stones:desert_stones"
})
