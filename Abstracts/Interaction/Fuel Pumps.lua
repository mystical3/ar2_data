local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Libraries", "Resources");
local v2 = v0.require("Libraries", "Network");
local v3 = {};
v3.__index = v3;
local function v8(v4) --[[ Line: 13 ]] --[[ Name: prepModel ]]
    for _, v6 in next, v4.Instance:GetDescendants() do
        if v6:IsA("BasePart") then
            local l_CFrame_0 = v6.CFrame;
            v6.Transparency = 1;
            v6.Size = v6.Size * 1.2;
            v6.CFrame = l_CFrame_0;
        end;
    end;
end;
v3.new = function(v9, v10, _) --[[ Line: 27 ]] --[[ Name: new ]]
    -- upvalues: v8 (copy), v3 (copy)
    local v12 = {
        Type = "Fuel Pump", 
        Id = v9, 
        Instance = v10
    };
    v12.HomeCFrame = v12.Instance.PrimaryPart.CFrame;
    v8(v12);
    return (setmetatable(v12, v3));
end;
v3.Destroy = function(v13) --[[ Line: 46 ]] --[[ Name: Destroy ]]
    if v13.Destroyed then
        return;
    else
        v13.Destroyed = true;
        setmetatable(v13, nil);
        table.clear(v13);
        v13.Destroyed = true;
        return;
    end;
end;
v3.GetInteractionPosition = function(v14, _, _) --[[ Line: 59 ]] --[[ Name: GetInteractionPosition ]]
    local l_FirstChild_0 = v14.Instance:FindFirstChild("Interact Point");
    if l_FirstChild_0 then
        return l_FirstChild_0.Position;
    else
        return v14.BasePart.Position;
    end;
end;
v3.Interact = function(v18) --[[ Line: 69 ]] --[[ Name: Interact ]]
    -- upvalues: v2 (copy)
    v2:Send("World Interact", v18.Id);
end;
v3.SetDetailed = function(_, _) --[[ Line: 73 ]] --[[ Name: SetDetailed ]]

end;
return v3;