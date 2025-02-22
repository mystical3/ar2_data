local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Configs", "ItemData");
local v3 = v0.require("Libraries", "Interface");
local v4 = v0.require("Libraries", "Network");
local v5 = v0.require("Libraries", "UserSettings");
local _ = v0.require("Libraries", "Resources");
local v7 = v0.require("Libraries", "ViewportIcons");
local v8 = v0.require("Classes", "Maids");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("GuiService");
local v13 = {
    ClassName = "Hotbar", 
    Gui = v3:GetGui("Hotbar")
};
local l_v3_Storage_0 = v3:GetStorage("Hotbar");
local v15 = nil;
local v16 = v8.new();
local v17 = {};
local v18 = {};
local v19 = {};
local v20 = {};
local v21 = {
    [1] = Enum.KeyCode.One, 
    [2] = Enum.KeyCode.Two, 
    [3] = Enum.KeyCode.Three, 
    [4] = Enum.KeyCode.Four, 
    [5] = Enum.KeyCode.Five, 
    [6] = Enum.KeyCode.Six, 
    [7] = Enum.KeyCode.Seven, 
    [8] = Enum.KeyCode.Eight
};
local _ = {
    Consumable = true, 
    Firearm = true, 
    Melee = true, 
    Medical = true, 
    Utility = true
};
local v23 = ColorSequence.new(Color3.fromRGB(0, 127, 122), Color3.fromRGB(0, 221, 150));
local v24 = ColorSequence.new(Color3.fromRGB(154, 37, 86), Color3.fromRGB(255, 0, 81));
local _ = ColorSequence.new(Color3.fromRGB(255, 122, 106), Color3.fromRGB(255, 236, 85));
local v26 = ColorSequence.new(Color3.fromRGB(0, 121, 235), Color3.fromRGB(0, 218, 235));
local v27 = Color3.fromRGB(0, 0, 0);
local v28 = Color3.fromRGB(255, 0, 34);
local v29 = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v30 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v31 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local v32 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v33 = Random.new();
local function _(v34, v35, v36, v37, v38) --[[ Line: 93 ]] --[[ Name: remapClamped ]]
    return v37 + (v38 - v37) * math.clamp((v34 - v35) / (v36 - v35), 0, 1);
end;
local function v43(v40) --[[ Line: 97 ]] --[[ Name: renderWait ]]
    -- upvalues: l_RunService_0 (copy)
    local v41 = v40 or 0;
    local v42 = tick();
    while tick() - v42 <= v41 do
        l_RunService_0.RenderStepped:Wait();
    end;
    return tick() - v42;
end;
local function _() --[[ Line: 108 ]] --[[ Name: saveHotbarOrder ]]
    -- upvalues: v15 (ref), v4 (copy), v13 (copy)
    if v15 and v15.Enabled then
        v4:Send("Update Hotbar Order", v13:Export());
    end;
end;
local function _(v45, v46) --[[ Line: 114 ]] --[[ Name: isPointInGui ]]
    local l_AbsolutePosition_0 = v46.AbsolutePosition;
    local v48 = l_AbsolutePosition_0 + v46.AbsoluteSize;
    local v49 = false;
    if v45.X >= l_AbsolutePosition_0.X then
        v49 = v45.X <= v48.X;
    end;
    local v50 = false;
    if v45.Y >= l_AbsolutePosition_0.Y then
        v50 = v45.Y <= v48.Y;
    end;
    return v49 and v50;
end;
local function v54(v52) --[[ Line: 124 ]] --[[ Name: getSlotMemoryIndex ]]
    if v52.HotbarMemoryIndex then
        return v52.HotbarMemoryIndex;
    elseif v52.Type == "Medical" or v52.Type == "Consumable" then
        local v53 = "";
        if next(v52.UseValue) then
            v53 = v53 .. "Heal";
        end;
        if next(v52.UseBoost) then
            v53 = v53 .. "Boost";
        end;
        if next(v52.UseFreeze) then
            v53 = v53 .. "Freeze";
        end;
        if v52.Type == "Consumable" then
            return v52.ConsumeConfig.Animation .. v53;
        elseif v52.Name:find("MedKit") or v52.Name:find("Bandage") then
            return "Health" .. v53;
        else
            return "Stamina" .. v53;
        end;
    elseif v52.Type == "Utility" then
        return v52.SubType;
    elseif v52.EquipSlot then
        return v52.EquipSlot;
    else
        warn("Unknown hotbar mem id", v52.Name);
        print(debug.traceback());
        return "Unknown";
    end;
