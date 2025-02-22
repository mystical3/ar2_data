local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Configs", "ItemData");
local v3 = v0.require("Libraries", "Interface");
local _ = v0.require("Libraries", "Cameras");
local v5 = v0.require("Libraries", "Keybinds");
local v6 = v0.require("Libraries", "UserSettings");
local l_TextService_0 = game:GetService("TextService");
local _ = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_v3_Storage_0 = v3:GetStorage("Controls");
local v11 = {};
local v12 = nil;
local v13 = {
    Gui = v3:GetGui("Controls")
};
local l_Template_0 = l_v3_Storage_0:WaitForChild("Template");
local l_IconTemplate_0 = l_v3_Storage_0:WaitForChild("IconTemplate");
local v16 = {
    [Enum.UserInputType.Keyboard] = {
        Up = "rbxassetid://545326522", 
        Down = "rbxassetid://915913507"
    }, 
    [Enum.UserInputType.MouseButton1] = {
        Up = "rbxassetid://545537722", 
        Down = "rbxassetid://916631011"
    }, 
    [Enum.UserInputType.MouseButton2] = {
        Up = "rbxassetid://545537797", 
        Down = "rbxassetid://916631128"
    }
};
local function v19() --[[ Line: 54 ]] --[[ Name: clearDrawList ]]
    -- upvalues: v11 (ref)
    for _, v18 in next, v11 do
        v18.Gui:Destroy();
    end;
    v11 = {};
end;
local function _(v20) --[[ Line: 62 ]] --[[ Name: isInputPressed ]]
    -- upvalues: l_UserInputService_0 (copy)
    if l_UserInputService_0:GetFocusedTextBox() then
        return false;
    elseif v20.Name:find("MouseButton") then
        return l_UserInputService_0:IsMouseButtonPressed(v20);
    else
        return l_UserInputService_0:IsKeyDown(v20 or Enum.KeyCode.World95);
    end;
end;
local function v28() --[[ Line: 74 ]] --[[ Name: highlightControls ]]
    -- upvalues: v11 (ref), v16 (copy), l_UserInputService_0 (copy)
    for _, v23 in next, v11 do
        for v24, v25 in next, v23.GuiBinds do
            local v26 = v16[v24];
            local v27 = "Up";
            if v24.EnumType == Enum.KeyCode then
                v26 = v16[Enum.UserInputType.Keyboard];
            end;
            if not l_UserInputService_0:GetFocusedTextBox() and if v24.Name:find("MouseButton") then l_UserInputService_0:IsMouseButtonPressed(v24) else l_UserInputService_0:IsKeyDown(v24 or Enum.KeyCode.World95) then
                v27 = "Down";
            end;
            v25.Image = v26[v27];
        end;
    end;
