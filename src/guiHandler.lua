
local guiHandler = {}

local currentWeek = 1
local currentAwardIdx
local rewardButtons = {}


function guiHandler.get_formspec(guiName,plrName,formspecData,updateRewards)


    local plrData = PlayerStore.getPlayerData(plrName)

    if(guiName == "Quest") then
        local formspec = "size[9,9]"..
        -- "list[current_player;main;0,3;6,4;]"..
        "image[3,-0.8;3,1;battlePass.png]"..
        "style[Back_Btn;fgcolor=red;textcolor=black]"..
        "style[DailyQst_Btn;fgcolor=red;textcolor=black]"..
        "label[0.1,0.3;FREE CHALLENGES]"..
        "label[0.1,4.6;BATTLE PASS CHALLENGES]"..
        "image_button[0,-0.3;0.8,0.7;ArrowLeft.png;Back_Btn;;true;false;]"..
        "image_button[8,-0.3;0.8,0.7;ArrowRight.png;Forward_Btn;;true;false;]"..""
        -- "image_button[3,1.8;2.2,1;Button.png;DailyQst_Btn;Daily;true;false;]"..""

        -- if(currentIdx == #formspecData) then 
        --    currentIdx = 1
        -- end

        -- if(currentIdx + 3 < #formspecData) then
        --     formspec = formspec..
        --     "style[Forward_Btn;fgcolor=red;textcolor=black]"..
        --     "image_button[3,1.8;2.2,1;Button.png;Forward_Btn;Forward;true;false;]"..""
        -- end

        -- if(currentIdx == 4) then 
        --     currentIdx = currentIdx + 1
        -- end

        -- local j=1
        -- for i = currentIdx,math.min(currentIdx + 3,#formspecData) do
        --     local week = formspecData[i]
        --     formspec = formspec..
        --     "image_button[" .. tostring((i-1) * 1.6) ..",0.6;1.5,1;tile.png;"..questTitle..";;true;false;]"..
        --     "tooltip["..week..";"..
        --     minetest.colorize("#EE0",tostring(week)..": Click to check out quests.")..
        --     "]"..
        --     "style["..week..";fgcolor=red;textcolor=black]"..
        --     "image_button[" .. tostring((j-1) * 1.5) ..",0.4;1.5,1;tile.png;"..week..";"..week..";true;false;]"..
        --     "" 
        --     j = j + 1
        --     currentIdx = i
        -- end

        for i,data in ipairs(formspecData) do
            local questTitle = data.name
            local questDes = data.des
            local questPoints = tostring(data.points.."x")
            local currprogress = data.progress.current
            local Questtarget = data.progress.target
            local premiumPts = tostring(data.premiumPoints.."x")

            local progressBar = (currprogress/Questtarget) * 7

            formspec = formspec..
            "label[1.3,-0.2;"..questTitle.."]"..
            "image[0.2,"..tostring((i - 0.3) + ((i-1) * 0.3))..";11,1.5;Container.png]"..
            "image[0.2,"..tostring((4.1 + i) + ((i-1) * 0.3))..";11,1.5;Container.png]"..
            "label[1,"..tostring((i - 0.1) + ((i-1) * 0.3))..";"..questDes.."]"..
            "label[1,"..tostring((4.3 + i) + ((i-1) * 0.3))..";"..questDes.."]"..
            "image[0.8,"..tostring((i + 0.5) + ((i-1) * 0.3))..";"..progressBar..",0.2;tile.png]"..
            "label[6.5,"..tostring((i + 0.35) + ((i-1) * 0.3))..";"..currprogress.."/"..Questtarget.."]"..
            "image[0.8,"..tostring((4.9 + i) + ((i-1) * 0.3))..";"..progressBar..",0.2;tile.png]"..
            "label[6.5,"..tostring((4.8 + i) + ((i-1) * 0.3))..";"..currprogress.."/"..Questtarget.."]"..
            "image[7.8,"..tostring((i) + ((i-1) * 0.3))..";0.8,0.6;default_wood.png]"..
            "image[7.8,"..tostring((4.4 + i) + ((i-1) * 0.3))..";0.8,0.6;default_wood.png]"..
            "label[7.85,"..tostring((i + 0.45) + ((i-1) * 0.3))..";"..questPoints.."]"..
            "label[7.85,"..tostring((4.85 + i) + ((i-1) * 0.3))..";"..questPoints.."]"
        end

        return formspec
    elseif(guiName == "Award") then
        local formspec = "size[9,6]"..
        "image[2.9,-0.8;3,1;battlePass.png]"..
        -- "list[current_player;main;0,5;6,4;]"..
        "style[Back_Btn;fgcolor=red;textcolor=black]"..
        "image_button[-0.1,-0.2;1,0.7;Button.png;Back_Btn;Back;true;false;]"..
        "style[Free_Rewards;fgcolor=red;textcolor=black]"..
        "image_button[-0.1,0.5;3,2.3;Button.png;Free_Rewards;Free;true;false;]"..
        "style[Season_Pass;fgcolor=red;textcolor=black]"..
        "style[Premium_Rewards;fgcolor=red;textcolor=black]"..
        "image_button[-0.1,3.7;3,2.3;Button.png;Premium_Rewards;Pass;true;false;]"..
        "image_button[0.6,5;1.7,0.6;Button.png;Season_Pass;Get Pass;true;false;]"..""
        -- "scrollbar[2.8,5.9;6.2,0.4;horizontal;award_scrollbar;0]"..""

        if not updateRewards then
            if(currentAwardIdx == #formspecData) then 
                currentAwardIdx = 1
            end
     
            if(currentAwardIdx == 3) then 
                currentAwardIdx = currentAwardIdx + 1
            end

        else
            local plrTier = plrData.tierData["currentTier"]
            if (plrTier >= 1 and plrTier <= 3) then
              currentAwardIdx = 1
              elseif (plrTier > 3 and plrTier <= 6) then
                currentAwardIdx = 4
              elseif (plrTier > 6 and plrTier <= 9) then
                currentAwardIdx = 7 
            end
        end

        if(currentAwardIdx + 2 < #formspecData) then
            formspec = formspec..
            "style[Forward_Btn;fgcolor=red;textcolor=black]"..
            "image_button[7.6,-0.2;1.5,0.7;Button.png;Forward_Btn;Forward;true;false;]"..""
        end
      
 
        local j=1

        for i = currentAwardIdx,math.min(currentAwardIdx + 2,#formspecData) do
            local data = formspecData[i]
            local rewardName = data.name
            local rewardTitle = data.title
            local rewardStatus = nil
            local premiumRewardStatus = nil
            local plrTier = plrData.tierData["currentTier"]

            if(i >= plrTier) then
               rewardStatus = "Locked"
            else
               for i,collAwd in ipairs(plrData.collected.Basic) do
                  if(collAwd == rewardName) then 
                      rewardStatus = "Collected"
                      break;
                  end
                end

                if(rewardStatus ~= "Collected") then
                    rewardStatus = "Unlocked"
                end
            end

            if(data.hasPremiumPass and rewardStatus ~= "Locked") then
               for i,collAwd in ipairs(plrData.collected.Premium) do
                  if(collAwd == rewardName) then
                      premiumRewardStatus = "Collected"
                  end
               end

               if(premiumRewardStatus ~= "Collected") then
                  premiumRewardStatus = "Unlocked"
               end

            else
                premiumRewardStatus = "Locked"
            end

           formspec = formspec..
           "image_button[" .. tostring(0.6 * (j-1) + ((j + 0.8) * 1.5)) ..",0.6;2.3,2;tile.png;"..rewardName..";;true;false;]"..
           "image_button[" .. tostring(0.6 * (j-1) + ((j + 0.8) * 1.5)) ..",3.8;2.3,2;tile.png;Premium"..rewardName..";;true;false;]"..
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

            minetest.chat_send_player(plrName, "Status Is "..rewardStatus)

            if rewardStatus == "Locked" then
                formspec = formspec..
                "image_button[" .. tostring((0.6 * (j-1) + (j + 1.2) * 1.5)) ..",1;1,1;Locked.png;"..rewardStatus..";;true;false;]"
            elseif rewardStatus == "Unlocked" then 
                formspec = formspec..
                "image_button[" .. tostring((0.6 * (j-1) + (j + 1.2) * 1.5)) ..",1;1,1;Unlocked.png;"..rewardStatus..";;true;false;]"
            else
                formspec = formspec..
                "image_button[" .. tostring((0.6 * (j-1) + (j + 1.2) * 1.5)) ..",1;1,1;tick.png;"..rewardStatus..";;true;false;]"
            end

            if premiumRewardStatus == "Locked" then
                formspec = formspec..
                "image_button[" .. tostring((0.6 * (j-1) + (j + 1.2) * 1.5)) ..",4.3;1,1;Locked.png;"..rewardStatus..";;true;false;]"
            elseif premiumRewardStatus == "Unlocked" then 
                formspec = formspec..
                "image_button[" .. tostring(0.3 + ((j-1) * 1.5)) ..",4.3;1,1;Unlocked.png;"..rewardStatus..";;true;false;]"
            else
                formspec = formspec..
                "image_button[" .. tostring(0.3 + ((j-1) * 1.5)) ..",4.3;1,1;tick.png;"..rewardStatus..";;true;false;]"
            end


            j= j+1
            currentAwardIdx = i
        end

        return formspec
    elseif(guiName == "Info") then
        local plrTier = plrData.tierData["currentTier"]
        local currPoints = plrData.tierData["progress"]

        local inventory_formspec = "size[5,8]"..
        "image[1.1,-0.8;3,1;battlePass.png]"..
        "style[Reward_Button;fgcolor=red;textcolor=black]"..
        "image_button[0.2,0.5;2.2,2.5;tile.png;Reward_Button;Rewards;true;false;]"..
        "tooltip[Reward_Button;"..
        minetest.colorize("#EE0", "Rewards")..
        "(Click me)"..
        "\n\nClick this to view the Rewads."..
        ";#000000;#FFFFFF]"..
        -- "tooltip[Reward_Button;"..
        -- minetest.colorize("#FFFF00", "Season 3 Battle Pass")..
        -- "\n"..
        -- minetest.colorize("#A9A9A9", "Premium Battle Pass")..
        -- "\n\n"..
        -- minetest.colorize("#A9A9A9", "Week ")..
        -- minetest.colorize("#008000", "Finished ")..
        -- "\n\n"..
        -- minetest.colorize("#FFFF00", "Statistics")..
        -- "\n"..
        -- minetest.colorize("#A9A9A9", "Tier ")..
        -- minetest.colorize("#FFFFFF", tostring(plrTier))..
        -- "\n"..
        -- minetest.colorize("#A9A9A9", "Points ")..
        -- minetest.colorize("#FFFFFF", tostring(currPoints.."/100"))..
        "]"..
        "style[Quest_Button;fgcolor=red;textcolor=black]"..
        "image_button[2.7,0.5;2.2,2.5;tile.png;Quest_Button;Quests;true;false;]"..
        "tooltip[Quest_Button;"..
        minetest.colorize("#EE0", "Quests")..
        "(Click me)"..
        "\n\nClick this to view the Quests."..
        ";#000000;#FFFFFF]"..
        -- "style_type[box; border = true;borderwidths = 5;bordercolors = #0000FF]"..
        "style_type[label;text_size=22]"..
        "label[2,3.5;INFO]"..
        "label[0.7,4.2;Pass: Premium/Free]"..
        "label[0.7,4.8;Tier: "..plrTier.."]"..
        "label[0.7,5.5;Points: "..currPoints.."]"..


        -- "list[current_player;main;0,4.2;5,4;]"..
        ""

        return inventory_formspec


    end
end

minetest.register_chatcommand("bp", { 
    description = "Show Main Gui",
    func = function(name,param)
        minetest.show_formspec(name, "battlepass:mainGui", guiHandler.get_formspec("Info",name))
    end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    local name = player:get_player_name()

    if formname == "battlepass:mainGui" then
        if fields.Info_Button then
            -- minetest.show_formspec(player:get_player_name(), "battlepass:Quests", quest_formSpec)
        elseif fields.Reward_Button then
             local rewardsData = rewards.Get_Rewards(name)
             if #rewardsData == 0 then 
                return
             end
             currentAwardIdx = 1
             minetest.show_formspec(name, "battlepass:Awards",guiHandler.get_formspec("Award",name,rewardsData))
        elseif fields.Quest_Button then
            -- local quest_weeks = quests.GetWeeks()
            -- if #quest_weeks == 0 then
            --     return
            -- end
            local questWeek = "Week"..currentWeek
            local weekQuests = quests.Get_WeeklyQuests(name,questWeek)
            
            minetest.show_formspec(name, "battlepass:weekGui",guiHandler.get_formspec("Quest",name,weekQuests))

            -- minetest.show_formspec(name, "battlepass:Quests",guiHandler.get_formspec("Quest",name,weekQuests))
        elseif fields.btn_close then
            return true
        end
    elseif formname == "battlepass:weekGui" then
        if fields.Back_Btn then
            if fields.Back_Btn then
                if currentWeek > 1 then
                    currentWeek = currentWeek - 1
                    local questWeek = "Week"..currentWeek
                    local weekQuests = quests.Get_WeeklyQuests(name,questWeek)
    
                    if not weekQuests then return end
                    
                    minetest.show_formspec(name, "battlepass:weekGui",guiHandler.get_formspec("Quest",name,weekQuests))
                else
                    minetest.show_formspec(name, "battlepass:mainGui", guiHandler.get_formspec("Info",name))
                end
            end
        end
        if fields.Forward_Btn then
            local quest_weeks = quests.GetWeeks()
            if currentWeek == #quest_weeks then return end
            currentWeek = currentWeek + 1
            local questWeek = "Week"..currentWeek
            local weekQuests = quests.Get_WeeklyQuests(name,questWeek)
            if not weekQuests then return end
            minetest.show_formspec(name, "battlepass:weekGui",guiHandler.get_formspec("Quest",name,weekQuests))
        end

    elseif formname == "battlepass:Awards" then
        local rewardsData = rewards.Get_Rewards(name)
        
        if #rewardsData == 0 then 
            return
        end

        if fields.Back_Btn then
            if currentAwardIdx > 3 then
                minetest.show_formspec(name, "battlepass:Awards",guiHandler.get_formspec("Award",name,rewardsData))
            else
                minetest.show_formspec(name, "battlepass:mainGui", guiHandler.get_formspec("Info",name))
            end
        end

        if fields.Forward_Btn then
            minetest.show_formspec(name, "battlepass:Awards",guiHandler.get_formspec("Award",name,rewardsData))
        end

        if fields.Season_Pass then
            local plrData = PlayerStore.getPlayerData(name)
            if not plrData.hasPremiumPass then
                minetest.chat_send_player(name, "Has No Premium Pass")

                -- Code to Purchase Premium Pass

            end

        end

        local rewardsData = rewards.Get_Rewards(name)
        for i,rewardData in ipairs(rewardsData) do
            if fields[rewardData.name] then

                local plrData = PlayerStore.getPlayerData(name)
                local plrTier = plrData.tierData["currentTier"]

                if i >= plrTier then
                    minetest.chat_send_player(name, "Award Locked")
                     return
                 end 

                 for i,collAwd in ipairs(plrData.collected.Basic) do
                     if rewardData.name == collAwd then
                        minetest.chat_send_player(name, "Award Collected Previously")
                        return
                     end
                 end


                if not rewardData.OnRewardCollected then
                     return
                 end
                 local rewardCollected = rewardData.OnRewardCollected(name)
                 if rewardCollected then
                    table.insert(plrData.collected.Basic,rewardData.name)
                    minetest.chat_send_player(name, "Award Collected")
                    PlayerStore.save()
                    minetest.show_formspec(name, "battlepass:Awards",guiHandler.get_formspec("Award",name,rewardsData,true))
                 end
                 
            elseif fields["Premium"..rewardData.name] then
                local plrData = PlayerStore.getPlayerData(name)
                local plrTier = plrData.tierData["currentTier"]

                minetest.chat_send_player(name, "Premium Pass "..tostring(plrData.hasPremiumPass))

                if not plrData.hasPremiumPass then
                   minetest.chat_send_player(name, "Player has no Premium Pass.")

                                   -- Code to Purchase Premium Pass

                   return
                end


                if i >= plrTier then
                    minetest.chat_send_player(name, "Award Locked")
                     return
                 end

                if not rewardData.OnPremiumRewardCollected then return end
               
                for i,collAwd in ipairs(plrData.collected.Premium) do
                    if rewardData.name == collAwd then
                       minetest.chat_send_player(name, "Award Collected Previously")
                       return
                    end
                end

                local rewardCollected = rewardData.OnPremiumRewardCollected(name)

                if rewardCollected then
                    table.insert(plrData.collected.Premium,rewardData.name)
                    minetest.chat_send_player(name, "Award Collected")
                    PlayerStore.save()
                    minetest.show_formspec(name, "battlepass:Awards",guiHandler.get_formspec("Award",name,rewardsData,true))
                 end

            end

        end
    end

end)

return guiHandler