end;
local function v63(v55) --[[ Line: 170 ]] --[[ Name: scoreItemWorth ]]
    local v56 = 0;
    if v55.UseValue then
        for _, v58 in next, v55.UseValue do
            v56 = v56 + v58;
        end;
    end;
    if v55.UseBoost then
        for _, v60 in next, v55.UseBoost do
            v56 = v56 + v60.Value * (v60.DecayTime / 150);
        end;
    end;
    if v55.UseFreeze then
        for _, v62 in next, v55.UseFreeze do
            v56 = v56 + v62;
        end;
    end;
    if v55.HotbarScoreValue then
        v56 = v55.HotbarScoreValue;
    end;
    return v56;
end;
local function v73(v64, v65) --[[ Line: 198 ]] --[[ Name: countItemDupes ]]
    local v66 = 0;
    if v64 and v65 then
        for _, v68 in next, v64.Containers do
            if v68.IsCarried then
                for _, v70 in next, v68.Occupants do
                    local v71 = v65.Name == v70.Name;
                    local v72 = false;
                    if v65.HotbarCountIndex and v65.HotbarCountIndex == v70.HotbarCountIndex then
                        v72 = true;
                    end;
                    if v72 or v71 then
                        v66 = v66 + 1;
                    end;
                end;
            end;
        end;
    end;
    return v66;
end;
local function v82(v74, v75) --[[ Line: 223 ]] --[[ Name: findItemInInventory ]]
    for _, v77 in next, v74.Equipment do
        if v77.Name == v75 then
            return v77;
        end;
    end;
    for _, v79 in next, v74.Containers do
        if v79.IsCarried then
            for _, v81 in next, v79.Occupants do
                if v81.Name == v75 then
                    return v81;
                end;
            end;
        end;
    end;
    return nil;
end;
local function v101(v83, v84, v85) --[[ Line: 243 ]] --[[ Name: findDuplicateItem ]]
    -- upvalues: v2 (copy), v54 (copy), v13 (copy), v63 (copy)
    local v86 = setmetatable({
        Name = v84
    }, {
        __index = v2[v84]
    });
    local v87 = v54(v86);
    local v88 = {};
    for _, v90 in next, v83.Equipment do
        if v13:CanSlot(v90) and v54(v90) == v87 then
            table.insert(v88, v90);
        end;
    end;
    for _, v92 in next, v83.Containers do
        if v92.IsCarried then
            for _, v94 in next, v92.Occupants do
                if v13:CanSlot(v94) and v54(v94) == v87 then
                    table.insert(v88, v94);
                end;
            end;
        end;
    end;
    if v85 then
        for v95 = #v88, 1, -1 do
            local v96 = v88[v95];
            if v96 == v85 or v96.Id == v85.Id then
                table.remove(v88, v95);
            end;
        end;
    end;
    for _, v98 in next, v88 do
        if v98.Name == v84 then
            return v98;
        end;
    end;
    table.sort(v88, function(v99, v100) --[[ Line: 280 ]]
        -- upvalues: v63 (ref)
        return v63(v99) > v63(v100);
    end);
    return v88[1];
end;
local function v110(v102) --[[ Line: 287 ]] --[[ Name: findSlotNumber ]]
    -- upvalues: v18 (ref), v54 (copy), v63 (copy), v17 (ref)
    for v103 = 1, 8 do
        local v104 = v18[v103];
        if v104 and v104.Name == v102.Name then
            return nil;
        end;
    end;
    local v105 = v54(v102);
    local v106 = v63(v102);
    if v105 then
        for v107 = 1, 8 do
            local v108 = v18[v107];
            if v17[v107] == v105 then
                if not v108 then
                    return v107;
                elseif v63(v108) < v106 then
                    return v107;
                else
                    return nil;
                end;
            end;
        end;
    end;
    for v109 = 1, 8 do
        if not v18[v109] and not v17[v109] then
            return v109;
        end;
    end;
    return nil;
end;
local function _(v111) --[[ Line: 341 ]] --[[ Name: tryEquippingSlot ]]
    -- upvalues: v18 (ref), v15 (ref)
    local v112 = v18[v111];
    if v15 and v112 then
        if v15.EquippedItem == v112 then
            return v15:Unequip();
        else
            return v15:Equip(v112);
        end;
    else
        return;
    end;
