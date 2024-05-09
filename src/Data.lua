quests.register_quest("Dummy1", {
	title = "Community Quest",
	description = "You must place 10 nodes.",
    Points = 150,
	week = "Week1",
	questType = "place",
	startTime = os.time(),
    endTime = os.time() + 604800,
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
	title = "Community Quest",
	description = "You must place 10 nodes.",
    Points = 150,
	week = "Week1",
	startTime = os.time(),
	endTime = os.time() + 604800,
	questType = "place",
	trigger = {
		type = "place",
		target = 20,
		item = "default:diamondblock",
	},
	premium = {
		points = 250
	},
})

quests.register_quest("Dummy3", {
	title = "Points Quest",
	description = "You must place 30 nodes.",
    Points = 100,
	week = "Week2",
	questType = "place",
	startTime = os.time() + 604800,
	endTime = os.time() + 1209600,
	premium = {
		points = 250
	},
	trigger = {
		type = "place",
		target = 30,
		item = "default:diamondblock"
	}
})
