
local guiHandler = {}

local inventory_formspec = "size[5,8]"..
"image[1.1,-0.8;3,1;battlePass.png]"..
"style[Info_Button;fgcolor=red;textcolor=black]"..
"image_button[0.2,0.2;2.2,1.8;tile.png;Info_Button;PlayerInfo;true;false;]"..
"tooltip[Info_Button;"..
minetest.colorize("#EE0", "Player Info")..
"(Click me)"..
"\n\nClick this to see your purchases."..
";#000000;#FFFFFF]"..
"style[Quest_Button;fgcolor=red;textcolor=black]"..
"image_button[2.7,0.2;2.2,1.8;tile.png;Quest_Button;Quests;true;false;]"..
"tooltip[Quest_Button;"..
minetest.colorize("#EE0", "Quests")..
"(Click me)"..
"\n\nClick this to view the Quests."..
";#000000;#FFFFFF]"..
"style[Pass_Button;fgcolor=red;textcolor=black]"..
"image_button[0.2,2.2;2.2,1.8;tile.png;Pass_Button;Buy Premium;true;false;]"..
"tooltip[Pass_Button;"..
minetest.colorize("#A020F0", "Genesis Battle Pass")..
"\n\n"..
minetest.colorize("#EE0",
"Level up your Battle Pass by\ncompleting weekly & daily Quests.\n\n"..
"Earn rewards like Elliptic keys.\nThese keys can open the Elliptic crate\nin lobby which contains new ASICs!\n\n"..
"Get even more quests and rewards by purchasing the ")..minetest.colorize("#2E8B57","Premium Battlepass")..
minetest.colorize("#EE0"," below")..
";#000000;#FFFFFF]"..
"style[Reward_Button;fgcolor=red;textcolor=black]"..
"image_button[2.7,2.2;2.2,1.8;tile.png;Reward_Button;Rewards;true;false]"..
"tooltip[Reward_Button;"..
minetest.colorize("#EE0", "Rewards")..
"(Click me)"..
"\n\nClick this to view the Rewards."..
";#000000;#FFFFFF]"..
-- "style_type[box; border = true;borderwidths = 5;bordercolors = #0000FF]"..
"list[current_player;main;0,4.2;5,4;]"..
""

local currentIdx
local currentAwardIdx