end;
local function v121(v114) --[[ Line: 353 ]] --[[ Name: setSlotAppearance ]]
    -- upvalues: v13 (copy), v18 (ref), v15 (ref), v73 (copy), v7 (copy)
    local v115 = v13.Gui.Slots[tostring(v114)];
    local v116 = v18[v114];
    local v117 = false;
    if v116 and not v116.Destroyed and v15 then
        local v118 = v73(v15.Inventory, v116);
        local v119 = v118 > 9 and "9+" or "x" .. v118;
        local l_EquippedItem_0 = v15.EquippedItem;
        v7:SetViewportIcon(v115.Icon, v116, "Hotbar");
        v115.Stack.Number.Backdrop.Text = v119;
        v115.Stack.Number.Text = v119;
        v115.Stack.Visible = v118 > 1;
        v115.Equipped.Visible = l_EquippedItem_0 == v116;
        if v15.IsInCitadelArena and v116.Type == "Firearm" then
            v117 = true;
        end;
    else
        v7:ClearViewportIcon(v115.Icon);
        v115.Stack.Visible = false;
        v115.Equipped.Visible = false;
    end;
    if v117 then
        v115.Icon.ImageColor3 = v115.Icon.ImageColor3:Lerp(Color3.new(), 0.5);
        v115.Icon.ImageTransparency = 0.6;
        v115.Number.TextColor3 = Color3.fromRGB(226, 98, 73);
        v115.Number.Backdrop.Text = "X";
        v115.Number.Text = "X";
        return;
    else
        v115.Icon.ImageColor3 = Color3.new(1, 1, 1);
        v115.Icon.ImageTransparency = 0;
        v115.Number.TextColor3 = Color3.new(1, 1, 1);
        v115.Number.Backdrop.Text = tostring(v114);
        v115.Number.Text = tostring(v114);
        return;
    end;
end;
local function _() --[[ Line: 397 ]] --[[ Name: setSlotAppearances ]]
    -- upvalues: v121 (copy)
    for v122 = 1, 8 do
        v121(v122);
    end;
