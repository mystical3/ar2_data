local _ = game:GetService("GuiService");
local v1 = require(game:GetService("ReplicatedFirst").Framework);
local v2 = v1.require("Configs", "Globals");
local v3 = v1.require("Configs", "ItemData");
local v4 = v1.require("Configs", "PerkTuning");
local v5 = v1.require("Libraries", "Interface");
local v6 = v1.require("Libraries", "Discovery");
local v7 = v1.require("Libraries", "Raycasting");
local v8 = v1.require("Libraries", "Keybinds");
local v9 = v1.require("Libraries", "ItemStats");
local v10 = v1.require("Libraries", "Resources");
local v11 = v1.require("Libraries", "UserSettings");
local _ = v1.require("Classes", "Signals");
local l_API_0 = v5:Get("GameMenu"):GetAPI("Inventory");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TextService_0 = game:GetService("TextService");
local l_RunService_0 = game:GetService("RunService");
local _ = workspace:WaitForChild("Loot");
local l_v5_Storage_0 = v5:GetStorage("HoverText");
local l_v5_MasterScreenGui_0 = v5:GetMasterScreenGui();
local v20 = {
    Gui = v5:GetGui("HoverText")
};
local v21 = 0;
local v22 = nil;
local v23 = false;
local l_IconImages_0 = v5:Get("Controls"):GetIconImages();
local l_KeyAliases_0 = v5:Get("Controls"):GetKeyAliases();
local l_Lengths_0, v27 = v5:Get("Controls"):GetLengths();
local v28 = nil;
local v29 = 0.1;
local _ = {
    "First", 
    "Second", 
    "Third", 
    "Fourth", 
    "Fifth", 
    "Sixth", 
    "Seventh", 
    "Eighth", 
    "Nineth", 
    "Tenth"
};
local _ = {
    Default = {
        ImageColor3 = Color3.fromRGB(255, 255, 255), 
        ImageTransparency = 0.75, 
        Image = "rbxassetid://4338859798"
    }, 
    ["Green Ammo"] = {
        ImageColor3 = Color3.fromRGB(198, 255, 139), 
        ImageTransparency = 0.7, 
        Image = "rbxassetid://4338859798"
    }, 
    ["Yellow Attachment"] = {
        ImageColor3 = Color3.fromRGB(217, 205, 99), 
        ImageTransparency = 0.7, 
        Image = "rbxassetid://4338859798"
    }, 
    ["Purple Booster"] = {
        ImageColor3 = Color3.fromRGB(255, 195, 246), 
        ImageTransparency = 0.7, 
        Image = "rbxassetid://4338859798"
    }, 
    ["Red Medical"] = {
        ImageColor3 = Color3.fromRGB(255, 117, 131), 
        ImageTransparency = 0.7, 
        Image = "rbxassetid://4338859798"
    }, 
    ["Blue Consumable"] = {
        ImageColor3 = Color3.fromRGB(195, 223, 255), 
        ImageTransparency = 0.7, 
        Image = "rbxassetid://4338859798"
    }, 
    ["Orange Utility"] = {
        ImageColor3 = Color3.fromRGB(255, 145, 55), 
        ImageTransparency = 0.7, 
        Image = "rbxassetid://4338859798"
    }
};
local function v37(v32, v33, v34) --[[ Line: 109 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    local v35 = v32:gsub("(\\?)<[^<>]->", {
        [""] = ""
    });
    local v36 = v34 or Vector2.new(3000, 200);
    return l_TextService_0:GetTextSize(v35, v33.TextSize, v33.Font, v36);
end;
local function _(v38, v39) --[[ Line: 116 ]] --[[ Name: isPointInGui ]]
    if not v39 then
        return false;
    else
        local l_AbsolutePosition_0 = v39.AbsolutePosition;
        local v41 = l_AbsolutePosition_0 + v39.AbsoluteSize;
        local v42 = false;
        if v38.X >= l_AbsolutePosition_0.X then
            v42 = v38.X <= v41.X;
        end;
        local v43 = false;
        if v38.Y >= l_AbsolutePosition_0.Y then
            v43 = v38.Y <= v41.Y;
        end;
        return v42 and v43;
    end;
end;
local function v62(v45) --[[ Line: 132 ]] --[[ Name: findGuiUnderPos ]]
    -- upvalues: l_API_0 (copy)
    local v46 = {};
    for _, v48 in next, l_API_0.ItemList do
        if v48.Gui then
            local v49 = false;
            if v48.Parent == l_API_0 or v48.Item and v48.Item.Parent and v48.Item.Parent.ClassName == "Item" then
                local l_l_API_0_SlottedItemGui_0 = l_API_0:GetSlottedItemGui(v48);
                if l_l_API_0_SlottedItemGui_0 then
                    if not l_l_API_0_SlottedItemGui_0 then
                        v49 = false;
                    else
                        local l_AbsolutePosition_1 = l_l_API_0_SlottedItemGui_0.AbsolutePosition;
                        local v52 = l_AbsolutePosition_1 + l_l_API_0_SlottedItemGui_0.AbsoluteSize;
                        local v53 = false;
                        if v45.X >= l_AbsolutePosition_1.X then
                            v53 = v45.X <= v52.X;
                        end;
                        local v54 = false;
                        if v45.Y >= l_AbsolutePosition_1.Y then
                            v54 = v45.Y <= v52.Y;
                        end;
                        v49 = v53 and v54;
                    end;
                end;
            elseif v48.Gui.Visible then
                local l_Gui_0 = v48.Gui;
                if not l_Gui_0 then
                    v49 = false;
                else
                    local l_AbsolutePosition_2 = l_Gui_0.AbsolutePosition;
                    local v57 = l_AbsolutePosition_2 + l_Gui_0.AbsoluteSize;
                    local v58 = false;
                    if v45.X >= l_AbsolutePosition_2.X then
                        v58 = v45.X <= v57.X;
                    end;
                    local v59 = false;
                    if v45.Y >= l_AbsolutePosition_2.Y then
                        v59 = v45.Y <= v57.Y;
                    end;
                    v49 = v58 and v59;
                end;
            end;
            if v49 then
                table.insert(v46, v48);
            end;
        end;
    end;
    table.sort(v46, function(v60, v61) --[[ Line: 158 ]]
        if v60.LayerOrder and v61.LayerOrder then
            return v60.LayerOrder > v61.LayerOrder;
        else
            return v60.Gui.ZIndex > v61.Gui.ZIndex;
        end;
    end);
    return v46[1];
end;
local function v68(v63) --[[ Line: 169 ]] --[[ Name: getRealItemPosition ]]
    local v64 = Vector3.new();
    local v65 = 0;
    for _, v67 in next, v63:GetDescendants() do
        if v67:IsA("BasePart") and v67.Transparency < 1 then
            v64 = v64 + v67.Position;
            v65 = v65 + 1;
        end;
    end;
    if v65 == 0 then
        return v63.Value.p;
    else
        return v64 / v65;
    end;
end;
local function v72(v69) --[[ Line: 187 ]] --[[ Name: setText ]]
    -- upvalues: v20 (copy)
    local v70 = v69.DisplayName or v69.Name or "NO NAME";
    local v71 = v69.Description or "";
    if v69.BrandingText and v69.BrandingText ~= "" then
        v70 = v69.BrandingText;
    end;
    v20.Gui.NameLabel.Text = v70;
    if v71 ~= "" then
        v20.Gui.FlexBin.Description.Text = v71;
        v20.Gui.FlexBin.Description.Visible = true;
        return;
    else
        v20.Gui.FlexBin.Description.Visible = false;
        return;
    end;
end;
local function v76(v73) --[[ Line: 221 ]] --[[ Name: setKeybind ]]
    -- upvalues: l_KeyAliases_0 (copy), v20 (copy), l_IconImages_0 (copy), l_Lengths_0 (copy), v27 (copy)
    local v74 = l_KeyAliases_0[v73] or v73.Name;
    local v75 = #v74 > 1;
    if v73.EnumType == Enum.UserInputType then
        v20.Gui.Key.Image = l_IconImages_0[v73].Up;
        v20.Gui.Key.TextLabel.Visible = false;
        return;
    elseif v73.EnumType == Enum.KeyCode then
        v20.Gui.Key.Image = l_IconImages_0[Enum.UserInputType.Keyboard].Up;
        v20.Gui.Key.Size = UDim2.new(0, v75 and l_Lengths_0 or v27, 0, 31);
        v20.Gui.Key.TextLabel.Text = v74;
        v20.Gui.Key.TextLabel.Visible = true;
        return;
    else
        v20.Gui.Key.Visible = false;
        return;
    end;
end;
local function v79(v77) --[[ Line: 238 ]] --[[ Name: getDiscoveryStatus ]]
    -- upvalues: v2 (copy), v6 (copy)
    local v78 = {};
    if not v77 then
        return v78;
    else
        if v77.RareItem then
            v78.Rare = true;
        end;
        if v77.SpecialItem then
            v78.Special = true;
        end;
        if v77.LegacyItem then
            v78.Legacy = true;
        end;
        if v77.UtilityStatusTag then
            v78.Utility = true;
        end;
        if v77.UtilityStatusTag then
            v78.Utility = true;
        end;
        if v77.EventItem then
            v78.Event = true;
        end;
        if v77.Name and v77.EquipSlot and v2.CosmeticSlots[v77.EquipSlot] then
            if v6:IsDiscovered(v77.Name) then
                v78.Unlocked = true;
                return v78;
            elseif v77.FreshItem then
                v78.New = true;
                return v78;
            else
                v78.Worn = true;
            end;
        end;
        return v78;
    end;
end;
local function v332(v80) --[[ Line: 289 ]] --[[ Name: getItemStats ]]
    -- upvalues: v1 (copy), v4 (copy), v10 (copy), v9 (copy)
    local v81 = {};
    local function _() --[[ Line: 292 ]] --[[ Name: addDivider ]]
        -- upvalues: v81 (copy)
        table.insert(v81, {
            Type = "Divider"
        });
    end;
    local function _(v83, v84) --[[ Line: 298 ]] --[[ Name: addLabel ]]
        -- upvalues: v81 (copy)
        table.insert(v81, {
            Type = "Label", 
            Name = v83, 
            Value = v84
        });
    end;
    local function _(v86, v87) --[[ Line: 306 ]] --[[ Name: addDescription ]]
        -- upvalues: v81 (copy)
        table.insert(v81, {
            Type = "Description", 
            Name = v86, 
            Value = v87
        });
    end;
    local function _(v89, v90, v91, v92) --[[ Line: 314 ]] --[[ Name: addBar ]]
        -- upvalues: v81 (copy)
        table.insert(v81, {
            Type = "Bar", 
            Name = v89, 
            Value = v90, 
            Percent = v91, 
            Compare = v92
        });
    end;
    local function _(v94, v95) --[[ Line: 328 ]] --[[ Name: addKeybind ]]
        -- upvalues: v81 (copy)
        table.insert(v81, {
            Type = "Keybind", 
            Name = v94, 
            Keybind = v95
        });
    end;
    local function _(v97, v98, v99) --[[ Line: 336 ]] --[[ Name: findAndDo ]]
        if v97[v98] then
            v99(v97[v98]);
            return true;
        else
            return false;
        end;
    end;
    local function _(v101) --[[ Line: 346 ]] --[[ Name: findEquippedItem ]]
        -- upvalues: v1 (ref)
        local v102 = v1.Classes.Players and v1.Classes.Players.get();
        local v103 = v102 and v102.Character;
        if v103 and v103.Inventory and v103.Inventory.Equipment[v101] then
            return v103.Inventory.Equipment[v101];
        else
            return nil;
        end;
    end;
    local function _(v105, v106) --[[ Line: 359 ]] --[[ Name: hasPerk ]]
        -- upvalues: v1 (ref)
        local v107 = v1.Classes.Players and v1.Classes.Players.get();
        local v108 = v107 and v107.Character;
        if v108 then
            return v108:HasPerk(v105, v106);
        else
            return false;
        end;
    end;
    if v80.Type == "Consumable" or v80.Type == "Medical" then
        local v110 = v1.Classes.Players and v1.Classes.Players.get();
        local v111 = v110 and v110.Character;
        local v112 = if v111 then v111:HasPerk("Mess Kit", nil) else false;
        v111 = v1.Classes.Players and v1.Classes.Players.get();
        local v113 = v111 and v111.Character;
        v110 = if v113 then v113:HasPerk("Trauma Kit", nil) else false;
        v113 = v1.Classes.Players and v1.Classes.Players.get();
        local v114 = v113 and v113.Character;
        v111 = if v114 then v114:HasPerk("Seasoning Kit", nil) else false;
        v114 = v1.Classes.Players and v1.Classes.Players.get();
        local v115 = v114 and v114.Character;
        v113 = if v115 then v115:HasPerk("Multivitamin Booster", nil) else false;
        for _, v117 in next, {
            "Health", 
            "Energy", 
            "Hydration"
        } do
            local function v132(v118) --[[ Line: 403 ]]
                -- upvalues: v117 (copy), v111 (copy), v4 (ref), v112 (copy), v81 (copy), v110 (copy)
                local l_v117_0 = v117;
                local function v131(v120) --[[ Line: 404 ]]
                    -- upvalues: v111 (ref), v117 (ref), v4 (ref), v112 (ref), v81 (ref), v110 (ref)
                    local l_v120_0 = v120;
                    local l_v120_1 = v120;
                    local v123 = nil;
                    if v111 and (v117 == "Energy" or v117 == "Hydration") and v120 < 0 then
                        l_v120_1 = v4("Seasoning Kit", "Modify")(v120);
                        l_v120_0 = math.floor(l_v120_1);
                    end;
                    if v112 and (v117 == "Energy" or v117 == "Hydration") then
                        local v124 = v4("Mess Kit", "Modify")(l_v120_1);
                        l_v120_1 = v124;
                        v123 = v120;
                        l_v120_0 = math.floor(v124);
                    end;
                    local v125 = l_v120_1 / 100;
                    local v126 = nil;
                    if v123 then
                        v126 = v123 / 100;
                    end;
                    local l_v117_1 = v117;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = l_v117_1, 
                        Value = l_v120_0, 
                        Percent = v125, 
                        Compare = v126
                    });
                    if v110 and v117 == "Health" then
                        l_v117_1 = v4("Trauma Kit", "BonusPercentFromHealAmount");
                        local v128 = v4("Trauma Kit", "BonusDecayRate") + v4("Trauma Kit", "BonusDecayDelay");
                        local v129 = l_v120_1 * l_v117_1;
                        local v130 = v129 / 100;
                        table.insert(v81, {
                            Type = "Bar", 
                            Name = "Utility Boost", 
                            Value = v129, 
                            Percent = v130, 
                            Compare = nil
                        });
                        v130 = string.format("%.1f Sec.", v128);
                        table.insert(v81, {
                            Type = "Label", 
                            Name = "Boost Decay Time", 
                            Value = v130
                        });
                    end;
                end;
                if v118[l_v117_0] then
                    v131(v118[l_v117_0]);
                    return;
                else
                    return;
                end;
            end;
            if v80.UseValue then
                v132(v80.UseValue);
            end;
            v132 = function(v133) --[[ Line: 444 ]]
                -- upvalues: v117 (copy), v81 (copy), v113 (copy), v4 (ref)
                local l_v117_2 = v117;
                local function v139(v135) --[[ Line: 445 ]]
                    -- upvalues: v117 (ref), v81 (ref)
                    local v136 = v117 .. " Boost";
                    local l_Value_0 = v135.Value;
                    local v138 = v135.Value / 100;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = v136, 
                        Value = l_Value_0, 
                        Percent = v138, 
                        Compare = nil
                    });
                end;
                if v133[l_v117_2] then
                    v139(v133[l_v117_2]);
                end;
                l_v117_2 = v117;
                v139 = function(v140) --[[ Line: 449 ]]
                    -- upvalues: v113 (ref), v4 (ref), v117 (ref), v81 (ref)
                    local v141 = 1;
                    if v113 then
                        v141 = v4("Multivitamin Booster", "BoosterTimeMod");
                    end;
                    local v142 = v117 .. " Boost Decay Time";
                    local v143 = string.format("%.1f Sec.", v140.DecayTime * v141);
                    table.insert(v81, {
                        Type = "Label", 
                        Name = v142, 
                        Value = v143
                    });
                end;
                if v133[l_v117_2] then
                    v139(v133[l_v117_2]);
                    return;
                else
                    return;
                end;
            end;
            if v80.UseBoost then
                v132(v80.UseBoost);
            end;
        end;
        for _, v145 in next, {
            "Health", 
            "Energy", 
            "Hydration"
        } do
            local function v152(v146) --[[ Line: 462 ]]
                -- upvalues: v145 (copy), v81 (copy)
                local l_v145_0 = v145;
                local function v151(v148) --[[ Line: 463 ]]
                    -- upvalues: v145 (ref), v81 (ref)
                    local v149 = v145 .. " Restore";
                    local v150 = string.format("%d over %.1f Secs.", v148.Amount, v148.Time);
                    table.insert(v81, {
                        Type = "Label", 
                        Name = v149, 
                        Value = v150
                    });
                end;
                if v146[l_v145_0] then
                    v151(v146[l_v145_0]);
                    return;
                else
                    return;
                end;
            end;
            if v80.UseRestore then
                v152(v80.UseRestore);
            end;
            v152 = function(v153) --[[ Line: 468 ]]
                -- upvalues: v145 (copy), v81 (copy)
                local l_v145_1 = v145;
                local function v158(v155) --[[ Line: 469 ]]
                    -- upvalues: v145 (ref), v81 (ref)
                    local v156 = v145 .. " Aid";
                    local v157 = v155 .. " Sec.";
                    table.insert(v81, {
                        Type = "Label", 
                        Name = v156, 
                        Value = v157
                    });
                end;
                if v153[l_v145_1] then
                    v158(v153[l_v145_1]);
                    return;
                else
                    return;
                end;
            end;
            if v80.UseFreeze then
                v152(v80.UseFreeze);
            end;
        end;
        if v80.ConsumeConfig then
            v115 = v10:Find("ReplicatedStorage.Assets.Animations." .. v80.ConsumeConfig.Animation):GetAttribute("Length") or 0;
            local v159 = string.format("%.1f Sec.", v115);
            table.insert(v81, {
                Type = "Label", 
                Name = "Use Time", 
                Value = v159
            });
        end;
    elseif v80.Type == "Melee" then
        local v160 = nil;
        local v161 = v1.Classes.Players and v1.Classes.Players.get();
        local v162 = v161 and v161.Character;
        if if v162 then v162:HasPerk("Sharpening Stone", nil) else false then
            if table.find(v4("Sharpening Stone", "Items"), v80.Name) then
                v160 = v4("Sharpening Stone", "DamageModifier");
            end;
        else
            v161 = v1.Classes.Players and v1.Classes.Players.get();
            v162 = v161 and v161.Character;
            if (if v162 then v162:HasPerk("Blunt Griptape", nil) else false) and table.find(v4("Blunt Griptape", "Items"), v80.Name) then
                v160 = v4("Blunt Griptape", "DamageModifier");
            end;
        end;
        if #v80.AttackConfig > 1 then
            local v163 = 0;
            v161 = 0;
            v162 = 0;
            local v164 = false;
            local v165 = false;
            for _, v167 in next, v80.AttackConfig do
                v161 = v161 + (v10:Find("ReplicatedStorage.Assets.Animations." .. v167.Animation):GetAttribute("Length") or 0) / v167.PlaybackSpeedMod;
                v162 = v162 + v167.Damage;
                v163 = v163 + 1;
                v164 = v167.CanHitMultipleTargets or v164;
                v165 = v167.CanStunZombies or v165;
            end;
            local l_v162_0 = v162;
            local v169 = l_v162_0 * (v160 or 1);
            local v170 = v169 / 100;
            local v171 = l_v162_0 / 100;
            table.insert(v81, {
                Type = "Bar", 
                Name = "Combo Damage", 
                Value = v169, 
                Percent = v170, 
                Compare = v171
            });
            v170 = v163 .. " Attacks";
            table.insert(v81, {
                Type = "Label", 
                Name = "Combo Length", 
                Value = v170
            });
            v170 = string.format("%.1f Sec.", v161);
            table.insert(v81, {
                Type = "Label", 
                Name = "Combo Speed", 
                Value = v170
            });
            v170 = v164 and "Yes" or "No";
            table.insert(v81, {
                Type = "Label", 
                Name = "Multi Hits", 
                Value = v170
            });
            v170 = v165 and "Yes" or "No";
            table.insert(v81, {
                Type = "Label", 
                Name = "Stuns Infected", 
                Value = v170
            });
        else
            local v172 = v80.AttackConfig[1];
            v162 = (v10:Find("ReplicatedStorage.Assets.Animations." .. v172.Animation):GetAttribute("Length") or 0) / v172.PlaybackSpeedMod;
            local l_Damage_0 = v172.Damage;
            local v174 = v172.Damage / 100;
            local v175 = nil;
            if v160 then
                l_Damage_0 = math.floor(v172.Damage * v160);
                v175 = v172.Damage / 100;
                v174 = v172.Damage * v160 / 100;
            end;
            table.insert(v81, {
                Type = "Bar", 
                Name = "Damage", 
                Value = l_Damage_0, 
                Percent = v174, 
                Compare = v175
            });
            local v176 = string.format("%.1f Sec.", v162);
            table.insert(v81, {
                Type = "Label", 
                Name = "Speed", 
                Value = v176
            });
            v176 = v172.CanHitMultipleTargets and "Yes" or "No";
            table.insert(v81, {
                Type = "Label", 
                Name = "Multi Hits", 
                Value = v176
            });
            v176 = v172.CanStunZombies and "Yes" or "No";
            table.insert(v81, {
                Type = "Label", 
                Name = "Stuns Infected", 
                Value = v176
            });
        end;
    elseif v80.Type == "Firearm" then
        local l_EquipSlot_0 = v80.EquipSlot;
        local v178 = v1.Classes.Players and v1.Classes.Players.get();
        local v179 = v178 and v178.Character;
        local v180 = (if v179 and v179.Inventory and v179.Inventory.Equipment[l_EquipSlot_0] then v179.Inventory.Equipment[l_EquipSlot_0] else nil) or {};
        if v180 == v80 then
            v180 = {};
        end;
        do
            local l_v180_0 = v180;
            l_EquipSlot_0 = function(v182) --[[ Line: 552 ]]
                -- upvalues: v80 (copy), l_v180_0 (ref), v81 (copy), v9 (ref)
                local function v196(v183) --[[ Line: 553 ]]
                    -- upvalues: v80 (ref), l_v180_0 (ref), v81 (ref)
                    local l_v183_0 = v183;
                    local v185 = nil;
                    if v80.FireConfig.PelletCount > 1 then
                        l_v183_0 = l_v183_0 * v80.FireConfig.PelletCount;
                    end;
                    local l_l_v183_0_0 = l_v183_0;
                    local v187 = nil;
                    if v80.HitModifiers and v80.HitModifiers.Head then
                        l_l_v183_0_0 = math.floor(l_l_v183_0_0 * v80.HitModifiers.Head);
                    end;
                    local l_l_v180_0_0 = l_v180_0;
                    local function v194(v189) --[[ Line: 568 ]]
                        -- upvalues: l_v180_0 (ref), v185 (ref), v187 (ref)
                        local function v193(v190) --[[ Line: 569 ]]
                            -- upvalues: l_v180_0 (ref), v185 (ref), v187 (ref)
                            local l_v190_0 = v190;
                            if l_v180_0.FireConfig.PelletCount > 1 then
                                l_v190_0 = l_v190_0 * l_v180_0.FireConfig.PelletCount;
                            end;
                            local l_l_v190_0_0 = l_v190_0;
                            if l_v180_0.HitModifiers and l_v180_0.HitModifiers.Head then
                                l_l_v190_0_0 = l_l_v190_0_0 * l_v180_0.HitModifiers.Head;
                            end;
                            v185 = l_v190_0 / 100;
                            v187 = l_l_v190_0_0 / 100;
                        end;
                        if v189.Damage then
                            v193(v189.Damage);
                            return;
                        else
                            return;
                        end;
                    end;
                    if l_l_v180_0_0.FireConfig then
                        v194(l_l_v180_0_0.FireConfig);
                    end;
                    l_l_v180_0_0 = tostring(l_v183_0);
                    v194 = l_v183_0 / 100;
                    local l_v185_0 = v185;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = "Base Damage", 
                        Value = l_l_v180_0_0, 
                        Percent = v194, 
                        Compare = l_v185_0
                    });
                    l_l_v180_0_0 = tostring(l_l_v183_0_0);
                    v194 = l_l_v183_0_0 / 100;
                    l_v185_0 = v187;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = "Max Damage", 
                        Value = l_l_v180_0_0, 
                        Percent = v194, 
                        Compare = l_v185_0
                    });
                end;
                if v182.Damage then
                    v196(v182.Damage);
                end;
                v196 = function(v197) --[[ Line: 591 ]]
                    -- upvalues: v9 (ref), l_v180_0 (ref), v81 (ref)
                    local l_v9_Max_0 = v9:GetMax("MaxEffectiveRange");
                    local v199 = nil;
                    local l_v9_Max_1 = v9:GetMax("MinEffectiveRange");
                    local v201 = nil;
                    local l_l_v180_0_1 = l_v180_0;
                    local function v206(v203) --[[ Line: 598 ]]
                        -- upvalues: v199 (ref), l_v9_Max_0 (copy), v201 (ref), l_v9_Max_1 (copy)
                        local function v205(v204) --[[ Line: 599 ]]
                            -- upvalues: v199 (ref), l_v9_Max_0 (ref), v201 (ref), l_v9_Max_1 (ref)
                            v199 = v204.StartsAt / l_v9_Max_0;
                            v201 = v204.LowestAt / l_v9_Max_1;
                        end;
                        if v203.DamageFallOff then
                            v205(v203.DamageFallOff);
                            return;
                        else
                            return;
                        end;
                    end;
                    if l_l_v180_0_1.FireConfig then
                        v206(l_l_v180_0_1.FireConfig);
                    end;
                    l_l_v180_0_1 = v197.StartsAt;
                    v206 = v197.StartsAt / l_v9_Max_0;
                    local l_v199_0 = v199;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = "Max Dmg. Range", 
                        Value = l_l_v180_0_1, 
                        Percent = v206, 
                        Compare = l_v199_0
                    });
                    l_l_v180_0_1 = v197.LowestAt;
                    v206 = v197.LowestAt / l_v9_Max_1;
                    l_v199_0 = v201;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = "Min Dmg. Range", 
                        Value = l_l_v180_0_1, 
                        Percent = v206, 
                        Compare = l_v199_0
                    });
                end;
                if v182.DamageFallOff then
                    v196(v182.DamageFallOff);
                    return;
                else
                    return;
                end;
            end;
            if v80.FireConfig then
                l_EquipSlot_0(v80.FireConfig);
            end;
            l_EquipSlot_0 = "RecoilData";
            if v80.RecoilDataCrouched and v80.DisplayCrouchRecoil then
                print("YUH");
                l_EquipSlot_0 = "RecoilDataCrouched";
            end;
            v178 = l_EquipSlot_0;
            v179 = function(v208) --[[ Line: 650 ]]
                -- upvalues: v9 (ref), l_v180_0 (ref), v81 (copy)
                local l_KickUpForce_0 = v208.KickUpForce;
                local l_ShiftForce_0 = v208.ShiftForce;
                local v211 = v208.SlideForce * 0.2;
                local l_RaiseForce_0 = v208.RaiseForce;
                local v213 = l_KickUpForce_0 + l_ShiftForce_0 + v211 + l_RaiseForce_0;
                local l_SpreadBase_0 = v208.SpreadBase;
                local v215 = math.tan((math.rad(l_SpreadBase_0 + v208.SpreadAddFPSZoom))) * 1000;
                local v216 = math.tan((math.rad(l_SpreadBase_0 + v208.SpreadAddFPSHip))) * 1000;
                local l_v9_Max_2 = v9:GetMax("GunHipSpread");
                local v218 = 1 - v9:ScaleStat(v213, "RecoilStability", 0.1);
                local v219 = 1 - v215 / l_v9_Max_2;
                local v220 = 1 - v216 / l_v9_Max_2;
                local v221 = 1 - v9:ScaleStat(v215, "GunHipSpread", 0, nil, 0);
                local v222 = 1 - v9:ScaleStat(v216, "GunHipSpread", 0);
                local v223 = nil;
                local v224 = nil;
                local v225 = nil;
                local v226 = "RecoilData";
                if l_v180_0.RecoilDataCrouched and l_v180_0.DisplayCrouchRecoil then
                    v226 = "RecoilDataCrouched";
                end;
                local l_l_v180_0_2 = l_v180_0;
                local l_v226_0 = v226;
                local function v238(v229) --[[ Line: 679 ]]
                    -- upvalues: v223 (ref), v9 (ref), v224 (ref), l_v9_Max_2 (copy), v225 (ref)
                    local l_KickUpForce_1 = v229.KickUpForce;
                    local l_ShiftForce_1 = v229.ShiftForce;
                    local v232 = v229.SlideForce * 0.2;
                    local l_RaiseForce_1 = v229.RaiseForce;
                    local v234 = l_KickUpForce_1 + l_ShiftForce_1 + v232 + l_RaiseForce_1;
                    local l_SpreadBase_1 = v229.SpreadBase;
                    local v236 = math.tan((math.rad(l_SpreadBase_1 + v229.SpreadAddFPSZoom))) * 1000;
                    local v237 = math.tan((math.rad(l_SpreadBase_1 + v229.SpreadAddFPSHip))) * 1000;
                    v223 = 1 - v9:ScaleStat(v234, "RecoilStability", 0.1);
                    v224 = 1 - v236 / l_v9_Max_2;
                    v225 = 1 - v237 / l_v9_Max_2;
                end;
                if l_l_v180_0_2[l_v226_0] then
                    v238(l_l_v180_0_2[l_v226_0]);
                end;
                l_l_v180_0_2 = string.format("%d%%", 100 * v222);
                l_v226_0 = v225;
                table.insert(v81, {
                    Type = "Bar", 
                    Name = "Hipfire Accuracy", 
                    Value = l_l_v180_0_2, 
                    Percent = v220, 
                    Compare = l_v226_0
                });
                l_l_v180_0_2 = string.format("%d%%", 100 * v221);
                l_v226_0 = v224;
                table.insert(v81, {
                    Type = "Bar", 
                    Name = "Aimed Accuracy", 
                    Value = l_l_v180_0_2, 
                    Percent = v219, 
                    Compare = l_v226_0
                });
                l_l_v180_0_2 = string.format("%d%%", 100 * v218);
                l_v226_0 = v223;
                table.insert(v81, {
                    Type = "Bar", 
                    Name = "Recoil", 
                    Value = l_l_v180_0_2, 
                    Percent = v218, 
                    Compare = l_v226_0
                });
            end;
            if v80[v178] then
                v179(v80[v178]);
            end;
            v178 = function(v239) --[[ Line: 700 ]]
                -- upvalues: v9 (ref), l_v180_0 (ref), v81 (copy)
                local function v248(v240) --[[ Line: 701 ]]
                    -- upvalues: v9 (ref), l_v180_0 (ref), v81 (ref)
                    local l_v9_Max_3 = v9:GetMax("GunRateOfFire");
                    local v242 = nil;
                    local l_l_v180_0_3 = l_v180_0;
                    local function v247(v244) --[[ Line: 705 ]]
                        -- upvalues: v242 (ref), l_v9_Max_3 (copy)
                        local function v246(v245) --[[ Line: 706 ]]
                            -- upvalues: v242 (ref), l_v9_Max_3 (ref)
                            v242 = v245 / l_v9_Max_3;
                        end;
                        if v244.FireRate then
                            v246(v244.FireRate);
                            return;
                        else
                            return;
                        end;
                    end;
                    if l_l_v180_0_3.FireConfig then
                        v247(l_l_v180_0_3.FireConfig);
                    end;
                    l_l_v180_0_3 = v240 / l_v9_Max_3;
                    v247 = v242;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = "Fire Rate", 
                        Value = v240, 
                        Percent = l_l_v180_0_3, 
                        Compare = v247
                    });
                end;
                if v239.FireRate then
                    v248(v239.FireRate);
                end;
                v248 = function(v249) --[[ Line: 714 ]]
                    -- upvalues: v9 (ref), l_v180_0 (ref), v81 (ref)
                    local l_v9_Max_4 = v9:GetMax("GunMuzzleVelocity");
                    local v251 = nil;
                    local l_l_v180_0_4 = l_v180_0;
                    local function v256(v253) --[[ Line: 718 ]]
                        -- upvalues: v251 (ref), l_v9_Max_4 (copy)
                        local function v255(v254) --[[ Line: 719 ]]
                            -- upvalues: v251 (ref), l_v9_Max_4 (ref)
                            v251 = v254 / l_v9_Max_4;
                        end;
                        if v253.MuzzleVelocity then
                            v255(v253.MuzzleVelocity);
                            return;
                        else
                            return;
                        end;
                    end;
                    if l_l_v180_0_4.FireConfig then
                        v256(l_l_v180_0_4.FireConfig);
                    end;
                    l_l_v180_0_4 = v249 / l_v9_Max_4;
                    v256 = v251;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = "Velocity", 
                        Value = v249, 
                        Percent = l_l_v180_0_4, 
                        Compare = v256
                    });
                end;
                if v239.MuzzleVelocity then
                    v248(v239.MuzzleVelocity);
                    return;
                else
                    return;
                end;
            end;
            if v80.FireConfig then
                v178(v80.FireConfig);
            end;
            v178 = function(v257) --[[ Line: 728 ]]
                -- upvalues: v81 (copy)
                local v258 = 0;
                for _, v260 in next, v257 do
                    for _, v262 in next, v260 do
                        for _, v264 in next, v262 do
                            if v258 < v264.Time then
                                v258 = v264.Time;
                            end;
                        end;
                    end;
                end;
                local v265 = string.format("%.1f Sec.", v258);
                table.insert(v81, {
                    Type = "Label", 
                    Name = "Reload Time", 
                    Value = v265
                });
            end;
            if v80.ReloadData then
                v178(v80.ReloadData);
            end;
            v178 = function(v266) --[[ Line: 744 ]]
                -- upvalues: v80 (copy), v81 (copy)
                if v80.CaliberAmmoDisplay then
                    v266 = v80.CaliberAmmoDisplay;
                end;
                table.insert(v81, {
                    Type = "Label", 
                    Name = "Ammo Type", 
                    Value = v266
                });
            end;
            if v80.Caliber then
                v178(v80.Caliber);
            end;
            if v80.FireConfig and v80.FireConfig.InternalMag then
                v178 = v80.FireConfig;
                v179 = function(v267) --[[ Line: 753 ]]
                    -- upvalues: v80 (copy), v81 (copy)
                    local v268 = v80.Amount .. "/" .. v267;
                    local v269 = v80.Amount / v267;
                    table.insert(v81, {
                        Type = "Bar", 
                        Name = "Ammo Loaded", 
                        Value = v268, 
                        Percent = v269, 
                        Compare = nil
                    });
                end;
                if v178.InternalMagSize then
                    v179(v178.InternalMagSize);
                end;
            end;
            if v80.Amount and v80.Caliber then
                v178 = v1.Classes.Players.get();
                v179 = v178 and v178.Character;
                if v179 and v179.Inventory and v179.Inventory.Containers then
                    local v270 = 0;
                    for _, v272 in next, v179.Inventory.Containers do
                        if v272.IsCarried then
                            for _, v274 in next, v272.Occupants do
                                if v274.Caliber == v80.Caliber and (v274.Amount or 0) > 0 then
                                    v270 = v270 + v274.Amount;
                                end;
                            end;
                        end;
                    end;
                    table.insert(v81, {
                        Type = "Label", 
                        Name = "Rounds held", 
                        Value = v270
                    });
                end;
            end;
        end;
    elseif v80.Type == "Attachment" then
        local l_Slot_0 = v80.Slot;
        table.insert(v81, {
            Type = "Label", 
            Name = "Slot", 
            Value = l_Slot_0
        });
    elseif v80.Type == "Ammo" then
        local l_Capacity_0 = v80.Capacity;
        local l_l_Capacity_0_0 = l_Capacity_0 --[[ copy: 10 -> 25 ]];
        local function v281(v278) --[[ Line: 786 ]]
            -- upvalues: l_l_Capacity_0_0 (copy), v81 (copy)
            local v279 = v278 .. "/" .. l_l_Capacity_0_0;
            local v280 = v278 / l_l_Capacity_0_0;
            table.insert(v81, {
                Type = "Bar", 
                Name = "Held", 
                Value = v279, 
                Percent = v280, 
                Compare = nil
            });
        end;
        if v80.Amount then
            v281(v80.Amount);
        end;
        v281 = function(v282) --[[ Line: 790 ]]
            -- upvalues: v80 (copy), v81 (copy)
            if v80.CaliberAmmoDisplay then
                v282 = v80.CaliberAmmoDisplay;
            end;
            table.insert(v81, {
                Type = "Label", 
                Name = "Ammo Type", 
                Value = v282
            });
        end;
        if v80.Caliber then
            v281(v80.Caliber);
        end;
    elseif v80.Type == "FuelCan" then
        local function v290(_) --[[ Line: 798 ]]
            -- upvalues: v80 (copy), v81 (copy)
            local l_Capacity_1 = v80.Capacity;
            local l_v80_0 = v80;
            local function v289(v286) --[[ Line: 801 ]]
                -- upvalues: l_Capacity_1 (copy), v81 (ref)
                local v287 = math.floor(v286) .. "/" .. l_Capacity_1 .. " gal.";
                local v288 = v286 / l_Capacity_1;
                table.insert(v81, {
                    Type = "Bar", 
                    Name = "Stored", 
                    Value = v287, 
                    Percent = v288, 
                    Compare = nil
                });
            end;
            if l_v80_0.Amount then
                v289(l_v80_0.Amount);
                return;
            else
                return;
            end;
        end;
        if v80.Amount then
            v290(v80.Amount);
        end;
    elseif v80.Type == "RepairTool" then
        local function v293(v291) --[[ Line: 808 ]]
            -- upvalues: v81 (copy)
            local v292 = string.format("%d%%", v291 * 100);
            table.insert(v81, {
                Type = "Bar", 
                Name = "Repairs", 
                Value = v292, 
                Percent = v291, 
                Compare = nil
            });
        end;
        if v80.RepairPercent then
            v293(v80.RepairPercent);
        end;
    elseif v80.Type == "Backpack" then
        local function v306(v294) --[[ Line: 812 ]]
            -- upvalues: v9 (ref), v80 (copy), v1 (ref), v81 (copy)
            local l_v9_Max_5 = v9:GetMax("Backpack");
            local v296, v297 = unpack(v294);
            local v298 = v296 * v297;
            local l_EquipSlot_1 = v80.EquipSlot;
            local v300 = v1.Classes.Players and v1.Classes.Players.get();
            local v301 = v300 and v300.Character;
            local v302 = (if v301 and v301.Inventory and v301.Inventory.Equipment[l_EquipSlot_1] then v301.Inventory.Equipment[l_EquipSlot_1] else nil) or {};
            l_EquipSlot_1 = nil;
            if v302 == v80 then
                v302 = {};
            end;
            if v302 then
                v300 = v302;
                v301 = function(v303) --[[ Line: 825 ]]
                    -- upvalues: l_EquipSlot_1 (ref), l_v9_Max_5 (copy)
                    local v304, v305 = unpack(v303);
                    l_EquipSlot_1 = v304 * v305 / l_v9_Max_5;
                end;
                if v300.ContainerSize then
                    v301(v300.ContainerSize);
                end;
            end;
            v300 = v298 / l_v9_Max_5;
            v301 = l_EquipSlot_1;
            table.insert(v81, {
                Type = "Bar", 
                Name = "Capacity", 
                Value = v298, 
                Percent = v300, 
                Compare = v301
            });
        end;
        if v80.ContainerSize then
            v306(v80.ContainerSize);
        end;
    elseif v80.Type == "Utility" then
        local function v308(v307) --[[ Line: 836 ]]
            -- upvalues: v81 (copy)
            table.insert(v81, {
                Type = "Label", 
                Name = "Type", 
                Value = v307
            });
        end;
        if v80.UtilityType then
            v308(v80.UtilityType);
        end;
        v308 = function(v309) --[[ Line: 840 ]]
            -- upvalues: v81 (copy)
            table.insert(v81, {
                Type = "Label", 
                Name = "Function", 
                Value = v309
            });
        end;
        if v80.UtilityMode then
            v308(v80.UtilityMode);
        end;
    end;
    local function v319(v310) --[[ Line: 846 ]]
        -- upvalues: v81 (copy)
        if #v310 > 0 then
            table.insert(v81, {
                Type = "Divider"
            });
        end;
        for v311 = 1, #v310 do
            local v312 = v310[v311];
            if v312.Type == "Description" then
                local l_Text_0 = v312.Text;
                table.insert(v81, {
                    Type = "Description", 
                    Name = "Stat", 
                    Value = l_Text_0
                });
            elseif v312.Type == "Label" then
                local l_Title_0 = v312.Title;
                local l_Text_1 = v312.Text;
                table.insert(v81, {
                    Type = "Label", 
                    Name = l_Title_0, 
                    Value = l_Text_1
                });
            elseif v312.Type == "Bar" then
                local l_Title_1 = v312.Title;
                local l_Value_1 = v312.Value;
                local l_Percent_0 = v312.Percent;
                table.insert(v81, {
                    Type = "Bar", 
                    Name = l_Title_1, 
                    Value = l_Value_1, 
                    Percent = l_Percent_0, 
                    Compare = nil
                });
            elseif v312.Type == "Divider" then
                table.insert(v81, {
                    Type = "Divider"
                });
            end;
        end;
    end;
    if v80.CustomLabels then
        v319(v80.CustomLabels);
    end;
    if v80.UtilityType == "Binoculars" then
        v319 = v1.Classes.Players.get();
        local v320 = v319 and v319.Character;
        if v320 and v320.Binds then
            table.insert(v81, {
                Type = "Divider"
            });
            local l_Binoculars_0 = v320.Binds.Binoculars;
            table.insert(v81, {
                Type = "Keybind", 
                Name = "Activate", 
                Keybind = l_Binoculars_0
            });
            l_Binoculars_0 = v80.UseActionName or "Scan";
            local l_MouseButton1_0 = Enum.UserInputType.MouseButton1;
            table.insert(v81, {
                Type = "Keybind", 
                Name = l_Binoculars_0, 
                Keybind = l_MouseButton1_0
            });
            return v81;
        end;
    elseif v80.UtilityType == "Flashlight" then
        v319 = v1.Classes.Players.get();
        local v323 = v319 and v319.Character;
        if v323 and v323.Binds then
            table.insert(v81, {
                Type = "Divider"
            });
            local v324 = v80.EnableActionName or "Activate";
            local l_Flashlight_0 = v323.Binds.Flashlight;
            table.insert(v81, {
                Type = "Keybind", 
                Name = v324, 
                Keybind = l_Flashlight_0
            });
            return v81;
        end;
    elseif v80.PerksGiven and table.find(v80.PerksGiven, "Map") then
        v319 = v1.Classes.Players.get();
        local v326 = v319 and v319.Character;
        if v326 and v326.Binds then
            table.insert(v81, {
                Type = "Divider"
            });
            local v327 = v80.EnableActionName or "Activate";
            local l_MapToggle_0 = v326.Binds.MapToggle;
            table.insert(v81, {
                Type = "Keybind", 
                Name = v327, 
                Keybind = l_MapToggle_0
            });
            return v81;
        end;
    elseif v80.Type == "Firearm" then
        v319 = v1.Classes.Players.get();
        local v329 = v319 and v319.Character;
        if v329 and v329.Binds then
            table.insert(v81, {
                Type = "Divider"
            });
            local v330 = v80.UseActionName or "Holster";
            local l_AtEase_0 = v329.Binds.AtEase;
            table.insert(v81, {
                Type = "Keybind", 
                Name = v330, 
                Keybind = l_AtEase_0
            });
            if #v80.FireModes > 1 then
                v330 = v80.UseActionName or "Fire Mode";
                l_AtEase_0 = v329.Binds.ToolAction;
                table.insert(v81, {
                    Type = "Keybind", 
                    Name = v330, 
                    Keybind = l_AtEase_0
                });
            end;
        end;
    end;
    return v81;
