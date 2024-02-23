function rewards.register_reward(name,def)

    def.name = name


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

	rewards.register_rewards[name] = def
end

function rewards.Get_Rewards(name)
	local hash_is_unlocked = {}
    local Data = {}

	-- Add all locked awards

    for name,awardData in pairs(rewards.register_rewards) do
		local idx = tonumber(string.sub(name, 5, #name))

      if not hash_is_unlocked[name] then
          Data[idx] = {
            name = awardData.name,
            status = "Locked",
            title = awardData.title
          }
      end
    end

    return Data
end