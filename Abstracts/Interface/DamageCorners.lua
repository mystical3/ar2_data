local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Classes", "Springs");
local l_RunService_0 = game:GetService("RunService");
local v4 = v2.new(1, 10, 0.6);
local v5 = false;
local l_v5_0 = v5;
local v7 = nil;
local v8 = {
    Gui = v1:GetGui("DamageCorners")
};
local v9 = {
    v8.Gui:WaitForChild("BottomLeft"), 
    v8.Gui:WaitForChild("BottomRight"), 
    v8.Gui:WaitForChild("TopLeft"), 
    v8.Gui:WaitForChild("TopRight")
};
local _ = function(v10) --[[ Line: 33 ]] --[[ Name: setAll ]]
    -- upvalues: v9 (copy)
    for _, v12 in next, v9 do
        v12.ImageTransparency = v10;
    end;
end;
v8.Set = function(_, v15) --[[ Line: 41 ]] --[[ Name: Set ]]
    -- upvalues: v5 (ref)
    v5 = v15;
end;
l_RunService_0.Heartbeat:Connect(function(v16) --[[ Line: 47 ]]
    -- upvalues: v7 (ref), l_v5_0 (ref), v5 (ref), v4 (copy), v9 (copy)
    local v17 = os.clock() % 0.7;
    if v7 ~= nil and v7 >= v17 then
        l_v5_0 = v5;
    end;
    v7 = v17;
    if l_v5_0 then
        local v18 = 1 - (1 - v17 / 0.7) * 0.5;
        v4:SetGoal(v18);
    else
        v4:SetGoal(1);
    end;
    local v19 = v4:Update(v16);
    for _, v21 in next, v9 do
        v21.ImageTransparency = v19;
    end;
end);
v8.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 70 ]]
    -- upvalues: v8 (copy)
    v8.Gui.Visible = true;
end);
v8.Gui.Visible = true;
return v8;