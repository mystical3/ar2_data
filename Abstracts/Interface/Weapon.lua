local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Libraries", "ViewportIcons");
local v3 = v0.require("Libraries", "UserSettings");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TextService_0 = game:GetService("TextService");
local l_v1_Storage_0 = v1:GetStorage("Weapon");
local v7 = {
    Gui = v1:GetGui("Weapon")
};
local v8 = {};
local v9 = nil;
local v10 = nil;
local l_Lengths_0, v12 = v1:Get("Controls"):GetLengths();
local l_IconImages_0 = v1:Get("Controls"):GetIconImages();
local l_KeyAliases_0 = v1:Get("Controls"):GetKeyAliases();
local l_Template_0 = l_v1_Storage_0:WaitForChild("Template");
local l_IconTemplate_0 = l_v1_Storage_0:WaitForChild("IconTemplate");
local v17 = {
    Automatic = "AUTO", 
    Semiautomatic = "SEMI", 
    Burst = "BURST"
};
local _ = {
    ["Firing Mode"] = "ToolAction", 
    Reload = "Reload", 
    Aim = "Aim", 
    Fire = "UseItem", 
    Holster = "AtEase", 
    Shoulder = "ShoulderSwap"
};
local function _(v19, v20) --[[ Line: 49 ]] --[[ Name: isInTable ]]
    for v21, v22 in next, v19 do
        if v22 == v20 then
            return true, v21;
        end;
    end;
    return false, 0;
end;
local function v26() --[[ Line: 59 ]] --[[ Name: clearDrawList ]]
    -- upvalues: v8 (ref)
    for _, v25 in next, v8 do
        v25.Gui:Destroy();
    end;
    v8 = {};
end;
local function v43(v27, v28) --[[ Line: 67 ]] --[[ Name: makeDrawList ]]
    -- upvalues: v3 (copy), v26 (copy), v1 (copy), l_Template_0 (copy), l_TextService_0 (copy), l_IconTemplate_0 (copy), l_KeyAliases_0 (copy), l_IconImages_0 (copy), v12 (copy), l_Lengths_0 (copy), v7 (copy), v8 (ref)
    if v3:GetSetting("User Interface", "Combat Controls") == "Off" then
        v26();
        return;
    else
        local l_Binds_0 = v27.Binds;
        local v30 = {};
        local v31 = {};
        local v32 = v1:IsVisible("GameMenu");
        local v33 = v27.MoveState:find("Swimming");
        if v28 then
            if v28.Type == "Firearm" then
                if v32 then
                    table.insert(v30, {
                        "Reload", 
                        {
                            l_Binds_0.Reload
                        }
                    });
                else
                    table.insert(v30, {
                        "Fire", 
                        {
                            l_Binds_0.UseItem
                        }
                    });
                    table.insert(v30, {
                        "Aim", 
                        {
                            l_Binds_0.Aim
                        }
                    });
                    table.insert(v30, {
                        "Reload", 
                        {
                            l_Binds_0.Reload
                        }
                    });
                    if #v28.FireModes > 1 then
                        table.insert(v30, {
                            "Fire Mode", 
                            {
                                l_Binds_0.ToolAction
                            }
                        });
                    end;
                end;
            elseif v28.Type == "Melee" then
                table.insert(v30, {
                    "Attack", 
                    {
                        l_Binds_0.UseItem
                    }
                });
            end;
        end;
        if not v27.Sitting and not v27.Climbing and not v33 and not v32 and (v28 and v28.Type == "Melee" or not v28) then
            table.insert(v30, {
                "Shove", 
                {
                    l_Binds_0.Shove
                }
            });
        end;
        if not v28 and not v32 then
            if v27.Climbing and not v27.Dismounting then
                table.insert(v30, {
                    "Dismount", 
                    {
                        l_Binds_0.Jump
                    }
                });
                table.insert(v30, {
                    "Dismount Side", 
                    {
                        l_Binds_0.Left, 
                        l_Binds_0.Right
                    }
                });
            elseif not v27.Sitting then
                table.insert(v30, {
                    "Sprint", 
                    {
                        l_Binds_0.Sprint
                    }
                });
                table.insert(v30, {
                    "Crouch", 
                    {
                        l_Binds_0.Crouch
                    }
                });
            end;
            if not v27.Sitting then
                table.insert(v30, {
                    "Auto Run", 
                    {
                        l_Binds_0.AutoRun
                    }
                });
            end;
        end;
        for v34, v35 in next, v30 do
            local v36 = {
                Name = v35[1], 
                Binds = v35[2], 
                GuiBinds = {}
            };
            local v37 = 0;
            local v38 = l_Template_0:Clone();
            v38.LayoutOrder = v34;
            v38.TextLabel.Text = v36.Name;
            v38.TextLabel.Backdrop.Text = v36.Name;
            local l_X_0 = l_TextService_0:GetTextSize(v36.Name, v38.TextLabel.TextSize, v38.TextLabel.Font, Vector2.new(500, 25)).X;
            for v40, v41 in next, v36.Binds do
                local v42 = l_IconTemplate_0:Clone();
                v42.LayoutOrder = v40;
                v42.TextLabel.Text = l_KeyAliases_0[v41] or v41.Name;
                if v41.Name:find("MouseButton") then
                    v42.Image = l_IconImages_0[v41].Up;
                    v42.TextLabel.Text = "";
                    v42.Size = UDim2.new(0, v12, 0, 31);
                elseif #v42.TextLabel.Text > 1 then
                    v42.Size = UDim2.new(0, l_Lengths_0, 0, 31);
                else
                    v42.Size = UDim2.new(0, v12, 0, 31);
                end;
                v37 = v37 + v42.Size.X.Offset;
                v42.Parent = v38.Key;
                v36.GuiBinds[v41] = v42;
            end;
            v38.Box.Position = UDim2.new(0, v38.Key.UIListLayout.AbsoluteContentSize.X - 16, 0, 0);
            v38.TextLabel.Position = UDim2.new(0, v38.Key.UIListLayout.AbsoluteContentSize.X + 4, 0, 0);
            v38.Box.Size = UDim2.new(0, l_X_0 + 30, 1, 0);
            v38.Parent = v7.Gui.Controls;
            v36.Gui = v38;
            v31[v34] = v36;
        end;
        v26();
        v8 = v31;
        return;
    end;
