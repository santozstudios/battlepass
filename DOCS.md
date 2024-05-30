### Info:
* Added remove function to global awards mod. You can call this when filtering rewards to show to the user. For example:
return table.find(quests_to_show, function (valid_quest_name)
	if valid_quest_name == quest.name then
	    if quest.def.endTime - os.time() <= 0 then
			awards.remove(pl_name,quest.name)
            return false
		else
			return true
		end
	end
end)