end;
v13.Refresh = function(_, v30) --[[ Line: 95 ]] --[[ Name: Refresh ]]
    -- upvalues: v6 (copy), v19 (copy), v3 (copy), v5 (copy), v0 (copy), v2 (copy), l_Template_0 (copy), l_TextService_0 (copy), l_IconTemplate_0 (copy), v1 (copy), v16 (copy), v13 (copy), v11 (ref), v12 (ref)
    if v30 == nil or v6:GetSetting("User Interface", "Character Controls") == "Off" then
        v19();
        return;
    else
        local l_Binds_0 = v30.Binds;
        local v32 = {};
        local v33 = {};
        local v34 = 0;
        local function v40(v35, v36) --[[ Line: 107 ]] --[[ Name: tryPerk ]]
            -- upvalues: v30 (copy), v32 (copy)
            if v30:HasPerk(v35) then
                local _, v38 = v30:HasPerk(v35, true);
                local l_v35_0 = v35;
                if v38 then
                    l_v35_0 = v38.DisplayName or v38.Name;
                end;
                table.insert(v32, {
                    l_v35_0, 
                    v36
                });
            end;
        end;
        if v3:IsVisible("GameMenu") then
            if v6:GetSetting("Accessibility", "Quick Move Behavior") == "Legacy" then
                table.insert(v32, {
                    "Organize", 
                    {
                        Enum.UserInputType.MouseButton1, 
                        Enum.KeyCode.LeftShift
                    }
                });
            else
                table.insert(v32, {
                    "Organize", 
                    {
                        Enum.UserInputType.MouseButton1
                    }
                });
            end;
            table.insert(v32, {
                "Actions", 
                {
                    Enum.UserInputType.MouseButton2
                }
            });
            table.insert(v32, {
                "Rotate Item", 
                {
                    Enum.UserInputType.MouseButton1, 
                    Enum.KeyCode.R
                }
            });
            local v41 = {};
            local l_EquippedItem_0 = v30.EquippedItem;
            local l_v5_Bind_0 = v5:GetBind("Secondary Interact");
            if l_v5_Bind_0 and l_v5_Bind_0.Key then
                l_v5_Bind_0 = l_v5_Bind_0.Key;
            end;
            if l_EquippedItem_0 and (l_EquippedItem_0.Type == "Firearm" or l_EquippedItem_0.Type == "Melee") and l_v5_Bind_0 then
                table.insert(v41, l_v5_Bind_0);
            else
                table.insert(v41, l_Binds_0.Inventory);
            end;
            table.insert(v32, {
                "Close Inventory", 
                v41
            });
        elseif v30.Sitting then
            if v30.IsVehicleDriver and v30.Vehicle then
                local v44 = v0.Classes.VehicleControler.get(v30.Vehicle);
                if v44 then
                    if v44:HasLights() then
                        table.insert(v32, {
                            "Lights", 
                            {
                                v5:GetBind("Vehicle Lights").Key
                            }
                        });
                    end;
                    if v44:HasHorn() then
                        table.insert(v32, {
                            "Horn", 
                            {
                                v5:GetBind("Vehicle Horn").Key
                            }
                        });
                    end;
                    if v44:HasSiren() then
                        local l_v5_Bind_1 = v5:GetBind("Vehicle Siren");
                        local l_v5_Bind_2 = v5:GetBind("Vehicle Siren 2");
                        table.insert(v32, {
                            "Siren", 
                            {
                                l_v5_Bind_1.Key, 
                                l_v5_Bind_2.Key
                            }
                        });
                    end;
                    table.insert(v32, {
                        "Auto Drive", 
                        {
                            l_Binds_0.AutoRun
                        }
                    });
                end;
            end;
            v40("Map", {
                l_Binds_0.MapToggle
            });
            table.insert(v32, {
                "Dismount", 
                {
                    l_Binds_0.Jump
                }
            });
        elseif v3:IsVisible("Map") then
            local l_Key_0 = v5:GetBind("Zoom Map In").Key;
            local l_Key_1 = v5:GetBind("Zoom Map Out").Key;
            table.insert(v32, {
                "Drag", 
                {
                    Enum.UserInputType.MouseButton1
                }
            });
            table.insert(v32, {
                "Close", 
                {
                    l_Binds_0.MapToggle
                }
            });
            table.insert(v32, {
                "Zoom In", 
                {
                    l_Key_0
                }
            });
            table.insert(v32, {
                "Zoom Out", 
                {
                    l_Key_1
                }
            });
        else
            local l_EquippedItem_1 = v30.EquippedItem;
            local l_Key_2 = v5:GetBind("Secondary Interact").Key;
            if v30.BinocularsEnabled == "" then
                if l_EquippedItem_1 and (l_EquippedItem_1.Type == "Firearm" or l_EquippedItem_1.Type == "Melee") and l_Key_2 then
                    table.insert(v32, {
                        "Interact", 
                        {
                            l_Key_2
                        }
                    });
                else
                    table.insert(v32, {
                        "Interact", 
                        {
                            l_Binds_0.UseItem
                        }
                    });
                end;
            end;
            v40("Map", {
                l_Binds_0.MapToggle
            });
            v40("Flashlight", {
                l_Binds_0.Flashlight
            });
            v40("Binoculars", {
                l_Binds_0.Binoculars
            });
            if v30.BinocularsEnabled ~= "" then
                local v51 = v2[v30.BinocularsEnabled];
                local v52 = "Action";
                if v51 and v51.EnableActionName then
                    v52 = v51.EnableActionName;
                end;
                table.insert(v32, {
                    v52, 
                    {
                        Enum.UserInputType.MouseButton1
                    }
                });
            end;
            table.insert(v32, {
                "Inventory", 
                {
                    l_Binds_0.Inventory
                }
            });
            if l_EquippedItem_1 and l_EquippedItem_1.Type == "Firearm" and v30.BinocularsEnabled == "" then
                table.insert(v32, {
                    "Holster", 
                    {
                        l_Binds_0.AtEase
                    }
                });
            end;
        end;
        for v53, v54 in next, v32 do
            local v55 = {
                Name = v54[1], 
                Binds = v54[2], 
                GuiBinds = {}
            };
            local v56 = 0;
            local v57 = l_Template_0:Clone();
            v57.LayoutOrder = v53;
            v57.TextLabel.Text = v55.Name;
            v57.TextLabel.Backdrop.Text = v55.Name;
            local l_X_0 = l_TextService_0:GetTextSize(v55.Name, v57.TextLabel.TextSize, v57.TextLabel.Font, Vector2.new(500, 25)).X;
            v57.Box.Size = UDim2.new(0, -l_X_0 - 23, 1, 0);
            for v59, v60 in next, v55.Binds do
                local v61 = l_IconTemplate_0:Clone();
                v61.LayoutOrder = v59;
                v61.TextLabel.Text = v1.KeyAliases[v60] or v60.Name;
                if v60.Name:find("MouseButton") then
                    v61.Image = v16[v60].Up;
                    v61.TextLabel.Text = "";
                    v61.Size = UDim2.new(0, 31, 0, 31);
                elseif #v61.TextLabel.Text > 1 then
                    v61.Size = UDim2.new(0, 90, 0, 31);
                else
                    v61.Size = UDim2.new(0, 31, 0, 31);
                end;
                v56 = v56 + v61.Size.X.Offset;
                v61.Parent = v57.Key;
                v55.GuiBinds[v60] = v61;
            end;
            v57.Name = v55.Name;
            v57.Parent = v13.Gui;
            v55.Gui = v57;
            v34 = math.max(v34, v56 + (#v55.Binds - 1) * v57.Key.UIListLayout.Padding.Offset);
            v33[v53] = v55;
        end;
        v13.Gui.Position = UDim2.new(1, -125 - math.max(0, v34 - 90), 1, -40);
        v19();
        v11 = v33;
        v12 = v30;
        return;
    end;
end;
v13.GetIconImages = function(_) --[[ Line: 281 ]] --[[ Name: GetIconImages ]]
    -- upvalues: v16 (copy)
    return v16;
end;
v13.GetKeyAliases = function(_) --[[ Line: 285 ]] --[[ Name: GetKeyAliases ]]
    -- upvalues: v1 (copy)
    return v1.KeyAliases;
end;
v13.GetLengths = function(_) --[[ Line: 289 ]] --[[ Name: GetLengths ]]
    return 90, 31;
end;
l_UserInputService_0.InputBegan:Connect(function(_, _) --[[ Line: 295 ]]
    -- upvalues: v28 (copy)
    v28();
end);
l_UserInputService_0.InputEnded:Connect(function(_, _) --[[ Line: 299 ]]
    -- upvalues: v28 (copy)
    v28();
end);
v3:ConnectScaler(function(_, _) --[[ Line: 303 ]]

end);
v6:BindToSetting("User Interface", "Character Controls", function(_) --[[ Line: 307 ]]
    -- upvalues: v13 (copy), v12 (ref)
    v13:Refresh(v12);
end);
v6:BindToSetting("Accessibility", "Quick Move Behavior", function(_) --[[ Line: 311 ]]
    -- upvalues: v13 (copy), v12 (ref)
    v13:Refresh(v12);
end);
return v13;