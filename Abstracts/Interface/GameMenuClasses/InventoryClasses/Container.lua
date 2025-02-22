local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "ItemData");
local _ = v0.require("Configs", "Globals");
local v3 = v0.require("Libraries", "Interface");
local v4 = v0.require("Libraries", "Resources");
local v5 = v0.require("Classes", "Signals");
local v6 = v0.require("Classes", "Maids");
local l_TextService_0 = game:GetService("TextService");
local l_v3_Storage_0 = v3:GetStorage("GameMenu");
local v9 = l_v3_Storage_0:WaitForChild("Container Template");
local v10 = l_v3_Storage_0:WaitForChild("Container VerticalLineTemplate");
local v11 = l_v3_Storage_0:WaitForChild("Container HorizontalLineTemplate");
local v12 = v4:Find("ReplicatedStorage.Chunking.Container Data");
local v13 = v4:Find("ReplicatedStorage.Client.Abstracts.Interface.GameMenuClasses.InventoryClasses.Item");
local v14 = require(v13);
local v15 = {};
v15.__index = v15;
local function _(v16, v17) --[[ Line: 29 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    return l_TextService_0:GetTextSize(v16, v17.TextSize, v17.Font, Vector2.new(1000, 200));
end;
local function _(v19) --[[ Line: 36 ]] --[[ Name: getContainerName ]]
    -- upvalues: v12 (copy)
    local l_v12_FirstChild_0 = v12:FindFirstChild(v19);
    if l_v12_FirstChild_0 then
        local l_DisplayName_0 = require(l_v12_FirstChild_0).DisplayName;
        if l_DisplayName_0 == "" then
            l_DisplayName_0 = v19;
        end;
        return l_DisplayName_0;
    else
        return v19;
    end;
end;
local function _(v23) --[[ Line: 52 ]] --[[ Name: findContainerName ]]
    -- upvalues: v12 (copy), v1 (copy)
    local l_Name_0 = v23.Name;
    local l_v12_FirstChild_1 = v12:FindFirstChild(l_Name_0);
    local v26;
    if l_v12_FirstChild_1 then
        local l_DisplayName_1 = require(l_v12_FirstChild_1).DisplayName;
        if l_DisplayName_1 == "" then
            l_DisplayName_1 = l_Name_0;
        end;
        v26 = l_DisplayName_1;
    else
        v26 = l_Name_0;
    end;
    if v1[v23.Name] and v1[v23.Name].DisplayName then
        v26 = v1[v23.Name].DisplayName;
    end;
    return v26 or "no name";
end;
local function v30(v29) --[[ Line: 62 ]] --[[ Name: scaleGui ]]
    v29.Contents.Size = UDim2.new(0, v29.Contents.Vertical.UIListLayout.AbsoluteContentSize.X, 0, v29.Contents.Horizontal.UIListLayout.AbsoluteContentSize.Y);
    v29.Size = UDim2.new(0, v29.Contents.Vertical.UIListLayout.AbsoluteContentSize.X + 15, 0, v29.UIListLayout.AbsoluteContentSize.Y);
    return v29.AbsoluteSize;
end;
local function v39(v31) --[[ Line: 76 ]] --[[ Name: newGui ]]
    -- upvalues: v9 (copy), v12 (copy), v1 (copy), v11 (copy), v10 (copy), v30 (copy), l_TextService_0 (copy)
    local v32 = v9:Clone();
    local l_Name_1 = v31.Name;
    local l_v12_FirstChild_2 = v12:FindFirstChild(l_Name_1);
    local v35;
    if l_v12_FirstChild_2 then
        local l_DisplayName_2 = require(l_v12_FirstChild_2).DisplayName;
        if l_DisplayName_2 == "" then
            l_DisplayName_2 = l_Name_1;
        end;
        v35 = l_DisplayName_2;
    else
        v35 = l_Name_1;
    end;
    if v1[v31.Name] and v1[v31.Name].DisplayName then
        v35 = v1[v31.Name].DisplayName;
    end;
    v32.Name = v35 or "no name";
    v32.LayoutOrder = 1;
    for v37 = 1, v31.SizeY + 1 do
        l_v12_FirstChild_2 = v11:Clone();
        l_v12_FirstChild_2.Name = tostring(v37);
        l_v12_FirstChild_2.LayoutOrder = v37;
        l_v12_FirstChild_2.Parent = v32.Contents.Horizontal;
    end;
    for v38 = 1, v31.SizeX + 1 do
        l_v12_FirstChild_2 = v10:Clone();
        l_v12_FirstChild_2.Name = tostring(v38);
        l_v12_FirstChild_2.LayoutOrder = v38;
        l_v12_FirstChild_2.Parent = v32.Contents.Vertical;
    end;
    v30(v32);
    v35 = v32.Name;
    l_Name_1 = v32.ContainerLabel.Label;
    v35 = l_TextService_0:GetTextSize(v35, l_Name_1.TextSize, l_Name_1.Font, Vector2.new(1000, 200)).X + 8;
    v32.ContainerLabel.Label.Text = v32.Name;
    v32.ContainerLabel.Label.Backdrop.Text = v32.Name;
    v32.ContainerLabel.Size = UDim2.new(0, v35, 0, 21);
    if v32.Name == "Pockets" then
        v32.ContainerLabel.Visible = false;
    end;
    return v32;
end;
local function v43(v40) --[[ Line: 115 ]] --[[ Name: cleanGuiList ]]
    for _, v42 in next, v40.ItemGuis do
        if not v40.Container.Occupants[v42.Id] then
            v40.ItemGuis[v42.Id] = nil;
            v42:Destroy();
        end;
    end;
end;
local function v49(v44, v45) --[[ Line: 125 ]] --[[ Name: rebuildGuiList ]]
    -- upvalues: v14 (copy)
    for _, v47 in next, v44.Container.Occupants do
        if not v44.ItemGuis[v47.Id] then
            local v48 = v14.new(v47, v44);
            v48.Gui.Parent = v44.ItemSlots;
            v48:SetLayerOrder(5);
            v48:Draw();
            if v45 then
                v48:PopEffect();
            end;
            v44.ItemGuis[v48.Id] = v48;
        end;
    end;
end;
v15.new = function(v50, v51) --[[ Line: 144 ]] --[[ Name: new ]]
    -- upvalues: v15 (copy), v39 (copy), v5 (copy), v6 (copy), v43 (copy), v49 (copy)
    local v52 = setmetatable({}, v15);
    v52.ClassName = "ContainerGui";
    v52.Id = v50.Id;
    v52.Name = v50.Name;
    v52.Type = v50.Type;
    v52.Container = v50;
    v52.Parent = v51;
    v52.SizeX = v50.Size[1];
    v52.SizeY = v50.Size[2];
    v52.Gui = v39(v52);
    v52.ItemSlots = v52.Gui.Contents.Items;
    v52.ItemGuis = {};
    v52.Expanded = v5.new();
    v52.Collapsed = v5.new();
    v52.Maid = v6.new();
    v50.Gui = v52;
    v52.Maid:Give(v52.Container.OccupantRemoved:Connect(function(_) --[[ Line: 169 ]]
        -- upvalues: v43 (ref), v52 (copy)
        v43(v52);
    end));
    v52.Maid:Give(v52.Container.OccupantAdded:Connect(function(_) --[[ Line: 173 ]]
        -- upvalues: v49 (ref), v52 (copy), v43 (ref)
        v49(v52, true);
        v43(v52);
    end));
    v52.Maid:Give(v52.Container.OccupantMoved:Connect(function() --[[ Line: 178 ]]
        -- upvalues: v49 (ref), v52 (copy), v43 (ref)
        v49(v52);
        v43(v52);
    end));
    v52.Maid:Give(v52.Container.GridRebuilt:Connect(function() --[[ Line: 183 ]]
        -- upvalues: v49 (ref), v52 (copy), v43 (ref)
        v49(v52, true);
        v43(v52);
    end));
    v49(v52);
    return v52;
end;
v15.Destroy = function(v55, _) --[[ Line: 199 ]] --[[ Name: Destroy ]]
    if v55.Maid then
        v55.Maid:Destroy();
        v55.Maid = nil;
    end;
    for _, v58 in next, v55.ItemGuis do
        if v58.Destroy then
            v58:Destroy();
        end;
    end;
    v55.ItemGuis = nil;
    if v55.Container then
        v55.Container.Gui = nil;
        v55.Container = nil;
    end;
    if v55.Gui then
        v55.Gui:Destroy();
        v55.Gui = nil;
    end;
    if v55.Expanded then
        v55.Expanded:Destroy();
        v55.Expanded = nil;
    end;
    if v55.Collapsed then
        v55.Collapsed:Destroy();
        v55.Collapsed = nil;
    end;
    v55.ItemSlots = nil;
    v55.Parent = nil;
    setmetatable(v55, nil);
end;
v15.SetGridSize = function(v59, v60) --[[ Line: 239 ]] --[[ Name: SetGridSize ]]
    -- upvalues: v30 (copy)
    v59.Gui.Contents.Horizontal.UIListLayout.Padding = UDim.new(0, v60);
    v59.Gui.Contents.Vertical.UIListLayout.Padding = UDim.new(0, v60);
    for _, v62 in next, v59.ItemGuis do
        v62:Draw();
    end;
    return (v30(v59.Gui));
end;
v15.IsEmpty = function(v63) --[[ Line: 250 ]] --[[ Name: IsEmpty ]]
    if v63.Container then
        return v63.Container:IsEmpty();
    else
        return nil;
    end;
end;
return v15;