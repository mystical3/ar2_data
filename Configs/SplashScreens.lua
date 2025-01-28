local v0 = nil;
v0 = if game:GetService("RunService"):IsServer() then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local v1 = {};
local v19 = {
    AwardItem = function(v2, ...) --[[ Line: 15 ]]
        -- upvalues: v0 (ref)
        for _, v4 in next, {
            ...
        } do
            if v0.Configs.ItemData[v4] then
                local v5 = nil;
                do
                    local l_v5_0 = v5;
                    v0.Libraries.SaveData:Update(v2.UserId, "Player", "DiscoveryItems", function(v7) --[[ Line: 22 ]]
                        -- upvalues: v4 (copy), l_v5_0 (ref)
                        if not v7[v4] then
                            v7[v4] = os.time();
                        end;
                        l_v5_0 = v7;
                        return v7;
                    end);
                    if l_v5_0 then
                        v0.Libraries.Network:Send(v2, "Discovery Update", l_v5_0);
                    end;
                end;
            end;
        end;
    end, 
    AwardSkin = function(v8, ...) --[[ Line: 39 ]]
        -- upvalues: v0 (ref), v1 (copy)
        local v9 = {
            ...
        };
        local v10 = nil;
        v0.Libraries.SaveData:Update(v8.UserId, "Purchases", "GunSkins", function(v11) --[[ Line: 43 ]]
            -- upvalues: v9 (copy), v10 (ref)
            local v12 = v11 or {};
            for _, v14 in next, v9 do
                if not v12[v14] then
                    v12[v14] = {
                        Favorite = false, 
                        Timestamp = os.time()
                    };
                end;
            end;
            v10 = v12;
            return v12;
        end);
        v0.Libraries.Network:Send(v8, "Firearm Skins Update", v1);
    end, 
    AwardBadge = function(v15, ...) --[[ Line: 67 ]]
        local l_BadgeService_0 = game:GetService("BadgeService");
        for _, v18 in next, {
            ...
        } do
            if l_BadgeService_0:GetBadgeInfoAsync(v18).IsEnabled and not l_BadgeService_0:UserHasBadgeAsync(v15.UserId, v18) then
                l_BadgeService_0:AwardBadge(v15.UserId, v18);
            end;
        end;
    end
};
v1.Template = {
    DisplayAfter = 1729791584, 
    ExpiresAfter = 1729791585, 
    ClickedValue = "clicked", 
    OnComplete = {}
};
v1["100m visits"] = {
    DisplayAfter = 1729897932, 
    ExpiresAfter = 1730781900, 
    ClickedValue = "badge fix", 
    OnComplete = {
        {
            v19.AwardItem, 
            "Vest Necklace 100M"
        }, 
        {
            v19.AwardBadge, 
            1.659625936844538E15
        }
    }
};
return v1;