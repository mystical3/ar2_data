local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Libraries", "Keybinds");
local v3 = v0.require("Libraries", "UserSettings");
local v4 = v0.require("Libraries", "Resources");
local l_v1_Storage_0 = v1:GetStorage("GameMenu");
local v6 = v4:Find("ReplicatedStorage.Client.Abstracts.Interface.GameMenuClasses.SettingsClasses");
local v7 = {};
local function v17(v8) --[[ Line: 17 ]] --[[ Name: buildKeybinds ]]
    -- upvalues: v2 (copy), l_v1_Storage_0 (copy), v6 (copy)
    local l_v2_BindsList_0 = v2:GetBindsList();
    local l_v2_DisplayOrder_0 = v2:GetDisplayOrder();
    for v11 = 1, #l_v2_DisplayOrder_0 do
        local v12 = l_v2_DisplayOrder_0[v11];
        local v13 = l_v2_BindsList_0[v12];
        local v14 = "Keybind";
        if not v13 and type(v12) == "table" then
            v12 = v12[1];
            v14 = "Header";
        end;
        local v15 = l_v1_Storage_0:WaitForChild("Settings " .. v14):Clone();
        v15.LayoutOrder = v11;
        v15.Parent = v8;
        require(v6:WaitForChild(v14))(v15, v12, v13);
    end;
    local l_Y_0 = v8.UIListLayout.AbsoluteContentSize.Y;
    v8.CanvasSize = UDim2.new(0, 0, 0, l_Y_0);
end;
local function v27(v18) --[[ Line: 42 ]] --[[ Name: buildSettings ]]
    -- upvalues: v3 (copy), l_v1_Storage_0 (copy), v6 (copy)
    local l_v3_DisplayOrder_0 = v3:GetDisplayOrder();
    local l_v3_SettingsList_0 = v3:GetSettingsList();
    for v21 = 1, #l_v3_DisplayOrder_0 do
        local v22 = l_v3_DisplayOrder_0[v21];
        local v23 = "Setting";
        local v24 = l_v3_SettingsList_0[v22];
        if not v24 and type(v22) == "table" then
            v22 = v22[1];
            v23 = "Header";
        end;
        local v25 = l_v1_Storage_0:WaitForChild("Settings " .. v23):Clone();
        v25.LayoutOrder = v21;
        v25.Parent = v18;
        require(v6:WaitForChild(v23))(v25, v22, v24);
    end;
    local l_Y_1 = v18.UIListLayout.AbsoluteContentSize.Y;
    v18.CanvasSize = UDim2.new(0, 0, 0, l_Y_1 + 5);
end;
v7.IsVisible = function(v28) --[[ Line: 70 ]] --[[ Name: IsVisible ]]
    return v28.Gui.Visible;
end;
v7.SetVisible = function(v29, v30) --[[ Line: 74 ]] --[[ Name: SetVisible ]]
    v29.Gui.Visible = v30;
end;
v7.IsClosable = function(_) --[[ Line: 78 ]] --[[ Name: IsClosable ]]
    -- upvalues: v2 (copy)
    if not v2:IsComplete() then
        return false;
    else
        return true;
    end;
end;
return function(_, v33) --[[ Line: 90 ]]
    -- upvalues: v7 (copy), v1 (copy), v2 (copy), v3 (copy), v17 (copy), v27 (copy)
    v7.Gui = v33;
    v7.KeybindsGui = v33.ScrollingFrame.Keybinds;
    v7.SettingsGui = v33.ScrollingFrame.Settings;
    v7.KeybindsGui.Reset.MouseButton1Click:Connect(function() --[[ Line: 105 ]]
        -- upvalues: v1 (ref), v2 (ref)
        v1:PlaySound("Interface.Click");
        v2:Reset();
    end);
    v7.SettingsGui.Reset.MouseButton1Click:Connect(function() --[[ Line: 110 ]]
        -- upvalues: v1 (ref), v3 (ref)
        v1:PlaySound("Interface.Click");
        v3:Reset();
    end);
    v2:BindToLoad(function() --[[ Line: 133 ]]
        -- upvalues: v17 (ref), v7 (ref)
        v17(v7.KeybindsGui.ScrollingFrame);
    end);
    v3:BindToLoaded(function() --[[ Line: 137 ]]
        -- upvalues: v27 (ref), v7 (ref)
        v27(v7.SettingsGui.ScrollingFrame);
    end);
    return v7;
end;