end;
local function v169(v124) --[[ Line: 403 ]] --[[ Name: handleButtonClick ]]
    -- upvalues: v5 (copy), l_UserInputService_0 (copy), v1 (copy), v13 (copy), v18 (ref), v15 (ref)
    local v125 = tonumber(v124.Name);
    local l_Icon_0 = v124.Icon;
    local v127 = false;
    local v128 = false;
    local l_v5_Setting_0 = v5:GetSetting("Accessibility", "Item Drag Padding");
    local v130 = Vector2.new();
    local function _() --[[ Line: 415 ]] --[[ Name: resetPosition ]]
        -- upvalues: l_Icon_0 (copy)
        l_Icon_0.Position = UDim2.new(0, 0, 0, 0);
    end;
    local function _() --[[ Line: 419 ]] --[[ Name: positionAtMouse ]]
        -- upvalues: l_UserInputService_0 (ref), v124 (copy), v1 (ref), l_Icon_0 (copy)
        local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
        local l_AbsolutePosition_1 = v124.AbsolutePosition;
        local l_GuiInset_0 = v1.GuiInset;
        local v135 = l_Icon_0.AbsoluteSize * 0.5;
        local v136 = l_l_UserInputService_0_MouseLocation_0 - l_AbsolutePosition_1 - l_GuiInset_0 - v135;
        l_Icon_0.Position = UDim2.new(0, v136.X, 0, v136.Y);
    end;
    local function v152(v138) --[[ Line: 431 ]] --[[ Name: dragEndBehavior ]]
        -- upvalues: v13 (ref), v125 (copy)
        local l_Slots_0 = v13.Gui.Slots;
        local l_AbsolutePosition_2 = l_Slots_0.AbsolutePosition;
        local v141 = l_AbsolutePosition_2 + l_Slots_0.AbsoluteSize;
        local v142 = false;
        if v138.X >= l_AbsolutePosition_2.X then
            v142 = v138.X <= v141.X;
        end;
        local v143 = false;
        if v138.Y >= l_AbsolutePosition_2.Y then
            v143 = v138.Y <= v141.Y;
        end;
        if v142 and v143 then
            local v144 = nil;
            for _, v146 in next, v13.Gui.Slots:GetChildren() do
                local v147 = tonumber(v146.Name);
                if v147 ~= v125 then
                    local l_AbsolutePosition_3 = v146.AbsolutePosition;
                    local v149 = l_AbsolutePosition_3 + v146.AbsoluteSize;
                    local v150 = false;
                    if v138.X >= l_AbsolutePosition_3.X then
                        v150 = v138.X <= v149.X;
                    end;
                    local v151 = false;
                    if v138.Y >= l_AbsolutePosition_3.Y then
                        v151 = v138.Y <= v149.Y;
                    end;
                    if v150 and v151 then
                        v144 = v147;
                        break;
                    end;
                end;
            end;
            if v144 and v144 ~= v125 then
                v13:SwapSlots(v125, v144);
                return;
            end;
        else
            l_Slots_0 = v13.Gui;
            l_AbsolutePosition_2 = l_Slots_0.AbsolutePosition;
            v141 = l_AbsolutePosition_2 + l_Slots_0.AbsoluteSize;
            v142 = false;
            if v138.X >= l_AbsolutePosition_2.X then
                v142 = v138.X <= v141.X;
            end;
            v143 = false;
            if v138.Y >= l_AbsolutePosition_2.Y then
                v143 = v138.Y <= v141.Y;
            end;
            if not (v142 and v143) then
                v13:Remove(nil, v125);
            end;
        end;
    end;
    l_Icon_0.InputBegan:Connect(function(v153) --[[ Line: 454 ]]
        -- upvalues: v130 (ref), v127 (ref)
        if v153.UserInputType == Enum.UserInputType.MouseButton1 then
            v130 = Vector2.new(v153.Position.X, v153.Position.Y);
            v127 = true;
        end;
    end);
    l_UserInputService_0.InputChanged:Connect(function(v154, _) --[[ Line: 462 ]]
        -- upvalues: v127 (ref), v130 (ref), l_v5_Setting_0 (ref), v128 (ref), l_UserInputService_0 (ref), v124 (copy), v1 (ref), l_Icon_0 (copy)
        if v127 and v154.UserInputType == Enum.UserInputType.MouseMovement then
            local v156 = Vector2.new(v154.Position.X, v154.Position.Y);
            local v157 = v156 - v130;
            v130 = v156;
            l_v5_Setting_0 = l_v5_Setting_0 - v157.magnitude;
            if l_v5_Setting_0 <= 0 then
                v128 = true;
                local l_l_UserInputService_0_MouseLocation_1 = l_UserInputService_0:GetMouseLocation();
                local l_AbsolutePosition_4 = v124.AbsolutePosition;
                local l_GuiInset_1 = v1.GuiInset;
                local v161 = l_Icon_0.AbsoluteSize * 0.5;
                local v162 = l_l_UserInputService_0_MouseLocation_1 - l_AbsolutePosition_4 - l_GuiInset_1 - v161;
                l_Icon_0.Position = UDim2.new(0, v162.X, 0, v162.Y);
            end;
        end;
    end);
    l_UserInputService_0.InputEnded:Connect(function(v163, _) --[[ Line: 477 ]]
        -- upvalues: v128 (ref), v127 (ref), v152 (copy), l_Icon_0 (copy), v125 (copy), v18 (ref), v15 (ref), l_v5_Setting_0 (ref), v5 (ref)
        if v163.UserInputType == Enum.UserInputType.MouseButton1 then
            local l_v128_0 = v128;
            local l_v127_0 = v127;
            v128 = false;
            v127 = false;
            if l_v128_0 then
                v152(l_Icon_0.AbsolutePosition + l_Icon_0.AbsoluteSize * 0.5);
                l_Icon_0.Position = UDim2.new(0, 0, 0, 0);
            elseif l_v127_0 then
                local v167 = v18[v125];
                if v15 and v167 then
                    local _ = if v15.EquippedItem == v167 then v15:Unequip() else v15:Equip(v167);
                end;
            end;
            l_v5_Setting_0 = v5:GetSetting("Accessibility", "Item Drag Padding");
        end;
    end);
