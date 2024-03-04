rewards.register_reward("Tier1", {
    Required_Tier = 1,
    title = "2x Player Joule Booster",

    OnRewardCollected = function(plr)
        return true
    end,

    OnPremiumRewardCollected = function(plr)
        return true
    end
})

rewards.register_reward("Tier2", {
    Required_Tier = 2,
    title = "2x Player Joule Booster",

    OnRewardCollected = function(plr)
        return true
    end,

    OnPremiumRewardCollected = function(plr)
       return true
    end
})

rewards.register_reward("Tier3", {
    Required_Tier = 3,
    title = "2x Player Joule Booster",
})

rewards.register_reward("Tier4", {
    Required_Tier = 4,
    title = "2x Player Joule Booster",
})

rewards.register_reward("Tier5", {
    Required_Tier = 5,
    title = "2x Player Joule Booster",
})