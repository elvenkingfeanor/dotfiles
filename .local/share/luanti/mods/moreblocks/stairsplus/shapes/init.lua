stairsplus.dofile("shapes", "micros")
stairsplus.dofile("shapes", "panels")
stairsplus.dofile("shapes", "slabs")
stairsplus.dofile("shapes", "slopes")
stairsplus.dofile("shapes", "stairs")

stairsplus.api.register_shape_group("basic", stairsplus.settings.basic_shapes)
stairsplus.api.register_shape_group("common", stairsplus.settings.common_shapes)
