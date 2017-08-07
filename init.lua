local settings = Settings(minetest.get_modpath("emeralds").."/settings.txt")

--
--  Item Registration
--

--  Emerald Crystal
minetest.register_craftitem("emeralds:emerald_crystal", {
	description = "Emerald Crystal",
	inventory_image = "emerald_crystal_full.png",
})
minetest.register_craftitem("emeralds:emerald_crystal_piece", {
	description = "Emerald Crystal Piece",
	inventory_image = "emerald_crystal_piece.png",
})

--
-- Node Registration
--

--  Ore
minetest.register_node("emeralds:emerald_ore", {
	description = "Emerald Ore",
	tiles = {"default_stone.png^emerald_ore.png"},
	groups = {cracky=3, stone=1},
	drop = 'emeralds:emerald_crystal',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "emeralds:emerald_ore",
	wherein = "default:stone",
	clust_scarcity = 5*5*5,
	clust_num_ores = 5,
	clust_size = 5,
	y_min = -5000,
	y_max = -5,
})

-- Emerald Block
minetest.register_node("emeralds:block", {
	description = "Emerald Block",
	tiles = {"emerald_block.png"},
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})

-- Chiseled Emerald
minetest.register_node("emeralds:chiseled", {
	description = "Chiseled Emerald",
	tiles = {"emerald_chiseled.png"},
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})

-- Emerald Pillar
minetest.register_node("emeralds:pillar", {
	description = "Emerald Pillar",
	paramtype2 = "facedir",
	tiles = {"emerald_pillar_top.png", "emerald_pillar_top.png", "emerald_pillar_side.png"},
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_place = minetest.rotate_node
})

-- Stairs & Slabs
stairs.register_stair_and_slab("emeraldblock", "emeralds:block",
		{cracky=3, oddly_breakable_by_hand=1},
		{"emerald_block.png"},
		"Emerald stair",
		"Emerald slab",
		default.node_sound_glass_defaults())

stairs.register_slab("emeraldstair", "emeralds:pillar",
		{cracky=3, oddly_breakable_by_hand=1},
		{"emerald_pillar_top.png", "emerald_pillar_top.png", "emerald_pillar_side.png"},
		"Emerald Pillar stair",
		"Emerald Pillar slab",
		default.node_sound_glass_defaults())

--
-- Crafting
--

-- Emerald Crystal Piece
minetest.register_craft({
	output = '"emeralds:emerald_crystal_piece" 3',
	recipe = {
		{'emeralds:emerald_crystal'}
	}
})

-- Emerald Block
minetest.register_craft({
	output = '"emeralds:block" 4',
	recipe = {
		{'emeralds:emerald_crystal', 'emeralds:emerald_crystal', ''},
		{'emeralds:emerald_crystal', 'emeralds:emerald_crystal', ''},
		{'', '', ''}
	}
})

-- Chiseled Emerald
minetest.register_craft({
	output = 'emeralds:chiseled 2',
	recipe = {
		{'stairs:slab_emeraldblock', '', ''},
		{'stairs:slab_emeraldblock', '', ''},
		{'', '', ''},
	}
})

-- Chiseled Emerald (for stairsplus)
minetest.register_craft({
	output = 'emeralds:chiseled 2',
	recipe = {
		{'emeralds:slab_block', '', ''},
		{'emeralds:slab_block', '', ''},
		{'', '', ''},
	}
})

-- Emerald Pillar
minetest.register_craft({
	output = 'emeralds:pillar 2',
	recipe = {
		{'emeralds:block', '', ''},
		{'emeralds:block', '', ''},
		{'', '', ''},
	}
})

