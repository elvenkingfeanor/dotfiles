if not stairsplus.has.default then
	return
end

stairsplus.api.register_passthrough_groups({
	"crumbly",
	"cracky",
	"snappy",
	"choppy",
	"fleshy",
	"flammable",
	"explody",
	"oddly_breakable_by_hand",
	"snowy", -- https://github.com/fluxionary/minetest-moreblocks/issues/20 might revisit this later
})
