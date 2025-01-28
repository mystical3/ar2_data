local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Libraries", "Resources");
local l_v1_Storage_0 = v1:GetStorage("MainMenu");
local v4 = v2:Find("ReplicatedStorage.Client.Abstracts.Interface.MainMenuClasses.SettingsClasses");
local v5 = {};
local v6 = false;
local function v17(v7) --[[ Line: 17 ]] --[[ Name: buildKeybinds ]]
    -- upvalues: v0 (copy), l_v1_Storage_0 (copy), v4 (copy)
    local l_Keybinds_0 = v0.Libraries.Keybinds;
    local l_l_Keybinds_0_DisplayOrder_0 = l_Keybinds_0:GetDisplayOrder();
    local l_l_Keybinds_0_BindsList_0 = l_Keybinds_0:GetBindsList();
    for v11 = 1, #l_l_Keybinds_0_DisplayOrder_0 do
        local v12 = l_l_Keybinds_0_DisplayOrder_0[v11];
        local v13 = l_l_Keybinds_0_BindsList_0[v12];
        local v14 = "Keybind";
        if not v13 and type(v12) == "table" then
            v12 = v12[1];
            v14 = "Header";
        end;
        local v15 = l_v1_Storage_0:WaitForChild("Settings " .. v14):Clone();
        v15.LayoutOrder = v11;
        v15.Parent = v7;
        require(v4:WaitForChild(v14))(v15, v12, v13);
    end;
    local l_Y_0 = v7.UIListLayout.AbsoluteContentSize.Y;
    v7.CanvasSize = UDim2.new(0, 0, 0, l_Y_0 + 5);
end;
local function v28(v18) --[[ Line: 44 ]] --[[ Name: buildSettings ]]
    -- upvalues: v0 (copy), l_v1_Storage_0 (copy), v4 (copy)
    local l_UserSettings_0 = v0.Libraries.UserSettings;
    local l_l_UserSettings_0_DisplayOrder_0 = l_UserSettings_0:GetDisplayOrder();
    local l_l_UserSettings_0_SettingsList_0 = l_UserSettings_0:GetSettingsList();
    for v22 = 1, #l_l_UserSettings_0_DisplayOrder_0 do
        local v23 = l_l_UserSettings_0_DisplayOrder_0[v22];
        local v24 = "Setting";
        local v25 = l_l_UserSettings_0_SettingsList_0[v23];
        if not v25 and type(v23) == "table" then
            v23 = v23[1];
            v24 = "Header";
        end;
        local v26 = l_v1_Storage_0:WaitForChild("Settings " .. v24):Clone();
        v26.LayoutOrder = v22;
        v26.Parent = v18;
        require(v4:WaitForChild(v24))(v26, v23, v25);
    end;
    local l_Y_1 = v18.UIListLayout.AbsoluteContentSize.Y;
    v18.CanvasSize = UDim2.new(0, 0, 0, l_Y_1 + 5);
end;
v5.IsVisible = function(v29) --[[ Line: 73 ]] --[[ Name: IsVisible ]]
    return v29.Gui.Visible;
end;
v5.IsClosable = function(_) --[[ Line: 77 ]] --[[ Name: IsClosable ]]
    -- upvalues: v0 (copy)
    if not v0.Libraries.Keybinds:IsComplete() then
        return false;
    else
        return true;
    end;
end;
v5.SetVisible = function(v31, v32, v33) --[[ Line: 85 ]] --[[ Name: SetVisible ]]
    -- upvalues: v6 (ref), v0 (copy), v17 (copy), v28 (copy)
    if v32 and not v6 then
        v0.Libraries.Keybinds:BindToLoad(function() --[[ Line: 87 ]]
            -- upvalues: v17 (ref), v31 (copy)
            v17(v31.Gui.ScrollingFrame.Keybinds.ScrollingFrame);
        end);
        v0.Libraries.UserSettings:BindToLoaded(function() --[[ Line: 91 ]]
            -- upvalues: v28 (ref), v31 (copy)
            v28(v31.Gui.ScrollingFrame.Settings.ScrollingFrame);
        end);
        v6 = true;
    end;
    if v32 then
        v33:SetBlur(30);
    end;
    v31.Gui.Visible = v32;
end;
v5.Start = function(_) --[[ Line: 105 ]] --[[ Name: Start ]]

end;
return function(_, v36) --[[ Line: 111 ]]
    -- upvalues: v5 (copy), v1 (copy), v0 (copy)
    v5.Gui = v36;
    v36.ScrollingFrame.Keybinds.Reset.MouseButton1Click:Connect(function() --[[ Line: 116 ]]
        -- upvalues: v1 (ref), v0 (ref)
        v1:PlaySound("Interface.Click");
        v0.Libraries.Keybinds:Reset();
    end);
    v36.ScrollingFrame.Settings.Reset.MouseButton1Click:Connect(function() --[[ Line: 121 ]]
        -- upvalues: v1 (ref), v0 (ref)
        v1:PlaySound("Interface.Click");
        v0.Libraries.UserSettings:Reset();
    end);
    return v5;
end;