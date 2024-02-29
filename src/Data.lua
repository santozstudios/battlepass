quests.register_quest("Dummy1", {
	title = "Community Quest",
	description = "To complete this quest you must place 10 nodes.",
    Points = 150,
	week = "Week1",
	premium = {
		points = 200,
	},
	trigger = {
		type = "place",
		target = 10,
		item = "default:diamondblock",
	}
})

quests.register_quest("Dummy2", {
	title = "Points Quest",
	description = "To complete this quest you must work as a community to kill 100 skeletons",
    Points = 100,
	week = "Week2",
	premium = {
		points = 250
	},
	trigger = {
		type = "death",
		target = 100
	}
})

quests.register_quest("Dummy3", {
	title = "Collect Diamonds",
	description = "To complete this quest you must work as a community to kill 100 skeletons",
    Points = 200,
	week = "Week1",
	premium = {
		points = 300
	},
	trigger = {
		type = "death",
		target = 100
	}
})

quests.register_quest("Dummy4", {
	title = "Boost Quest",
	description = "To complete this quest you must work as a community to kill 100 skeletons",
    Points = 80,
	week = "Week2",
	trigger = {
		type = "death",
		target = 100
	},
	premium = {
		points = 160
	}
})

quests.register_quest("Dummy5", {
	title = "Savier",
	description = "To complete this quest you must work as a community to kill 100 skeletons",
    Points = 80,
	week = "Week3",
	trigger = {
		type = "death",
		target = 100
	},
	premium = {
		points = 160
	}
})

quests.register_quest("Dummy6", {
	title = "Collect coins",
	description = "To complete this quest you must work as a community to kill 100 skeletons",
    Points = 80,
	week = "Week4",
	trigger = {
		type = "death",
		target = 100
	},
	premium = {
		points = 160
	}
})

quests.register_quest("Dummy7", {
	title = "Beat Enimies",
	description = "To complete this quest you must work as a community to kill 100 skeletons",
    Points = 80,
	week = "Week5",
	trigger = {
		type = "death",
		target = 100
	},
	premium = {
		points = 160
	}
})