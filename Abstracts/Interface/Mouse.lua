local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("GuiService");
local l_RunService_0 = game:GetService("RunService");
local v6 = 0.5;
local v7 = 0;
local v8 = {
    Gui = v2:GetGui("Mouse")
};
v8.Grab = v8.Gui.Grab;
v8.Spinner = v8.Gui.Spinner;
v8.ForceMouseHide = false;
v8.SetIconVisible = function(v9, v10, v11) --[[ Line: 27 ]] --[[ Name: SetIconVisible ]]
    if v9[v10] then
        v9[v10].Visible = not not v11;
    end;
end;
v8.SetSpinnerRate = function(_, v13) --[[ Line: 33 ]] --[[ Name: SetSpinnerRate ]]
    -- upvalues: v6 (ref)
    v6 = v13;
end;
v8.ResetSpinner = function(_) --[[ Line: 37 ]] --[[ Name: ResetSpinner ]]
    -- upvalues: v7 (ref)
    v7 = 0;
end;
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 43 ]]
    -- upvalues: l_UserInputService_0 (copy), v2 (copy), v8 (copy)
    debug.profilebegin("Mouse UI Render step");
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    if v2:IsVisible("Reticle") then
        v8.Grab.Position = UDim2.new(0, 32, 0, 1);
    else
        v8.Grab.Position = UDim2.new(0.5, 0, 0.5, 0);
    end;
    v8.Gui.Position = UDim2.new(0, l_l_UserInputService_0_MouseLocation_0.X, 0, l_l_UserInputService_0_MouseLocation_0.Y);
    debug.profileend();
end);
l_RunService_0.Heartbeat:Connect(function(v16) --[[ Line: 60 ]]
    -- upvalues: v7 (ref), v6 (ref), v8 (copy), l_UserInputService_0 (copy), v2 (copy), v0 (copy)
    debug.profilebegin("Mouse UI Step");
    v7 = v7 + v16 / v6;
    v8.Spinner.Rotation = v7 % 1 * 360;
    if v8.Grab.Visible then
        l_UserInputService_0.MouseIconEnabled = false;
    elseif v2:IsVisible("GameMenu", "Map", "Dropdown") then
        l_UserInputService_0.MouseIconEnabled = true;
    else
        local v17 = v2:IsVisible("Reticle");
        local l_State_0 = v2:Get("Binoculars"):GetState();
        if v0.Classes.Players then
            local v19 = v0.Classes.Players.get();
            local v20 = v19 and v19.Character;
            if v20 then
                local l_EquippedItem_0 = v20.EquippedItem;
                if l_EquippedItem_0 and l_EquippedItem_0.Type == "Melee" then
                    v17 = true;
                end;
                if v20.AtEaseInput then
                    v17 = false;
                end;
            end;
        end;
        if v17 or l_State_0 then
            l_UserInputService_0.MouseIconEnabled = false;
        else
            l_UserInputService_0.MouseIconEnabled = true;
        end;
    end;
    if not v8.Gui.Visible then
        v8.Gui.Visible = true;
    end;
    if v8.ForceMouseHide then
        l_UserInputService_0.MouseIconEnabled = false;
    end;
    if not v2:GetMasterScreenGui().Enabled then
        l_UserInputService_0.MouseIconEnabled = false;
    end;
    debug.profileend();
end);
return v8;