local v0 = require(game:GetService("ReplicatedFirst").Framework).require("Libraries", "Interface");
local l_RunService_0 = game:GetService("RunService");
local v2 = {
    Gui = v0:GetGui("Compass"):WaitForChild("Box")
};
v2.NorthEast = v2.Gui:WaitForChild("Bin"):WaitForChild("NorthEast");
v2.SouthWest = v2.Gui:WaitForChild("Bin"):WaitForChild("SouthWest");
v2.Update = function(_, _) --[[ Line: 20 ]] --[[ Name: Update ]]

end;
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 26 ]]
    -- upvalues: v2 (copy), v0 (copy)
    debug.profilebegin("Compass UI Step");
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local l_p_0 = l_CurrentCamera_0.CFrame.p;
    local l_unit_0 = ((Vector3.new(0, 0, -10000000, 0) - l_p_0) * Vector3.new(1, 0, 1, 0)).unit;
    local v8 = l_CurrentCamera_0.CFrame:vectorToObjectSpace(l_unit_0);
    local v9 = math.atan2(v8.X, -v8.Z) / 3.141592653589793;
    if v9 > 0 then
        v2.SouthWest.Position = UDim2.new(0, 229 - 748 * (1 - v9), 0, 0);
        v2.NorthEast.Position = v2.SouthWest.Position + UDim2.new(0, 748, 0, 0);
    else
        v2.NorthEast.Position = UDim2.new(0, 229 + 748 * v9, 0, 0);
        v2.SouthWest.Position = v2.NorthEast.Position + UDim2.new(0, 748, 0, 0);
    end;
    if v2.NorthEast.Position.X.Offset > 0 then
        v2.SouthWest.Position = v2.NorthEast.Position - UDim2.new(0, 748, 0, 0);
    end;
    if v2.SouthWest.Position.X.Offset > 0 then
        v2.NorthEast.Position = v2.SouthWest.Position - UDim2.new(0, 748, 0, 0);
    end;
    if v0:IsVisible("GameMenu") or v0:IsVisible("MedalQuest") then
        v2.Gui.Visible = false;
    else
        v2.Gui.Visible = true;
    end;
    debug.profileend();
end);
v0:ConnectScaler(function(_, _) --[[ Line: 63 ]]

end);
return v2;