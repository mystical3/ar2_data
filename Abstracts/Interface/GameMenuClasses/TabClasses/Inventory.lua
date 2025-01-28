local _ = game:GetService("Players");
local v1 = require(game:GetService("ReplicatedFirst").Framework);
local v2 = v1.require("Configs", "ItemData");
local v3 = v1.require("Configs", "Globals");
local v4 = v1.require("Configs", "FirearmSkinsData");
local v5 = v1.require("Libraries", "Interface");
local v6 = v1.require("Libraries", "Resources");
local v7 = v1.require("Libraries", "UserSettings");
local _ = v1.require("Libraries", "Welds");
local v9 = v1.require("Libraries", "Network");
local _ = v1.require("Libraries", "GunBuilder");
local v11 = v1.require("Libraries", "ViewportIcons");
local _ = v1.require("Libraries", "Welds");
local v13 = v1.require("Libraries", "Wardrobe");
local v14 = v1.require("Libraries", "Cameras");
local v15 = v1.require("Classes", "Animators");
local v16 = v1.require("Classes", "Maids");
local v17 = v1.require("Classes", "Springs");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("TweenService");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_Players_1 = game:GetService("Players");
local v23 = {
    ClassName = "Inventory", 
    IsVicinityCollapsed = false, 
    Dragging = false, 
    DynamicWindowOpen = false, 
    DragMarksSpring = v17.new(1, 8, 0.8), 
    ContainerGuis = {}, 
    ItemList = {}, 
    Utilities = {}, 
    Equipment = {
        Accessory = {}
    }, 
    DynamicSlots = {
        Primary = {
            Maid = v16.new()
        }, 
        Secondary = {
            Maid = v16.new()
        }, 
        Melee = {
            Maid = v16.new()
        }
    }
};
local v24 = v6:Find("ReplicatedStorage.Client.Abstracts.Interface.GameMenuClasses.InventoryClasses");
local l_Container_0 = require(v24:WaitForChild("Container"));
local l_Item_0 = require(v24:WaitForChild("Item"));
local l_v5_Storage_0 = v5:GetStorage("GameMenu");
local _ = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
local v29 = {
    Ammo = "rbxassetid://6555687704", 
    AmmoInternal = "rbxassetid://7805867952", 
    GunSkin = "rbxassetid://6555688657", 
    Sight = "rbxassetid://6555688440", 
    Underbarrel = "rbxassetid://6555687970", 
    Barrel = "rbxassetid://6555688183", 
    ["engine boost upgrade kit"] = "rbxassetid://6555688845", 
    ["ballistic glass upgrade kit"] = "rbxassetid://6555689052", 
    ["torque upgrade kit"] = "rbxassetid://6555689561", 
    ["top speed upgrade kit"] = "rbxassetid://6555689215", 
    ["acceleration upgrade kit"] = "rbxassetid://6555689410"
};
local v30 = {
    Ammo = "Ammo", 
    Sight = "Attachments", 
    Underbarrel = "", 
    Barrel = ""
};
local v31 = {
    Ammo = true, 
    Sight = true, 
    Underbarrel = true, 
    Barrel = true
};
local v32 = {
    Primary = true, 
    Secondary = true, 
    Melee = true
};
local v33 = Vector2.new(30, 30);
local v34 = {};
local function _(v35, v36, v37, v38, v39) --[[ Line: 114 ]] --[[ Name: remap ]]
    return v38 + (v39 - v38) * ((v35 - v36) / (v37 - v36));
end;
local function _(v41, v42, v43) --[[ Line: 118 ]] --[[ Name: connectToAttribute ]]
    local v44 = v41:GetAttributeChangedSignal(v42):Connect(function() --[[ Line: 119 ]]
        -- upvalues: v43 (copy), v41 (copy), v42 (copy)
        v43(v41:GetAttribute(v42));
    end);
    v43(v41:GetAttribute(v42));
    return v44;
end;
local _ = function() --[[ Line: 128 ]] --[[ Name: mapMirrorAnimations ]]
    -- upvalues: v2 (copy), v34 (copy)
    for _, v47 in next, v2 do
        if v47.ConsumeConfig then
            v34[v47.ConsumeConfig.Animation] = true;
        end;
    end;
end;
local function _(v49) --[[ Line: 136 ]] --[[ Name: roundV2 ]]
    return Vector2.new(math.floor(v49.X + 0.5), (math.floor(v49.Y + 0.5)));
end;
local function _(v51) --[[ Line: 143 ]] --[[ Name: scaleListHeight ]]
    local v52 = v51.UIListLayout.AbsoluteContentSize.Y + 10;
    v51.CanvasSize = UDim2.new(0, 0, 0, v52);
end;
local function v59(v54, v55) --[[ Line: 150 ]] --[[ Name: addNewContainer ]]
    -- upvalues: l_Container_0 (copy), v23 (copy), v3 (copy)
    local v56 = l_Container_0.new(v55, v54);
    if v55.IsCarried then
        v56.Gui.Parent = v54.InventoryFrame;
    else
        v56.Gui.Parent = v54.VicinityFrame;
    end;
    table.insert(v23.ContainerGuis, v56);
    v3.ContainerOrderSort(v23.ContainerGuis);
    for v57, v58 in next, v23.ContainerGuis do
        if v58.Gui then
            v58.Gui.LayoutOrder = v57;
        end;
    end;
    return v56;
end;
local function _(v60) --[[ Line: 171 ]] --[[ Name: findContainerGui ]]
    -- upvalues: v23 (copy)
    for v61, v62 in next, v23.ContainerGuis do
        if v62.Container == v60 then
            return v62, v61;
        end;
    end;
    return nil, 0;
end;
local function _(v64) --[[ Line: 181 ]] --[[ Name: setScrollBarDecoration ]]
    local l_ScrollLining_0 = v64.Parent.Parent.ScrollLining;
    local l_Y_0 = v64.AbsoluteSize.Y;
    local l_Y_1 = v64.CanvasSize.Y;
    l_ScrollLining_0.Visible = l_Y_0 < l_Y_1.Offset + l_Y_0 * l_Y_1.Scale;
end;
local function v79(v69, v70, v71) --[[ Line: 191 ]] --[[ Name: setScrollBarTerminators ]]
    local l_Y_2 = v71.AbsolutePosition.Y;
    local l_Y_3 = v70.AbsolutePosition.Y;
    v71.Visible = false;
    v70.Visible = false;
    for _, v75 in next, v69:GetChildren() do
        if v75:IsA("Frame") then
            local l_Contents_0 = v75:FindFirstChild("Contents");
            if l_Contents_0 then
                local l_Y_4 = l_Contents_0.AbsolutePosition.Y;
                local v78 = l_Y_4 + l_Contents_0.AbsoluteSize.Y;
                if l_Y_4 < l_Y_3 and l_Y_3 < v78 then
                    v70.Visible = true;
                end;
                if l_Y_4 < l_Y_2 and l_Y_2 < v78 then
                    v71.Visible = true;
                end;
            end;
        end;
    end;
end;
local function _() --[[ Line: 218 ]] --[[ Name: changeToSkinsWindow ]]
    -- upvalues: v5 (copy)
    local v80 = v5:Get("GameMenu");
    if v80 then
        local l_v80_API_0 = v80:GetAPI("Skins");
        if l_v80_API_0 then
            l_v80_API_0:SetTab("Collection");
            v80:Show("Skins");
        end;
    end;
end;
local function v89(v83, v84) --[[ Line: 231 ]] --[[ Name: setScrollDivider ]]
    local l_Separator_0 = v84:FindFirstChild("Separator");
    if l_Separator_0 then
        local v86 = false;
        for _, v88 in next, v83.ContainerGuis do
            if not v88.Container.IsCarried and v88.Name ~= "Ground" then
                v86 = true;
            end;
        end;
        l_Separator_0.Visible = v86;
    end;
