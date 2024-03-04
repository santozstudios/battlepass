local storage = minetest.get_mod_storage()
local __player_data


local function convert_data()
	minetest.log("warning", "Importing awards data from previous version")

	local old_players = __player_data
	__player_data = {}
	for name, data in pairs(old_players) do
		while name.name do
			name = name.name
		end
		data.name = name
		print("Converting data for " .. name)

		-- Just rename counted
		local counted = {
			chats  = "chat",
			deaths = "death",
			joins  = "join",
		}
		for from, to in pairs(counted) do
			data[to]   = data[from]
			data[from] = nil
		end

		data.death = {
			unknown = data.death,
			__total = data.death,
		}

		-- Convert item db to new format
		local counted_items = {
			count = "dig",
			place = "place",
			craft = "craft",
		}
		for from, to in pairs(counted_items) do
			local ret = {}

			local count = 0
			if data[from] then
				for modname, items in pairs(data[from]) do
					for itemname, value in pairs(items) do
						itemname = modname .. ":" .. itemname
						local key = minetest.registered_aliases[itemname] or itemname
						ret[key] = value
						count = count + value
					end
				end
			end

			ret.__total = count
			data[from] = nil
			data[to] = ret
		end

		__player_data[name] = data
	end
end

function PlayerStore.save()
	storage:set_string("player_data", minetest.write_json(__player_data))
end

function PlayerStore.getPlayerData(name)
	assert(type(name) == "string")
    
	local data = __player_data[name] or {}
	__player_data[name] = data

	data.name     = data.name or name
	data.unlocked = data.unlocked or {}

    data.triggerData = data.triggerData or {}

	data.tierData = data.tierData or {
		currentTier = 1,
		progress = 0
	}

	data.collected = data.collected or {
		Basic = {},
		Premium = {}
	}

	data.hasPremiumPass = data.hasPremiumPass or false



	return data
end

function PlayerStore.load()
	local old_save_path = minetest.get_worldpath().."/awards.txt"
	local file = io.open(old_save_path, "r")
	if file then
		local table = minetest.deserialize(file:read("*all"))
		if type(table) == "table" then
			__player_data = table
			convert_data()
		else
			__player_data = {}
		end
		file:close()
		os.rename(old_save_path, minetest.get_worldpath().."/awards.bk.txt")
		awards.save()
	else
		local json = storage:get("player_data")
		__player_data = json and minetest.parse_json(json) or {}
	end
end