end;
local function v176(v170, v171, v172) --[[ Line: 498 ]] --[[ Name: animateStatBarChange ]]
    -- upvalues: l_v3_Storage_0 (copy), l_TweenService_0 (copy), v31 (copy), v28 (copy), v32 (copy), v0 (copy)
    if v171 < v172 then
        local v173 = l_v3_Storage_0.ChangeFlash:Clone();
        v173.Position = UDim2.fromScale(v172, 0);
        v173.Size = UDim2.fromScale(v172 - v171, 1);
        v173.Parent = v170;
        local v174 = l_TweenService_0:Create(v173, v31, {
            BackgroundColor3 = v28
        });
        local v175 = l_TweenService_0:Create(v173, v32, {
            BackgroundTransparency = 1
        });
        v174.Completed:Connect(function() --[[ Line: 513 ]]
            -- upvalues: v175 (copy)
            v175:Play();
        end);
        v175.Completed:Connect(function() --[[ Line: 517 ]]
            -- upvalues: v173 (copy), v0 (ref), v175 (copy), v174 (copy)
            v173:Destroy();
            v0.destroy(v175, "Completed");
            v0.destroy(v174, "Completed");
        end);
        v174:Play();
    end;
end;
local function v195(v177) --[[ Line: 528 ]] --[[ Name: connectStatBars ]]
    -- upvalues: v13 (copy), v16 (copy), v26 (copy), v24 (copy), v23 (copy), v176 (copy), l_RunService_0 (copy), v28 (copy), v27 (copy)
    local v178 = {
        Health = v177.Health, 
        Energy = v177.Energy, 
        Hydration = v177.Hydration
    };
    for v179, v180 in next, v178 do
        local l_Padding_0 = v13.Gui.Stats[v179].Padding;
        local l_Bonus_0 = v180.Bonus;
        v16:Give(v180.Changed:Connect(function(v183, v184) --[[ Line: 542 ]]
            -- upvalues: v180 (copy), l_Padding_0 (copy), v26 (ref), v24 (ref), v23 (ref), v176 (ref)
            local v185 = v180.ChangeTier or 0;
            local v186 = math.sign(v185);
            local v187 = v186 >= 0 and "Down" or "Up";
            local v188 = v186 >= 0 and "Up" or "Down";
            for _, v190 in next, l_Padding_0.Arrows[v187]:GetChildren() do
                v190.Visible = math.abs((tonumber(v190.Name))) <= math.abs(v185);
            end;
            l_Padding_0.Arrows[v187].Visible = true;
            l_Padding_0.Arrows[v188].Visible = false;
            local v191 = v180:Get(true);
            if v180.Frozen or false then
                l_Padding_0.Bar.UIGradient.Color = v26;
            elseif v191 < 0.25 then
                l_Padding_0.Bar.UIGradient.Color = v24;
            else
                l_Padding_0.Bar.UIGradient.Color = v23;
            end;
            l_Padding_0.Bar.Size = UDim2.new(v191, 0, 1, 0);
            v176(l_Padding_0, v183 / v180.Max, v184 / v180.Max);
        end));
        v16:Give(l_Bonus_0.Changed:Connect(function(v192, v193) --[[ Line: 574 ]]
            -- upvalues: l_Padding_0 (copy), l_Bonus_0 (copy), v176 (ref), v180 (copy)
            l_Padding_0.Booster.Size = UDim2.new(l_Bonus_0:Get(true), 0, 1, 0);
            if v193 == 0 and v192 > 0 then
                l_Padding_0.Booster.Shadow.ImageTransparency = 0;
            elseif v192 == 0 then
                l_Padding_0.Booster.Shadow.ImageTransparency = 1;
            end;
            v176(l_Padding_0, v192 / v180.Max, v193 / v180.Max);
        end));
        v16:Give(l_RunService_0.Stepped:Connect(function() --[[ Line: 586 ]]
            -- upvalues: v180 (copy), v28 (ref), v27 (ref), l_Padding_0 (copy)
            if v180 and v180.Value and v180.Max and v180.Value / v180.Max < 0.001 then
                local v194 = (tick() % 2 / 2) ^ 0.5;
                l_Padding_0.BackgroundColor3 = v28:Lerp(v27, v194);
                return;
            else
                l_Padding_0.BackgroundColor3 = v27;
                return;
            end;
        end));
        v180.Changed:Fire(v180:Get(), v180:Get());
        v180.Bonus.Changed:Fire(v180:Get(), v180:Get());
    end;