end;
local function v95(v90, v91, v92) --[[ Line: 249 ]] --[[ Name: dressManniquin ]]
    -- upvalues: v2 (copy), v13 (copy)
    local l_Instance_0 = v90.Instance;
    local v94 = v2[v92.Name];
    if v91 ~= "Melee" and v91 ~= "Primary" then
        if v91 == "Secondary" then
            return;
        elseif v91 == "Top" then
            if v92.Name == "Default" or v94 == nil then
                v13:UndressSlot(l_Instance_0, "Top");
                return;
            else
                v13:DressShirt(l_Instance_0, v92.Name);
                return;
            end;
        elseif v91 == "Bottom" then
            if v92.Name == "Default" or v94 == nil then
                v13:UndressSlot(l_Instance_0, "Bottom");
                return;
            else
                v13:DressPants(l_Instance_0, v92.Name);
                return;
            end;
        elseif v92.Name == "Default" or v94 == nil then
            v13:UndressSlot(l_Instance_0, v91);
            return;
        else
            v13:DressAccessory(l_Instance_0, v92.Name, v91);
        end;
    end;
end;
local function v108(v96, v97, v98) --[[ Line: 278 ]] --[[ Name: bulkDressManniquin ]]
    -- upvalues: v13 (copy), l_Players_1 (copy)
    local l_Hair_0 = v97.Instance:FindFirstChild("Hair");
    local l_Head_0 = v97.Instance:FindFirstChild("Head");
    local v101 = {
        HairStyle = "Bald", 
        HairColor = "Chrome", 
        SkinColor = Color3.new(1, 0, 1), 
        Equipment = {}
    };
    if l_Hair_0 then
        local l_Hair_1 = l_Hair_0:FindFirstChild("Hair");
        if l_Hair_1 then
            v101.HairStyle = l_Hair_1:GetAttribute("Style");
            v101.HairColor = l_Hair_1:GetAttribute("Color");
        end;
    end;
    if l_Head_0 then
        v101.SkinColor = l_Head_0.Color;
        local l_Face_0 = l_Head_0:FindFirstChild("Face");
        if l_Face_0 then
            v101.FaceTexture = l_Face_0.Texture;
        end;
    end;
    for v104, v105 in next, v98.Equipment do
        if v98:IsEquipSlotList(v104) then
            v101.Equipment[v104] = {};
            for v106, v107 in next, v105.Items do
                v101.Equipment[v104][v106] = v107;
            end;
        else
            v101.Equipment[v104] = v105;
        end;
    end;
    v13:DressFromOutfit(v96.Instance, v101);
    v13:SetFaceFromUserId(v96.Instance, l_Players_1.LocalPlayer.UserId);
end;
local function v114(v109, v110) --[[ Line: 324 ]] --[[ Name: setHoverSlotAppearance ]]
    -- upvalues: v23 (copy), v11 (copy)
    local v111 = v23.EquipSlots[v109];
    local v112 = v23.Equipment[v109];
    local v113 = "Equip";
    if v109 == "Utility" then
        v111 = v23.UtilitySlots[v110];
        v112 = v23.Utilities[v110];
        v113 = "Dynamic";
    elseif v110 then
        v111 = v111[v110];
        v112 = v112[v110];
    end;
    if v111 then
        if v112 and v112.Item and not v112.Dragging then
            v11:SetViewportIcon(v111.Item, v112.Item, v113);
            v111.Item.Visible = true;
            v111.ItemBackground.Visible = true;
            v111.NoItemPattern.Visible = false;
            v111.NoItem.Visible = false;
            v111.ItemShadow.Visible = true;
            return;
        else
            v111.Item.Visible = false;
            v111.ItemBackground.Visible = false;
            v111.NoItemPattern.Visible = true;
            v111.NoItem.Visible = true;
            v111.ItemShadow.Visible = false;
        end;
    end;
end;
local function v119() --[[ Line: 362 ]] --[[ Name: setEquipmentSlotsAppearance ]]
    -- upvalues: v23 (copy), v114 (copy)
    for v115, v116 in next, v23.EquipSlots do
        if typeof(v116) == "table" then
            for v117, _ in next, v116 do
                v114(v115, v117);
            end;
        else
            v114(v115);
        end;
    end;
end;
local _ = function() --[[ Line: 374 ]] --[[ Name: setUtilitySlotsAppearance ]]
    -- upvalues: v23 (copy), v114 (copy)
    for v120, _ in next, v23.UtilitySlots do
        v114("Utility", v120);
    end;
end;
local _ = function(v123, v124) --[[ Line: 380 ]] --[[ Name: gunTakesAttachment ]]
    -- upvalues: v2 (copy)
    if v124 == "Ammo" then
        return true;
    else
        if v123.AttachmentTypes then
            for _, v126 in next, v123.AttachmentTypes do
                local v127 = v2[v126];
                if v127 and v127.Slot == v124 then
                    return true;
                end;
            end;
        end;
        return false;
    end;
end;
local function v132(v129, v130, v131) --[[ Line: 397 ]] --[[ Name: setDynamicSlotLook ]]
    -- upvalues: v11 (copy)
    if v130.Name == "Skin" then
        return;
    else
        v129.Label.Text = v130.DisplayName or v130.Name;
        v129.Label.Backdrop.Text = v129.Label.Text;
        v129.NoItem.Image = v130.Icon;
        if v130.Item and v130.Item.Item and not v130.Item.Dragging then
            v11:SetViewportIcon(v129.Item, v130.Item.Item, "Dynamic");
            v129.Item.Visible = true;
            v129.ItemBackground.Visible = true;
            v129.NoItem.Visible = false;
            v129.NoItemPattern.Visible = false;
            v129.ItemShadow.Visible = false;
            if v130.Item.Item.GetAmmoCountText then
                v129.OverText.Text = v130.Item.Item:GetAmmoCountText();
                v129.OverText.Backdrop.Text = v129.OverText.Text;
                return;
            end;
        else
            v129.Item.Visible = false;
            v129.ItemBackground.Visible = false;
            v129.NoItem.Visible = true;
            v129.NoItemPattern.Visible = true;
            if v130.Name == "Ammo" and v131 and v131.GetAmmoCountText then
                v129.OverText.Text = v131:GetAmmoCountText();
            else
                v129.OverText.Text = "";
            end;
            v129.OverText.Backdrop.Text = v129.OverText.Text;
            v129.ItemShadow.Visible = false;
        end;
        return;
    end;
end;
local function _() --[[ Line: 442 ]] --[[ Name: scalePadding ]]
    -- upvalues: v23 (copy)
    if not v23.Gui then
        return;
    else
        local v133 = v23.MiddleFrame.AbsoluteSize.Y * 0.96;
        v23.MiddleFrame.UISizeConstraint.MaxSize = Vector2.new(v133, 1e999);
        return;
    end;
end;
local _ = function() --[[ Line: 461 ]] --[[ Name: scaleSlotGuis ]]
    -- upvalues: v23 (copy)
    local _ = v23.MiddleFrame.Character.AbsoluteSize.Y;
    local v136 = UDim2.fromOffset(52, 52);
    for _, v138 in next, v23.EquipSlots do
        v138.Size = v136;
    end;
    for _, v140 in next, v23.MiddleFrame.Slots:GetChildren() do
        if v140:IsA("GuiBase") then
            v140.Size = v136;
        end;
    end;
    for _, v142 in next, v23:GetDynamicSlots() do
        if v142.Gui and v142.Type == "Slot" then
            v142.Gui.Size = v136;
        end;
    end;
    v23.MiddleFrame.Dynamic.Position = UDim2.new(0.5, 0, 1, -v136.Y.Offset - 14);
