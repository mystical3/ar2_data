local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Network");
local v2 = v0.require("Classes", "Signals");
local v3 = {
    StatisticChanged = v2.new(), 
    StatisticsLoaded = v2.new()
};
local v4 = {};
local v5 = {};
local v6 = false;
local v7 = false;
v3.GetStatisticsList = function(_) --[[ Line: 23 ]] --[[ Name: GetStatisticsList ]]
    -- upvalues: v4 (ref)
    return v4;
end;
v3.GetStatistic = function(_, v10, v11) --[[ Line: 27 ]] --[[ Name: GetStatistic ]]
    -- upvalues: v7 (ref), v4 (ref)
    if not v7 then
        return nil;
    elseif v11 then
        return v4[v10][v11].Value;
    else
        return v4[v10];
    end;
end;
v3.Load = function(_) --[[ Line: 39 ]] --[[ Name: Load ]]
    -- upvalues: v6 (ref), v4 (ref), v1 (copy), v3 (copy), v7 (ref)
    if v6 then
        return;
    else
        v6 = true;
        v4 = v1:Fetch("Get User Statistics");
        v3.StatisticsLoaded:Fire();
        v7 = true;
        return;
    end;
end;
v3.GetDisplayOrder = function(_) --[[ Line: 53 ]] --[[ Name: GetDisplayOrder ]]
    return {
        "Character", 
        "Player"
    };
end;
v3.BindToStatistic = function(v14, v15, v16, v17) --[[ Line: 60 ]] --[[ Name: BindToStatistic ]]
    -- upvalues: v5 (copy), v7 (ref)
    if not v5[v15] then
        v5[v15] = {};
    end;
    if not v5[v15][v16] then
        v5[v15][v16] = {};
    end;
    table.insert(v5[v15][v16], v17);
    if v7 then
        v17(v14:GetStatistic(v15, v16));
    end;
end;
v3.BindToLoaded = function(v18, v19) --[[ Line: 76 ]] --[[ Name: BindToLoaded ]]
    -- upvalues: v7 (ref)
    if v7 then
        v19();
        return;
    else
        local v20 = nil;
        v20 = v18.StatisticsLoaded:Connect(function() --[[ Line: 82 ]]
            -- upvalues: v20 (ref), v19 (copy)
            v20:Disconnect();
            v19();
        end);
        return;
    end;
end;
v1:Add("User Statistics Upate", function(v21, v22, v23) --[[ Line: 91 ]]
    -- upvalues: v6 (ref), v3 (copy), v4 (ref)
    if not v6 then
        v3:Load();
    end;
    if v4[v21] then
        local v24 = v4[v21][v22];
        if v24 then
            local l_Value_0 = v24.Value;
            v24.Value = v23;
            if v23 ~= l_Value_0 then
                v3.StatisticChanged:Fire(v21, v22, v23, l_Value_0);
            end;
        end;
    end;
end);
v3.StatisticChanged:Connect(function(v26, v27, v28, v29) --[[ Line: 111 ]]
    -- upvalues: v5 (copy)
    if v5[v26] and v5[v26][v27] then
        for _, v31 in next, v5[v26][v27] do
            v31(v28, v29);
        end;
    end;
end);
return v3;