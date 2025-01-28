local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Network");
local v3 = {
    Discovered = v0.require("Classes", "Signals").new()
};
local v4 = {};
local v5 = true;
local function v12(v6) --[[ Line: 21 ]] --[[ Name: syncMaster ]]
    -- upvalues: v5 (ref), v4 (ref), v3 (copy)
    local v7 = {};
    local l_v5_0 = v5;
    for v9 in next, v6 do
        if not v4[v9] then
            table.insert(v7, v9);
        end;
    end;
    v4 = v6;
    v5 = false;
    if not l_v5_0 then
        for _, v11 in next, v7 do
            v3.Discovered:Fire(v11);
        end;
    end;
end;
v3.IsDiscovered = function(_, v14) --[[ Line: 43 ]] --[[ Name: IsDiscovered ]]
    -- upvalues: v4 (ref)
    return v4[v14];
end;
v3.GetMasterList = function(_) --[[ Line: 47 ]] --[[ Name: GetMasterList ]]
    -- upvalues: v4 (ref)
    return v4;
end;
v3.ResyncMasterList = function(_) --[[ Line: 51 ]] --[[ Name: ResyncMasterList ]]
    -- upvalues: v12 (copy), v2 (copy), v4 (ref)
    v12(v2:Fetch("Get Discovered Items"));
    return v4;
end;
v2:Add("Discovery Update", function(v17) --[[ Line: 59 ]]
    -- upvalues: v12 (copy)
    v12(v17);
end);
return v3;