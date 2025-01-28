local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Network");
local v2 = v0.require("Libraries", "RJSON");
local v3 = v0.require("Classes", "Signals");
local v4 = {
    BindChanged = v3.new(), 
    BindOverwritten = v3.new(), 
    BindsLoaded = v3.new()
};
local v5 = {};
local v6 = false;
local v7 = false;
local function v8(v9, v10, v11) --[[ Line: 23 ]] --[[ Name: overwrite ]]
    -- upvalues: v8 (copy)
    local v12 = false;
    if type(v11) == "table" then
        local v13 = v9[v10];
        if not v13 then
            v9[v10] = {};
            v13 = v9[v10];
        end;
        for v14, v15 in next, v11 do
            if type(v15) == "table" then
                if v8(v13, v14, v15) then
                    v12 = true;
                end;
            else
                if v13[v14] ~= v15 then
                    v12 = true;
                end;
                v13[v14] = v15;
            end;
        end;
        return v12;
    else
        if v9[v10] ~= v11 then
            v12 = true;
        end;
        v9[v10] = v11;
        return v12;
    end;
end;
local function v21(v16) --[[ Line: 58 ]] --[[ Name: import ]]
    -- upvalues: v2 (copy), v5 (copy), v8 (copy), v4 (copy)
    for v17, v18 in next, v2:Decode(v16) do
        if not v5[v17] then
            v5[v17] = {};
        end;
        for v19, v20 in next, v18 do
            if v8(v5[v17], v19, v20) then
                v4.BindChanged:Fire(v19);
            end;
        end;
    end;
end;
v4.GetBindsList = function(_) --[[ Line: 74 ]] --[[ Name: GetBindsList ]]
    -- upvalues: v5 (copy)
    return v5;
end;
v4.GetBind = function(_, v24) --[[ Line: 78 ]] --[[ Name: GetBind ]]
    -- upvalues: v5 (copy)
    return v5[v24];
end;
v4.GetDisplayOrder = function(_) --[[ Line: 82 ]] --[[ Name: GetDisplayOrder ]]
    return {
        {
            "Character"
        }, 
        "Move Forwards", 
        "Move Left", 
        "Move Backwards", 
        "Move Right", 
        "Jump", 
        "Shove", 
        "Auto Run", 
        "Crouch", 
        "Sprint", 
        {
            "Weapon"
        }, 
        "Aim Down Sights", 
        "Reload", 
        "Fire Mode", 
        "Attachment Use", 
        "At Ease", 
        "Shoulder Change", 
        {
            "Vehicle"
        }, 
        "Vehicle Lights", 
        "Vehicle Horn", 
        "Vehicle Siren", 
        "Vehicle Siren 2", 
        {
            "Utility"
        }, 
        "Toggle Inventory", 
        "Toggle Binoculars", 
        "Toggle Flashlight", 
        "Toggle Map", 
        "Zoom Map In", 
        "Zoom Map Out", 
        {
            "Misc"
        }, 
        "Secondary Interact", 
        "Lock Look Direction", 
        "Change Chat Channel", 
        "Chat Focus", 
        "Change Player List Tab"
    };
end;
v4.SetKeyBind = function(v26, v27, v28) --[[ Line: 126 ]] --[[ Name: SetKeyBind ]]
    -- upvalues: v5 (copy), v1 (copy)
    v5[v27].Key = v28;
    v1:Send("Set Keybind", v27, "Key", v28);
    v26.BindChanged:Fire(v27);
end;
v4.EditBindProperty = function(v29, v30, v31, v32) --[[ Line: 141 ]] --[[ Name: EditBindProperty ]]
    -- upvalues: v1 (copy), v2 (copy)
    local l_v29_Bind_0 = v29:GetBind(v30);
    if l_v29_Bind_0 and type(l_v29_Bind_0[v31]) == "table" then
        l_v29_Bind_0[v31].Value = v32;
        v29.BindChanged:Fire(v30);
        v1:Send("Set Keybind", v30, v31, v2:Encode(l_v29_Bind_0[v31]));
    end;
end;
v4.IsComplete = function(_) --[[ Line: 152 ]] --[[ Name: IsComplete ]]
    -- upvalues: v5 (copy)
    for _, v36 in next, v5 do
        if not v36.Key then
            return false;
        end;
    end;
    return true;
end;
v4.Load = function(v37) --[[ Line: 162 ]] --[[ Name: Load ]]
    -- upvalues: v6 (ref), v21 (copy), v1 (copy), v7 (ref)
    if v6 then
        return;
    else
        v6 = true;
        v21(v1:Fetch("Get Keybinds"));
        v7 = true;
        v37.BindsLoaded:Fire();
        return;
    end;
end;
v4.BindToLoad = function(v38, v39) --[[ Line: 176 ]] --[[ Name: BindToLoad ]]
    -- upvalues: v7 (ref)
    if v7 then
        v39();
        return;
    else
        local v40 = nil;
        v40 = v38.BindsLoaded:Connect(function() --[[ Line: 182 ]]
            -- upvalues: v40 (ref), v39 (copy)
            v40:Disconnect();
            v39();
        end);
        return;
    end;
end;
v4.Reset = function(_) --[[ Line: 189 ]] --[[ Name: Reset ]]
    -- upvalues: v1 (copy)
    v1:Send("Reset Keybinds");
end;
v1:Add("Keybinds Reset", function(v42) --[[ Line: 195 ]]
    -- upvalues: v21 (copy)
    v21(v42);
end);
return v4;