end;
local function v208(v196) --[[ Line: 602 ]] --[[ Name: connectInventoryHooks ]]
    -- upvalues: v16 (copy), v13 (copy), v121 (copy), v18 (ref)
    local l_Inventory_0 = v196.Inventory;
    v16:Give(l_Inventory_0.EquipmentAdded:Connect(function(v198) --[[ Line: 605 ]]
        -- upvalues: v13 (ref)
        v13:Slot(v198);
    end));
    v16:Give(l_Inventory_0.EquipmentRemoved:Connect(function(v199) --[[ Line: 609 ]]
        -- upvalues: v13 (ref)
        v13:Remove(v199);
    end));
    v16:Give(v196.EquipmentChanged:Connect(function(_, _) --[[ Line: 613 ]]
        -- upvalues: v121 (ref)
        for v202 = 1, 8 do
            v121(v202);
        end;
    end));
    v16:Give(l_Inventory_0.CarriedItemAdded:Connect(function(v203) --[[ Line: 618 ]]
        -- upvalues: v13 (ref), v121 (ref)
        if v13:CanSlot(v203) and not v203.EquipSlot then
            v13:Slot(v203);
        end;
        for v204 = 1, 8 do
            v121(v204);
        end;
    end));
    v16:Give(l_Inventory_0.InventoryChanged:Connect(function() --[[ Line: 629 ]]
        -- upvalues: v18 (ref), l_Inventory_0 (copy), v13 (ref)
        for v205 = 8, 1, -1 do
            local v206 = v18[v205];
            local v207 = true;
            if v206 and v206.Id and not v206.Destroyed and l_Inventory_0:FindItem(v206.Id) then
                v207 = false;
            end;
            if v207 and v206 then
                v13:Remove(v206);
            end;
        end;
    end));
end;
local function v218(v209, v210, v211) --[[ Line: 647 ]] --[[ Name: animateBarFeedback ]]
    -- upvalues: l_v3_Storage_0 (copy), v33 (copy), l_TweenService_0 (copy), v29 (copy), v30 (copy), v43 (copy), v0 (copy)
    if not v211 then
        v211 = Color3.new(1, 1, 1);
    end;
    local v212 = l_v3_Storage_0.Decrease:Clone();
    v212.Number.Text = string.format("%s%d", v210 > 0 and "+" or "", v210);
    v212.Number.TextColor3 = v211;
    if v212 then
        local v213 = math.abs(v210);
        local v214 = v33:NextInteger(10, 20);
        local v215 = v214 + (v33:NextInteger(90, 110) - v214) * math.clamp((v213 - 2) / 8, 0, 1);
        v213 = Vector2.new(v33:NextNumber(-0.3, 0.3), -1).unit * v215;
        v214 = v209.Padding.Bar.AbsoluteSize.X;
        v212.Position = UDim2.new(0, v214, 0.5, 0);
        v212.Parent = v209;
        local v216 = l_TweenService_0:Create(v212, v29, {
            Position = UDim2.new(0, v214 + v213.X, 0.5, v213.Y)
        });
        local v217 = l_TweenService_0:Create(v212, v30, {
            Size = UDim2.new()
        });
        v216.Completed:Connect(function() --[[ Line: 677 ]]
            -- upvalues: v43 (ref), v217 (copy)
            v43(0.2);
            v217:Play();
        end);
        v217.Completed:Connect(function() --[[ Line: 682 ]]
            -- upvalues: v212 (copy), v0 (ref), v216 (copy), v217 (copy)
            v212:Destroy();
            v0.destroy(v216, "Completed");
            v0.destroy(v217, "Completed");
        end);
        v216:Play();
    end;
end;
local function _(v219) --[[ Line: 693 ]] --[[ Name: cleanSlotMaid ]]
    -- upvalues: v20 (copy)
    if v20[v219] then
        v20[v219]:Destroy();
    end;
    v20[v219] = nil;
end;
local function v224(v221, v222) --[[ Line: 701 ]] --[[ Name: newSlotMade ]]
    -- upvalues: v8 (copy), v121 (copy), v20 (copy)
    local v223 = v8.new();
    if v222 and (v222.Type == "Firearm" or v222.CanTakeCosmeticSkins) then
        v223:Give(v222.Changed:Connect(function() --[[ Line: 706 ]]
            -- upvalues: v121 (ref), v221 (copy)
            v121(v221);
        end));
    end;
    if v20[v221] then
        v20[v221]:Destroy();
    end;
    v20[v221] = nil;
    v20[v221] = v223;
