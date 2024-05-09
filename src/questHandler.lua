
function quests.register_quest(name, def)
	def.name = name
	local playerObj = minetest.localplayer

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

	-- Add Quest
	if def.week then 
		if not quests.register_quests.WeeklyQuests[def.week] then
			quests.register_quests.WeeklyQuests[def.week] = {}
		end
		quests.register_quests.WeeklyQuests[def.week][name] = def
	elseif def.daily then
		table.insert(quests.register_quests.DailyQuests,def)
	end

end

function quests.LoadQuestData(plrName)
	local data  = PlayerStore.getPlayerData(plrName)
	--------- Storing Weekly Quest Data if not Stored ---------------
	for week,weekData in pairs(quests.register_quests.WeeklyQuests) do
		for questName,def in pairs(weekData) do
			if not data.questData[def.questType] then
				data.questData[def.questType] = {}
		    end
			if def.startTime and def.endTime and not data.questData[def.questType][def.name] then
				local dataTable = {
					StartTime = def.startTime,
					EndTime = def.endTime,
					Progress = 0,
					Name = def.name,
				}
				data.questData[def.questType][def.name] = dataTable
		    end
		end
	end

	-------- Storing Daily Quest Data if not stored -----------
	for i,def in ipairs(quests.register_quests.DailyQuests) do
		if not data.questData[def.questType] then
			data.questData[def.questType] = {}
		end
		if def.startTime and def.endTime and not data.questData[def.questType][def.name] then
			local dataTable = {
				StartTime = def.startTime,
				EndTime = def.endTime,
				Progress = 0,
				Name = def.name,
			}
			data.questData[def.questType][def.name] = dataTable
		end
	end

	PlayerStore.save()


end

function quests.GetWeeks()
	local weeks = {}
	for week,data in pairs(quests.register_quests.WeeklyQuests) do
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
   
     for week,weekData in pairs(quests.register_quests.WeeklyQuests) do
		if(week == weekName) then
			for questName,def in pairs(weekData) do
				if not is_unlocked[name] and def:can_unlock(data) then
					local progress = def.get_progress and def:get_progress(data)
	   
					Data[#Data + 1] = {
					   name     = def.week,
					   des      = def.description,
					   points = def.Points,
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



function quests.GetDailyQuests(name)

	local Data = {}
	local plrData = PlayerStore.getPlayerData(name)

   for i,def in ipairs(quests.register_quests.DailyQuests) do
	local progress = def.get_progress and def:get_progress(plrData)
       Data[i] = {
		   name     = def.title,
		   des      = def.description,
		   points = def.Points,
		   progress = progress,
	   }
   end

   return Data
end
