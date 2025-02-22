local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Libraries", "Resources");
local v4 = v0.require("Classes", "Signals");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("RunService");
local l_GameMenuBlur_0 = game:GetService("Lighting"):WaitForChild("GameMenuBlur");
local v9 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local v10 = nil;
local v11 = {
    Gui = v1:GetGui("GameMenu"), 
    TabChanged = v4.new()
};
local v12 = {
    Inventory = v11.Gui.TopBar.Inventory, 
    Settings = v11.Gui.TopBar.Settings, 
    Journal = v11.Gui.TopBar.Journal, 
    Skins = v11.Gui.TopBar.Skins
};
local v13 = {};
local v14 = {
    "Inventory", 
    "Journal", 
    "Skins", 
    "Settings"
};
local v15 = 1;
local v16 = {};
local l_IconImages_0 = v1:Get("Controls"):GetIconImages();
local function v24() --[[ Line: 55 ]] --[[ Name: initTabClasses ]]
    -- upvalues: v3 (copy), v11 (copy), v13 (copy), v12 (copy)
    local v18 = v3:Find("ReplicatedStorage.Client.Abstracts.Interface.GameMenuClasses.TabClasses");
    local l_TabContent_0 = v11.Gui.TabContent;
    for _, v21 in next, v18:GetChildren() do
        local v22 = l_TabContent_0:WaitForChild(v21.Name);
        v22.Visible = false;
        local v23 = require(v21)(v11, v22);
        v13[v21.Name] = v23;
    end;
    if v13.Skins.EventTagged then
        v12.Skins.EventTag.Visible = true;
        return;
    else
        v12.Skins.EventTag.Visible = false;
        return;
    end;
end;
local function v27(v25) --[[ Line: 74 ]] --[[ Name: tweenBlur ]]
    -- upvalues: l_GameMenuBlur_0 (copy), v10 (ref), l_TweenService_0 (copy), v9 (copy)
    local l_Size_0 = l_GameMenuBlur_0.Size;
    if v10 and v10.PlaybackState == Enum.PlaybackState.Playing then
        v10:Cancel();
        l_GameMenuBlur_0.Size = l_Size_0;
    end;
    v10 = l_TweenService_0:Create(l_GameMenuBlur_0, v9, {
        Size = v25
    });
    v10:Play();
end;
local function v39(v28) --[[ Line: 86 ]] --[[ Name: setTab ]]
    -- upvalues: v11 (copy), v14 (copy), v13 (copy), v15 (ref), v12 (copy)
    if not v11:IsClosable() then
        return;
    else
        local l_v28_0 = v28;
        local l_v28_1 = v28;
        if typeof(v28) == "number" then
            if #v14 < l_v28_1 then
                l_v28_1 = 1;
            elseif l_v28_1 < 1 then
                l_v28_1 = #v14;
            end;
            l_v28_0 = v14[l_v28_1];
        elseif typeof(v28) == "string" then
            for v31, v32 in next, v14 do
                if v32 == v28 then
                    l_v28_1 = v31;
                    break;
                end;
            end;
        end;
        for v33, v34 in next, v13 do
            if v33 ~= l_v28_0 then
                v34:SetVisible(false);
            end;
        end;
        v13[l_v28_0]:SetVisible(true);
        v11.TabChanged:Fire(l_v28_0);
        v15 = l_v28_1;
        local l_Selector_0 = v11.Gui.TopBar.Selector;
        local v36 = v12[l_v28_0];
        l_Selector_0.Size = UDim2.new(0, math.abs(v36.AbsoluteSize.X) + 8, 0, 3);
        l_Selector_0.Position = UDim2.new(v36.Position.X.Scale, v36.Position.X.Offset - 4, 1, -1);
        for v37, v38 in next, v12 do
            if v37 == l_v28_0 then
                v38.ImageTransparency = 0;
            else
                v38.ImageTransparency = 0.65;
            end;
        end;
        return;
    end;
end;
local function _() --[[ Line: 145 ]] --[[ Name: closeCurrentTab ]]
    -- upvalues: v14 (copy), v15 (ref), v13 (copy)
    local v40 = v14[v15];
    if v40 then
        local v41 = v13[v40];
        if v41 then
            v41:SetVisible(false);
        end;
    end;
end;
v11.GetAPI = function(_, v44) --[[ Line: 159 ]] --[[ Name: GetAPI ]]
    -- upvalues: v13 (copy)
    return v13[v44];
end;
v11.Show = function(_, v46) --[[ Line: 163 ]] --[[ Name: Show ]]
    -- upvalues: v39 (copy), v1 (copy)
    v39(v46);
    v1:Show("GameMenu");
end;
v11.IsVisible = function(_, v48) --[[ Line: 169 ]] --[[ Name: IsVisible ]]
    -- upvalues: v1 (copy), v13 (copy)
    if v1:IsVisible("GameMenu") then
        return v13[v48]:IsVisible();
    else
        return false;
    end;
end;
v11.IsClosable = function(_) --[[ Line: 177 ]] --[[ Name: IsClosable ]]
    -- upvalues: v14 (copy), v15 (ref), v13 (copy)
    if not v13[v14[v15]]:IsClosable() then
        return false;
    else
        return true;
    end;
end;
for v50, v51 in next, v12 do
    v51.MouseButton1Click:Connect(function() --[[ Line: 191 ]]
        -- upvalues: v39 (copy), v50 (copy)
        v39(v50);
    end);
end;
v11.Gui.TopBar.Rules.MouseButton1Click:Connect(function() --[[ Line: 196 ]]
    -- upvalues: v1 (copy)
    v1:PlaySound("Interface.Click");
    v1:Show("Rules");
end);
v11.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 201 ]]
    -- upvalues: v11 (copy), v27 (copy), v2 (copy), v14 (copy), v15 (ref), v13 (copy)
    if v11.Gui.Visible then
        v27(30);
        return;
    else
        v2:Send("Inventory Container Group Disconnect");
        v2:Send("Ammo Movement Cancel");
        local v52 = v14[v15];
        if v52 then
            local v53 = v13[v52];
            if v53 then
                v53:SetVisible(false);
            end;
        end;
        v27(0);
        return;
    end;
end);
l_UserInputService_0.InputBegan:Connect(function(v54, _) --[[ Line: 214 ]]
    -- upvalues: v11 (copy), v16 (copy), l_IconImages_0 (copy)
    if not v11.Gui.Visible then
        return;
    else
        local v56 = v16[v54.KeyCode];
        if v56 then
            v56.Image = l_IconImages_0[v54.UserInputType].Down;
        end;
        return;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v57, _) --[[ Line: 236 ]]
    -- upvalues: v16 (copy), l_IconImages_0 (copy)
    local v59 = v16[v57.KeyCode];
    if v59 then
        v59.Image = l_IconImages_0[v57.UserInputType].Up;
    end;
end);
v1:ConnectScaler(function(_, _) --[[ Line: 244 ]]

end);
v1:AttachToTopbar(function(v62, _, v64) --[[ Line: 255 ]]
    -- upvalues: v11 (copy)
    if v64 then
        v11.Gui.TopBar.Position = UDim2.fromOffset(v62.X - 51, 3);
        v11.Gui.TopBar.Size = UDim2.new(1, 0, 0, 65);
        return;
    else
        v11.Gui.TopBar.Position = UDim2.new();
        v11.Gui.TopBar.Size = UDim2.new(1, 0, 0, 61);
        return;
    end;
end);
v24();
return v11;