function guiHandler.get_formspec(guiName,plrName,formspecData)

    if not formspecData then return end

    local plrData = PlayerStore.getPlayerData(plrName)

    if(guiName == "Quest") then
        local formspec = "size[6,7]"..
        "list[current_player;main;0,3;6,4;]"..
        "image[1.5,-0.8;3,1;battlePass.png]"..
        "style[Back_Btn;fgcolor=red;textcolor=black]"..
        "image_button[0,1.8;2.2,1;Button.png;Back_Btn;Back;true;false;]"..""

        if(currentIdx == #formspecData) then 
           currentIdx = 1
        end

        if(currentIdx + 3 < #formspecData) then
            formspec = formspec..
            "style[Forward_Btn;fgcolor=red;textcolor=black]"..
            "image_button[3,1.8;2.2,1;Button.png;Forward_Btn;Forward;true;false;]"..""
        end

        if(currentIdx == 4) then 
            currentIdx = currentIdx + 1
        end

        local j=1
        for i = currentIdx,math.min(currentIdx + 3,#formspecData) do
            local week = formspecData[i]
            formspec = formspec..
            "tooltip["..week..";"..
            minetest.colorize("#EE0",tostring(week)..": Click to check out quests.")..
            "]"..
            "style["..week..";fgcolor=red;textcolor=black]"..
            "image_button[" .. tostring((j-1) * 1.5) ..",0.4;1.5,1;tile.png;"..week..";"..week..";true;false;]"..
            "" 
            j = j + 1
            currentIdx = i
        end

        return formspec

    elseif(guiName == "WeekQuest") then
        local formspec = "size[6,8]"..
        "list[current_player;main;0,4;6,4;]"..
        "image[1.7,-0.8;3,1;battlePass.png]"..
        "label[2,0.2;FREE QUESTS]"..
        "label[1.8,1.6;PREMIUM QUESTS]"..
        "image_button[0,3;2.2,1;Button.png;Back_Btn;Back;true;false;]"..
        ""
        for i,data in ipairs(formspecData) do

            local questTitle = data.name
            local questDes = data.des
            local questPoints = tostring(data.points.."x")
            local currprogress = data.progress.current
            local Questtarget = data.progress.target
            local premiumPts = tostring(data.premiumPoints.."x")

            formspec = formspec..
            "image_button[" .. tostring((i-1) * 1.6) ..",0.6;1.5,1;tile.png;"..questTitle..";;true;false;]"..
            "image_button[" .. tostring((i-1) * 1.6) ..",2;1.5,1;tile.png;Premium"..questTitle..";;true;false;]"..
            "tooltip["..questTitle..";"..
            minetest.colorize("#EE0", "QUEST:")..
            minetest.colorize("#FFFFFF",questTitle.."\n")..
            questDes.."\n\n"..
            minetest.colorize("#A020F0", "INFORMATION")..
            "\n"..
            minetest.colorize("#5A5A5A","Points:")..
            questPoints.."\n"..
            minetest.colorize("#5A5A5A","Progress:")..
            currprogress.."/"..Questtarget..']'..
            "tooltip[Premium"..questTitle..";"..
            minetest.colorize("#EE0", "QUEST:")..
            minetest.colorize("#FFFFFF",questTitle.."\n")..
            questDes.."\n\n"..
            minetest.colorize("#A020F0", "INFORMATION")..
            "\n"..
            minetest.colorize("#5A5A5A","Points:")..
            premiumPts.."\n"..
            minetest.colorize("#5A5A5A","Progress:")..
            currprogress.."/"..Questtarget.."]"..
            ""
        end

        return formspec

    elseif(guiName == "Award") then
        local formspec = "size[6,9]"..
        "image[1.5,-0.8;3,1;battlePass.png]"..
        "list[current_player;main;0,5;6,4;]"..
        "label[2.3,1.3;FREE]"..
        "label[2.1,2.7;PREMIUM]"..
        "style[Back_Btn;fgcolor=red;textcolor=black]"..
        "image_button[0,4.2;2,0.8;Button.png;Back_Btn;Back;true;false;]"..""

        if(currentAwardIdx == #formspecData) then 
            currentAwardIdx = 1
         end
 
         if(currentAwardIdx + 3 < #formspecData) then
             formspec = formspec..
             "style[Forward_Btn;fgcolor=red;textcolor=black]"..
             "image_button[4,4.2;2,0.8;Button.png;Forward_Btn;Forward;true;false;]"..""
         end
 
         if(currentAwardIdx == 4) then 
            currentAwardIdx = currentAwardIdx + 1
         end
 
         local j=1

         for i = currentAwardIdx,math.min(currentAwardIdx + 3,#formspecData) do
            local data = formspecData[i]
            local rewardName = data.name
            local rewardTitle = data.title
            local rewardStatus = nil
            local plrTier = plrData.tierData["currentTier"]

            -- minetest.chat_send_player(name, name..data.tierData["progress"])


            if(i >= plrTier) then
                rewardStatus = "Locked"
            else
                rewardStatus = "Unlocked"
            end

           formspec = formspec..
           "image_button[" .. tostring((j-1) * 1.5) ..",0.3;1.5,1;tile.png;"..rewardName..";;true;false;]"..
           "image_button[" .. tostring((j-1) * 1.5) ..",3.2;1.5,1;tile.png;Premium"..rewardName..";;true;false;]"..
            "tooltip["..rewardName..";"..
            minetest.colorize("#90EE90", rewardName.."\n".."\n")..
            minetest.colorize("#D3D3D3","Rewards".."\n")..
            minetest.colorize("#ADD8E6", rewardTitle.."\n".."\n")..
            minetest.colorize("#D3D3D3","Status:")..
            minetest.colorize("#90EE90"," "..rewardStatus).."]"..
            "tooltip[Premium"..rewardName..";"..
            minetest.colorize("#90EE90", rewardName.."\n".."\n")..
            minetest.colorize("#D3D3D3","Rewards".."\n")..
            minetest.colorize("#ADD8E6", rewardTitle.."\n".."\n")..
            minetest.colorize("#D3D3D3","Status:")..
            minetest.colorize("#90EE90"," "..rewardStatus).."]"..
            ""

            if rewardStatus == "Locked" then
                formspec = formspec..
                "image_button[" .. tostring(0.3 + ((j-1) * 1.5)) ..",1.7;1,1;Locked.png;"..rewardStatus..";;true;false;]"
            else
                formspec = formspec..
                "image_button[" .. tostring(0.3 + ((j-1) * 1.5)) ..",1.7;1,1;Unlocked.png;"..rewardStatus..";;true;false;]"
            end
            j= j+1
            currentAwardIdx = i
        end

        return formspec
    end
end

minetest.register_chatcommand("bp", { 
    description = "Show Main Gui",
    func = function(name,param)
        minetest.show_formspec(name, "battlepass:mainGui", inventory_formspec)
    end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    local name = player:get_player_name()
    minetest.chat_send_player(name, name.." said: Don't Play!")

    if formname == "battlepass:mainGui" then
        if fields.Info_Button then
            print(fields.Info_Button.State);
            -- minetest.show_formspec(player:get_player_name(), "battlepass:Quests", quest_formSpec)
        elseif fields.Reward_Button then
             local rewardsData = rewards.Get_Rewards(name)
             if #rewardsData == 0 then 
                return
             end
             currentAwardIdx = 1
             minetest.show_formspec(name, "battlepass:Awards",guiHandler.get_formspec("Award",name,rewardsData))
        elseif fields.Quest_Button then
            local quest_weeks = quests.GetWeeks()

            if #quest_weeks == 0 then
                return
            end
            currentIdx = 1
            minetest.show_formspec(name, "battlepass:Quests",guiHandler.get_formspec("Quest",name,quest_weeks))
        elseif fields.btn_close then
            return true
        end
    elseif formname == "battlepass:Quests" then

        -- Check for week buttons --
        local quest_weeks = quests.GetWeeks()

        if fields.Back_Btn then
            if currentIdx > 4 then
                if #quest_weeks == 0 then
                   return
                end
                minetest.show_formspec(name, "battlepass:Quests",guiHandler.get_formspec("Quest",name,quest_weeks))
            else
                minetest.show_formspec(name, "battlepass:mainGui",inventory_formspec)
            end
        end

        if fields.Forward_Btn then
            minetest.show_formspec(name, "battlepass:Quests",guiHandler.get_formspec("Quest",name,quest_weeks))
        end

        if #quest_weeks > 0 then
            for i = 1, #quest_weeks do
                if fields["Week"..i] then
                    local questWeek = "Week"..i
                    local weekQuests = quests.Get_WeeklyQuests(name,questWeek)

                    if #weekQuests == 0 then
                        return
                    end
                    
                    minetest.show_formspec(name, "battlepass:weekGui",guiHandler.get_formspec("WeekQuest",name,weekQuests))
                end
            end
        end
    elseif formname == "battlepass:weekGui" then
        if fields.Back_Btn then
            local quest_weeks = quests.GetWeeks()

            if #quest_weeks == 0 then
                return
            end
            currentIdx = 1
            minetest.show_formspec(name, "battlepass:Quests",guiHandler.get_formspec("Quest",name,quest_weeks))
        end

    elseif formname == "battlepass:Awards" then
        local rewardsData = rewards.Get_Rewards(name)
        
        if #rewardsData == 0 then 
            return
        end

        if fields.Back_Btn then
            if currentAwardIdx > 4 then
                minetest.show_formspec(name, "battlepass:Awards",guiHandler.get_formspec("Award",name,rewardsData))
            else
                minetest.show_formspec(name, "battlepass:mainGui",inventory_formspec)
            end
        end

        if fields.Forward_Btn then
            minetest.show_formspec(name, "battlepass:Awards",guiHandler.get_formspec("Award",name,rewardsData))
        end

        local rewardsData = rewards.Get_Rewards(name)
        for i,rewardData in ipairs(rewardsData) do
            if fields[rewardData.name] then

                local plrData = PlayerStore.getPlayerData(name)
                local plrTier = plrData.tierData["currentTier"]
                local collectedData = plrData.collected
                if not collectedData then return end
                if i >= plrTier then
                    minetest.chat_send_player(name, "Award Locked")
                     return
                 end 

                 for i,collAwd in ipairs(collectedData.Basic) do
                     if rewardData.name == collAwd then
                        minetest.chat_send_player(name, "Award Collected Previously")
                        return
                     end
                 end

                for key,value in pairs(rewardData) do
                    minetest.chat_send_player(name, "Keys "..key)
                end


                if not rewardData.OnRewardCollected then
                     return
                 end
                 local rewardCollected = rewardData.OnRewardCollected(name)
                 if rewardCollected then
                    table.insert(plrData.collected.Basic,rewardData.name)
                    minetest.chat_send_player(name, "Award Collected")
                    PlayerStore.save()
                 end
            elseif fields["Premium"..rewardData.name] then
                    
                    


            end

        end
        
    end

end)

return guiHandler