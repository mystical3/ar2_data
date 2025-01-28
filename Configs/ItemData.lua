local l_RunService_0 = game:GetService("RunService");
local v1 = l_RunService_0:IsServer();
local _ = l_RunService_0:IsStudio();
local v3 = nil;
v3 = if v1 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local _ = v3.require("Configs", "Globals");
local _ = v3.require("Classes", "Signals");
local v6 = v3.require("Libraries", "Resources");
local v7 = v6:Find("ReplicatedStorage.Viewport Templates");
local v8 = {};
local function v9(v10) --[[ Line: 32 ]] --[[ Name: copy ]]
    -- upvalues: l_RunService_0 (copy), v9 (copy)
    if l_RunService_0:IsStudio() then
        return v10;
    else
        for _, v12 in next, v10 do
            if typeof(v12) == "table" then
                v9(v12);
            end;
        end;
        return table.freeze(v10);
    end;
end;
local function v13(v14) --[[ Line: 47 ]] --[[ Name: pullTemplate ]]
    -- upvalues: v7 (copy), v13 (copy)
    local v15 = v7:WaitForChild(v14, 1);
    if v15 then
        local v16 = require(v15:Clone());
        if typeof(v16) == "string" then
            return v13(v16);
        else
            return v16;
        end;
    else
        error(string.format("Couldn't locate template: %s", v14), 0);
        return;
    end;
end;
local function v22(v17) --[[ Line: 68 ]] --[[ Name: buildIconConfig ]]
    -- upvalues: v13 (copy)
    local l_IconData_0 = v17.IconData;
    local v19 = {};
    v19 = if typeof(l_IconData_0) == "string" then v13(l_IconData_0) else l_IconData_0;
    for v20, v21 in next, v19.Stages do
        if typeof(v21) == "string" then
            v19.Stages[v20] = v13(v21);
        end;
    end;
    v17.IconData = v19;
    return v17;
end;
local _ = function(_) --[[ Line: 100 ]] --[[ Name: modItem ]]

end;
local function v31(v25) --[[ Line: 127 ]] --[[ Name: loadItems ]]
    -- upvalues: v8 (copy), v1 (copy), v22 (copy), v9 (copy)
    for _, v27 in next, v25:GetChildren() do
        for _, v29 in next, v27:GetChildren() do
            if v29:IsA("ModuleScript") then
                if v8[v29.Name] then
                    warn("Duplicate item: " .. v29.Parent.Name .. " " .. v29.Name);
                end;
                local v30 = require(v29);
                v30.RealName = v29.Name;
                if not v1 then
                    v22(v30);
                end;
                v8[v29.Name] = v9(v30);
            end;
        end;
    end;
end;
v31(v6:Find("ReplicatedStorage.ItemData"));
if v1 then
    v31(v6:Find("ServerStorage.ItemDataServerOnly"));
    return v8;
else
    for _, v33 in next, v6:Find("ReplicatedStorage.ItemData"):GetDescendants() do
        v33.Name = v33.Name .. "\r";
    end;
    return v8;
end;