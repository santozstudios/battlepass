function quests.register_quest(name, def)
	def.name = name

	-- Add Triggers
	if def.trigger and def.trigger.type then
		local tdef = quests.registered_triggers[def.trigger.type]
		assert(tdef, "Trigger not found: " .. def.trigger.type)
		tdef:on_register(def)
	end

	function def:can_unlock(data)
		if not self.requires then
			return true
		end

		for i=1, #self.requires do
			if not data.unlocked[self.requires[i]] then
				return false
			end
		end
		return true
	end

    -- function def:get_progress(data)
    --     local current = math.min(data[tname] or 0, def.trigger.target)
    --     return {
    --         current = current,
    --         target = def.trigger.target,
    --     }
    -- end

	-- Add Quest
	if not quests.register_quests[def.week] then
		quests.register_quests[def.week] = {}
	end

	quests.register_quests[def.week][name] = def

end

function quests.GetWeeks()
	local weeks = {}
	for week,data in pairs(quests.register_quests) do
		local idx = tonumber(string.sub(week, 5, #week))

		if idx then 
			weeks[idx] = week
		end
		-- minetest.chat_send_player("singleplayer", "Week: "..week.."\nIndex: "..tostring(idx))
	end

	return weeks
end

function quests.Get_WeeklyQuests(name,weekName)


   local is_unlocked = {}
   local data = PlayerStore.getPlayerData(name)
   local Data = {}
   
     for week,weekData in pairs(quests.register_quests) do
		if(week == weekName) then
			for questName,def in pairs(weekData) do
				if not is_unlocked[name] and def:can_unlock(data) then
					local progress = def.get_progress and def:get_progress(data)
	   
					Data[#Data + 1] = {
					   name     = def.title,
					   des      = def.description,
					   points = def.Points,
					   unlocked = false,
					   progress = progress,
					   week = def.week,
					   premiumPoints = def.premium.points
				   }
				end
			end
		end
     end
     
     return Data

end