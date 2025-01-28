local v0 = game:GetService("RunService"):IsServer();
local _ = nil;
local v2 = (if v0 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework)).require("Libraries", "Resources"):Find("ReplicatedStorage.ColorVariants");
local v3 = {};
local v4 = {};
local v5 = {};
v3.HasVariants = function(_, v7) --[[ Line: 26 ]] --[[ Name: HasVariants ]]
    -- upvalues: v4 (copy)
    if v4[v7] then
        return true;
    else
        return false;
    end;
end;
v3.GetVariants = function(_, v9) --[[ Line: 34 ]] --[[ Name: GetVariants ]]
    -- upvalues: v4 (copy), v5 (copy)
    local v10 = v4[v9];
    if v10 then
        return v5[v10];
    else
        return nil;
    end;
end;
for _, v12 in next, v2:GetChildren() do
    v5[v12.Name] = table.freeze(require(v12));
    for v13, _ in next, v5[v12.Name] do
        v4[v13] = v12.Name;
    end;
end;
return v3;