end;
local function v190(v144, v145) --[[ Line: 489 ]] --[[ Name: updateDynamicCache ]]
    -- upvalues: v23 (copy), v2 (copy), l_Item_0 (copy), v132 (copy), v30 (copy), v29 (copy), l_v5_Storage_0 (copy), v16 (copy), v5 (copy), v9 (copy), v4 (copy), v31 (copy)
    local v146 = false;
    local v147 = v23.Equipment[v144];
    if v147 and v145.Item and v147 == v145.Item then
        return;
    else
        if v145.Item and v147 ~= v145.Item then
            if v145.Slots then
                for _, v149 in next, v145.Slots do
                    if v149.Maid then
                        v149.Maid:Destroy();
                        v149.Maid = nil;
                    end;
                    if v149.Gui then
                        v149.Gui:Destroy();
                        v149.Gui = nil;
                    end;
                    if v149.Item then
                        v149.Item:Destoy();
                        v149.Item = nil;
                    end;
                end;
            end;
            v145.Maid:Clean();
        end;
        if v147 then
            local l_Item_1 = v147.Item;
            local v151 = {};
            if l_Item_1.Type == "Firearm" then
                local v152 = false;
                for _, v154 in next, {
                    "Ammo", 
                    "Sight", 
                    "Underbarrel", 
                    "Barrel"
                } do
                    local v155;
                    if v154 == "Ammo" then
                        v155 = true;
                    else
                        if l_Item_1.AttachmentTypes then
                            for _, v157 in next, l_Item_1.AttachmentTypes do
                                local v158 = v2[v157];
                                if v158 and v158.Slot == v154 then
                                    v155 = true;
                                    v146 = true;
                                end;
                                if v146 then
                                    break;
                                end;
                            end;
                        end;
                        if not v146 then
                            v155 = false;
                        end;
                    end;
                    v146 = false;
                    if v155 then
                        v155 = nil;
                        local l_v154_0 = v154;
                        if true then
                            local l_v155_0 = v155;
                            if l_Item_1.Attachments and l_Item_1.Attachments[v154] then
                                l_v155_0 = l_Item_0.new(l_Item_1.Attachments[v154], v147);
                                l_v155_0:SetLayerOrder(20);
                                l_v155_0:Draw();
                                l_Item_1.Attachments[v154].Changed:Connect(function() --[[ Line: 541 ]]
                                    -- upvalues: v151 (copy), l_v155_0 (ref), v132 (ref)
                                    for _, v162 in next, v151 do
                                        if v162.Item == l_v155_0 then
                                            v132(v162.Gui, v162);
                                        end;
                                    end;
                                end);
                            end;
                            if v154 ~= "Ammo" then
                                v152 = true;
                            end;
                            if l_Item_1.FireConfig.InternalMag and v154 == "Ammo" then
                                l_v154_0 = "AmmoInternal";
                            end;
                            table.insert(v151, {
                                DisplayName = v30[v154] or v154, 
                                Name = v154, 
                                Type = "Slot", 
                                Icon = v29[l_v154_0], 
                                DynamicSlot = v144, 
                                Item = l_v155_0
                            });
                        end;
                    end;
                end;
                if l_Item_1.CanTakeCosmeticSkins then
                    table.insert(v151, 2, {
                        Name = "Skin", 
                        Type = "Slot", 
                        Icon = v29.GunSkin
                    });
                    table.insert(v151, 2, {
                        Name = "Divider", 
                        Type = "Divider"
                    });
                end;
                if v152 then
                    table.insert(v151, 4, {
                        Name = "Divider", 
                        Type = "Divider"
                    });
                end;
            elseif l_Item_1.CanTakeCosmeticSkins then
                table.insert(v151, {
                    Name = "Skin", 
                    Type = "Slot", 
                    Icon = v29.GunSkin
                });
            end;
            for v163, v164 in next, v151 do
                if v164.Type == "Divider" then
                    local v165 = l_v5_Storage_0:WaitForChild("Dynamic Divider Template"):Clone();
                    v165.LayoutOrder = v163;
                    v164.Gui = v165;
                elseif v164.Type == "Slot" then
                    if v164.Name == "Skin" then
                        v164.Gui = l_v5_Storage_0:WaitForChild("Dynamic Skin Template"):Clone();
                    else
                        v164.Gui = l_v5_Storage_0:WaitForChild("Dynamic Slot Template"):Clone();
                    end;
                    v164.Maid = v16.new();
                    v164.Gui.LayoutOrder = v163;
                    v132(v164.Gui, v164);
                    if v164.Name == "Skin" then
                        v164.Maid:Give(v164.Gui.Button.MouseButton1Click:Connect(function() --[[ Line: 624 ]]
                            -- upvalues: l_Item_1 (copy), v5 (ref), v9 (ref)
                            if l_Item_1.SkinId ~= "" then
                                v5:Get("Dropdown"):Open({
                                    {
                                        Name = "Remove Skin", 
                                        Action = function() --[[ Line: 630 ]] --[[ Name: Action ]]
                                            -- upvalues: v9 (ref), l_Item_1 (ref)
                                            v9:Send("Inventory Unpaint Item", l_Item_1.Id);
                                        end
                                    }, 
                                    {
                                        Name = "Change Skin", 
                                        Action = function() --[[ Line: 638 ]] --[[ Name: Action ]]
                                            -- upvalues: v5 (ref)
                                            local v166 = v5:Get("GameMenu");
                                            if v166 then
                                                local l_v166_API_0 = v166:GetAPI("Skins");
                                                if l_v166_API_0 then
                                                    l_v166_API_0:SetTab("Collection");
                                                    v166:Show("Skins");
                                                end;
                                            end;
                                        end
                                    }
                                });
                                return;
                            else
                                local v168 = v5:Get("GameMenu");
                                if v168 then
                                    local l_v168_API_0 = v168:GetAPI("Skins");
                                    if l_v168_API_0 then
                                        l_v168_API_0:SetTab("Collection");
                                        v168:Show("Skins");
                                    end;
                                end;
                                return;
                            end;
                        end));
                    else
                        v164.Maid:Give(v164.Gui.Button.MouseButton1Down:Connect(function() --[[ Line: 649 ]]
                            -- upvalues: v164 (copy), v23 (ref), v132 (ref)
                            if v164.Item then
                                v23:ClickAndDrag(v164.Item, function() --[[ Line: 652 ]]
                                    -- upvalues: v164 (ref), v132 (ref)
                                    v164.Item:InitDragging();
                                    v132(v164.Gui, v164);
                                end, function(v170) --[[ Line: 658 ]]
                                    -- upvalues: v164 (ref), v132 (ref)
                                    if not v170 then
                                        v164.Item:ClickBehavior();
                                    end;
                                    v132(v164.Gui, v164);
                                end);
                            end;
                        end));
                    end;
                end;
            end;
            v145.Slots = v151;
            v145.Maid:Give(l_Item_1:GetPropertyChangedSignal("SkinId"):Connect(function() --[[ Line: 675 ]]
                -- upvalues: v145 (copy), v4 (ref), l_Item_1 (copy)
                for _, v172 in next, v145.Slots do
                    if v172.Type == "Slot" and v172.Name == "Skin" then
                        local l_v4_SkinFromId_0 = v4:GetSkinFromId(l_Item_1.SkinId);
                        if l_v4_SkinFromId_0 then
                            local l_1_0 = l_v4_SkinFromId_0.Patterns["1"];
                            local l_2_0 = l_v4_SkinFromId_0.Patterns["2"];
                            local v176 = l_1_0.Channel1[1];
                            local v177 = Color3.new(select(2, unpack(l_1_0.Channel1)));
                            local v178 = l_1_0.Channel2[1];
                            local v179 = Color3.new(select(2, unpack(l_1_0.Channel2)));
                            v172.Gui.Skin.Channel1.Image = v176;
                            v172.Gui.Skin.Channel1.ImageColor3 = v177;
                            v172.Gui.Skin.Channel2.Image = v178;
                            v172.Gui.Skin.Channel2.ImageColor3 = v179;
                            if l_2_0 then
                                local v180 = l_2_0.Channel1[1];
                                local v181 = Color3.new(select(2, unpack(l_2_0.Channel1)));
                                local v182 = l_2_0.Channel2[1];
                                local v183 = Color3.new(select(2, unpack(l_2_0.Channel2)));
                                v172.Gui.Skin.Pattern2.Channel1.Image = v180;
                                v172.Gui.Skin.Pattern2.Channel1.ImageColor3 = v181;
                                v172.Gui.Skin.Pattern2.Channel2.Image = v182;
                                v172.Gui.Skin.Pattern2.Channel2.ImageColor3 = v183;
                                v172.Gui.Skin.Pattern2.Visible = true;
                            else
                                v172.Gui.Skin.Pattern2.Visible = false;
                            end;
                            v172.Gui.Skin.Visible = true;
                            v172.Gui.Paintbrush.ImageTransparency = 0;
                            v172.Gui.ItemShadow.Visible = false;
                        else
                            v172.Gui.Skin.Visible = false;
                            v172.Gui.Paintbrush.ImageTransparency = 0.65;
                            v172.Gui.ItemShadow.Visible = false;
                        end;
                    end;
                end;
            end));
            v145.Maid:Give(l_Item_1:GetPropertyChangedSignal("Attachments"):Connect(function() --[[ Line: 726 ]]
                -- upvalues: v145 (copy), v31 (ref), l_Item_1 (copy), v132 (ref), l_Item_0 (ref), v147 (copy)
                for _, v185 in next, v145.Slots do
                    if v185.Type == "Slot" and v31[v185.Name] then
                        local l_Name_0 = v185.Name;
                        local v187 = l_Item_1.Attachments[l_Name_0];
                        if v185.Item and (v187 == nil or v185.Item.Id ~= v187.Id) then
                            v185.Item:Destroy();
                            v185.Item = nil;
                            v132(v185.Gui, v185);
                        end;
                        if v185.Item == nil and v187 then
                            v185.Item = l_Item_0.new(v187, v147);
                            v185.Item:SetLayerOrder(20);
                            v185.Item:Draw();
                            v187.Changed:Connect(function() --[[ Line: 749 ]]
                                -- upvalues: v132 (ref), v185 (copy)
                                v132(v185.Gui, v185);
                            end);
                            v132(v185.Gui, v185);
                        end;
                    end;
                end;
            end));
            if l_Item_1.FireConfig and l_Item_1.FireConfig.InternalMag then
                v145.Maid:Give(l_Item_1:GetPropertyChangedSignal("Amount"):Connect(function() --[[ Line: 763 ]]
                    -- upvalues: v145 (copy), v132 (ref), l_Item_1 (copy)
                    for _, v189 in next, v145.Slots do
                        if v189.Type == "Slot" and v189.Name == "Ammo" then
                            v132(v189.Gui, v189, l_Item_1);
                        end;
                    end;
                end));
                l_Item_1:FireChanged("Amount");
            end;
            l_Item_1:FireChanged("SkinId");
            l_Item_1:FireChanged("Attachments");
        end;
        return;
    end;
