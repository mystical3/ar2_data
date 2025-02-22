local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "FirearmSkinsData");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Signals");
local v4 = {
    SkinAdded = v3.new(), 
    SkinsSynced = v3.new()
};
local v5 = {};
local v6 = true;
local function v14(v7) --[[ Line: 22 ]] --[[ Name: syncMaster ]]
    -- upvalues: v6 (ref), v5 (ref), v4 (copy)
    local v8 = {};
    local l_v6_0 = v6;
    for v10, _ in next, v7 do
        if not v5[v10] then
            table.insert(v8, v10);
        end;
    end;
    v5 = v7;
    v6 = false;
    v4.SkinsSynced:Fire();
    if not l_v6_0 then
        for _, v13 in next, v8 do
            v4.SkinAdded:Fire(v13);
        end;
    end;
end;
v4.IsOwned = function(_, v16) --[[ Line: 45 ]] --[[ Name: IsOwned ]]
    -- upvalues: v5 (ref)
    return v5[v16] ~= nil;
end;
v4.GetTimestamp = function(_, v18) --[[ Line: 49 ]] --[[ Name: GetTimestamp ]]
    -- upvalues: v5 (ref)
    if v5[v18] then
        return v5[v18].Timestamp;
    else
        return nil;
    end;
end;
v4.IsFavorited = function(_, v20) --[[ Line: 57 ]] --[[ Name: IsFavorited ]]
    -- upvalues: v5 (ref)
    if v5[v20] then
        return v5[v20].Favorite;
    else
        return false;
    end;
end;
v4.GetList = function(_) --[[ Line: 65 ]] --[[ Name: GetList ]]
    -- upvalues: v5 (ref), v1 (copy)
    local v22 = {};
    for v23 in next, v5 do
        table.insert(v22, v1:GetSkinFromId(v23));
    end;
    return v22;
end;
v4.ResyncMasterList = function(v24) --[[ Line: 75 ]] --[[ Name: ResyncMasterList ]]
    -- upvalues: v14 (copy), v2 (copy)
    v14(v2:Fetch("Get Firearm Skins"));
    return v24:GetList();
end;
v2:Add("Firearm Skins Update", function(v25) --[[ Line: 83 ]]
    -- upvalues: v14 (copy)
    v14(v25);
end);
return v4;