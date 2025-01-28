local v0 = require(game:GetService("ReplicatedFirst").Framework).require("Libraries", "Interface");
local l_RunService_0 = game:GetService("RunService");
local v2 = 3;
if l_RunService_0:IsStudio() then
    v2 = 0.2;
end;
local v3 = {
    Gui = v0:GetGui("Rules")
};
local l_v2_0 = v2;
local l_Controls_0 = v3.Gui.Controls;
local v6 = false;
local function _(v7, v8, v9) --[[ Line: 26 ]] --[[ Name: lerp ]]
    return v7 + (v8 - v7) * v9;
end;
l_Controls_0.Continue.MouseButton1Down:Connect(function() --[[ Line: 32 ]]
    -- upvalues: v6 (ref)
    v6 = true;
end);
l_Controls_0.Continue.MouseButton1Up:Connect(function() --[[ Line: 36 ]]
    -- upvalues: v6 (ref)
    v6 = false;
end);
l_Controls_0.Continue.MouseLeave:Connect(function() --[[ Line: 40 ]]
    -- upvalues: v6 (ref)
    v6 = false;
end);
l_RunService_0.Heartbeat:Connect(function(v11) --[[ Line: 44 ]]
    -- upvalues: v6 (ref), l_v2_0 (ref), v2 (ref), l_Controls_0 (copy), v0 (copy)
    if v6 then
        l_v2_0 = l_v2_0 - v11;
    else
        l_v2_0 = l_v2_0 + v11;
    end;
    l_v2_0 = math.clamp(l_v2_0, 0, v2);
    local v12 = 1 - math.clamp(l_v2_0 / v2, 0, 1);
    local v13 = v12 > 0 and 0.8 or 1;
    l_Controls_0.Progress.Fill.Size = UDim2.fromScale(v12, 1);
    local l_Progress_0 = l_Controls_0.Progress;
    local l_BackgroundTransparency_0 = l_Controls_0.Progress.BackgroundTransparency;
    l_Progress_0.BackgroundTransparency = l_BackgroundTransparency_0 + (v13 - l_BackgroundTransparency_0) * 0.3;
    if l_v2_0 <= 0 then
        v0:Hide("Rules");
    end;
end);
return v3;