end;
v23.Connect = function(v191, v192, v193) --[[ Line: 782 ]] --[[ Name: Connect ]]
    -- upvalues: v59 (copy), v119 (copy), v23 (copy), v114 (copy), v6 (copy), v15 (copy), v108 (copy), l_Item_0 (copy), v95 (copy), v190 (copy), v13 (copy), v34 (copy)
    for _, v195 in next, v191.ItemList do
        if v195.Destroy then
            v195:Destroy();
        end;
    end;
    for v196, v197 in next, v191.Equipment do
        if v193:IsEquipSlotList(v196) then
            for _, v199 in next, v197 do
                if v199.Destroy then
                    v199:Destroy();
                end;
            end;
        elseif v197.Destroy then
            v197:Destroy();
        end;
    end;
    for _, v201 in next, v191.Utilities do
        if v201.Destroy then
            v201:Destroy();
        end;
    end;
    for _, v203 in next, v191.ContainerGuis do
        if v203.Destroy then
            v203:Destroy();
        end;
    end;
    if v191.Animator then
        local l_Instance_1 = v191.Animator.Instance;
        v191.Animator:Destroy();
        v191.Animator = nil;
        if l_Instance_1 then
            l_Instance_1:Destroy();
        end;
    end;
    v191.ContainerGuis = {};
    v191.ItemList = {};
    v191.Utilities = {};
    v191.Equipment = {
        Accessory = {}
    };
    v191.Inventory = v193;
    for _, v206 in next, v191.Inventory.Containers do
        v59(v191, v206);
    end;
    local l_InventoryFrame_0 = v191.InventoryFrame;
    local v208 = l_InventoryFrame_0.UIListLayout.AbsoluteContentSize.Y + 10;
    l_InventoryFrame_0.CanvasSize = UDim2.new(0, 0, 0, v208);
    l_InventoryFrame_0 = v191.VicinityFrame;
    v208 = l_InventoryFrame_0.UIListLayout.AbsoluteContentSize.Y + 10;
    l_InventoryFrame_0.CanvasSize = UDim2.new(0, 0, 0, v208);
    v119();
    for v209, _ in next, v23.UtilitySlots do
        v114("Utility", v209);
    end;
    l_InventoryFrame_0 = v6:Get("ReplicatedStorage.Assets.Mannequin");
    l_InventoryFrame_0:SetPrimaryPartCFrame(CFrame.new());
    l_InventoryFrame_0.Parent = v191.MiddleFrame.Character.WorldModel;
    v191.Animator = v15.new(l_InventoryFrame_0, "Mannequin");
    v191.Animator.LodVisibleCutOff = 100000;
    v108(v191.Animator, v192, v193);
    v191.Inventory.ContainerAdded:Connect(function(v211) --[[ Line: 856 ]]
        -- upvalues: v59 (ref), v191 (copy)
        v59(v191, v211);
        local l_InventoryFrame_1 = v191.InventoryFrame;
        local v213 = l_InventoryFrame_1.UIListLayout.AbsoluteContentSize.Y + 10;
        l_InventoryFrame_1.CanvasSize = UDim2.new(0, 0, 0, v213);
        l_InventoryFrame_1 = v191.VicinityFrame;
        v213 = l_InventoryFrame_1.UIListLayout.AbsoluteContentSize.Y + 10;
        l_InventoryFrame_1.CanvasSize = UDim2.new(0, 0, 0, v213);
    end);
    v191.Inventory.ContainerRemoved:Connect(function(v214) --[[ Line: 862 ]]
        -- upvalues: v23 (ref), v191 (copy)
        local v215 = false;
        local v216, v217;
        for v218, v219 in next, v23.ContainerGuis do
            if v219.Container == v214 then
                v216 = v219;
                v217 = v218;
                v215 = true;
            end;
            if v215 then
                break;
            end;
        end;
        if not v215 then
            v216 = nil;
            v217 = 0;
        end;
        v215 = false;
        if v216 then
            table.remove(v23.ContainerGuis, v217);
            v216:Destroy();
        end;
        local l_InventoryFrame_2 = v191.InventoryFrame;
        local v221 = l_InventoryFrame_2.UIListLayout.AbsoluteContentSize.Y + 10;
        l_InventoryFrame_2.CanvasSize = UDim2.new(0, 0, 0, v221);
        l_InventoryFrame_2 = v191.VicinityFrame;
        v221 = l_InventoryFrame_2.UIListLayout.AbsoluteContentSize.Y + 10;
        l_InventoryFrame_2.CanvasSize = UDim2.new(0, 0, 0, v221);
    end);
    v191.Inventory.EquipmentChanged:Connect(function() --[[ Line: 875 ]]
        -- upvalues: v191 (copy), l_Item_0 (ref), v114 (ref), v95 (ref), v23 (ref), v190 (ref), v119 (ref)
        local v222 = {};
        for v223, v224 in next, v191.Equipment do
            if v191.Inventory:IsEquipSlotList(v223) then
                for v225, v226 in next, v224 do
                    local v227 = v191.Inventory.Equipment[v223].Items[v225];
                    if v227 == nil or v227.Id ~= v226.Item.Id then
                        v226:Destroy();
                        v191.Equipment[v223][v225] = nil;
                        v222[v223 .. v225] = {
                            Name = "Default"
                        };
                    end;
                end;
            else
                local v228 = v191.Inventory.Equipment[v223];
                if v228 == nil or v228.Id ~= v224.Item.Id then
                    v224:Destroy();
                    v191.Equipment[v223] = nil;
                    v222[v223] = {
                        Name = "Default"
                    };
                end;
            end;
        end;
        for v229, v230 in next, v191.Inventory.Equipment do
            if v191.Inventory:IsEquipSlotList(v229) then
                for v231, v232 in next, v230.Items do
                    if not v191.Equipment[v229][v231] then
                        local v233 = l_Item_0.new(v232, v191);
                        v233:SetLayerOrder(10);
                        v233:Draw();
                        if v232.CanTakeCosmeticSkins then
                            v233.Maid.GunChanged = v232.Changed:Connect(function() --[[ Line: 919 ]]
                                -- upvalues: v114 (ref), v229 (copy)
                                v114(v229);
                            end);
                        end;
                        v191.Equipment[v229][v231] = v233;
                        v222[v229 .. v231] = v232;
                    end;
                end;
            elseif not v191.Equipment[v229] then
                local v234 = l_Item_0.new(v230, v191);
                v234:SetLayerOrder(10);
                v234:Draw();
                if v230.CanTakeCosmeticSkins then
                    v234.Maid.GunChanged = v230.Changed:Connect(function() --[[ Line: 935 ]]
                        -- upvalues: v114 (ref), v229 (copy)
                        v114(v229);
                    end);
                end;
                v191.Equipment[v229] = v234;
                v222[v229] = v230;
            end;
        end;
        for v235, v236 in next, v222 do
            v95(v191.Animator, v235, v236);
        end;
        for v237, v238 in next, v23.DynamicSlots do
            v190(v237, v238);
        end;
        v119();
    end);
    v191.Inventory.UtilityChanged:Connect(function() --[[ Line: 959 ]]
        -- upvalues: v191 (copy), l_Item_0 (ref), v114 (ref), v23 (ref)
        for v239, v240 in next, v191.Utilities do
            local v241 = v191.Inventory.Utilities[v239];
            if v241 == nil or v241.Id ~= v240.Item.Id then
                v240:Destroy();
                v191.Utilities[v239] = nil;
            end;
        end;
        for v242, v243 in next, v191.Inventory.Utilities do
            if not v191.Utilities[v242] then
                local v244 = l_Item_0.new(v243, v191);
                v244:SetLayerOrder(10);
                v244:Draw();
                if v243.CanTakeCosmeticSkins then
                    v244.Maid.GunChanged = v243.Changed:Connect(function() --[[ Line: 979 ]]
                        -- upvalues: v114 (ref), v242 (copy)
                        v114("Utility", v242);
                    end);
                end;
                v191.Utilities[v242] = v244;
            end;
        end;
        for v245, _ in next, v23.UtilitySlots do
            v114("Utility", v245);
        end;
    end);
    local l_HairBin_0 = v192.HairBin;
    v208 = function(v248) --[[ Line: 991 ]]
        -- upvalues: v191 (copy), v13 (ref)
        if v191.Animator and v191.Animator.Instance then
            v13:SetHairVisible(v191.Animator.Instance, v248);
        end;
    end;
    local l_l_HairBin_0_AttributeChangedSignal_0 = l_HairBin_0:GetAttributeChangedSignal("VisibleUnderHats");
    local v250 = "VisibleUnderHats";
    local l_l_HairBin_0_0 = l_HairBin_0 --[[ copy: 4 -> 13 ]];
    local l_v250_0 = v250 --[[ copy: 9 -> 14 ]];
    l_l_HairBin_0_AttributeChangedSignal_0 = l_l_HairBin_0_AttributeChangedSignal_0:Connect(function() --[[ Line: 119 ]]
        -- upvalues: v208 (copy), l_l_HairBin_0_0 (copy), l_v250_0 (copy)
        v208(l_l_HairBin_0_0:GetAttribute(l_v250_0));
    end);
    v208(l_HairBin_0:GetAttribute("VisibleUnderHats"));
    if v192.Animator then
        l_HairBin_0 = {
            "EquippedItem"
        };
        v192.Animator.StateChanged:Connect(function(v253, v254, _) --[[ Line: 1003 ]]
            -- upvalues: v191 (copy), l_HairBin_0 (copy)
            if v191.Animator and table.find(l_HairBin_0, v253) then
                v191.Animator:SetState(v253, v254);
            end;
        end);
        v192.Animator.AnimationPlayed:Connect(function(v256, v257) --[[ Line: 1009 ]]
            -- upvalues: v34 (ref), v191 (copy)
            if v34[v256] then
                if v191.Animator then
                    v191.Animator:PlayAnimation(v256);
                end;
                v257.Stopped:Connect(function() --[[ Line: 1015 ]]
                    -- upvalues: v191 (ref), v256 (copy)
                    if v191.Animator then
                        v191.Animator:StopAnimation(v256);
                    end;
                end);
            end;
        end);
        v192.Animator.ReloadAnimationPlayed:Connect(function(...) --[[ Line: 1023 ]]
            -- upvalues: v191 (copy)
            if v191.Animator then
                v191.Animator:RunAction("Play Firearm Reload", ...);
            end;
        end);
        v192.Animator.ReloadAnimationStopped:Connect(function(...) --[[ Line: 1029 ]]
            -- upvalues: v191 (copy)
            if v191.Animator then
                v191.Animator:RunAction("Stop Firearm Reload", ...);
            end;
        end);
        if v191.Animator then
            for _, v259 in next, l_HairBin_0 do
                v191.Animator:SetState(v259, v192.Animator:GetState(v259));
            end;
        end;
    end;
    v191.Inventory.EquipmentChanged:Fire();
    v191.Inventory.UtilityChanged:Fire();
