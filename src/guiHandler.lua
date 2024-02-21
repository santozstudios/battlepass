
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

function guiHandler.get_formspec(guiName,week)

    if(guiName == "Quest") then
        local formspec = "size[6,7]"..
        "list[current_player;main;0,3;6,4;]"..
        "image[1.5,-0.8;3,1;battlePass.png]"

        local quest_weeks = quests.GetWeeks()

        if #quest_weeks == 0 then
            return
        end

        for i,week in ipairs(quest_weeks) do

            -- local questTitle = data.name
            -- local questDes = data.des
            -- local questPoints = data.points
            -- local currprogress = data.progress.current
            -- local Questtarget = data.progress.target
           
            formspec = formspec..
            -- "image[-0.1,0.4;7.4,1.6;default_wood.png]"..
            "tooltip["..week..";"..
            minetest.colorize("#EE0", week..": Click to check out quests.")..
            "]"..
            "style[Back_Btn;fgcolor=red;textcolor=black]"..
            "style["..week..";fgcolor=red;textcolor=black]"..
            "image_button[" .. tostring((i-1) * 1.5) ..",0.4;1.5,1;tile.png;"..week..";"..week..";true;false;]"..
            "image_button[0,1.8;2.2,1;Button.png;Back_Btn;Back;true;false;]"..
            -- "image_button[2.7,0.2;2.2,1.8;pass.png;Quest_Button;]"..
            -- "tooltip[Quest_Button;"..
            -- minetest.colorize("#EE0", "QUEST:")..
            -- minetest.colorize("#FFFFFF",questTitle.."\n")..
            -- questDes.."\n\n"..
            -- minetest.colorize("#A020F0", "INFORMATION")..
            -- "\n"..
            -- minetest.colorize("#5A5A5A","Points:")..
            -- questPoints.."\n"..
            -- minetest.colorize("#5A5A5A","Progress:")..
            -- currprogress.."/"..Questtarget..
            ""
        end

        return formspec

    elseif(guiName == "WeekQuest") then


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

        elseif fields.Quest_Button then
            minetest.show_formspec(name, "battlepass:Quests",guiHandler.get_formspec("Quest",name))
        elseif fields.btn_close then
            return true
        end
    elseif formname == "battlepass:Quests" then

        -- Check for week buttons --
        local weeksData = {}--quests.getWeeks()

        if #weeksData > 0 then
            for i = 1, #weeksData do
                if fields["Week"..i] then
                    minetest.show_formspec(name, "battlepass:mainGui",iguiHandler.get_formspec("WeekQuest",name))
                end
            end
        end

        if fields.Back_Btn then
            minetest.show_formspec(name, "battlepass:mainGui", inventory_formspec)
        end
    end
end)

return guiHandler