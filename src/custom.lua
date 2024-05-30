local reward = {}

function awards.remove(name, award)
	local data  = awards.player(name)
	local awdef = awards.registered_awards[award]
	assert(awdef, "Unable to remove an award which doesn't exist!")

	if data.disabled or
			(not data.unlocked[award]) then
		return
	end

	minetest.log("action", "Award " .. award .." has been removed from ".. name)
	data.unlocked[award] = nil
	awards.save()
end



custom_awards = {
     remove_reward = awards.remove 
}