end;
local function _(v44) --[[ Line: 177 ]] --[[ Name: isInputPressed ]]
    -- upvalues: l_UserInputService_0 (copy)
    if l_UserInputService_0:GetFocusedTextBox() then
        return false;
    elseif v44.Name:find("MouseButton") then
        return l_UserInputService_0:IsMouseButtonPressed(v44);
    else
        return l_UserInputService_0:IsKeyDown(v44 or Enum.KeyCode.World95);
    end;
end;
local function v52() --[[ Line: 189 ]] --[[ Name: highlightControls ]]
    -- upvalues: v8 (ref), l_IconImages_0 (copy), l_UserInputService_0 (copy)
    for _, v47 in next, v8 do
        for v48, v49 in next, v47.GuiBinds do
            local v50 = l_IconImages_0[v48];
            local v51 = "Up";
            if v48.EnumType == Enum.KeyCode then
                v50 = l_IconImages_0[Enum.UserInputType.Keyboard];
            end;
            if not l_UserInputService_0:GetFocusedTextBox() and if v48.Name:find("MouseButton") then l_UserInputService_0:IsMouseButtonPressed(v48) else l_UserInputService_0:IsKeyDown(v48 or Enum.KeyCode.World95) then
                v51 = "Down";
            end;
            v49.Image = v50[v51];
        end;
    end;
