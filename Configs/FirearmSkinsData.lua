local l_RunService_0 = game:GetService("RunService");
local v1 = l_RunService_0:IsServer();
local _ = l_RunService_0:IsStudio();
local v3 = nil;
v3 = if v1 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local v4 = v3.require("Configs", "Globals");
local v5 = v3.require("Libraries", "Resources"):Find("ReplicatedStorage.Purchasables.GunSkins");
local v6 = {};
local v7 = {};
local v8 = {};
local v9 = {};
local v10 = {
    [945021129] = 1256786737, 
    [945021166] = 1256786782, 
    [945021198] = 1256786818, 
    [945021242] = 1256786840, 
    [945021271] = 1256786860, 
    [945021308] = 1256786878, 
    [945021437] = 1256786897, 
    [964082363] = 1256786927, 
    [966623360] = 1256786963, 
    [1131971279] = 1256787005, 
    [1131971847] = 1256787029, 
    [1228879971] = 1256787058, 
    [1228880007] = 1256787123, 
    [1279200370] = 1279200916, 
    [1713043455] = 1713044434, 
    [1754278725] = 1754279109, 
    [1791937974] = 1791943964, 
    [1791938280] = 1791944135, 
    [1842623112] = 1842627468, 
    [2196126612] = 2196125950, 
    [2673072641] = 2673073459, 
    [2673076581] = 2673077603
};
local function v16() --[[ Line: 61 ]] --[[ Name: load ]]
    -- upvalues: v5 (copy), v10 (copy), v4 (copy), v7 (copy), v6 (copy), v8 (copy)
    for _, v12 in next, v5:GetChildren() do
        local v13 = require(v12);
        if v10[v13.DevProductId] and not v4.isProdPlace() then
            v13.DevProductId = v10[v13.DevProductId];
        end;
        for _, v15 in next, v13.Skins do
            v15.Group = v12.Name;
            v7[v15.Id] = v15;
        end;
        v6[v12.Name] = v13;
        v8[v12.Name] = v13.Skins;
    end;
end;
v9.GetSkinFromId = function(_, v18) --[[ Line: 83 ]] --[[ Name: GetSkinFromId ]]
    -- upvalues: v7 (copy)
    return v7[v18];
end;
v9.GetSkinsFromGroup = function(_, v20) --[[ Line: 87 ]] --[[ Name: GetSkinsFromGroup ]]
    -- upvalues: v8 (copy)
    return v8[v20];
end;
v9.GetSkins = function(_) --[[ Line: 91 ]] --[[ Name: GetSkins ]]
    -- upvalues: v8 (copy)
    return v8;
end;
v9.GetSkinGroupInfo = function(_, v23) --[[ Line: 95 ]] --[[ Name: GetSkinGroupInfo ]]
    -- upvalues: v6 (copy)
    return v6[v23];
end;
v9.GetSkinsData = function(_) --[[ Line: 99 ]] --[[ Name: GetSkinsData ]]
    -- upvalues: v6 (copy)
    return v6;
end;
v9.FindRollerSkins = function(_, v26) --[[ Line: 103 ]] --[[ Name: FindRollerSkins ]]
    -- upvalues: v8 (copy)
    local v27 = {};
    for _, v29 in next, v8 do
        local v30 = false;
        for _, v32 in next, v29 do
            if v32.Id == v26 then
                v30 = true;
                break;
            end;
        end;
        if v30 then
            for _, v34 in next, v29 do
                table.insert(v27, v34);
            end;
            return v27;
        end;
    end;
    return v27;
end;
v9.FindSkinIndex = function(_, v36) --[[ Line: 128 ]] --[[ Name: FindSkinIndex ]]
    -- upvalues: v7 (copy), v8 (copy)
    local v37 = v8[v7[v36].Group];
    for v38, v39 in next, v37 do
        if v39.Id == v36 then
            return v38;
        end;
    end;
    return 0;
end;
v16();
return v9;