end;
local function v342() --[[ Line: 915 ]] --[[ Name: scaleSize ]]
    -- upvalues: v20 (copy), v37 (copy)
    local l_X_0 = v20.Gui.NameLabel.TextBounds.X;
    local l_X_1 = v20.Gui.StateLabels.UIListLayout.AbsoluteContentSize.X;
    local v335 = l_X_0 + l_X_1 + 16;
    local v336 = 250;
    if v20.Gui.FlexBin.StatsBin.Visible then
        v336 = v336 + 50;
    end;
    v20.Gui.Size = UDim2.new(0, math.max(250, v335), 0, 88);
    v20.Gui.Divider.Size = UDim2.new(1, -(18 + l_X_1), 0, 1);
    if v20.Gui.FlexBin.StatsBin.Visible then
        local l_Y_0 = v20.Gui.FlexBin.StatsBin.UIListLayout.AbsoluteContentSize.Y;
        v20.Gui.FlexBin.StatsBin.Size = UDim2.new(1, 0, 0, l_Y_0);
    end;
    if v20.Gui.FlexBin.Description.Visible then
        local v338 = Vector2.new(v20.Gui.FlexBin.Description.AbsoluteSize.X, 1000);
        local v339 = v37(v20.Gui.FlexBin.Description.Text, v20.Gui.FlexBin.Description, v338);
        v20.Gui.FlexBin.Description.Size = UDim2.new(1, 0, 0, v339.Y + 2);
    end;
    local l_Y_1 = v20.Gui.FlexBin.UIListLayout.AbsoluteContentSize.Y;
    local v341 = UDim.new(0, l_Y_1 + 34);
    v20.Gui.Size = UDim2.new(v20.Gui.Size.X, v341);