end;
v7.Refresh = function(v53, v54, _) --[[ Line: 210 ]] --[[ Name: Refresh ]]
    -- upvalues: v43 (copy), v9 (ref), v10 (ref), v17 (copy), v2 (copy)
    if not v54 then
        return;
    else
        local l_EquippedItem_0 = v54.EquippedItem;
        v53:Stop(v54);
        v43(v54, l_EquippedItem_0);
        v9 = v54;
        v10 = l_EquippedItem_0;
        local function v59() --[[ Line: 225 ]] --[[ Name: ammo ]]
            -- upvalues: l_EquippedItem_0 (copy), v53 (copy), v17 (ref)
            local v57 = 0;
            local l_v57_0 = v57;
            if l_EquippedItem_0 then
                if l_EquippedItem_0.Attachments and l_EquippedItem_0.Attachments.Ammo then
                    v57 = v57 + l_EquippedItem_0.Attachments.Ammo.WorkingAmount;
                    l_v57_0 = l_EquippedItem_0.Attachments.Ammo.Capacity;
                elseif l_EquippedItem_0.FireConfig and l_EquippedItem_0.FireConfig.InternalMag then
                    v57 = v57 + l_EquippedItem_0.WorkingAmount;
                    l_v57_0 = l_EquippedItem_0.FireConfig.InternalMagSize;
                end;
            end;
            v53.Gui.Frame.Ammo.Text = string.format("%d/%d", v57, l_v57_0);
            v53.Gui.Frame.Ammo.Backdrop.Text = v53.Gui.Frame.Ammo.Text;
            v53.Gui.Frame.Mode.TextLabel.Text = v17[l_EquippedItem_0.FireMode] or "";
            v53.Gui.Frame.Mode.TextLabel.Backdrop.Text = v53.Gui.Frame.Mode.TextLabel.Text;
            v53.Gui.Frame.Mode.ImageLabel.Visible = true;
            v53.Gui.Icon.Number.Text = l_EquippedItem_0.HotbarSlot or "";
            v53.Gui.Icon.Number.Backdrop.Text = l_EquippedItem_0.HotbarSlot or "";
        end;
        local function v71() --[[ Line: 251 ]] --[[ Name: magazines ]]
            -- upvalues: v54 (copy), l_EquippedItem_0 (copy), v53 (copy)
            local v60 = false;
            local v61 = 0;
            for _, v63 in next, v54.Inventory.Containers do
                if v63.IsCarried then
                    for _, v65 in next, v63.Occupants do
                        local l_MagazineTypes_0 = l_EquippedItem_0.MagazineTypes;
                        local l_Name_0 = v65.Name;
                        local v68;
                        for _, v70 in next, l_MagazineTypes_0 do
                            if v70 == l_Name_0 then
                                v68 = true;
                                v60 = true;
                            end;
                            if v60 then
                                break;
                            end;
                        end;
                        if not v60 then
                            v68 = false;
                        end;
                        v60 = false;
                        if v68 and (v65.Amount or 0) > 0 then
                            v61 = v61 + 1;
                        end;
                    end;
                end;
            end;
            v53.Gui.Frame.Magazines.TextLabel.Text = string.format("%d", v61);
            v53.Gui.Frame.Magazines.TextLabel.Backdrop.Text = v53.Gui.Frame.Magazines.TextLabel.Text;
        end;
        if l_EquippedItem_0 and l_EquippedItem_0.EquipSlot then
            if l_EquippedItem_0.Type == "Firearm" then
                v53.Ammo = l_EquippedItem_0.Changed:Connect(v59);
                v53.Magazines = v54.Inventory.InventoryChanged:Connect(v71);
                v53.RebuildIcon = l_EquippedItem_0.Changed:Connect(function() --[[ Line: 275 ]]
                    -- upvalues: v2 (ref), v53 (copy), l_EquippedItem_0 (copy)
                    v2:SetViewportIcon(v53.Gui.Icon.ViewportFrame, l_EquippedItem_0, "Hotbar");
                end);
                v53.Gui.Frame.Magazines.Visible = true;
                v53.Gui.Frame.Mode.Visible = true;
                v53.Gui.Frame.Gradient.Visible = true;
                v53.Gui.Frame.Cover.Visible = true;
                v53.Gui.Frame.LineTop.Size = UDim2.new(1, 40, 0, 1);
                v53.Gui.Frame.LineBottom.Size = UDim2.new(1, 40, 0, 1);
            else
                v53.Gui.Frame.Magazines.Visible = false;
                v53.Gui.Frame.Mode.Visible = false;
                v53.Gui.Frame.Gradient.Visible = false;
                v53.Gui.Frame.Cover.Visible = false;
                v53.Gui.Frame.LineTop.Size = UDim2.new(1, 0, 0, 1);
                v53.Gui.Frame.LineBottom.Size = UDim2.new(1, 0, 0, 1);
                v53.Gui.Frame.Ammo.Text = "Melee";
                v53.Gui.Frame.Ammo.Backdrop.Text = v53.Gui.Frame.Ammo.Text;
                v53.Gui.Icon.Number.Text = l_EquippedItem_0.HotbarSlot or "";
                v53.Gui.Icon.Number.Backdrop.Text = l_EquippedItem_0.HotbarSlot or "";
            end;
            v2:SetViewportIcon(v53.Gui.Icon.ViewportFrame, l_EquippedItem_0, "Hotbar");
            v53.Gui.Frame.Weapon.Text = l_EquippedItem_0.DisplayName;
            v53.Gui.Frame.Weapon.Backdrop.Text = l_EquippedItem_0.DisplayName;
            v53.Gui.Frame.Size = UDim2.new(0, math.max(130, v53.Gui.Frame.Weapon.TextBounds.X + 7), 0, 60);
            v53.Gui.Icon.Visible = true;
            v53.Gui.Frame.Visible = true;
            v53.Gui.Controls.Position = UDim2.new(0, 0, 1, -100);
        else
            v53.Gui.Icon.Visible = false;
            v53.Gui.Frame.Visible = false;
            v53.Gui.Controls.Position = UDim2.new(0, 0, 1, -25);
        end;
        if l_EquippedItem_0 and l_EquippedItem_0.Type == "Firearm" then
            v71();
            v59();
        end;
        return;
    end;
end;
v7.Stop = function(v72, _) --[[ Line: 323 ]] --[[ Name: Stop ]]
    -- upvalues: v26 (copy)
    if v72.Ammo then
        v72.Ammo:Disconnect();
        v72.Ammo = nil;
    end;
    if v72.Magazines then
        v72.Magazines:Disconnect();
        v72.Magazines = nil;
    end;
    if v72.RebuildIcon then
        v72.RebuildIcon:Disconnect();
        v72.RebuildIcon = nil;
    end;
    v72.Gui.Icon.Visible = false;
    v72.Gui.Frame.Visible = false;
    v72.Gui.Controls.Position = UDim2.new(0, 0, 1, -25);
    v26();
end;
l_UserInputService_0.InputBegan:Connect(function(_, v75) --[[ Line: 348 ]]
    -- upvalues: v52 (copy)
    if not v75 then
        v52();
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(_, v77) --[[ Line: 354 ]]
    -- upvalues: v52 (copy)
    if not v77 then
        v52();
    end;
end);
v1:ConnectScaler(function(_, _) --[[ Line: 360 ]]

end);
v3:BindToSetting("User Interface", "Combat Controls", function(v80) --[[ Line: 364 ]]
    -- upvalues: v7 (copy), v9 (ref), v26 (copy)
    if v80 == "On" then
        v7:Refresh(v9);
        return;
    else
        v26();
        return;
    end;
end);
return v7;