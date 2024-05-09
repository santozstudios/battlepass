
quests.on = {}

local default_def = {}

function default_def:run_callbacks(player, data,table_func)
    local name = player:get_player_name()
	for i = 1, #self.on do
		local res = nil
		local entry = self.on[i]
		if type(entry) == "function" then
			res = entry(player, data)
		elseif type(entry) == "table" and entry.points then
			res = table_func(entry)
		end

		if res then
            minetest.chat_send_player(name, "Response is "..res)
            local name = player:get_player_name()

			if(data.tierData["progress"] + res > 100) then
                ---- Tier Upgraded-----
				minetest.chat_send_player(name, "Current Player Progress "..data.tierData["progress"])
				local currentProg = nil
				if(data.tierData["progress"] + res > 100) then
					currentProg = data.tierData["progress"] + res - 100
				else
					currentProg = data.tierData["progress"] + res
				end
				local completedTier = data.tierData["currentTier"]
				data.tierData["progress"] = currentProg
				data.tierData["currentTier"] = data.tierData["currentTier"] + 1
			else
				data.tierData["progress"] = data.tierData["progress"] + res
			end
            minetest.chat_send_player(name, "After Adding "..data.tierData["progress"])
			PlayerStore.save()
		end
	end
end

function quests.register_trigger(tname,tdef)
    tdef.name = tname

    for key, value in pairs(default_def) do
		tdef[key] = value
	end

    if tdef.type == "counted" then

        function tdef:on_register(def)
            local tmp = {
                quest  = def.name,
                target = def.trigger.target,
                points = def.Points
            }
            tdef.register(tmp)
    
            function def.get_progress(_, data)
                -- local current = math.min(data[tname] or 0, tmp.target)
                -- return {
                --     current = current,
                --     target = tmp.target,
                --     label = S(tdef.progress, current, tmp.target),
                -- }
				local done
				for questType,questData in pairs(data.questData) do
					if questType == tname then
						for questName,data in pairs(questData) do
							if data.Name == tmp.name then
                               done = data.Progress
							   break
							end
						end
						if done then break end
					end
				end 

				done = math.min(0, tmp.target)
            end
    
            function def.getDefaultDescription(_)
                local n = def.trigger.target
                return NS(tdef.auto_description[1], tdef.auto_description[2], n, n)
            end
    
            if old_reg then
                return old_reg(tdef, def)
            end

			local data = PlayerStore.getPlayerData(name)
			

        end
    
        function tdef.notify(player)
            assert(player and player.is_player and player:is_player())
            local name = player:get_player_name()
            local data = PlayerStore.getPlayerData(name)

            -- Increment counter
            local currentVal = (data.triggerData[tname] or 0) + 1
            data.triggerData[tname] = currentVal

			if data.questData[tname] then
				for questType,questData in pairs(data.questData) do
					if questType == tname then
						for questName,data in pairs(questData) do
							if data.StartTime - os.time() < 0 and data.EndTime - os.time() > 0 then
								data.Progress = data.Progress + 1
							end
						end
					end
				end
			end
			PlayerStore.save()

            tdef:run_callbacks(player, data, function(questData)
				minetest.chat_send_player(name, "Current Value "..currentVal)
				if currentVal > questData.target then
					minetest.chat_send_player(name, "Points Already Given.")
					return
				end
                if questData.target and questData.points and currentVal and
                        currentVal >= questData.target then
                    return questData.points
                end
            end)
        end
    
        awards["notify_" .. tname] = tdef.notify

    elseif tdef.type == "counted_key" then

		-- On award register
		local old_reg = tdef.on_register
		function tdef:on_register(def)
			-- Register trigger
			local tmp = {
				name  = def.name,
				key    = tdef:get_key(def),
				target = def.trigger.target,
                points = def.Points
			}
			tdef.register(tmp)

			-- If group, add it to watch list
			-- if tdef.key_is_item and tmp.key and tmp.key:sub(1, 6) == "group:" then
			-- 	tdef.watched_groups[tmp.key:sub(7, #tmp.key)] = true
			-- end

			-- Called to get progress values and labels
			function def.get_progress(_, data)
				data.triggerData[tname] = data.triggerData[tname] or {}



				local done
				-- if tmp.key then
				-- 	done = data.triggerData[tname][tmp.key] or 0
				-- else
				-- 	done = data.triggerData[tname].__total or 0
				-- end
				-- done = math.min(done, tmp.target)

				for questType,questData in pairs(data.questData) do
					if questType == tname then
						for questName,data in pairs(questData) do
							if data.Name == tmp.name then
                               done = data.Progress
							   break
							end
						end
						if done then break end
					end
				end 

				done = math.min(0, tmp.target)


				return {
					current = done,
					target = tmp.target,
					-- label = S(tdef.progress, done, tmp.target),
				}
			end

			-- Build description if none is specificed by the award
			function def.getDefaultDescription(_)
				local n = def.trigger.target
				if tmp.key then
					local nname = tmp.key
					return NS(tdef.auto_description[1],
							tdef.auto_description[2], n, n, nname)
				else
					return NS(tdef.auto_description_total[1],
							tdef.auto_description_total[2], n, n)
				end
			end

			-- Call on_register in trigger type definition
			if old_reg then
				return old_reg(tdef, def)
			end
		end

		function tdef.notify(player, key, n)
			n = n or 1

			assert(player and player.is_player and player:is_player() and key)
			local name = player:get_player_name()
			local data = PlayerStore.getPlayerData(name)

			-- Increment counter
			data.triggerData[tname] = data.triggerData[tname] or {}
			local currentVal = (data.triggerData[tname][key] or 0) + n
			data.triggerData[tname][key] = currentVal
			data.triggerData[tname].__total = (data.triggerData[tname].__total or 0)
			if key:sub(1, 6) ~= "group:" then
				data.triggerData[tname].__total = data.triggerData[tname].__total + n
			end

			if data.questData[tname] then
				for questType,questData in pairs(data.questData) do
					if questType == tname then
						for questName,data in pairs(questData) do
							if data.StartTime - os.time() < 0 and data.EndTime - os.time() > 0 then
								data.Progress = data.Progress + 1
							end
						end
					end
				end
			end
			PlayerStore.save()

			tdef:run_callbacks(player, data, function(questData)
				local current
				if questData.key == key then
					current = currentVal
				elseif questData.key == nil then
					current = data.triggerData[tname].__total
				else
					return
				end
				if current > questData.target then
					minetest.chat_send_player(name, "Points Already Given.")
					return
				end
				if current >= questData.target then
					return questData.points
				end
			end)
		end

		quests["notify_" .. tname] = tdef.notify
    end

    quests.registered_triggers[tname] = tdef

	tdef.on = {}
	tdef.register = function(func)
		table.insert(tdef.on, func)
	end

	-- Backwards compat
	quests.on[tname] = tdef.on
	quests['register_on_' .. tname] = tdef.register
	return tdef 
end