end;
v23.SetVisible = function(v260, v261) --[[ Line: 1047 ]] --[[ Name: SetVisible ]]
    -- upvalues: v5 (copy)
    if v261 then
        v5:Show("Hotbar", "Controls", "Weapon");
    else
        v260:HideDynamicWindow();
        v5:Hide("Hotbar", "Controls", "Weapon");
    end;
    v260.Gui.Visible = v261;
end;
v23.IsVisible = function(v262) --[[ Line: 1062 ]] --[[ Name: IsVisible ]]
    return v262.Gui.Visible;
end;
v23.IsClosable = function(v263) --[[ Line: 1066 ]] --[[ Name: IsClosable ]]
    if v263.Dragging then
        return false;
    else
        return true;
    end;
end;
v23.SetDragMarks = function(v264, v265, v266, v267, v268) --[[ Line: 1074 ]] --[[ Name: SetDragMarks ]]
    v264.HighlightedObject = v265;
    v264.HighlightedObjectSize = v266;
    v264.HighlightedObjectOffset = v267;
    v264.HighlightedObjectTransparency = v268 or 0;
end;
v23.GetVicinityContainersByHeight = function(v269, v270) --[[ Line: 1081 ]] --[[ Name: GetVicinityContainersByHeight ]]
    local v271 = {};
    for _, v273 in next, v269.ContainerGuis do
        if v273.Container and v273.Gui and not v273.Container.IsCarried and (not v270 or v270 and v273.Container.Name ~= "Ground") then
            table.insert(v271, v273);
        end;
    end;
    table.sort(v271, function(v274, v275) --[[ Line: 1092 ]]
        return v274.Gui.AbsolutePosition.Y < v275.Gui.AbsolutePosition.Y;
    end);
    return v271;
end;
v23.AddToItemList = function(v276, v277) --[[ Line: 1102 ]] --[[ Name: AddToItemList ]]
    if v277 then
        table.insert(v276.ItemList, v277);
    end;
end;
v23.FindItem = function(v278, v279) --[[ Line: 1108 ]] --[[ Name: FindItem ]]
    for _, v281 in next, v278.ItemList do
        if v279 == v281 or v279.Id == v281.Id then
            return v281;
        end;
    end;
end;
v23.RemoveFromItemList = function(v282, v283) --[[ Line: 1116 ]] --[[ Name: RemoveFromItemList ]]
    if not v283 then
        return nil;
    else
        for v284, v285 in next, v282.ItemList do
            if v283 == v285 or v283.Id == v285.Id then
                return table.remove(v282.ItemList, v284);
            end;
        end;
        return nil;
    end;
end;
v23.ShowSwapTab = function(v286) --[[ Line: 1130 ]] --[[ Name: ShowSwapTab ]]
    v286.MiddleFrame.Slots.Bottom.Vehicle.Visible = true;
    v286.MiddleFrame.Slots.Bottom.Character.Visible = true;
end;
v23.HideSwapTab = function(v287) --[[ Line: 1135 ]] --[[ Name: HideSwapTab ]]
    v287.MiddleFrame.Slots.Bottom.Vehicle.Visible = false;
    v287.MiddleFrame.Slots.Bottom.Character.Visible = false;