end;
v13.CanSlot = function(_, v226) --[[ Line: 718 ]] --[[ Name: CanSlot ]]
    -- upvalues: v15 (ref)
    if not v226 then
        return false;
    elseif v226.CanSlotInHotbar then
        if v226.CanSlotAsUtility then
            local v227 = v15 and v15.Inventory;
            if v227 and not v227:IsUtilitySlotted(v226) then
                return false;
            end;
        end;
        if v226.EquipSlot then
            if v15 and v15.Inventory and v15.Inventory.Equipment then
                local v228 = v15.Inventory.Equipment[v226.EquipSlot];
                if v228 and v228.Id ~= v226.Id then
                    return false;
                end;
            else
                return false;
            end;
        end;
        if v15 and v15.Inventory then
            local v229, v230 = v15.Inventory:IsItemHeld(v226);
            if not v229 or not v230 then
                return false;
            end;
        end;
        return true;
    else
        return false;
    end;
end;
v13.Remove = function(_, v232, v233, v234) --[[ Line: 759 ]] --[[ Name: Remove ]]
    -- upvalues: v18 (ref), v20 (copy), v15 (ref), v4 (copy), v13 (copy), v121 (copy)
    local v235 = v233 or nil;
    local v236 = v232 or nil;
    if v236 then
        for v237, v238 in next, v18 do
            if v238 == v236 or v238.Id == v236.Id then
                v235 = v237;
                break;
            end;
        end;
    elseif v235 then
        v236 = v18[v235];
    end;
    if v235 then
        v18[v235] = nil;
        local l_v235_0 = v235;
        if v20[l_v235_0] then
            v20[l_v235_0]:Destroy();
        end;
        v20[l_v235_0] = nil;
        if not v234 and v15 and v15.Enabled then
            v4:Send("Update Hotbar Order", v13:Export());
        end;
        for v240 = 1, 8 do
            v121(v240);
        end;
    end;
    if v236 and v15 and (v15.EquippedItem == v236 or v15.EquippedItem and v15.EquippedItem.Id == v236.Id) then
        v15:Unequip();
    end;
end;
v13.Slot = function(v241, v242, v243, v244) --[[ Line: 801 ]] --[[ Name: Slot ]]
    -- upvalues: v110 (copy), v17 (ref), v54 (copy), v19 (copy), v18 (ref), v20 (copy), v224 (copy), v15 (ref), v4 (copy), v13 (copy), v121 (copy)
    if v242 and v242.CanSlotInHotbar then
        if not v243 then
            v243 = v110(v242);
        end;
        if v243 then
            local v245, v246 = v241:IsSlotted(v242);
            if v245 and v246 then
                v241:SwapSlots(v246, v243);
                return;
            else
                v17[v243] = v54(v242);
                v19[v243] = v242.Name;
                v18[v243] = v242;
                if v20[v243] then
                    v20[v243]:Destroy();
                    v20[v243] = nil;
                end;
                v224(v243, v242);
                if not v244 and v15 and v15.Enabled then
                    v4:Send("Update Hotbar Order", v13:Export());
                end;
                for v247 = 1, 8 do
                    v121(v247);
                end;
            end;
        end;
    end;
end;
v13.SwapSlots = function(_, v249, v250, v251) --[[ Line: 834 ]] --[[ Name: SwapSlots ]]
    -- upvalues: v18 (ref), v17 (ref), v20 (copy), v224 (copy), v15 (ref), v4 (copy), v13 (copy), v121 (copy)
    local v252 = v18[v249];
    local v253 = v17[v249];
    local v254 = v18[v250];
    local v255 = v17[v250];
    local _ = v20[v249];
    local _ = v20[v250];
    v18[v249] = v254;
    v17[v249] = v255;
    v18[v250] = v252;
    v17[v250] = v253;
    v224(v249, v254);
    v224(v250, v252);
    if not v251 and v15 and v15.Enabled then
        v4:Send("Update Hotbar Order", v13:Export());
    end;
    for v258 = 1, 8 do
        v121(v258);
    end;
end;
v13.FindReplacement = function(v259, v260) --[[ Line: 860 ]] --[[ Name: FindReplacement ]]
    -- upvalues: v15 (ref), v101 (copy), v13 (copy)
    if v260 == nil or v260.Destroyed then
        return;
    else
        local v261, v262 = v259:IsSlotted(v260);
        if v261 and v15 and v15.Inventory then
            local v263 = v101(v15.Inventory, v260.Name, v260);
            if v263 then
                v13:Slot(v263, v262);
            end;
        end;
        return;
    end;
