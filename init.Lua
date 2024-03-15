
quests = {
    register_quests = {
        ["WeeklyQuests"] = {

        },
        ["DailyQuests"] = {

        }
    },
    registered_triggers = {}
}

PlayerStore = {

}

rewards = {
    register_rewards = {}
}




local GuiHandler = dofile(minetest.get_modpath("battlepass") .. "/src/guiHandler.lua")

dofile(minetest.get_modpath("battlepass") .. "/src/trigger.lua")
dofile(minetest.get_modpath("battlepass") .. "/src/triggersData.lua")
dofile(minetest.get_modpath("battlepass") .. "/src/questHandler.lua")
dofile(minetest.get_modpath("battlepass") .. "/src/DataStore.lua")
dofile(minetest.get_modpath("battlepass") .. "/src/Data.lua")
dofile(minetest.get_modpath("battlepass") .. "/src/awardsHandler.lua")
dofile(minetest.get_modpath("battlepass") .. "/src/RewardsData.lua")



PlayerStore.load()
minetest.register_on_shutdown(PlayerStore.save)