end;
local function v347() --[[ Line: 951 ]] --[[ Name: cleanHoverText ]]
    -- upvalues: v21 (ref), v22 (ref), v23 (ref), v28 (ref), v20 (copy)
    v21 = 0;
    v22 = nil;
    v23 = false;
    if v28 then
        for _, v344 in next, v20.Gui.FlexBin.StatsBin:GetChildren() do
            if v344:IsA("GuiBase") then
                v344:Destroy();
            end;
        end;
        for _, v346 in next, v20.Gui.StateLabels:GetChildren() do
            if v346:IsA("GuiBase") then
                v346.Visible = false;
            end;
        end;
        v20.Gui.FlexBin.Description.Text = "";
        v20.Gui.FlexBin.Divider.Visible = false;
        v20.Gui.FlexBin.StatsBin.Visible = false;
        v20.Gui.NameLabel.Text = "";
        v20.Gui.Key.Visible = false;
        v28 = nil;
    end;
end;
local function v372(v348, v349, v350) --[[ Line: 980 ]] --[[ Name: displayHoverText ]]
    -- upvalues: v22 (ref), v21 (ref), v23 (ref), v28 (ref), v29 (ref), v347 (copy), v76 (copy), v20 (copy), v79 (copy), v332 (copy), v5 (copy), v72 (copy), l_v5_Storage_0 (copy), v37 (copy), v342 (copy)
    if v22 ~= v348 then
        v21 = v350;
        v22 = v348;
        v23 = false;
        return;
    else
        if v28 == v348 then
            v21 = v21 + v350;
            if v21 < v29 then
                return;
            end;
        end;
        v23 = true;
        if v348 == v28 then
            return;
        else
            v347();
            v28 = v348;
            if v349 then
                v76(v349);
                v20.Gui.Key.Visible = true;
            else
                v20.Gui.Key.Visible = false;
            end;
            local v351 = v79(v348);
            local v352 = v332(v348);
            local l_IconImages_1 = v5:Get("Controls"):GetIconImages();
            local l_KeyAliases_1 = v5:Get("Controls"):GetKeyAliases();
            v72(v348);
            for _, v356 in next, v20.Gui.StateLabels:GetChildren() do
                if v356:IsA("GuiBase") then
                    v356.Visible = v351[v356.Name] ~= nil;
                end;
            end;
            if next(v352) then
                for v357, v358 in next, v352 do
                    if v358.Type == "Divider" then
                        local v359 = l_v5_Storage_0.DividerTemplate:Clone();
                        v359.LayoutOrder = v357;
                        v359.Parent = v20.Gui.FlexBin.StatsBin;
                    elseif v358.Type == "Bar" then
                        local v360 = math.clamp(v358.Percent, 0, 1);
                        local v361 = l_v5_Storage_0.StatBarTemplate:Clone();
                        v361.Description.Text = v358.Name;
                        v361.Data.Text = v358.Value;
                        v361.Bar.Fill.Size = UDim2.new(v360, 0, 1, 0);
                        if v358.Compare then
                            local v362 = math.clamp(v358.Compare, 0, 1);
                            if v358.Compare < v358.Percent then
                                v361.Bar.Fill.PositiveFill.Size = UDim2.new(1 - v362 / v360, 0, 1, 0);
                                v361.Bar.Fill.PositiveFill.Position = UDim2.new(1, 1, 0, 0);
                                v361.Bar.Fill.Cap.Visible = false;
                            else
                                v361.Bar.NegativeFill.Size = UDim2.new(v362, 0, 1, 0);
                                v361.Bar.Fill.Cap.Visible = true;
                            end;
                        elseif v358.Percent < 0 then
                            local v363 = math.clamp(math.abs(v358.Percent), 0, 1);
                            v361.Bar.NegativeFill.Size = UDim2.new(v363, 0, 1, 0);
                        end;
                        v361.Name = v358.Name;
                        v361.LayoutOrder = v357;
                        v361.Parent = v20.Gui.FlexBin.StatsBin;
                    elseif v358.Type == "Description" then
                        local v364 = l_v5_Storage_0.StatDescriptionTemplate:Clone();
                        v364.Description.RichText = true;
                        v364.Description.Text = v358.Value;
                        local l_X_2 = v20.Gui.FlexBin.StatsBin.AbsoluteSize.X;
                        local v366 = Vector2.new(l_X_2 - 24, 5000);
                        local v367 = v37(v358.Value, v364.Description, v366);
                        v364.Size = UDim2.new(1, 0, 0, v367.Y + 2);
                        v364.Name = v358.Name;
                        v364.LayoutOrder = v357;
                        v364.Parent = v20.Gui.FlexBin.StatsBin;
                    elseif v358.Type == "Keybind" then
                        local v368 = l_v5_Storage_0.KeybindTemplate:Clone();
                        v368.Description.Text = v358.Name;
                        if l_IconImages_1[v358.Keybind] then
                            v368.Icon.Image = l_IconImages_1[v358.Keybind].Up;
                            v368.Icon.Size = UDim2.fromOffset(17, 17);
                            v368.Icon.TextLabel.Text = "";
                        else
                            local v369 = l_KeyAliases_1[v358.Keybind];
                            local v370 = #v369 > 1;
                            v368.Icon.Image = l_IconImages_1[Enum.UserInputType.Keyboard].Up;
                            v368.Icon.Size = UDim2.fromOffset(v370 and 43 or 17, 17);
                            v368.Icon.TextLabel.Text = v369;
                        end;
                        v368.Name = v358.Name;
                        v368.LayoutOrder = v357;
                        v368.Parent = v20.Gui.FlexBin.StatsBin;
                    else
                        local v371 = l_v5_Storage_0.StatTextTemplate:Clone();
                        v371.Description.Text = v358.Name;
                        v371.Data.Text = v358.Value;
                        v371.Name = v358.Name;
                        v371.LayoutOrder = v357;
                        v371.Parent = v20.Gui.FlexBin.StatsBin;
                    end;
                end;
                v20.Gui.FlexBin.StatsBin.Visible = true;
                v20.Gui.FlexBin.Divider.Visible = true;
            else
                v20.Gui.FlexBin.StatsBin.Visible = false;
                v20.Gui.FlexBin.Divider.Visible = false;
            end;
            if not v20.Gui.FlexBin.Description.Visible then
                v20.Gui.FlexBin.Divider.Visible = false;
            end;
            v342();
            return;
        end;
    end;