end;
v13.Connect = function(_, v265) --[[ Line: 876 ]] --[[ Name: Connect ]]
    -- upvalues: v16 (copy), v18 (ref), v17 (ref), v15 (ref), v195 (copy), v208 (copy)
    v16:Clean();
    v18 = {};
    v17 = {};
    v15 = v265;
    v195(v265);
    v208(v265);
end;
v13.Export = function(_) --[[ Line: 887 ]] --[[ Name: Export ]]
    -- upvalues: v18 (ref), v17 (ref)
    local v267 = {
        Memory = {}, 
        Items = {}
    };
    for v268, v269 in next, v18 do
        v267.Items[tostring(v268)] = v269.Name;
    end;
    for v270, v271 in next, v17 do
        v267.Memory[tostring(v270)] = v271;
    end;
    return v267;
end;
v13.Import = function(_, v273) --[[ Line: 908 ]] --[[ Name: Import ]]
    -- upvalues: v17 (ref), v15 (ref), v82 (copy), v13 (copy), v121 (copy)
    local l_next_0 = next;
    local v275 = v273.Memory or {};
    for v276, v277 in l_next_0, v275 do
        v17[tonumber(v276)] = v277;
    end;
    if v15 and v15.Inventory then
        l_next_0 = next;
        v275 = v273.Items or {};
        for _, v279 in l_next_0, v275 do
            local v280 = v82(v15.Inventory, v279);
            if v280 then
                v13:Slot(v280, nil, true);
            end;
        end;
        for v281 = 1, 8 do
            v121(v281);
        end;
    end;
end;
v13.IsSlotted = function(_, v283) --[[ Line: 926 ]] --[[ Name: IsSlotted ]]
    -- upvalues: v18 (ref)
    if v283 then
        for v284, v285 in next, v18 do
            if v285 == v283 or v285.Id == v283.Id then
                return true, v284;
            end;
        end;
    end;
    return false, 0;
end;
v13.SetCombatStatus = function(_, v287) --[[ Line: 938 ]] --[[ Name: SetCombatStatus ]]
    -- upvalues: v13 (copy)
    if v287 > 0 then
        local v288 = math.floor(v287 / 60);
        local v289 = math.floor(v287 % 60);
        if v289 < 10 then
            v289 = "0" .. v289;
        end;
        local v290 = v288 .. ":" .. v289;
        v13.Gui.Combat.Timer.TextLabel.Text = v290;
        v13.Gui.Combat.Timer.TextLabel.Backdrop.Text = v290;
        v13.Gui.Combat.Visible = true;
        return;
    else
        v13.Gui.Combat.Visible = false;
        return;
    end;
end;
v13.Draw = function(_) --[[ Line: 957 ]] --[[ Name: Draw ]]
    -- upvalues: v121 (copy)
    for v292 = 1, 8 do
        v121(v292);
    end;
end;
v4:Add("Hotbar Stat Feedback", function(v293, v294, v295) --[[ Line: 963 ]]
    -- upvalues: v5 (copy), v13 (copy), v218 (copy)
    local l_v5_Setting_1 = v5:GetSetting("User Interface", "Hotbar Indicators");
    if l_v5_Setting_1 == "All" or l_v5_Setting_1 == "Health" and v293 == "Health" then
        local l_FirstChild_0 = v13.Gui.Stats:FindFirstChild(v293);
        if l_FirstChild_0 then
            v218(l_FirstChild_0, v294, v295);
        end;
    end;
end);
l_UserInputService_0.InputBegan:Connect(function(v298, v299) --[[ Line: 975 ]]
    -- upvalues: v3 (copy), v21 (copy), v18 (ref), v15 (ref)
    if v3:IsVisible("Hotbar") and not v299 and v298.UserInputType == Enum.UserInputType.Keyboard then
        local v300 = nil;
        for v301, v302 in next, v21 do
            if v302 == v298.KeyCode then
                v300 = v301;
                break;
            end;
        end;
        if v300 then
            local v303 = v18[v300];
            if v15 and v303 then
                if v15.EquippedItem == v303 then
                    local _ = v15:Unequip();
                    return;
                else
                    local _ = v15:Equip(v303);
                    return;
                end;
            end;
        end;
    end;
end);
v3:ConnectScaler(function(_, _) --[[ Line: 994 ]]

end);
for _, v309 in next, v13.Gui.Slots:GetChildren() do
    v169(v309);
end;
return v13;