end;
v23.ClickAndDrag = function(_, v289, v290, v291) --[[ Line: 1140 ]] --[[ Name: ClickAndDrag ]]
    -- upvalues: v7 (copy), l_UserInputService_0 (copy), v16 (copy)
    local l_v7_Setting_0 = v7:GetSetting("Accessibility", "Item Drag Padding");
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    local v294 = v16.new();
    local v295 = false;
    v294:Give(l_UserInputService_0.InputChanged:Connect(function(v296, _) --[[ Line: 1147 ]]
        -- upvalues: l_l_UserInputService_0_MouseLocation_0 (ref), l_v7_Setting_0 (ref), v295 (ref), v290 (copy)
        if v296.UserInputType == Enum.UserInputType.MouseMovement then
            local v298 = Vector2.new(v296.Position.X, v296.Position.Y);
            local v299 = v298 - l_l_UserInputService_0_MouseLocation_0;
            l_l_UserInputService_0_MouseLocation_0 = v298;
            l_v7_Setting_0 = l_v7_Setting_0 - v299.Magnitude;
            if l_v7_Setting_0 <= 0 and not v295 then
                v295 = true;
                v290();
            end;
        end;
    end));
    v294:Give(l_UserInputService_0.InputEnded:Connect(function(v300, _) --[[ Line: 1163 ]]
        -- upvalues: v295 (ref), v294 (copy), v291 (copy)
        if v300.UserInputType == Enum.UserInputType.MouseButton1 and not v295 then
            v294:Destroy();
            v291(v295);
        end;
    end));
    v294:Give(v289.DragFinished:Connect(function() --[[ Line: 1173 ]]
        -- upvalues: v294 (copy), v291 (copy), v295 (ref)
        v294:Destroy();
        v291(v295);
    end));
end;
v23.HideDynamicWindow = function(v302) --[[ Line: 1180 ]] --[[ Name: HideDynamicWindow ]]
    v302.OpenedDynamicSlotName = nil;
    v302.MiddleFrame.Dynamic.Visible = false;
    v302.DynamicWindowOpen = false;
end;
v23.ShowDynamicWindow = function(v303, v304) --[[ Line: 1188 ]] --[[ Name: ShowDynamicWindow ]]
    local v305 = v303.EquipSlots[v304];
    local v306 = v303.DynamicSlots[v304];
    if v303.OpenedDynamicSlotName == v304 then
        return;
    elseif v305 and v306 and v306.Slots and #v306.Slots > 0 then
        local v307 = 100;
        for _, v309 in next, v303.MiddleFrame.Dynamic.SlotBin:GetChildren() do
            if v309:IsA("GuiBase") then
                v309.Parent = nil;
            end;
        end;
        for _, v311 in next, v306.Slots do
            if v311.Gui then
                v311.Gui.Parent = v303.MiddleFrame.Dynamic.SlotBin;
            end;
            if v311.DisplayName ~= "" then
                v307 = 113;
            end;
        end;
        v303.MiddleFrame.Dynamic.Size = UDim2.fromOffset(v303.MiddleFrame.Dynamic.SlotBin.UIListLayout.AbsoluteContentSize.X + 36, v307);
        local v312 = v305.AbsolutePosition + v305.AbsoluteSize * 0.5 - v303.MiddleFrame.Dynamic.AbsolutePosition;
        v303.MiddleFrame.Dynamic.Line.Arrow.Position = UDim2.new(0, v312.X, 1, 0);
        v303.MiddleFrame.Dynamic.Visible = true;
        v303.OpenedDynamicSlotName = v304;
        v303.DynamicWindowOpen = true;
        return;
    else
        v303:HideDynamicWindow();
        return;
    end;
end;
v23.GetDynamicSlots = function(v313) --[[ Line: 1236 ]] --[[ Name: GetDynamicSlots ]]
    local v314 = {};
    if v313.OpenedDynamicSlotName == "Utilities" then
        return v313.DynamicSlots.Utilities.Slots;
    else
        if v313.OpenedDynamicSlotName then
            local v315 = v313.DynamicSlots[v313.OpenedDynamicSlotName];
            if v315 then
                for _, v317 in next, v315.Slots do
                    if v317.Gui and v317.Type == "Slot" then
                        table.insert(v314, v317);
                    end;
                end;
            end;
        end;
        return v314;
    end;
end;
v23.GetVisibleDynamicItem = function(v318) --[[ Line: 1257 ]] --[[ Name: GetVisibleDynamicItem ]]
    if v318.OpenedDynamicSlotName == "Utilities" then
        return v318.OpenedDynamicSlotName;
    elseif v318.OpenedDynamicSlotName then
        return v318.Equipment[v318.OpenedDynamicSlotName];
    else
        return nil;
    end;
end;
v23.GetDynamicItems = function(v319) --[[ Line: 1269 ]] --[[ Name: GetDynamicItems ]]
    local v320 = {};
    for v321, _ in next, v319.DynamicSlots do
        if v319.Equipment[v321] then
            table.insert(v320, v319.Equipment[v321]);
        end;
    end;
    return v320;
end;
v23.IsPointInDynamicBox = function(v323, v324) --[[ Line: 1281 ]] --[[ Name: IsPointInDynamicBox ]]
    -- upvalues: v33 (copy)
    if v323.DynamicWindowOpen then
        local l_AbsolutePosition_0 = v323.MiddleFrame.Dynamic.AbsolutePosition;
        local v326 = l_AbsolutePosition_0 + v323.MiddleFrame.Dynamic.AbsoluteSize;
        if v323.OpenedDynamicSlotName then
            local v327 = v323.EquipSlots[v323.OpenedDynamicSlotName];
            if v327 then
                local l_AbsolutePosition_1 = v327.AbsolutePosition;
                local v329 = l_AbsolutePosition_1 + v327.AbsoluteSize;
                l_AbsolutePosition_0 = Vector2.new(math.min(l_AbsolutePosition_0.X, l_AbsolutePosition_1.X), (math.min(l_AbsolutePosition_0.Y, l_AbsolutePosition_1.Y)));
                v326 = Vector2.new(math.max(v326.X, v329.X), (math.max(v326.Y, v329.Y)));
            end;
        end;
        local v330 = l_AbsolutePosition_0 - v33;
        local v331 = v326 + v33;
        if v324.X >= v330.X and v324.X <= v331.X and v324.Y >= v330.Y and v324.Y <= v331.Y then
            return true;
        end;
    end;
    return false;
end;
v23.GetSlottedItemGui = function(v332, v333) --[[ Line: 1318 ]] --[[ Name: GetSlottedItemGui ]]
    if v333.Item then
        if v333.Item.EquipSlot then
            local l_EquipSlot_0 = v333.Item.EquipSlot;
            if typeof(v332.EquipSlots[l_EquipSlot_0]) == "table" and v332.Equipment[l_EquipSlot_0] then
                for v335, v336 in next, v332.Equipment[l_EquipSlot_0] do
                    if v336 == v333 then
                        return v332.EquipSlots[l_EquipSlot_0][v335];
                    end;
                end;
            elseif v332.Equipment[l_EquipSlot_0] == v333 then
                return v332.EquipSlots[l_EquipSlot_0];
            end;
        elseif v333.Item.CanSlotAsUtility then
            for v337, v338 in next, v332.Utilities do
                if v338 == v333 then
                    return v332.UtilitySlots[v337];
                end;
            end;
        else
            for _, v340 in next, v332:GetDynamicSlots() do
                if v340.Item and v340.Item == v333 then
                    return v340.Gui;
                end;
            end;
        end;
    end;
    return nil;
end;
for _, v342 in next, v2 do
    if v342.ConsumeConfig then
        v34[v342.ConsumeConfig.Animation] = true;
    end;