end;
v11:BindToSetting("Accessibility", "Hover Display Delay", function(v373) --[[ Line: 1151 ]]
    -- upvalues: v29 (ref)
    v29 = v373;
end);
l_RunService_0.Heartbeat:Connect(function(v374) --[[ Line: 1155 ]]
    -- upvalues: l_UserInputService_0 (copy), v5 (copy), v20 (copy), v1 (copy), v2 (copy), v62 (copy), v372 (copy), v23 (ref), v347 (copy), v3 (copy), v7 (copy), v68 (copy), v8 (copy), l_v5_MasterScreenGui_0 (copy)
    local v375 = l_UserInputService_0:IsMouseButtonPressed(Enum.UserInputType.MouseButton1);
    local v376 = l_UserInputService_0:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
    if v5:IsVisible("Dropdown") or v375 or v376 then
        v20.Gui.Visible = false;
        return;
    else
        debug.profilebegin("Hovertext UI step");
        local v377 = v1.Classes.Players and v1.Classes.Players.get();
        local v378 = v377 and v377.Character;
        if v5:IsVisible("GameMenu") and v5:Get("GameMenu"):IsVisible("Inventory") then
            local v379 = l_UserInputService_0:GetMouseLocation() - v2.GuiInset;
            local v380 = v62(v379);
            if v380 and v380.Item then
                local v381 = v379 + Vector2.new(21, 1);
                v372(v380.Item, nil, v374);
                v20.Gui.Position = UDim2.new(0, v381.X, 0, v381.Y);
                v20.Gui.AnchorPoint = Vector2.new();
                v20.Gui.Visible = v23;
            else
                v347();
                v20.Gui.Visible = false;
            end;
        elseif v5:IsVisible("MainMenu") then
            local v382 = l_UserInputService_0:GetMouseLocation() - v2.GuiInset;
            local v383 = v5:Get("MainMenu");
            local v384 = v383 and v383:GetAPI("Creator");
            local v385 = false;
            if v384 and not v384:IsOutfitHoverVisible() then
                for _, v387 in next, v384:GetContextItems() do
                    local l_Gui_1 = v387.Gui;
                    local v389;
                    if not l_Gui_1 then
                        v389 = false;
                    else
                        local l_AbsolutePosition_3 = l_Gui_1.AbsolutePosition;
                        local v391 = l_AbsolutePosition_3 + l_Gui_1.AbsoluteSize;
                        local v392 = false;
                        if v382.X >= l_AbsolutePosition_3.X then
                            v392 = v382.X <= v391.X;
                        end;
                        local v393 = false;
                        if v382.Y >= l_AbsolutePosition_3.Y then
                            v393 = v382.Y <= v391.Y;
                        end;
                        v389 = v392 and v393;
                    end;
                    if v389 then
                        v372(v3[v387.Name], nil, v374);
                        v385 = true;
                        break;
                    end;
                end;
                if not v385 then
                    for _, v395 in next, v384:GetColorVariantsList() do
                        local l_Gui_2 = v395.Gui;
                        local v397;
                        if not l_Gui_2 then
                            v397 = false;
                        else
                            local l_AbsolutePosition_4 = l_Gui_2.AbsolutePosition;
                            local v399 = l_AbsolutePosition_4 + l_Gui_2.AbsoluteSize;
                            local v400 = false;
                            if v382.X >= l_AbsolutePosition_4.X then
                                v400 = v382.X <= v399.X;
                            end;
                            local v401 = false;
                            if v382.Y >= l_AbsolutePosition_4.Y then
                                v401 = v382.Y <= v399.Y;
                            end;
                            v397 = v400 and v401;
                        end;
                        if v397 then
                            v372(v3[v395.Name], nil, v374);
                            v385 = true;
                            break;
                        end;
                    end;
                end;
            end;
            if v385 then
                v20.Gui.Position = UDim2.fromOffset(v382.X - 21, v382.Y - 10);
                v20.Gui.AnchorPoint = Vector2.new(1, 0);
                v20.Gui.Visible = v23;
            else
                v347();
                v20.Gui.Visible = false;
            end;
        else
            local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
            local v403 = workspace.CurrentCamera:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y);
            local v404 = Ray.new(v403.Origin, v403.Direction * 150);
            local v405, v406 = v7:InteractCast(v404);
            if (workspace.CurrentCamera.Focus.p - v406).magnitude < 20 and v405 and v378 and v378.Inventory then
                local l_GroundContainer_0 = v378.Inventory.GroundContainer;
                local v408 = nil;
                if l_GroundContainer_0 and l_GroundContainer_0.Occupants then
                    for _, v410 in next, l_GroundContainer_0.Occupants do
                        if v410.NodeObject and v405:IsDescendantOf(v410.NodeObject) then
                            v408 = v410;
                            break;
                        end;
                    end;
                end;
                if v408 then
                    local v411 = v68(v408.NodeObject);
                    local v412 = workspace.CurrentCamera:WorldToScreenPoint(v411);
                    local v413 = Vector2.new(v412.X, v412.Y) + Vector2.new(14, 16);
                    local l_MouseButton1_1 = Enum.UserInputType.MouseButton1;
                    if v377.Character.EquippedItem and not v377.Character.AtEaseInput then
                        local l_v8_Bind_0 = v8:GetBind("Secondary Interact");
                        if l_v8_Bind_0 then
                            l_MouseButton1_1 = l_v8_Bind_0.Key;
                        end;
                    end;
                    v372(v408, l_MouseButton1_1, v374);
                    v20.Gui.Position = UDim2.new(0, v413.X, 0, v413.Y);
                    v20.Gui.AnchorPoint = Vector2.new();
                    v20.Gui.Visible = v23;
                else
                    v347();
                    v20.Gui.Visible = false;
                end;
            else
                v347();
                v20.Gui.Visible = false;
            end;
        end;
        if v20.Gui.Visible then
            local v416 = l_v5_MasterScreenGui_0.AbsoluteSize - v2.GuiInset - (v20.Gui.AbsolutePosition + v20.Gui.AbsoluteSize);
            local v417 = UDim2.fromOffset(math.min(0, v416.X), (math.min(0, v416.Y)));
            v20.Gui.Position = v20.Gui.Position + v417;
        end;
        debug.profileend();
        return;
    end;
end);
return v20;