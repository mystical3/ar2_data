local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Network");
local v2 = v0.require("Libraries", "RJSON");
local v3 = v0.require("Classes", "Signals");
local v4 = {
    SettingChanged = v3.new(), 
    SettingsLoaded = v3.new()
};
local v5 = {};
local v6 = {};
local v7 = false;
local v8 = false;
local function v9(v10) --[[ Line: 24 ]] --[[ Name: copyTable ]]
    -- upvalues: v9 (copy)
    local v11 = {};
    for v12, v13 in next, v10 do
        if type(v13) == "table" then
            v13 = v9(v13);
        end;
        v11[v12] = v13;
    end;
    return v11;
end;
local function v14(v15, v16, v17) --[[ Line: 38 ]] --[[ Name: overwrite ]]
    -- upvalues: v14 (copy)
    local v18 = false;
    if type(v17) == "table" then
        local v19 = v15[v16];
        if not v19 then
            v15[v16] = {};
            v19 = v15[v16];
        end;
        for v20, v21 in next, v17 do
            if type(v21) == "table" then
                if v14(v19, v20, v21) then
                    v18 = true;
                end;
            else
                if v19[v20] ~= v21 then
                    v18 = true;
                end;
                v19[v20] = v21;
            end;
        end;
        return v18;
    else
        if v15[v16] ~= v17 then
            v18 = true;
        end;
        v15[v16] = v17;
        return v18;
    end;
end;
local function v27(v22) --[[ Line: 73 ]] --[[ Name: import ]]
    -- upvalues: v2 (copy), v5 (copy), v14 (copy), v4 (copy)
    for v23, v24 in next, v2:Decode(v22) do
        if not v5[v23] then
            v5[v23] = {};
        end;
        for v25, v26 in next, v24 do
            if v14(v5[v23], v25, v26) then
                v4.SettingChanged:Fire(v23, v25, v26.Value);
            end;
        end;
    end;
end;
v4.GetSettingsList = function(_) --[[ Line: 89 ]] --[[ Name: GetSettingsList ]]
    -- upvalues: v5 (copy)
    return v5;
end;
v4.GetSetting = function(_, v30, v31) --[[ Line: 93 ]] --[[ Name: GetSetting ]]
    -- upvalues: v8 (ref), v5 (copy)
    if not v8 then
        return nil;
    elseif v31 then
        return v5[v30][v31].Value;
    else
        return v5[v30];
    end;
end;
v4.Load = function(_) --[[ Line: 105 ]] --[[ Name: Load ]]
    -- upvalues: v7 (ref), v27 (copy), v1 (copy), v4 (copy), v8 (ref)
    if v7 then
        return;
    else
        v7 = true;
        v27(v1:Fetch("Get User Settings"));
        v4.SettingsLoaded:Fire();
        v8 = true;
        return;
    end;
end;
v4.Reset = function(_) --[[ Line: 119 ]] --[[ Name: Reset ]]
    -- upvalues: v1 (copy)
    v1:Send("Reset User Settings");
end;
v4.GetDisplayOrder = function(_) --[[ Line: 123 ]] --[[ Name: GetDisplayOrder ]]
    return {
        "Sound Volume", 
        "Accessibility", 
        "Character", 
        "Game Quality", 
        "User Interface", 
        "Debug", 
        {
            ""
        }
    };
end;
v4.Change = function(_, v36, v37, v38, v39) --[[ Line: 136 ]] --[[ Name: Change ]]
    -- upvalues: v5 (copy), v1 (copy), v4 (copy)
    local l_Value_0 = v5[v36][v37].Value;
    local l_v38_0 = v38;
    if not v39 then
        l_v38_0 = v1:Fetch("Set User Setting", v36, v37, v38);
    end;
    if l_v38_0 then
        v5[v36][v37].Value = l_v38_0;
        if l_v38_0 ~= l_Value_0 then
            v4.SettingChanged:Fire(v36, v37, l_v38_0);
        end;
    end;
end;
v4.BindToSetting = function(_, v43, v44, v45) --[[ Line: 153 ]] --[[ Name: BindToSetting ]]
    -- upvalues: v6 (copy), v8 (ref), v5 (copy)
    if not v6[v43] then
        v6[v43] = {};
    end;
    if not v6[v43][v44] then
        v6[v43][v44] = {};
    end;
    table.insert(v6[v43][v44], v45);
    if v8 then
        v45(v5[v43][v44].Value);
    end;
end;
v4.BindToLoaded = function(v46, v47) --[[ Line: 169 ]] --[[ Name: BindToLoaded ]]
    -- upvalues: v8 (ref)
    if v8 then
        v47();
        return;
    else
        local v48 = nil;
        v48 = v46.SettingsLoaded:Connect(function() --[[ Line: 175 ]]
            -- upvalues: v48 (ref), v47 (copy)
            v48:Disconnect();
            v47();
        end);
        return;
    end;
end;
v1:Add("User Settings Reset", function(v49) --[[ Line: 184 ]]
    -- upvalues: v27 (copy)
    v27(v49);
end);
v4.SettingChanged:Connect(function(v50, v51, ...) --[[ Line: 188 ]]
    -- upvalues: v6 (copy)
    if v6[v50] and v6[v50][v51] then
        for _, v53 in next, v6[v50][v51] do
            v53(...);
        end;
    end;
end);
return v4;