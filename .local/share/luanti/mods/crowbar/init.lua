local S = core.get_translator("crowbar")
local mod_default = core.get_modpath("default")
local mod_mcl_core = core.get_modpath("mcl_core")

--Tool registration
--Iron crowbar

local iron_crowbar_def = {
    description = S("Iron Crowbar"),
    inventory_image = "iron_crowbar.png",
    wield_scale = {x=1.3, y=1.4, z=1.0},
    
    --Default
    tool_capabilities = {
        full_punch_interval = 0.65,
        damage_groups = {fleshy = 7},
        groupcaps = {
            crumbly = {
                maxlevel = 3, 
                uses = 0,
                times = {[1]=1.0, [2]=1.0, [3]=1.0}
            },
            cracky = {
                maxlevel = 3,
                uses = 0,
                times = {[1]=1.0, [2]=1.0, [3]=1.0}
            },
            snappy = {
                maxlevel = 3,
                uses = 0,
                times = {[1]=1.0, [2]=1.0, [3]=1.0}
            },
            choppy = {
                maxlevel = 3, 
                uses = 0, 
                times = {[1]=1.0, [2]=1.0, [3]=1.0}
            },
            oddly_breakable_by_hand = {
                maxlevel = 3,
                uses = 0,
                times = {[1]=1.0, [2]=1.0, [3]=1.0}
            }
        }
    },

    --Mineclone
    groups = {
        tool = 1,
        axe = 1,
        dig_speed_class = 4,
        enchantability = 5
    },
    _mcl_diggroups = {
        pickaxey = { speed = 7, level = 4, uses = 0 },
        shovely = { speed = 7, level = 4, uses = 0 },
        axey = { speed = 7, level = 4, uses = 0 },
        swordy = { speed = 7, level = 4, uses = 0 },
        swordy_cobweb = { speed = 7, level = 4, uses = 0 }
    },
    _mcl_toollike_wield = true
}

--Netherite crowbar

local netherite_crowbar_def = {
    description = S("Netherite Crowbar"),
    inventory_image = "netherite_crowbar.png",
    wield_scale = {x=1.3, y=1.4, z=1.0},
    
    --Default
    tool_capabilities = {
        full_punch_interval = 0.65,
        damage_groups = {fleshy = 7},
        groupcaps = {
            crumbly = {
                maxlevel = 3, 
                uses = 0,
                times = {[1]=0.6, [2]=0.6, [3]=0.6}
            },
            
            cracky = {
                maxlevel = 3,
                uses = 0,
                times = {[1]=0.6, [2]=0.6, [3]=0.6}
            },
            snappy = {
                maxlevel = 3,
                uses = 0,
                times = {[1]=0.6, [2]=0.6, [3]=0.6}
            },
            choppy = {
                maxlevel = 3, 
                uses = 0, 
                times = {[1]=0.6, [2]=0.6, [3]=0.6}
            },
            oddly_breakable_by_hand = {
                maxlevel = 3, 
                uses = 0, 
                times = {[1]=0.6, [2]=0.6, [3]=0.6}
            }
        }
    },

    --Mineclone
    groups = { 
        tool = 1,
        axe = 1,
        dig_speed_class = 6,
        enchantability = 10
    },
    _mcl_diggroups = {
        pickaxey = { speed = 8, level = 6, uses = 0 },
        shovely = { speed = 8, level = 6, uses = 0 },
        axey = { speed = 8, level = 6, uses = 0 },
        swordy = { speed = 8, level = 6, uses = 0 },
        swordy_cobweb = { speed = 8, level = 6, uses = 0 }
    },
    _mcl_toollike_wield = true,
}

core.register_tool("crowbar:iron_crowbar", iron_crowbar_def)
core.register_tool("crowbar:netherite_crowbar", netherite_crowbar_def)

--Craft recipies
--default

core.register_craft({
    type = "shaped",
    output = "crowbar:iron_crowbar",
    recipe = {
        {"default:steel_ingot", ""},
        {"default:steel_ingot", "default:bronze_ingot"},
        {"default:steel_ingot", ""}
    }
})

core.register_craft({
    type = "shaped",
    output = "crowbar:iron_crowbar",
    recipe = {
        {"", "default:steel_ingot"},
        {"default:bronze_ingot", "default:steel_ingot"},
        {"", "default:steel_ingot"}
    }
})

core.register_craft({
    output = "crowbar:netherite_crowbar",
    recipe = {
        {"default:mese_crystal","crowbar:iron_crowbar", "default:lava_bucket"}
    }
})

core.register_craft({
    type = "cooking",
    output = "default:iron_lump",
    recipe = "crowbar:iron_crowbar",
    cooktime = 10
})

core.register_craft({
    type = "cooking",
    output = "default:mese_crystal_fragment",
    recipe = "crowbar:netherite_crowbar",
    cooktime = 10
})

--mcl

core.register_craft({
    type = "shaped",
    output = "crowbar:iron_crowbar",
    recipe = {
        {"mcl_core:iron_ingot", ""},
        {"mcl_core:iron_ingot", "mcl_copper:copper_ingot"},
        {"mcl_core:iron_ingot", ""}
    }
})
        
core.register_craft({
    type = "shaped",
    output = "crowbar:iron_crowbar",
    recipe = {
        {"","mcl_core:iron_ingot"},
        {"mcl_copper:copper_ingot", "mcl_core:iron_ingot"},
        {"","mcl_core:iron_ingot"}
    }
})

core.register_craft({
    output = "crowbar:netherite_crowbar",
    recipe = {
        {"mcl_nether:netherite_ingot","crowbar:iron_crowbar"}
    }
})

core.register_craft({
    type = "cooking",
    output = "mcl_core:iron_nugget",
    recipe = "crowbar:iron_crowbar",
    cooktime = 10
})

core.register_craft({
    type = "cooking",
    output = "mcl_nether:netherite_scrap",
    recipe = "crowbar:netherite_crowbar",
    cooktime = 10
})

--moreores

core.register_craft({
    output = "crowbar:netherite_crowbar",
    recipe = {
        {"moreores:mithril_ingot","crowbar:iron_crowbar", ""}
    }
})