--Emerald Pickaxe
minetest.register_craft({
	output = 'emeralds:emerald_pickaxe',
	recipe = {
		{'emeralds:emerald_crystal_piece', 'emeralds:emerald_crystal_piece', 'emeralds:emerald_crystal_piece'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

--Emerald Axe
minetest.register_craft({
	output = 'emeralds:emerald_axe',
	recipe = {
		{'', 'emeralds:emerald_crystal_piece', 'emeralds:emerald_crystal_piece'},
		{'', 'default:stick', 'emeralds:emerald_crystal_piece'},
		{'', 'default:stick', ''},
	}
})

--Emerald Shovel
minetest.register_craft({
	output = 'emeralds:emerald_shovel',
	recipe = {
		{'', 'emeralds:emerald_crystal_piece', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

--Emerald Hoe
minetest.register_craft({
	output = 'emeralds:emerald_hoe',
	recipe = {
		{'', 'emeralds:emerald_crystal_piece', 'emeralds:emerald_crystal_piece'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

--Emerald Sword
minetest.register_craft({
	output = 'emeralds:emerald_sword',
	recipe = {
		{'', 'emeralds:emerald_crystal_piece', ''},
		{'', 'emeralds:emerald_crystal_piece', ''},
		{'', 'default:stick', ''},
	}
})
--
-- ABMS
--

local dirs2 = {12, 9, 18, 7, 12}

-- Replace all instances of the horizontal emerald pillar with the
minetest.register_abm({
	nodenames = {"emeralds:pillar_horizontal"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2 or 0
			nfdir = dirs2[fdir+1]
		minetest.add_node(pos, {name = "emeralds:pillar", param2 = nfdir})
	end,
})

--
-- Compatibility with stairsplus
--

if minetest.get_modpath("moreblocks") and settings:get_bool("ENABLE_STAIRSPLUS") then
	register_stair_slab_panel_micro("emerald", "block", "emeralds:block",
		{cracky=3},
		{"emerald_block.png"},
		"Emerald Block",
		"block",
		0
	)

	register_stair_slab_panel_micro("emerald", "chiseled", "emeralds:chiseled",
		{cracky=3},
		{"emerald_chiseled.png"},
		"Chiseled Emerald",
		"chiseled",
		0
	)

	register_stair_slab_panel_micro("emerald", "pillar", "emeralds:pillar",
		{cracky=3},
		{"emerald_pillar_top.png", "emerald_pillar_top.png", "emerald_pillar_side.png"},
		"Emerald Pillar",
		"pillar",
		0
	)

	table.insert(circular_saw.known_stairs, "emeralds:block")
	table.insert(circular_saw.known_stairs, "emeralds:chiseled")
	table.insert(circular_saw.known_stairs, "emeralds:pillar")
end

--
-- Deprecated
--

if settings:get_bool("ENABLE_HORIZONTAL_PILLAR") then
	-- Emerald Pillar (horizontal)
	minetest.register_node("emeralds:pillar_horizontal", {
			description = "Emerald Pillar Horizontal",
			tiles = {"emerald_pillar_side.png", "emerald_pillar_side.png", "emerald_pillar_side.png^[transformR90",
			"emerald_pillar_side.png^[transformR90", "emerald_pillar_top.png", "emerald_pillar_top.png"},
			paramtype2 = "facedir",
			drop = 'emeralds:pillar',
			groups = {cracky=3, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
			sounds = default.node_sound_glass_defaults(),
	})
end

-- Tools Registration


-- Emerald Pickaxe
minetest.register_tool("emeralds:emerald_pickaxe", {
	description = "Emerald Pickaxe",
	inventory_image = "emerald_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=60, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

-- Emerald Axe
minetest.register_tool("emeralds:emerald_axe", {
	description = "Emerald Axe",
	inventory_image = "emerald_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=60, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

-- Emerald Shovel
minetest.register_tool("emeralds:emerald_shovel", {
	description = "Emerald Shovel",
	inventory_image = "emerald_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=80, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

-- Emerald Hoe
farming.register_hoe("emeralds:emerald_hoe", {
	description = "Emerald Hoe",
	inventory_image = "emerald_hoe.png",
	max_uses = 440,
	material = "emeralds:emerald_crystal_piece"
})
-- Emerald Sword
minetest.register_tool("emeralds:emerald_sword", {
	description = "Emerald Sword",
	inventory_image = "emerald_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=80, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
})