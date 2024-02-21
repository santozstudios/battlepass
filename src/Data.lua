quests.register_quest("Dummy1", {
	title = "Community Quest",
	description = "To complete this quest you must work as a community to kill 100 skeletons",
    Points = "150x",
	week = "Week1",
	premium = {
		points = "200x"
	},
	trigger = {
		type = "death",
		target = 100
	}
})

quests.register_quest("Dummy1", {
	title = "Community Quest",
	description = "To complete this quest you must work as a community to kill 100 skeletons",
    Points = "80x",
	week = "Week2",
	trigger = {
		type = "death",
		target = 100
	},
	premium = {
		points = "160x"
	}
})