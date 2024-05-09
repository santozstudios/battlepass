
local S = function (str)
	return str
end
local function player_ok(player)
	return player and player.is_player and player:is_player() and not player.is_fake_player
end
-- minetest.after(0, function()
-- 	-- Check whether there is at least one node which can be built by the player
-- 	local building_is_possible = false
-- 	for _, def in pairs(minetest.registered_nodes) do
-- 		if (def.description and def.pointable ~= false and not def.groups.not_in_creative_inventory) then
-- 			building_is_possible = true
-- 			break
-- 		end
-- 	end

-- 	-- The following awards require at least one node which can be built
-- 	if not building_is_possible then
-- 		return
-- 	end

--     error("Laka")

   
-- end)

quests.register_trigger("place", {
    type = "counted_key",
    progress = S("@1/@2 placed"),
    auto_description = { S("Place: @2"), S("Place: @1×@2") },
    auto_description_total = { S("Place @1 block."), S("Place @1 blocks.") },
    get_key = function(self, def)
        return minetest.registered_aliases[def.trigger.node] or def.trigger.node
    end,
    key_is_item = true,
})

minetest.register_on_placenode(function(pos, node, player)
	if not player_ok(player) or not pos or not node then
		return
	end
	local node_name = node.name
	node_name = minetest.registered_aliases[node_name] or node_name
	quests.notify_place(player, node_name)
end)

-- quests.register_trigger("craft", {
-- 	type = "counted_key",
-- 	progress = S("@1/@2 crafted"),
-- 	auto_description = { S("Craft: @2"), S("Craft: @1×@2") },
-- 	auto_description_total = { S("Craft @1 item"), S("Craft @1 items.") },
-- 	get_key = function(self, def)
-- 		return minetest.registered_aliases[def.trigger.item] or def.trigger.item
-- 	end,
-- 	key_is_item = true,
-- })

-- minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
-- 	if not player_ok(player) or itemstack:is_empty() then
-- 		return
-- 	end

-- 	local itemname = itemstack:get_name()
-- 	itemname = minetest.registered_aliases[itemname] or itemname
-- 	quests.notify_craft(player, itemname, itemstack:get_count())
-- end)

-- quests.register_trigger("death", {
-- 	type = "counted_key",
-- 	progress = S("@1/@2 deaths"),
-- 	auto_description = { S("Die once of @2"), S("Die @1 times of @2") },
-- 	auto_description_total = { S("Die @1 times."), S("Mine @1 times") },
-- 	get_key = function(self, def)
-- 		return def.trigger.reason
-- 	end,
-- })
-- minetest.register_on_dieplayer(function(player, reason)
-- 	if reason then
-- 		reason = reason.type
-- 	else
-- 		reason = "unknown"
-- 	end
-- 	awards.notify_death(player, reason)
-- end)