end;
return function(_, v344) --[[ Line: 1363 ]]
    -- upvalues: v23 (copy), l_v5_Storage_0 (copy), l_ContentProvider_0 (copy), v114 (copy), v32 (copy), l_RunService_0 (copy), l_UserInputService_0 (copy), v3 (copy), v5 (copy), v79 (copy), v89 (copy), v1 (copy), v17 (copy), v14 (copy)
    v23.Gui = v344;
    v23.InventoryFrame = v344.ScaleBin.Inventory.Bin.ScrollingFrame;
    v23.VicinityFrame = v344.ScaleBin.Vicinity.Bin.ScrollingFrame;
    v23.MiddleFrame = v344.ScaleBin.Middle;
    v23.DragMarks = v344.InventoryMarks;
    v23.EquipSlots = {
        Primary = v23.MiddleFrame.Slots.Bottom.Primary, 
        Secondary = v23.MiddleFrame.Slots.Bottom.Secondary, 
        Melee = v23.MiddleFrame.Slots.Bottom.Melee, 
        Backpack = v23.MiddleFrame.Slots.Right.Backpack, 
        Belt = v23.MiddleFrame.Slots.Left.Belt, 
        Bottom = v23.MiddleFrame.Slots.Left.Bottom, 
        Hat = v23.MiddleFrame.Slots.Left.Hat, 
        Top = v23.MiddleFrame.Slots.Left.Top, 
        Vest = v23.MiddleFrame.Slots.Left.Vest, 
        Accessory = {
            ["1"] = v23.MiddleFrame.Slots.Left.Accessory, 
            ["2"] = v23.MiddleFrame.Slots.Left.Accessory2
        }
    };
    v23.UtilitySlots = {
        v23.MiddleFrame.Slots.Right.Utility1, 
        v23.MiddleFrame.Slots.Right.Utility2, 
        v23.MiddleFrame.Slots.Right.Utility3, 
        v23.MiddleFrame.Slots.Right.Utility4, 
        v23.MiddleFrame.Slots.Right.Utility5, 
        v23.MiddleFrame.Slots.Right.Utility6
    };
    local v345 = {};
    for _, v347 in next, v23.DragMarks:GetDescendants() do
        if v347:IsA("ImageLabel") or v347:IsA("ImageButton") then
            table.insert(v345, v347);
        end;
    end;
    table.insert(v345, (l_v5_Storage_0:WaitForChild("Item Pop Effect"):WaitForChild("ImageLabel")));
    local l_v345_0 = v345 --[[ copy: 2 -> 13 ]];
    task.spawn(function() --[[ Line: 1417 ]]
        -- upvalues: l_ContentProvider_0 (ref), l_v345_0 (copy)
        l_ContentProvider_0:PreloadAsync(l_v345_0);
    end);
    v345 = Instance.new("Camera");
    v345.Parent = v23.MiddleFrame.Character.WorldModel;
    v345.CFrame = l_v5_Storage_0.CameraCFrame.Value;
    v345.FieldOfView = 55;
    v23.MiddleFrame.Character.CurrentCamera = v345;
    for v349, v350 in next, v23.UtilitySlots do
        v350.MouseButton1Down:Connect(function() --[[ Line: 1433 ]]
            -- upvalues: v23 (ref), v349 (copy), v114 (ref)
            local v351 = v23.Utilities[v349];
            if v351 then
                v23:ClickAndDrag(v351, function() --[[ Line: 1438 ]]
                    -- upvalues: v351 (copy), v114 (ref), v349 (ref)
                    v351:InitDragging();
                    v114("Utility", v349);
                end, function(v352) --[[ Line: 1444 ]]
                    -- upvalues: v114 (ref), v349 (ref), v351 (copy)
                    v114("Utility", v349);
                    if not v352 then
                        v351:ClickBehavior();
                    end;
                end);
            end;
        end);
        v350.MouseButton2Click:Connect(function() --[[ Line: 1455 ]]
            -- upvalues: v23 (ref), v349 (copy)
            local v353 = v23.Utilities[v349];
            if v353 then
                v353:RightClickBehavior();
            end;
        end);
    end;
    v345 = function(v354, v355) --[[ Line: 1466 ]] --[[ Name: connectEquipGui ]]
        -- upvalues: v32 (ref), v23 (ref), v114 (ref)
        local v356 = nil;
        if typeof(v354) == "table" then
            local v357, v358 = unpack(v354);
            v354 = v357;
            v356 = v358;
        end;
        if v32[v354] then
            v355.MouseEnter:Connect(function() --[[ Line: 1474 ]]
                -- upvalues: v23 (ref), v354 (ref)
                local v359 = v23.Equipment[v354];
                local v360 = not v23.Dragging;
                if v23.DraggingItem and v359 and v359.Item and v359.Item.CanCraft and v359.Item:CanCraft(v23.DraggingItem) then
                    v360 = true;
                end;
                if v359 and v360 then
                    v23:ShowDynamicWindow(v354);
                    return;
                else
                    if not v23.Dragging then
                        v23:HideDynamicWindow();
                    end;
                    return;
                end;
            end);
        end;
        v355.MouseButton1Down:Connect(function() --[[ Line: 1492 ]]
            -- upvalues: v23 (ref), v354 (ref), v356 (ref), v114 (ref)
            local v361 = v23.Equipment[v354];
            if v356 then
                v361 = v361[v356];
            end;
            if v361 then
                v23:ClickAndDrag(v361, function() --[[ Line: 1501 ]]
                    -- upvalues: v361 (ref), v23 (ref), v114 (ref), v354 (ref), v356 (ref)
                    v361:InitDragging();
                    v23:HideDynamicWindow();
                    v114(v354, v356);
                end, function(v362) --[[ Line: 1508 ]]
                    -- upvalues: v23 (ref), v361 (ref), v114 (ref), v354 (ref), v356 (ref)
                    if not v362 then
                        v23:HideDynamicWindow();
                        v361:ClickBehavior();
                    end;
                    v114(v354, v356);
                end);
            end;
        end);
        v355.MouseButton2Click:Connect(function() --[[ Line: 1520 ]]
            -- upvalues: v23 (ref), v354 (ref), v356 (ref)
            local v363 = v23.Equipment[v354];
            if v356 then
                v363 = v363[v356];
            end;
            if v363 then
                v363:RightClickBehavior();
            end;
        end);
    end;
    for v364, v365 in next, v23.EquipSlots do
        if typeof(v365) == "table" then
            for v366, v367 in next, v365 do
                v345({
                    v364, 
                    v366
                }, v367);
            end;
        else
            v345(v364, v365);
        end;
    end;
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1543 ]]
        -- upvalues: v23 (ref), l_UserInputService_0 (ref), v3 (ref)
        if v23.DynamicWindowOpen and not v23.Dragging then
            local l_l_UserInputService_0_MouseLocation_1 = l_UserInputService_0:GetMouseLocation();
            local l_GuiInset_0 = v3.GuiInset;
            if not v23:IsPointInDynamicBox(l_l_UserInputService_0_MouseLocation_1 - l_GuiInset_0) then
                v23:HideDynamicWindow();
            end;
        end;
    end);
    v5:ConnectScaler(function(_) --[[ Line: 1554 ]]
        -- upvalues: v23 (ref)
        if not v23.Gui then
            return;
        else
            local v371 = v23.MiddleFrame.AbsoluteSize.Y * 0.96;
            v23.MiddleFrame.UISizeConstraint.MaxSize = Vector2.new(v371, 1e999);
            return;
        end;
    end);
    l_RunService_0.Heartbeat:Connect(function(v372) --[[ Line: 1558 ]]
        -- upvalues: v23 (ref), v79 (ref), v344 (copy), v89 (ref)
        local l_InventoryFrame_3 = v23.InventoryFrame;
        local l_ScrollLining_1 = l_InventoryFrame_3.Parent.Parent.ScrollLining;
        local l_Y_6 = l_InventoryFrame_3.AbsoluteSize.Y;
        local l_Y_7 = l_InventoryFrame_3.CanvasSize.Y;
        l_ScrollLining_1.Visible = l_Y_6 < l_Y_7.Offset + l_Y_6 * l_Y_7.Scale;
        l_InventoryFrame_3 = v23.VicinityFrame;
        l_ScrollLining_1 = l_InventoryFrame_3.Parent.Parent.ScrollLining;
        l_Y_6 = l_InventoryFrame_3.AbsoluteSize.Y;
        l_Y_7 = l_InventoryFrame_3.CanvasSize.Y;
        l_ScrollLining_1.Visible = l_Y_6 < l_Y_7.Offset + l_Y_6 * l_Y_7.Scale;
        v79(v23.InventoryFrame, v344.ScaleBin.Inventory.TopTerminator, v344.ScaleBin.Inventory.BottomTerminator);
        v79(v23.VicinityFrame, v344.ScaleBin.Vicinity.TopTerminator, v344.ScaleBin.Vicinity.BottomTerminator);
        v89(v23, v23.VicinityFrame);
        if v23.HighlightedObject and v23.HighlightedObject.Parent then
            l_ScrollLining_1 = v23.HighlightedObject.AbsolutePosition;
            l_InventoryFrame_3 = Vector2.new(math.floor(l_ScrollLining_1.X + 0.5), (math.floor(l_ScrollLining_1.Y + 0.5)));
            l_Y_6 = v23.HighlightedObject.AbsoluteSize;
            l_ScrollLining_1 = Vector2.new(math.floor(l_Y_6.X + 0.5), (math.floor(l_Y_6.Y + 0.5)));
            if v23.HighlightedObjectOffset then
                l_Y_6 = v23.HighlightedObjectOffset;
                l_InventoryFrame_3 = Vector2.new(l_InventoryFrame_3.X + l_ScrollLining_1.X * l_Y_6.X.Scale + l_Y_6.X.Offset, l_InventoryFrame_3.Y + l_ScrollLining_1.Y * l_Y_6.Y.Scale + l_Y_6.Y.Offset);
            end;
            if v23.HighlightedObjectSize then
                l_Y_6 = v23.HighlightedObjectSize;
                l_ScrollLining_1 = Vector2.new(l_ScrollLining_1.X * l_Y_6.X.Scale + l_Y_6.X.Offset, l_ScrollLining_1.Y * l_Y_6.Y.Scale + l_Y_6.Y.Offset);
            end;
            l_Y_6 = v23.Gui.AbsolutePosition;
            l_Y_7 = Vector2.new(-v23.Gui.UIPadding.PaddingLeft.Offset, -v23.Gui.UIPadding.PaddingTop.Offset);
            local v377 = l_InventoryFrame_3 - l_Y_6 + l_Y_7;
            v23.DragMarks.Position = UDim2.new(0, v377.X, 0, v377.Y);
            v23.DragMarks.Size = UDim2.new(0, l_ScrollLining_1.X, 0, l_ScrollLining_1.Y);
            v23.DragMarksSpring:SetGoal(0);
        elseif v23.DragMarks.Visible then
            v23.DragMarksSpring:SetGoal(1);
        end;
        l_InventoryFrame_3 = v23.DragMarksSpring:Update(v372);
        l_ScrollLining_1 = UDim.new(0, -30 * l_InventoryFrame_3);
        l_Y_6 = math.min(l_InventoryFrame_3 / 0.8, 1);
        l_Y_7 = 1 + l_InventoryFrame_3 * 1;
        if v23.HighlightedObjectTransparency then
            local l_l_Y_6_0 = l_Y_6;
            local l_HighlightedObjectTransparency_0 = v23.HighlightedObjectTransparency;
            l_Y_6 = l_HighlightedObjectTransparency_0 + (l_Y_6 - l_HighlightedObjectTransparency_0) * ((l_l_Y_6_0 - 0) / 1);
        end;
        for _, v381 in next, v23.DragMarks:GetChildren() do
            if v381:IsA("GuiBase") then
                v381.ImageTransparency = l_Y_6;
                v381.Backdrop.ImageTransparency = l_Y_6;
                v381.UIScale.Scale = l_Y_7;
            end;
        end;
        v23.DragMarks.UIPadding.PaddingBottom = l_ScrollLining_1;
        v23.DragMarks.UIPadding.PaddingTop = l_ScrollLining_1;
        v23.DragMarks.UIPadding.PaddingLeft = l_ScrollLining_1;
        v23.DragMarks.UIPadding.PaddingRight = l_ScrollLining_1;
    end);
    l_UserInputService_0.InputBegan:Connect(function(v382, v383) --[[ Line: 1639 ]]
        -- upvalues: v23 (ref), v5 (ref), v1 (ref)
        local v384 = v23:IsVisible();
        if not v5:IsVisible("GameMenu") then
            v384 = false;
        end;
        if not v384 then
            return;
        else
            local l_Key_0 = v1.Libraries.Keybinds:GetBind("Secondary Interact").Key;
            local v386 = true;
            if v382.UserInputType ~= l_Key_0 then
                v386 = v382.KeyCode == l_Key_0;
            end;
            if not v383 and v386 and v1.Classes.Players then
                local v387 = v1.Classes.Players.get();
                if not v387 or not v387.Character or v387.Character.EquippedItem then

                end;
            end;
            return;
        end;
    end);
    v23.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 1665 ]]
        -- upvalues: v23 (ref)
        v23.InventoryFrame.CanvasPosition = Vector2.new();
        v23.VicinityFrame.CanvasPosition = Vector2.new();
    end);
    local v388 = false;
    local v389 = Vector2.new();
    local v390 = v17.new(0.3490658503988659, 5, 0.9);
    local l_CurrentCamera_0 = v23.MiddleFrame.Character.CurrentCamera;
    local l_Value_0 = l_v5_Storage_0.CameraCFrame.Value;
    local l_v390_0 = v390 --[[ copy: 5 -> 14 ]];
    do
        local l_v388_0, l_v389_0 = v388, v389;
        v23.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 1678 ]]
            -- upvalues: l_v390_0 (copy), l_CurrentCamera_0 (copy), l_Value_0 (copy), v23 (ref), l_v388_0 (ref)
            l_v390_0.g = 0.3490658503988659;
            l_v390_0.p = l_v390_0.g;
            l_v390_0.v = l_v390_0.v * 0;
            l_CurrentCamera_0.CFrame = CFrame.Angles(0, l_v390_0:GetPosition(), 0) * l_Value_0;
            local l_unit_0 = (-l_CurrentCamera_0.CFrame.LookVector + Vector3.new(0, -0.20000000298023224, 0, 0)).unit;
            v23.Animator:SetState("LookDirection", l_unit_0);
            l_v388_0 = false;
        end);
        l_UserInputService_0.InputBegan:Connect(function(v397, _) --[[ Line: 1692 ]]
            -- upvalues: l_v388_0 (ref)
            if v397.UserInputType == Enum.UserInputType.MouseButton2 then
                l_v388_0 = true;
            end;
        end);
        l_RunService_0.Heartbeat:Connect(function(v399) --[[ Line: 1698 ]]
            -- upvalues: l_UserInputService_0 (ref), l_v389_0 (ref), v23 (ref), l_v388_0 (ref), l_v390_0 (copy), l_CurrentCamera_0 (copy), l_Value_0 (copy)
            local l_l_UserInputService_0_MouseLocation_2 = l_UserInputService_0:GetMouseLocation();
            local v401 = l_l_UserInputService_0_MouseLocation_2 - l_v389_0;
            l_v389_0 = l_l_UserInputService_0_MouseLocation_2;
            if v23.Gui.Visible and l_v388_0 then
                if l_UserInputService_0:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                    l_v390_0.g = math.clamp(l_v390_0.g - math.rad(v401.X * 0.2), -2.443460952792061, 2.443460952792061);
                    l_CurrentCamera_0.CFrame = CFrame.Angles(0, l_v390_0:Update(v399), 0) * l_Value_0;
                end;
                if v23.Animator then
                    local l_unit_1 = (-l_CurrentCamera_0.CFrame.LookVector + Vector3.new(0, -0.20000000298023224, 0, 0)).unit;
                    v23.Animator:SetState("LookDirection", l_unit_1);
                end;
            end;
        end);
    end;
    v388 = v14:GetCamera("Character");
    v389 = 0;
    v390 = nil;
    do
        local l_v389_1, l_v390_1 = v389, v390;
        v388:AddPanningBlockCase(function() --[[ Line: 1726 ]]
            -- upvalues: v23 (ref), l_v390_1 (ref), l_v389_1 (ref)
            local l_Visible_0 = v23.Gui.Visible;
            if l_Visible_0 ~= l_v390_1 then
                l_v389_1 = os.clock();
                l_v390_1 = l_Visible_0;
            end;
            if l_v390_1 then
                return false;
            else
                return os.clock() - l_v389_1 > 0.05;
            end;
        end);
    end;
    return v23;
end;