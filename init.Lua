
quests = {
    register_quests = {}
}

PlayerStore = {

}

rewards = {
    register_rewards = {}
}




local GuiHandler = dofile(minetest.get_modpath("battlepass") .. "\\src\\guiHandler.lua")


dofile(minetest.get_modpath("battlepass") .. "\\src\\questHandler.lua")
dofile(minetest.get_modpath("battlepass") .. "\\src\\DataStore.lua")
dofile(minetest.get_modpath("battlepass") .. "\\src\\Data.lua")
dofile(minetest.get_modpath("battlepass") .. "\\src\\awardsHandler.lua")
dofile(minetest.get_modpath("battlepass") .. "\\src\\RewardsData.lua")


PlayerStore.load()

local main_formSpec = "size[8,4]" ..
"button[2,0;4,1;btn_quest;Quests]" ..
"button[2,1;4,1;btn_reward;Rewards]" ..
"button[2,2;4,1;btn_Info;Info]" ..
"button[2,3;4,1;btn_battlePass;Purchase Premium BP]" ..
"button[7.6,-0.2;0.7,0.4;btn_close;X]" 

 
local quest_formSpec = "size[10,6]" ..
"label[1,1;Quest Section:]" ..
"label[1,2;Quest 1: Defeat Villains of Level1]" ..
"label[1,3;Quest 2: Defeat MiniBoss of Level1]" ..
"button[4,5;2,1;btn_close;Close]" 

local reward_formSpec =
"size[6,8]"..
"image[1.5,-0.8;4,1;battlePass.png]"..
"list[current_player;main;0,5;6,3;]"..
""