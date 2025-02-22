local l_RunService_0 = game:GetService("RunService");
local v1 = l_RunService_0:IsServer();
local v2 = nil;
v2 = if v1 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local v3 = v2.require("Configs", "ItemData");
local v4 = v2.require("Libraries", "Resources");
local v5 = v4:Find("Workspace.Zombies.Master Config");
local v6 = require(v5);
local v7 = {};
local v8 = {};
local v9 = {
    Inherits = true
};
local function v10(v11) --[[ Line: 36 ]] --[[ Name: copy ]]
    -- upvalues: v10 (copy)
    if typeof(v11) == "table" then
        local v12 = {};
        for v13, v14 in next, v11 do
            if typeof(v14) == "table" then
                v14 = v10(v14);
            end;
            v12[v13] = v14;
        end;
        return v12;
    else
        return v11;
    end;
end;
local function v15(v16, v17) --[[ Line: 57 ]] --[[ Name: applyToConfig ]]
    -- upvalues: v9 (copy), v10 (copy), v4 (copy), v15 (copy)
    for v18, v19 in next, v17 do
        if not v9[v18] then
            v16[v18] = v10(v19);
        end;
    end;
    if v17.Inherits then
        for v20 = 1, #v17.Inherits do
            local v21 = "Workspace.Zombies." .. v17.Inherits[v20];
            local v22 = v4:Search(v21);
            if not v22 then
                warn("Failed to find zombie preset:", v17.Inherits[v20]);
            else
                v15(v16, require(v22));
            end;
        end;
    end;
    return v16;
end;
local function v33(v23, v24) --[[ Line: 82 ]] --[[ Name: validateConfig ]]
    -- upvalues: v3 (copy), v4 (copy)
    for v25, v26 in next, v24.Hair do
        if typeof(v26) == "table" and v3[v25] then
            for _, v28 in next, v26 do
                if not v3[v25].Colors[v28] then
                    print("Invalid zombie hair:", v23, v25, v28);
                end;
            end;
        else
            print("Invalid zombie hair:", v23, v25, v26);
        end;
    end;
    for _, v30 in next, {
        v24.Tops, 
        v24.Bottoms
    } do
        for _, v32 in next, v30 do
            if not v4:Search("ServerStorage.ClothingTextures." .. v32) then
                print("Missing clothing item:", v32);
            end;
        end;
    end;
end;
local function v41(v34) --[[ Line: 108 ]] --[[ Name: buildNewConfig ]]
    -- upvalues: v4 (copy), v15 (copy), v6 (copy), l_RunService_0 (copy), v33 (copy)
    local v35 = "Workspace.Zombies.Configs." .. v34;
    local v36 = v4:Search(v35);
    local v37 = {};
    if v36 then
        v37 = require(v36);
    else
        warn("Failed to find zombie config:", v34);
    end;
    local v38 = v15({}, v37);
    v38.ConfigName = v34;
    setmetatable(v38, {
        __index = function(_, v40) --[[ Line: 123 ]] --[[ Name: __index ]]
            -- upvalues: v6 (ref)
            return v6[v40];
        end
    });
    if l_RunService_0:IsServer() then
        v33(v34, v38);
    end;
    return v38;
end;
v7.Get = function(_, v43) --[[ Line: 137 ]] --[[ Name: Get ]]
    -- upvalues: v8 (copy), v41 (copy)
    if not v8[v43] then
        v8[v43] = v41(v43);
    end;
    return v8[v43];
end;
return v7;