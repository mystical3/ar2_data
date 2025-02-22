local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "ItemData");
local v2 = v0.require("Configs", "Globals");
local _ = v0.require("Configs", "FirearmSkinsData");
local v4 = v0.require("Libraries", "Interface");
local v5 = v0.require("Libraries", "Network");
local v6 = v0.require("Libraries", "Discovery");
local v7 = v0.require("Libraries", "UserSettings");
local v8 = v0.require("Libraries", "ViewportIcons");
local v9 = v0.require("Classes", "Signals");
local v10 = v0.require("Classes", "Maids");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_v4_Storage_0 = v4:GetStorage("GameMenu");
local l_v4_Gui_0 = v4:GetGui("DragBin");
local v16, v17 = v4:Get("Hotbar");
local v18, _ = v4:Get("Dropdown");
local v20 = l_v4_Storage_0:WaitForChild("Item Template");
local v21 = l_v4_Storage_0:WaitForChild("Item Pop Effect");
local v22 = 0;
local v23 = "none pizza with left beef";
local v24 = {};
v24.__index = v24;
local v25 = Random.new();
local v26 = 44;
local _ = Vector2.new((v26 + 1) * 2, (v26 + 1) * 2);
local v28 = {
    ImageTransparency = 1, 
    Size = UDim2.new(1, 120, 1, 120)
};
local v29 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
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
local function _(v31, v32, v33) --[[ Line: 112 ]] --[[ Name: lerp ]]
    return v31 + (v32 - v31) * v33;
end;
local function _() --[[ Line: 116 ]] --[[ Name: getCharacter ]]
    -- upvalues: v0 (copy)
    local v35 = v0.Classes.Players.get();
    if v35 and v35.Character then
        return v35.Character;
    else
        return nil;
    end;
end;
local function _(v37, v38) --[[ Line: 127 ]] --[[ Name: isInTable ]]
    for v39, v40 in next, v37 do
        if v40 == v38 then
            return true, v39;
        end;
    end;
    return false, 0;
end;
local function _(v42) --[[ Line: 137 ]] --[[ Name: getGuiSize ]]
    -- upvalues: v26 (ref)
    local v43 = v42.GridSize[1];
    local v44 = v42.GridSize[2];
    return Vector2.new(v43 * v26 + (v43 - 1) * 1, v44 * v26 + (v44 - 1) * 1);
end;
local function v48(v46) --[[ Line: 147 ]] --[[ Name: playDropSound ]]
    -- upvalues: v1 (copy), v4 (copy), v25 (copy)
    local v47 = v1[v46 and v46.Name or ""];
    if v47 and v47.InventoryDropSound then
        v4:PlaySound("Inventory." .. v47.InventoryDropSound, nil, v25:NextNumber(0.98, 1.02));
        return;
    else
        v4:PlaySound("Inventory.Default Item Drop", nil, v25:NextNumber(0.98, 1.02));
        return;
    end;
end;
local function v51(v49) --[[ Line: 158 ]] --[[ Name: playPickupSound ]]
    -- upvalues: v1 (copy), v4 (copy), v25 (copy)
    local v50 = v1[v49 and v49.Name or ""];
    if v50 and v50.InventoryPickupSound then
        v4:PlaySound("Inventory." .. v50.InventoryPickupSound, nil, v25:NextNumber(0.98, 1.02));
        return;
    else
        v4:PlaySound("Inventory.Default Item Pickup", nil, v25:NextNumber(0.98, 1.02));
        return;
    end;
end;
local function v60(v52, v53) --[[ Line: 169 ]] --[[ Name: setItemZIndex ]]
    v52.Fade.ZIndex = v53 + 3;
    v52.Gradient.ZIndex = v53 + 4;
    v52.Item.ZIndex = v53 + 5;
    v52.Ammo.ZIndex = v53 + 7;
    v52.Label.ZIndex = v53 + 7;
    v52.Label.Backdrop.ZIndex = v53 + 6;
    for _, v55 in next, v52.Ammo:GetDescendants() do
        if v55:IsA("GuiBase") then
            v55.ZIndex = v53 + 7;
        end;
    end;
    v52.Ammo.Item.Gradient.ZIndex = v53 + 6;
    v52.Ammo.AmmoCount.Backdrop.ZIndex = v53 + 6;
    for _, v57 in next, v52.Attachments:GetChildren() do
        if v57:IsA("GuiBase") then
            v57.ZIndex = v53 + 7;
        end;
    end;
    v52.Spinner.ZIndex = v53 + 10;
    v52.Spinner.Inner.ZIndex = v53 + 11;
    for _, v59 in next, v52.Border:GetChildren() do
        if v59:IsA("GuiBase") then
            v59.ZIndex = v53 + 12;
        end;
    end;
end;
local function _(v61, v62) --[[ Line: 207 ]] --[[ Name: isPointInGui ]]
    local l_AbsolutePosition_0 = v62.AbsolutePosition;
    local v64 = l_AbsolutePosition_0 + v62.AbsoluteSize;
    local v65 = false;
    if v61.X >= l_AbsolutePosition_0.X then
        v65 = v61.X <= v64.X;
    end;
    local v66 = false;
    if v61.Y >= l_AbsolutePosition_0.Y then
        v66 = v61.Y <= v64.Y;
    end;
    return v65 and v66;
end;
local function v111(v68, v69) --[[ Line: 217 ]] --[[ Name: findDropBin ]]
    -- upvalues: v4 (copy), v17 (copy)
    local l_API_0 = v4:Get("GameMenu"):GetAPI("Inventory");
    local l_VicinityFrame_0 = l_API_0.VicinityFrame;
    local l_AbsolutePosition_1 = l_VicinityFrame_0.AbsolutePosition;
    local v73 = l_AbsolutePosition_1 + l_VicinityFrame_0.AbsoluteSize;
    local v74 = false;
    if v69.X >= l_AbsolutePosition_1.X then
        v74 = v69.X <= v73.X;
    end;
    local v75 = false;
    if v69.Y >= l_AbsolutePosition_1.Y then
        v75 = v69.Y <= v73.Y;
    end;
    local v76 = v74 and v75;
    l_AbsolutePosition_1 = l_API_0.InventoryFrame;
    v73 = l_AbsolutePosition_1.AbsolutePosition;
    v74 = v73 + l_AbsolutePosition_1.AbsoluteSize;
    v75 = false;
    if v69.X >= v73.X then
        v75 = v69.X <= v74.X;
    end;
    local v77 = false;
    if v69.Y >= v73.Y then
        v77 = v69.Y <= v74.Y;
    end;
    l_VicinityFrame_0 = v75 and v77;
    v73 = l_API_0.MiddleFrame;
    v74 = v73.AbsolutePosition;
    v75 = v74 + v73.AbsoluteSize;
    v77 = false;
    if v69.X >= v74.X then
        v77 = v69.X <= v75.X;
    end;
    local v78 = false;
    if v69.Y >= v74.Y then
        v78 = v69.Y <= v75.Y;
    end;
    l_AbsolutePosition_1 = v77 and v78;
    v74 = v17;
    v75 = v74.AbsolutePosition;
    v77 = v75 + v74.AbsoluteSize;
    v78 = false;
    if v69.X >= v75.X then
        v78 = v69.X <= v77.X;
    end;
    local v79 = false;
    if v69.Y >= v75.Y then
        v79 = v69.Y <= v77.Y;
    end;
    v73 = v78 and v79;
    if l_AbsolutePosition_1 then
        if l_API_0:IsPointInDynamicBox(v69) then
            return "Dynamic Slot", l_API_0:GetVisibleDynamicItem(), nil;
        else
            if v68.Item and v68.Item.EquipSlot ~= nil then
                for v80, v81 in next, l_API_0.EquipSlots do
                    if typeof(v81) == "table" then
                        for v82, v83 in next, v81 do
                            if v83:IsA("GuiBase") then
                                local l_AbsolutePosition_2 = v83.AbsolutePosition;
                                local v85 = l_AbsolutePosition_2 + v83.AbsoluteSize;
                                local v86 = false;
                                if v69.X >= l_AbsolutePosition_2.X then
                                    v86 = v69.X <= v85.X;
                                end;
                                local v87 = false;
                                if v69.Y >= l_AbsolutePosition_2.Y then
                                    v87 = v69.Y <= v85.Y;
                                end;
                                if v86 and v87 then
                                    return "Equipment", v80, v82;
                                end;
                            end;
                        end;
                    elseif v81:IsA("GuiBase") then
                        local l_AbsolutePosition_3 = v81.AbsolutePosition;
                        local v89 = l_AbsolutePosition_3 + v81.AbsoluteSize;
                        local v90 = false;
                        if v69.X >= l_AbsolutePosition_3.X then
                            v90 = v69.X <= v89.X;
                        end;
                        local v91 = false;
                        if v69.Y >= l_AbsolutePosition_3.Y then
                            v91 = v69.Y <= v89.Y;
                        end;
                        if v90 and v91 then
                            return "Equipment", v80, nil;
                        end;
                    end;
                end;
            end;
            if v68.Item and v68.Item.CanSlotAsUtility then
                for v92, v93 in next, l_API_0.UtilitySlots do
                    if v93:IsA("GuiBase") then
                        local l_AbsolutePosition_4 = v93.AbsolutePosition;
                        local v95 = l_AbsolutePosition_4 + v93.AbsoluteSize;
                        local v96 = false;
                        if v69.X >= l_AbsolutePosition_4.X then
                            v96 = v69.X <= v95.X;
                        end;
                        local v97 = false;
                        if v69.Y >= l_AbsolutePosition_4.Y then
                            v97 = v69.Y <= v95.Y;
                        end;
                        if v96 and v97 then
                            return "Utility", v92, nil;
                        end;
                    end;
                end;
            end;
            if v68.Item and v68.Item.CanSlotAsUtility then
                return "Utility", nil, nil;
            elseif v68.Item and v68.Item.EquipSlot ~= nil then
                return "Equipment", "None", nil;
            else
                return "Vicinity", nil, nil;
            end;
        end;
    elseif v73 then
        for _, v99 in next, v17.Slots:GetChildren() do
            if v99 then
                local l_AbsolutePosition_5 = v99.AbsolutePosition;
                local v101 = l_AbsolutePosition_5 + v99.AbsoluteSize;
                local v102 = false;
                if v69.X >= l_AbsolutePosition_5.X then
                    v102 = v69.X <= v101.X;
                end;
                local v103 = false;
                if v69.Y >= l_AbsolutePosition_5.Y then
                    v103 = v69.Y <= v101.Y;
                end;
                if v102 and v103 then
                    return "Hotbar", (tonumber(v99.Name));
                end;
            end;
        end;
        return "Hotbar", nil;
    else
        if l_VicinityFrame_0 or v76 then
            for _, v105 in next, l_API_0.ContainerGuis do
                if v105.Gui.Visible then
                    local l_ItemSlots_0 = v105.ItemSlots;
                    local l_AbsolutePosition_6 = l_ItemSlots_0.AbsolutePosition;
                    local v108 = l_AbsolutePosition_6 + l_ItemSlots_0.AbsoluteSize;
                    local v109 = false;
                    if v69.X >= l_AbsolutePosition_6.X then
                        v109 = v69.X <= v108.X;
                    end;
                    local v110 = false;
                    if v69.Y >= l_AbsolutePosition_6.Y then
                        v110 = v69.Y <= v108.Y;
                    end;
                    if v109 and v110 then
                        return "Inventory", v105;
                    end;
                end;
            end;
        end;
        return "Vicinity", nil;
    end;
end;
local function v160(v112, v113) --[[ Line: 285 ]] --[[ Name: getItemUnderPos ]]
    -- upvalues: v4 (copy)
    local l_API_1 = v4:Get("GameMenu"):GetAPI("Inventory");
    local l_VicinityFrame_1 = l_API_1.VicinityFrame;
    local l_AbsolutePosition_7 = l_VicinityFrame_1.AbsolutePosition;
    local v117 = l_AbsolutePosition_7 + l_VicinityFrame_1.AbsoluteSize;
    local v118 = false;
    if v112.X >= l_AbsolutePosition_7.X then
        v118 = v112.X <= v117.X;
    end;
    local v119 = false;
    if v112.Y >= l_AbsolutePosition_7.Y then
        v119 = v112.Y <= v117.Y;
    end;
    local v120 = v118 and v119;
    l_AbsolutePosition_7 = l_API_1.InventoryFrame;
    v117 = l_AbsolutePosition_7.AbsolutePosition;
    v118 = v117 + l_AbsolutePosition_7.AbsoluteSize;
    v119 = false;
    if v112.X >= v117.X then
        v119 = v112.X <= v118.X;
    end;
    local v121 = false;
    if v112.Y >= v117.Y then
        v121 = v112.Y <= v118.Y;
    end;
    l_VicinityFrame_1 = v119 and v121;
    v117 = l_API_1.MiddleFrame;
    v118 = v117.AbsolutePosition;
    v119 = v118 + v117.AbsoluteSize;
    v121 = false;
    if v112.X >= v118.X then
        v121 = v112.X <= v119.X;
    end;
    local v122 = false;
    if v112.Y >= v118.Y then
        v122 = v112.Y <= v119.Y;
    end;
    l_AbsolutePosition_7 = v121 and v122;
    if not v113 then
        v113 = {
            Id = ""
        };
    end;
    if v120 or l_VicinityFrame_1 then
        for _, v124 in next, l_API_1.ContainerGuis do
            if v124.Container and v124.Container.IsCarried == l_VicinityFrame_1 then
                for _, v126 in next, v124.ItemGuis do
                    if v126 ~= v113 then
                        local l_Gui_0 = v126.Gui;
                        local l_AbsolutePosition_8 = l_Gui_0.AbsolutePosition;
                        local v129 = l_AbsolutePosition_8 + l_Gui_0.AbsoluteSize;
                        local v130 = false;
                        if v112.X >= l_AbsolutePosition_8.X then
                            v130 = v112.X <= v129.X;
                        end;
                        local v131 = false;
                        if v112.Y >= l_AbsolutePosition_8.Y then
                            v131 = v112.Y <= v129.Y;
                        end;
                        if v130 and v131 then
                            return "Container", v126, v126.Gui;
                        end;
                    end;
                end;
            end;
        end;
    elseif l_AbsolutePosition_7 then
        for v132, v133 in next, l_API_1.EquipSlots do
            if typeof(v133) == "table" then
                for v134, v135 in next, v133 do
                    local v136 = l_API_1.Equipment[v132][v134];
                    if v135 and v136 ~= v113 then
                        local l_AbsolutePosition_9 = v135.AbsolutePosition;
                        local v138 = l_AbsolutePosition_9 + v135.AbsoluteSize;
                        local v139 = false;
                        if v112.X >= l_AbsolutePosition_9.X then
                            v139 = v112.X <= v138.X;
                        end;
                        local v140 = false;
                        if v112.Y >= l_AbsolutePosition_9.Y then
                            v140 = v112.Y <= v138.Y;
                        end;
                        if v139 and v140 then
                            return "Equipment", v136, v135;
                        end;
                    end;
                end;
            else
                local v141 = l_API_1.Equipment[v132];
                if v133 and v141 ~= v113 then
                    local l_AbsolutePosition_10 = v133.AbsolutePosition;
                    local v143 = l_AbsolutePosition_10 + v133.AbsoluteSize;
                    local v144 = false;
                    if v112.X >= l_AbsolutePosition_10.X then
                        v144 = v112.X <= v143.X;
                    end;
                    local v145 = false;
                    if v112.Y >= l_AbsolutePosition_10.Y then
                        v145 = v112.Y <= v143.Y;
                    end;
                    if v144 and v145 then
                        return "Equipment", v141, v133;
                    end;
                end;
            end;
        end;
        for v146, v147 in next, l_API_1.UtilitySlots do
            local v148 = l_API_1.UtilitySlots[v146];
            if v147 and v148 ~= v113 then
                local l_AbsolutePosition_11 = v147.AbsolutePosition;
                local v150 = l_AbsolutePosition_11 + v147.AbsoluteSize;
                local v151 = false;
                if v112.X >= l_AbsolutePosition_11.X then
                    v151 = v112.X <= v150.X;
                end;
                local v152 = false;
                if v112.Y >= l_AbsolutePosition_11.Y then
                    v152 = v112.Y <= v150.Y;
                end;
                if v151 and v152 then
                    return "Utility", v148, v147;
                end;
            end;
        end;
        for _, v154 in next, l_API_1:GetDynamicSlots() do
            if v154.Type == "Slot" and v154.Gui and v154.Item ~= v113 then
                local l_Gui_1 = v154.Gui;
                local l_AbsolutePosition_12 = l_Gui_1.AbsolutePosition;
                local v157 = l_AbsolutePosition_12 + l_Gui_1.AbsoluteSize;
                local v158 = false;
                if v112.X >= l_AbsolutePosition_12.X then
                    v158 = v112.X <= v157.X;
                end;
                local v159 = false;
                if v112.Y >= l_AbsolutePosition_12.Y then
                    v159 = v112.Y <= v157.Y;
                end;
                if v158 and v159 then
                    return "Dynamic", v154.Item, v154.Gui;
                end;
            end;
        end;
    end;
    return "None", nil, nil;
end;
local function v165(v161, v162, v163) --[[ Line: 350 ]] --[[ Name: mousePosToGrid ]]
    -- upvalues: v26 (ref)
    local v164 = (v161.Gui.AbsolutePosition - v162.ItemSlots.AbsolutePosition) / (v26 + 1);
    if v163 then
        return {
            v164.X + 1, 
            v164.Y + 1
        };
    else
        return {
            math.floor(v164.X + 0.5) + 1, 
            math.floor(v164.Y + 0.5) + 1
        };
    end;
end;
local function v174(v166) --[[ Line: 368 ]] --[[ Name: getPositionsNear ]]
    local v167 = {};
    for v168 = -1, 1 do
        for v169 = -1, 1 do
            table.insert(v167, {
                math.floor(v166[1] + 0.5) + v168, 
                math.floor(v166[2] + 0.5) + v169
            });
        end;
    end;
    table.sort(v167, function(v170, v171) --[[ Line: 380 ]]
        -- upvalues: v166 (copy)
        local v172 = Vector2.new(unpack(v166)) - Vector2.new(unpack(v170));
        local v173 = Vector2.new(unpack(v166)) - Vector2.new(unpack(v171));
        return v172.Magnitude < v173.Magnitude;
    end);
    return v167;
end;
local function v183(v175, v176, v177, v178) --[[ Line: 390 ]] --[[ Name: findFirstOpenSpot ]]
    for v179 = 1, #v176 do
        local v180 = v176[v179];
        local v181, _ = v175:HasSpace(v177, v180, v178);
        if v181 then
            return true, v180;
        end;
    end;
    return false, {
        0, 
        0
    };
end;
local function v190() --[[ Line: 403 ]] --[[ Name: getGuns ]]
    -- upvalues: v4 (copy)
    local l_Inventory_0 = v4:Get("GameMenu"):GetAPI("Inventory").Inventory;
    local v185 = {};
    if l_Inventory_0 then
        for _, v187 in next, l_Inventory_0.Containers do
            if v187.IsCarried then
                for _, v189 in next, v187.Occupants do
                    if v189.Type == "Firearm" then
                        table.insert(v185, v189);
                    end;
                end;
            end;
        end;
    end;
    table.insert(v185, l_Inventory_0.Equipment.Primary);
    table.insert(v185, l_Inventory_0.Equipment.Secondary);
    return v185;
end;
local function _(v191, v192) --[[ Line: 426 ]] --[[ Name: canCraft ]]
    if v191 and v191.CanCraft and v192 then
        return v191:CanCraft(v192);
    else
        return false;
    end;
end;
local function v212(v194, v195) --[[ Line: 434 ]] --[[ Name: findEquipmentGui ]]
    -- upvalues: v4 (copy)
    local l_API_2 = v4:Get("GameMenu"):GetAPI("Inventory");
    local l_EquipSlot_0 = v194.Item.EquipSlot;
    local v198 = l_API_2.EquipSlots[l_EquipSlot_0];
    local v199 = nil;
    if typeof(v198) == "table" then
        local v200 = nil;
        local v201 = 1e999;
        local v202 = false;
        for v203, v204 in next, v198 do
            local l_AbsolutePosition_13 = v204.AbsolutePosition;
            local v206 = l_AbsolutePosition_13 + v204.AbsoluteSize;
            local l_AbsolutePosition_14 = v204.AbsolutePosition;
            local v208 = l_AbsolutePosition_14 + v204.AbsoluteSize;
            local v209 = false;
            if v195.X >= l_AbsolutePosition_14.X then
                v209 = v195.X <= v208.X;
            end;
            local v210 = false;
            if v195.Y >= l_AbsolutePosition_14.Y then
                v210 = v195.Y <= v208.Y;
            end;
            if v209 and v210 then
                v198 = v204;
                v199 = v203;
                v202 = true;
                break;
            else
                l_AbsolutePosition_14 = (v195 - Vector2.new(math.clamp(v195.X, l_AbsolutePosition_13.X, v206.X), (math.clamp(v195.Y, l_AbsolutePosition_13.Y, v206.Y)))).Magnitude;
                if l_AbsolutePosition_14 < v201 then
                    v201 = l_AbsolutePosition_14;
                    v200 = v203;
                end;
            end;
        end;
        if not v202 then
            local l_v200_0 = v200;
            if l_v200_0 then
                v198 = v198[l_v200_0];
                v199 = l_v200_0;
            end;
        end;
    end;
    return v198, v199;
end;
local function v248(v213, v214) --[[ Line: 490 ]] --[[ Name: dragMarksBehavior ]]
    -- upvalues: v4 (copy), v111 (copy), v160 (copy), v23 (ref), v22 (ref), v174 (copy), v165 (copy), v183 (copy), v26 (ref), v212 (copy)
    local l_API_3 = v4:Get("GameMenu"):GetAPI("Inventory");
    local v216, v217, _ = v111(v213, v214);
    local v219, v220, v221 = v160(v214, v213);
    if v216 == "Vicinity" and v23 ~= "Vicinity" then
        v22 = os.clock();
    end;
    v23 = v216;
    if v216 == "Inventory" then
        if v219 == "Container" then
            local l_Item_0 = v220.Item;
            local l_Item_1 = v213.Item;
            if if l_Item_0 and l_Item_0.CanCraft and l_Item_1 then l_Item_0:CanCraft(l_Item_1) else false then
                l_API_3:SetDragMarks(v221, UDim2.new(1, 6, 1, 6), UDim2.new(0, -3, 0, -3));
                return;
            end;
        end;
        local v224 = v174((v165(v213, v217, true)));
        local v225, v226 = v183(v217.Container, v224, v213.Item.GridSize, v213.Item);
        if v225 and v217.ItemSlots then
            local v227 = v213.Item.GridSize[1];
            local v228 = v213.Item.GridSize[2];
            local v229 = UDim2.new(0, (v226[1] - 1) * v26 + v226[1] * 1, 0, (v226[2] - 1) * v26 + v226[2] * 1) - UDim2.new(0, 5, 0, 5);
            local v230 = UDim2.new(0, v227 * v26 + (v227 - 1) * 1, 0, v228 * v26 + (v228 - 1) * 1) + UDim2.new(0, 10, 0, 10);
            l_API_3:SetDragMarks(v217.ItemSlots, v230, v229);
            return;
        else
            l_API_3:SetDragMarks();
            return;
        end;
    elseif v216 == "Dynamic Slot" then
        local l_Slot_0 = v213.Item.Slot;
        if v213.Item.Type == "Ammo" then
            l_Slot_0 = "Ammo";
        end;
        for _, v233 in next, l_API_3:GetDynamicSlots() do
            if v233.Name == l_Slot_0 and v233.Gui then
                l_API_3:SetDragMarks(v233.Gui, UDim2.new(1, 8, 1, 8), UDim2.new(0, -4, 0, -4));
                return;
            end;
        end;
        return;
    elseif v216 == "Utility" then
        local v234 = nil;
        local v235 = nil;
        local v236 = 1e999;
        local v237 = false;
        for _, v239 in next, l_API_3.UtilitySlots do
            local l_AbsolutePosition_15 = v239.AbsolutePosition;
            local v241 = l_AbsolutePosition_15 + v239.AbsoluteSize;
            local l_AbsolutePosition_16 = v239.AbsolutePosition;
            local v243 = l_AbsolutePosition_16 + v239.AbsoluteSize;
            local v244 = false;
            if v214.X >= l_AbsolutePosition_16.X then
                v244 = v214.X <= v243.X;
            end;
            local v245 = false;
            if v214.Y >= l_AbsolutePosition_16.Y then
                v245 = v214.Y <= v243.Y;
            end;
            if v244 and v245 then
                v234 = v239;
                v237 = true;
                break;
            else
                l_AbsolutePosition_16 = (v214 - Vector2.new(math.clamp(v214.X, l_AbsolutePosition_15.X, v241.X), (math.clamp(v214.Y, l_AbsolutePosition_15.Y, v241.Y)))).Magnitude;
                if l_AbsolutePosition_16 < v236 then
                    v236 = l_AbsolutePosition_16;
                    v235 = v239;
                end;
            end;
        end;
        if not v237 then
            v234 = v235;
        end;
        if v234 then
            l_API_3:SetDragMarks(v234, UDim2.new(1, 8, 1, 8), UDim2.new(0, -4, 0, -4));
            return;
        else
            l_API_3:SetDragMarks();
            return;
        end;
    elseif v216 == "Equipment" then
        local v246, _ = v212(v213, v214);
        if v246 then
            l_API_3:SetDragMarks(v246, UDim2.new(1, 8, 1, 8), UDim2.new(0, -4, 0, -4));
            return;
        else
            l_API_3:SetDragMarks();
            return;
        end;
    else
        l_API_3:SetDragMarks();
        return;
    end;
end;
local function v268(v249) --[[ Line: 638 ]] --[[ Name: popSameCalibers ]]
    -- upvalues: v4 (copy)
    local l_API_4 = v4:Get("GameMenu"):GetAPI("Inventory");
    local v251 = v249.Item and v249.Item.Caliber ~= nil;
    if l_API_4 and v251 then
        local l_Caliber_0 = v249.Item.Caliber;
        local v253 = {};
        if v249.Item.Type == "Firearm" then
            if v249.Item.FireConfig.InternalMag then
                for _, v255 in next, l_API_4.ItemList do
                    if v255.Item and v255.Item.Caliber == l_Caliber_0 then
                        local v256 = v255.Item.SubType == "Container";
                        local v257 = v255.Item.SubType == "Pack";
                        if v256 or v257 then
                            table.insert(v253, v255);
                        end;
                    end;
                end;
            else
                for _, v259 in next, l_API_4.ItemList do
                    if v259.Item and v259.Item.Caliber == l_Caliber_0 and table.find(v249.Item.MagazineTypes, v259.Item.Name) then
                        table.insert(v253, v259);
                    end;
                end;
            end;
        elseif v249.Item.SubType == "Magazine" then
            for _, v261 in next, l_API_4.ItemList do
                if v261.Item and v261.Item.Caliber == l_Caliber_0 then
                    local v262 = false;
                    if v261.Item.MagazineTypes and table.find(v261.Item.MagazineTypes, v249.Item.Name) then
                        v262 = true;
                    end;
                    if v261.Item.Type == "Ammo" or v262 then
                        table.insert(v253, v261);
                    end;
                end;
            end;
        else
            local v263 = v249.Item.SubType ~= "Magazine";
            for _, v265 in next, l_API_4.ItemList do
                if v265.Item and v265.Item.Caliber == l_Caliber_0 then
                    if v265.Item.Type == "Ammo" then
                        table.insert(v253, v265);
                    end;
                    if v265.Item.FireConfig and v265.Item.FireConfig.InternalMag and v263 then
                        table.insert(v253, v265);
                    end;
                end;
            end;
        end;
        for _, v267 in next, v253 do
            if v267.Parent and v267.Parent.Type ~= "Item" then
                v267:PopEffect(true, Color3.fromRGB(154, 223, 255));
            end;
        end;
    end;
end;
local function v277(v269) --[[ Line: 716 ]] --[[ Name: predictDynamicPlacement ]]
    -- upvalues: v4 (copy)
    local l_API_5 = v4:Get("GameMenu"):GetAPI("Inventory");
    local v271 = {};
    for _, v273 in next, l_API_5:GetDynamicItems() do
        local l_Item_2 = v273.Item;
        local l_Item_3 = v269.Item;
        if if l_Item_2 and l_Item_2.CanCraft and l_Item_3 then l_Item_2:CanCraft(l_Item_3) else false then
            table.insert(v271, v273);
        end;
    end;
    if #v271 == 1 then
        local v276 = v271[1];
        if v276 and v276.Item and v276.Item.EquipSlot then
            l_API_5:ShowDynamicWindow(v276.Item.EquipSlot);
        end;
    end;
end;
local function v365(v278) --[[ Line: 735 ]] --[[ Name: connect ]]
    -- upvalues: v7 (copy), v4 (copy), v26 (ref), v2 (copy), l_RunService_0 (copy), v248 (copy), v24 (copy), l_UserInputService_0 (copy), v48 (copy), l_v4_Gui_0 (copy), v60 (copy), v268 (copy), v277 (copy), v111 (copy), v160 (copy), v16 (copy), v5 (copy), v0 (copy), v174 (copy), v165 (copy), v183 (copy), v212 (copy)
    local l_Parent_0 = v278.Gui.Parent;
    local v280 = Vector2.new();
    local v281 = Vector2.new();
    local _ = Vector2.new();
    local l_v7_Setting_0 = v7:GetSetting("Accessibility", "Item Drag Padding");
    local l_API_6 = v4:Get("GameMenu"):GetAPI("Inventory");
    local v285 = false;
    local v286 = false;
    local function _() --[[ Line: 749 ]] --[[ Name: drawDraggedPos ]]
        -- upvalues: v278 (copy), v26 (ref), v280 (ref), v2 (ref)
        local l_Item_4 = v278.Item;
        local v288 = l_Item_4.GridSize[1];
        local v289 = l_Item_4.GridSize[2];
        local v290 = Vector2.new(v288 * v26 + (v288 - 1) * 1, v289 * v26 + (v289 - 1) * 1) * 0.5;
        l_Item_4 = v280 - v290 + v2.GuiInset;
        v278.Gui.Position = UDim2.new(0, l_Item_4.X, 0, l_Item_4.Y);
    end;
    v278.Maid:Give(v278.Gui.MouseEnter:Connect(function() --[[ Line: 767 ]]
        -- upvalues: v278 (copy), l_API_6 (copy)
        if not v278.Dragging and not l_API_6.Dragging then
            v278.Gui.BorderTest.Visible = true;
        end;
    end));
    v278.Maid:Give(v278.Gui.MouseLeave:Connect(function() --[[ Line: 773 ]]
        -- upvalues: v278 (copy)
        v278.Gui.BorderTest.Visible = false;
    end));
    v278.Maid:Give(v278.Item.Changed:Connect(function(_) --[[ Line: 777 ]]
        -- upvalues: v278 (copy), l_RunService_0 (ref)
        if v278.Destroyed then
            return;
        elseif v278.Item and v278.Item.Destroyed then
            return;
        else
            if v278.Item.AmmoMoving then
                v278.SpinnerGui.Visible = true;
                v278.Maid:CleanIndex("Ammo Moving Loop");
                v278.Maid["Ammo Moving Loop"] = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 790 ]]
                    -- upvalues: v278 (ref)
                    local l_Spinner_0 = v278.Gui:FindFirstChild("Spinner");
                    if l_Spinner_0 then
                        l_Spinner_0.Rotation = tick() * 2 % 1 * 360;
                    end;
                end);
            elseif not v278.Destroyed then
                v278.SpinnerGui.Visible = false;
            end;
            if v278.Item.AmmoMoving == false then
                v278.Maid:CleanIndex("Ammo Moving Loop");
            end;
            if not v278.Destroyed then
                v278:Draw();
            end;
            return;
        end;
    end));
    v278.Maid:Give(v278.GuiRotated:Connect(function(_) --[[ Line: 811 ]]
        -- upvalues: v278 (copy), v4 (ref), v26 (ref), v280 (ref), v2 (ref), v248 (ref)
        if v278.Destroyed then
            return;
        else
            v4:PlaySound("Interface.Swipe");
            v4:Get("GameMenu"):GetAPI("Inventory"):SetDragMarks();
            local l_Item_5 = v278.Item;
            local v296 = l_Item_5.GridSize[1];
            local v297 = l_Item_5.GridSize[2];
            local v298 = Vector2.new(v296 * v26 + (v296 - 1) * 1, v297 * v26 + (v297 - 1) * 1) * 0.5;
            l_Item_5 = v280 - v298 + v2.GuiInset;
            v278.Gui.Position = UDim2.new(0, l_Item_5.X, 0, l_Item_5.Y);
            v248(v278, v280);
            return;
        end;
    end));
    v278.Maid:Give(v278.Gui.InputBegan:Connect(function(v299) --[[ Line: 834 ]]
        -- upvalues: v278 (copy), v280 (ref), v24 (ref), l_API_6 (copy), v285 (ref), l_v7_Setting_0 (ref), v7 (ref), v281 (ref), v286 (ref)
        if v278.Destroyed then
            return;
        else
            if v299.UserInputType == Enum.UserInputType.MouseButton1 then
                local v300 = false;
                local l_v280_0 = v280;
                local l_Item_6 = v278.Gui.Ammo.Item;
                local l_AbsolutePosition_17 = l_Item_6.AbsolutePosition;
                local v304 = l_AbsolutePosition_17 + l_Item_6.AbsoluteSize;
                local v305 = false;
                if l_v280_0.X >= l_AbsolutePosition_17.X then
                    v305 = l_v280_0.X <= v304.X;
                end;
                local v306 = false;
                if l_v280_0.Y >= l_AbsolutePosition_17.Y then
                    v306 = l_v280_0.Y <= v304.Y;
                end;
                if v305 and v306 and v278.Item and v278.Item.Attachments and v278.Item.Attachments.Ammo then
                    if not v278.SpecialAmmoGui then
                        v278.SpecialAmmoGui = v24.new(v278.Item.Attachments.Ammo, v278);
                        v278.SpecialAmmoGui:Draw();
                    end;
                    if v278.SpecialAmmoGui then
                        l_API_6:ClickAndDrag(v278.SpecialAmmoGui, function() --[[ Line: 852 ]]
                            -- upvalues: v278 (ref)
                            v278.AmmoDragged = true;
                            v278.SpecialAmmoGui:InitDragging();
                            v278:Draw();
                        end, function(_) --[[ Line: 858 ]]
                            -- upvalues: v278 (ref)
                            v278.AmmoDragged = false;
                            v278:Draw();
                            v278.SpecialAmmoGui:Destroy();
                            v278.SpecialAmmoGui = nil;
                        end);
                        v300 = true;
                    end;
                end;
                if not v300 then
                    v285 = true;
                    l_v7_Setting_0 = v7:GetSetting("Accessibility", "Item Drag Padding");
                    v281 = v280;
                    return;
                end;
            elseif v299.UserInputType == Enum.UserInputType.MouseButton2 then
                v286 = true;
            end;
            return;
        end;
    end));
    v278.Maid:Give(l_UserInputService_0.InputEnded:Connect(function(v308) --[[ Line: 884 ]]
        -- upvalues: v278 (copy), v285 (ref), v286 (ref), v48 (ref), v4 (ref), l_UserInputService_0 (ref)
        if v278.Destroyed then
            return;
        elseif not v285 and not v286 and not v278.Dragging then
            return;
        elseif v308.UserInputType == Enum.UserInputType.MouseButton1 then
            if v278.Dragging or v278.Parent and v278.Parent.Dragging then
                v48(v278);
                v4:Get("GameMenu"):GetAPI("Inventory").Dragging = false;
                v4:Get("GameMenu"):GetAPI("Inventory").DraggingItem = nil;
                v4:Get("GameMenu"):GetAPI("Inventory"):SetDragMarks();
                if v278.Attached and v278.Parent.Dragging then
                    v278.Parent.Dragging = false;
                    v278.Parent.DragStopped:Fire();
                    if v278.Parent and v278.Parent.DragFinished then
                        v278.Parent.DragFinished:Fire();
                    end;
                else
                    v278.Dragging = false;
                    v278.DragStopped:Fire();
                    if v278.DragFinished then
                        v278.DragFinished:Fire();
                    end;
                end;
            elseif v285 then
                v278:ClickBehavior();
            end;
            v285 = false;
            return;
        else
            if v308.UserInputType == Enum.UserInputType.MouseButton2 then
                if v286 and not l_UserInputService_0:IsKeyDown(Enum.KeyCode.LeftShift) then
                    v278:RightClickBehavior();
                end;
                v4:PlaySound("Interface.Click");
                v286 = false;
            end;
            return;
        end;
    end));
    v278.Maid:Give(l_UserInputService_0.InputBegan:Connect(function(v309, _) --[[ Line: 935 ]]
        -- upvalues: v278 (copy)
        if v278.Destroyed then
            return;
        else
            if v278.Dragging and v309.KeyCode == Enum.KeyCode.R and v278.Item.IconRotationDirection ~= 0 then
                v278:SetRotation(not v278.Item.Rotated);
            end;
            return;
        end;
    end));
    v278.Maid:Give(l_UserInputService_0.InputChanged:Connect(function(v311, _) --[[ Line: 947 ]]
        -- upvalues: v278 (copy), v280 (ref), l_v7_Setting_0 (ref), v285 (ref), v26 (ref), v2 (ref), v248 (ref)
        if v278.Destroyed then
            return;
        else
            if v311.UserInputType == Enum.UserInputType.MouseMovement then
                local v313 = Vector2.new(v311.Position.X, v311.Position.Y);
                local v314 = v313 - v280;
                v280 = v313;
                l_v7_Setting_0 = l_v7_Setting_0 - v314.Magnitude;
                if v285 and not v278.Dragging and l_v7_Setting_0 <= 0 then
                    v278:InitDragging();
                end;
                if v278.Dragging then
                    local l_Item_7 = v278.Item;
                    local v316 = l_Item_7.GridSize[1];
                    local v317 = l_Item_7.GridSize[2];
                    local v318 = Vector2.new(v316 * v26 + (v316 - 1) * 1, v317 * v26 + (v317 - 1) * 1) * 0.5;
                    l_Item_7 = v280 - v318 + v2.GuiInset;
                    v278.Gui.Position = UDim2.new(0, l_Item_7.X, 0, l_Item_7.Y);
                    v248(v278, v280);
                end;
            end;
            return;
        end;
    end));
    v278.Maid:Give(v278.DragBegin:Connect(function() --[[ Line: 971 ]]
        -- upvalues: v278 (copy), l_Parent_0 (ref), l_v4_Gui_0 (ref), v26 (ref), v280 (ref), v2 (ref), v60 (ref), v268 (ref), v277 (ref)
        if v278.Destroyed then
            return;
        else
            v278.Gui.BorderTest.Visible = false;
            l_Parent_0 = v278.Gui.Parent;
            v278.Gui.Parent = l_v4_Gui_0;
            local l_Item_8 = v278.Item;
            local v320 = l_Item_8.GridSize[1];
            local v321 = l_Item_8.GridSize[2];
            local v322 = Vector2.new(v320 * v26 + (v320 - 1) * 1, v321 * v26 + (v321 - 1) * 1) * 0.5;
            l_Item_8 = v280 - v322 + v2.GuiInset;
            v278.Gui.Position = UDim2.new(0, l_Item_8.X, 0, l_Item_8.Y);
            v60(v278.Gui, 70);
            v278:Draw();
            v268(v278);
            v277(v278);
            return;
        end;
    end));
    v278.Maid:Give(v278.DragStopped:Connect(function() --[[ Line: 1001 ]]
        -- upvalues: v278 (copy), l_UserInputService_0 (ref), v2 (ref), v111 (ref), v280 (ref), v160 (ref), v16 (ref), v5 (ref), v0 (ref), v174 (ref), v165 (ref), v183 (ref), l_API_6 (copy), v212 (ref), l_Parent_0 (ref), v4 (ref)
        if v278.Destroyed then
            return;
        elseif not v278.Item then
            return;
        else
            local _ = l_UserInputService_0:GetMouseLocation() - v2.GuiInset;
            local v324, v325, v326 = v111(v278, v280);
            local v327, v328, _ = v160(v280, v278);
            local v330 = false;
            local v331 = true;
            local l_Item_9 = v278.Item;
            if v324 == "Hotbar" and v325 then
                local v333 = false;
                if v16:CanSlot(l_Item_9) then
                    if not l_Item_9.Parent.IsCarried then
                        v5:Send("Inventory Pickup Item", l_Item_9.Id);
                        v333 = true;
                    end;
                    v16:Slot(l_Item_9, v325);
                end;
                v330 = v333;
                v331 = not v333;
            elseif v324 == "Vicinity" then
                local v334 = true;
                if l_Item_9.Parent and l_Item_9.Parent.ClassName == "Container" and l_Item_9.Parent.Name == "Ground" then
                    v334 = false;
                end;
                if v334 then
                    v5:Send("Inventory Drop Item", l_Item_9.Id);
                    v330 = true;
                    v331 = false;
                end;
            elseif v324 == "Inventory" then
                if v327 == "Container" and v328 and v328.Item.OnCraft then
                    local v335 = v0.Classes.Players.get();
                    local v336 = if v335 and v335.Character then v335.Character else nil;
                    local v337 = true;
                    if v328.SpecialAmmoGui == v278 then
                        v337 = false;
                    end;
                    if v336 and v337 then
                        v328.Item:OnCraft(v336, l_Item_9);
                    end;
                else
                    local v338 = v174((v165(v278, v325, true)));
                    local v339, v340 = v183(v325.Container, v338, l_Item_9.GridSize, l_Item_9);
                    if v325.Name == "Ground" then
                        if l_Item_9.Parent and l_Item_9.Parent == v325.Container then
                            if not v325.Container:Insert(l_Item_9, v340) then
                                v325.Container:Insert(l_Item_9);
                            end;
                            v331 = true;
                        else
                            if l_Item_9.Parent and l_Item_9.Parent.ClassName == "Container" and l_Item_9.Parent:Remove(l_Item_9) and not v325.Container:Insert(l_Item_9, v340) then
                                v325.Container:Insert(l_Item_9);
                            end;
                            v5:Send("Inventory Drop Item", l_Item_9.Id);
                            v331 = true;
                        end;
                    elseif v339 then
                        if l_Item_9.Parent and l_Item_9.Parent.ClassName == "Container" then
                            if l_Item_9.Parent.Id == v325.Container.Id then
                                l_Item_9.GridPosition = v340;
                            elseif not v325.Container.IsCarried then
                                v330 = true;
                                v331 = false;
                            elseif l_Item_9.Parent:Remove(l_Item_9) then
                                if v325.Container:Insert(l_Item_9, v340) then
                                    l_Item_9.Changed:Fire("Manual fire");
                                end;
                                v330 = true;
                                v331 = false;
                            end;
                        end;
                        v5:Send("Inventory Move Item", l_Item_9.Id, v325.Container.Id, v340, l_Item_9.Rotated);
                    end;
                end;
            elseif v324 == "Dynamic Slot" and v325 then
                local l_Slot_1 = l_Item_9.Slot;
                if l_Item_9.Type == "Ammo" then
                    l_Slot_1 = "Ammo";
                end;
                if v325.Item and v325.Item.Attachments then
                    local v342 = v325.Item.Attachments[l_Slot_1];
                    if v342 and v342.Id ~= l_Item_9.Id or v342 == nil then
                        local v343 = v0.Classes.Players.get();
                        local v344 = if v343 and v343.Character then v343.Character else nil;
                        if v344 then
                            v325.Item:OnCraft(v344, l_Item_9);
                        end;
                    end;
                end;
            elseif v324 == "Utility" then
                local v345 = nil;
                local v346 = nil;
                local v347 = 1e999;
                local v348 = false;
                for v349, v350 in next, l_API_6.UtilitySlots do
                    local l_AbsolutePosition_18 = v350.AbsolutePosition;
                    local v352 = l_AbsolutePosition_18 + v350.AbsoluteSize;
                    local l_v280_1 = v280;
                    local l_AbsolutePosition_19 = v350.AbsolutePosition;
                    local v355 = l_AbsolutePosition_19 + v350.AbsoluteSize;
                    local v356 = false;
                    if l_v280_1.X >= l_AbsolutePosition_19.X then
                        v356 = l_v280_1.X <= v355.X;
                    end;
                    local v357 = false;
                    if l_v280_1.Y >= l_AbsolutePosition_19.Y then
                        v357 = l_v280_1.Y <= v355.Y;
                    end;
                    if v356 and v357 then
                        v345 = v349;
                        v348 = true;
                        break;
                    else
                        local v358 = Vector2.new(math.clamp(v280.X, l_AbsolutePosition_18.X, v352.X), (math.clamp(v280.Y, l_AbsolutePosition_18.Y, v352.Y)));
                        l_v280_1 = (v280 - v358).Magnitude;
                        if l_v280_1 < v347 then
                            v347 = l_v280_1;
                            v346 = v349;
                        end;
                    end;
                end;
                if not v348 then
                    v345 = v346;
                end;
                v330 = true;
                v331 = false;
                v5:Send("Inventory Slot Utility", v278.Item.Id, v345);
            elseif v324 == "Equipment" then
                local v359 = l_API_6.Inventory.Equipment[l_Item_9.EquipSlot];
                local l_v326_0 = v326;
                if not l_v326_0 then
                    local _, v362 = v212(v278, v280);
                    l_v326_0 = v362;
                end;
                if l_v326_0 and v359 and v359.Items then
                    v359 = v359.Items[l_v326_0];
                end;
                local v363 = l_Item_9.EquipSlot ~= nil;
                local v364 = false;
                if v359 and v359.Id == l_Item_9.Id then
                    v364 = true;
                end;
                if v363 and not v364 then
                    v5:Send("Inventory Equip Item", l_Item_9.Id, l_v326_0);
                    v330 = true;
                    v331 = false;
                end;
            else
                print("you dropped an item in a strange spot, where did you drop it?");
            end;
            if not v278.Destroyed then
                if v278.Gui then
                    v278.Gui.Parent = l_Parent_0;
                end;
                if v330 and v278.Gui then
                    v278.Gui.Visible = false;
                end;
                if v331 and v278.Gui then
                    v278:Draw();
                end;
            end;
            v4:Get("GameMenu"):GetAPI("Inventory"):SetDragMarks();
            return;
        end;
    end));
end;
v24.setDrawScale = function(v366) --[[ Line: 1280 ]] --[[ Name: setDrawScale ]]
    -- upvalues: v26 (ref)
    v26 = math.floor(44 * v366);
    return v26;
end;
v24.new = function(v367, v368) --[[ Line: 1286 ]] --[[ Name: new ]]
    -- upvalues: v20 (copy), v9 (copy), v10 (copy), v24 (copy), v365 (copy), v4 (copy)
    local v369 = {
        ClassName = "ItemGui", 
        Item = v367, 
        Id = v367.Id, 
        Name = v367.Name, 
        Parent = v368, 
        Gui = v20:Clone()
    };
    v369.SpinnerGui = v369.Gui:WaitForChild("Spinner");
    v369.LayerOrder = 0;
    v369.Gui.Label.Text = v369.Item.IconLabelText or "???";
    v369.Gui.Label.Backdrop.Text = v369.Gui.Label.Text;
    v369.DragBegin = v9.new();
    v369.DragStopped = v9.new();
    v369.DragFinished = v9.new();
    v369.GuiRotated = v9.new();
    v369.Maid = v10.new();
    v369.Rotated = false;
    v369.Dragging = false;
    v369.Destroyed = false;
    v369.IconDrawn = false;
    setmetatable(v369, v24);
    v365(v369);
    v4:Get("GameMenu"):GetAPI("Inventory"):AddToItemList(v369);
    return v369;
end;
v24.SetLayerOrder = function(v370, v371) --[[ Line: 1376 ]] --[[ Name: SetLayerOrder ]]
    v370.LayerOrder = v371;
end;
v24.PopEffect = function(v372, v373, v374) --[[ Line: 1380 ]] --[[ Name: PopEffect ]]
    -- upvalues: v21 (copy), l_TweenService_0 (copy), v29 (copy), v28 (copy)
    if not v372.Gui or v372.Destroyed then
        return;
    elseif v372.RunningPopEffect and not v373 then
        return;
    else
        v372.RunningPopEffect = true;
        local v375 = v21:Clone();
        v375.Position = v372.Gui.Position;
        v375.Size = v372.Gui.Size;
        if v374 then
            v375.ImageLabel.ImageColor3 = v374;
        end;
        local v376 = l_TweenService_0:Create(v375.ImageLabel, v29, v28);
        v376.Completed:Connect(function() --[[ Line: 1403 ]]
            -- upvalues: v375 (copy), v376 (copy), v372 (copy)
            v375:Destroy();
            v376:Destroy();
            v372.RunningPopEffect = false;
        end);
        v375.Parent = v372.Gui.Parent;
        v376:Play();
        return;
    end;
end;
v24.Destroy = function(v377) --[[ Line: 1414 ]] --[[ Name: Destroy ]]
    -- upvalues: v4 (copy)
    if v377.Destroyed then
        return;
    else
        v377.Destroyed = true;
        if v377.Maid then
            v377.Maid:Destroy();
            v377.Maid = nil;
        end;
        if v377.DragBegin then
            v377.DragBegin:Destroy();
            v377.DragBegin = nil;
        end;
        if v377.DragStopped then
            v377.DragStopped:Destroy();
            v377.DragStopped = nil;
        end;
        if v377.DragFinished then
            v377.DragFinished:Destroy();
            v377.DragFinished = nil;
        end;
        if v377.GuiRotated then
            v377.GuiRotated:Destroy();
            v377.GuiRotated = nil;
        end;
        if v377.Gui then
            v377.Gui:Destroy();
            v377.Gui = nil;
        end;
        v4:Get("GameMenu"):GetAPI("Inventory"):RemoveFromItemList(v377);
        if v377.Dragging then
            v377.Dragging = false;
            v4:Get("GameMenu"):GetAPI("Inventory").Dragging = false;
            v4:Get("GameMenu"):GetAPI("Inventory"):SetDragMarks();
        end;
        v377.Item = nil;
        v377.Parent = nil;
        setmetatable(v377, nil);
        return;
    end;
end;
v24.Draw = function(v378, v379) --[[ Line: 1468 ]] --[[ Name: Draw ]]
    -- upvalues: v8 (copy), v26 (ref), v60 (copy)
    if v378.Item.Visible == false then
        v378.Gui.Visible = false;
        return;
    else
        v378.Gui.Visible = true;
        if v378.Item then
            if v379 then
                pcall(function() --[[ Line: 1480 ]]
                    -- upvalues: v378 (copy)
                    v378.Gui.Item.WorldModel["View Model"]:SetAttribute("IconKey", nil);
                end);
            end;
            v8:SetViewportIcon(v378.Gui.Item, v378.Item, "Grid");
        end;
        local v380 = v378.Item.GridSize[1];
        local v381 = v378.Item.GridSize[2];
        if not v378.Dragging then
            local v382 = v378.Item.GridPosition[1];
            local v383 = v378.Item.GridPosition[2];
            v378.Gui.Position = UDim2.new(0, (v382 - 1) * v26 + v382 * 1, 0, (v383 - 1) * v26 + v383 * 1);
        end;
        v378.Gui.Size = UDim2.new(0, v380 * v26 + (v380 - 1) * 1, 0, v381 * v26 + (v381 - 1) * 1);
        v378.Gui.AnchorPoint = Vector2.new(0, 0);
        v378.Gui.Item.Size = v378.Item.Rotated and UDim2.new(v378.Gui.Size.Y, v378.Gui.Size.X) or v378.Gui.Size;
        v378.Gui.Item.Rotation = v378.Item.Rotated and 90 * v378.Item.IconRotationDirection or 0;
        v378.Gui.Item.AnchorPoint = Vector2.new(0.5, 0.5);
        v378.Gui.Item.Position = UDim2.new(0.5, 0, 0.5, 0);
        v378.Gui.Label.Visible = true;
        if v378.Dragging then
            v60(v378.Gui, 70);
        else
            v60(v378.Gui, 56);
        end;
        if v378.Dragging then
            v378.Gui.Border.Visible = true;
        else
            v378.Gui.Border.Visible = false;
        end;
        local v384 = 0;
        if v378.Item.Attachments then
            for v385, _ in next, v378.Item.Attachments do
                if v385 ~= "Ammo" then
                    v384 = v384 + 1;
                end;
            end;
        end;
        for _, v388 in next, v378.Gui.Attachments:GetChildren() do
            if v388:IsA("GuiBase") then
                v388.Visible = v388.LayoutOrder <= v384;
            end;
        end;
        if v378.Item.Type == "Firearm" then
            local v389 = false;
            local v390 = false;
            local v391 = nil;
            local v392 = 0;
            local v393 = 0;
            if v378.Item.FireConfig.InternalMag then
                v392 = v378.Item.Amount;
                v393 = v378.Item.FireConfig.InternalMagSize;
                v389 = true;
                v390 = true;
            elseif v378.Item.Attachments and v378.Item.Attachments.Ammo and not v378.AmmoDragged then
                local l_Id_0 = v378.Item.Attachments.Ammo.Id;
                local v395 = nil;
                for _, v397 in next, v378.Item.Attachments do
                    if v397.Id == l_Id_0 then
                        v395 = v397;
                    end;
                end;
                if v395 then
                    v392 = v395.Amount;
                    v393 = v395.Capacity;
                    v391 = v395.Name;
                    v389 = true;
                else
                    v389 = false;
                end;
                v390 = false;
            end;
            if v391 then
                v8:SetViewportIcon(v378.Gui.Ammo.Item, v391, "Dynamic");
                v378.Gui.Ammo.Item.NoItem.Visible = false;
            else
                v8:ClearViewportIcon(v378.Gui.Ammo.Item);
                v378.Gui.Ammo.Item.NoItem.Visible = true;
            end;
            if v389 then
                v378.Gui.Ammo.AmmoCount.Text = v392 .. "/" .. v393;
                v378.Gui.Ammo.AmmoCount.Backdrop.Text = v378.Gui.Ammo.AmmoCount.Text;
            else
                v378.Gui.Ammo.AmmoCount.Text = "Unloaded";
                v378.Gui.Ammo.AmmoCount.Backdrop.Text = v378.Gui.Ammo.AmmoCount.Text;
            end;
            if v390 then
                v378.Gui.Ammo.AmmoCount.Position = UDim2.new(0, -1, 1, 2);
                v378.Gui.Ammo.Item.Visible = false;
            else
                v378.Gui.Ammo.AmmoCount.Position = UDim2.new(1, 6, 1, 2);
                v378.Gui.Ammo.Item.Visible = true;
            end;
            v378.Gui.Ammo.Visible = true;
            return;
        elseif v378.Item.Type == "Ammo" then
            v378.Gui.Ammo.AmmoCount.Text = v378.Item.Amount .. "/" .. v378.Item.Capacity;
            v378.Gui.Ammo.AmmoCount.Backdrop.Text = v378.Gui.Ammo.AmmoCount.Text;
            v378.Gui.Ammo.AmmoCount.Position = UDim2.new(0, -1, 1, 2);
            v378.Gui.Ammo.Item.Visible = false;
            v378.Gui.Ammo.Visible = true;
            return;
        else
            v378.Gui.Ammo.Visible = false;
            return;
        end;
    end;
end;
v24.SetRotation = function(v398, v399, v400) --[[ Line: 1622 ]] --[[ Name: SetRotation ]]
    -- upvalues: v1 (copy)
    if v398.Dragging or v400 then
        local l_GridSize_0 = v1[v398.Item.Name].GridSize;
        v398.Item.Rotated = not not v399;
        if v398.Item.Rotated then
            v398.Item.GridSize = {
                l_GridSize_0[2], 
                l_GridSize_0[1]
            };
        else
            v398.Item.GridSize = {
                l_GridSize_0[1], 
                l_GridSize_0[2]
            };
        end;
        v398:Draw();
        v398.GuiRotated:Fire(v398.Item.Rotated);
    end;
end;
v24.InitDragging = function(v402) --[[ Line: 1639 ]] --[[ Name: InitDragging ]]
    -- upvalues: v51 (copy), v4 (copy)
    v51(v402);
    v4:Get("GameMenu"):GetAPI("Inventory").Dragging = true;
    v4:Get("GameMenu"):GetAPI("Inventory").DraggingItem = v402.Item;
    v402.Dragging = true;
    v402.DragBegin:Fire();
end;
v24.ClickBehavior = function(v403) --[[ Line: 1649 ]] --[[ Name: ClickBehavior ]]
    -- upvalues: v7 (copy), l_UserInputService_0 (copy), v5 (copy), v48 (copy), v4 (copy), v51 (copy)
    local v404 = true;
    if v7:GetSetting("Accessibility", "Quick Move Behavior") == "Legacy" then
        v404 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.LeftShift);
    end;
    if v404 then
        if v403.Item.Parent.ClassName == "Item" then
            v5:Send("Inventory Remove Attachment", v403.Item.Id, v403.Item.Parent.Id);
            v48(v403);
            return;
        elseif v403.Item.Parent.IsCarried or v403.Item.Parent.ClassName == "Inventory" then
            local l_VicinityContainersByHeight_0 = v4:Get("GameMenu"):GetAPI("Inventory"):GetVicinityContainersByHeight(true);
            local l_GridSize_1 = v403.Item.GridSize;
            local v407 = {
                l_GridSize_1[2], 
                l_GridSize_1[1]
            };
            local v408 = nil;
            local v409 = nil;
            local v410 = false;
            v48(v403);
            for v411 = 1, #l_VicinityContainersByHeight_0 do
                local v412 = l_VicinityContainersByHeight_0[v411];
                if v412 then
                    local v413, v414 = v412.Container:HasSpace(l_GridSize_1);
                    local v415, _ = v412.Container:HasSpace(v407);
                    if v413 then
                        v408 = v412;
                        v409 = v414;
                    elseif v415 then
                        v408 = v412;
                        v409 = v414;
                        v410 = true;
                    end;
                end;
                if v408 then
                    break;
                end;
            end;
            if v408 and v409 then
                local l_Rotated_0 = v403.Item.Rotated;
                if v410 then
                    l_Rotated_0 = not l_Rotated_0;
                end;
                v5:Send("Inventory Move Item", v403.Item.Id, v408.Container.Id, v409, v403.Item.Rotated);
                return;
            else
                v5:Send("Inventory Drop Item", v403.Item.Id);
                return;
            end;
        elseif not v403.Item.Parent.IsCarried then
            v51(v403);
            v5:Send("Inventory Pickup Item", v403.Item.Id);
        end;
    end;
end;
v24.RightClickBehavior = function(v418) --[[ Line: 1718 ]] --[[ Name: RightClickBehavior ]]
    -- upvalues: v190 (copy), v4 (copy), v5 (copy), v16 (copy), v51 (copy), v2 (copy), v6 (copy), v48 (copy), v18 (copy)
    local v419 = false;
    local v420 = false;
    local l_Item_10 = v418.Item;
    local v422 = v190();
    local v423 = {};
    local v424 = false;
    local v425 = false;
    local l_Inventory_1 = v4:Get("GameMenu"):GetAPI("Inventory").Inventory;
    local v427 = nil;
    if l_Inventory_1 and l_Inventory_1.Parent then
        v427 = l_Inventory_1.Parent;
    end;
    local function _(v428, v429, v430) --[[ Line: 1733 ]] --[[ Name: add ]]
        -- upvalues: v423 (copy)
        if not v430 then
            v430 = #v423 + 1;
        end;
        table.insert(v423, v430, {
            Name = v428, 
            Action = v429
        });
    end;
    local function v438() --[[ Line: 1741 ]] --[[ Name: equipAdds ]]
        -- upvalues: l_Item_10 (copy), v5 (ref), v423 (copy)
        if l_Item_10.EquipSlot then
            if l_Item_10.Parent and l_Item_10.Parent.ClassName == "Inventory" then
                local v432 = l_Item_10.UnequipText or "Unequip";
                local function v433() --[[ Line: 1744 ]]
                    -- upvalues: v5 (ref), l_Item_10 (ref)
                    v5:Send("Inventory Unequip Item", l_Item_10.Id);
                end;
                local v434 = nil or #v423 + 1;
                table.insert(v423, v434, {
                    Name = v432, 
                    Action = v433
                });
                return;
            else
                local v435 = l_Item_10.EquipText or "Equip";
                local function v436() --[[ Line: 1748 ]]
                    -- upvalues: v5 (ref), l_Item_10 (ref)
                    v5:Send("Inventory Equip Item", l_Item_10.Id);
                end;
                local v437 = nil or #v423 + 1;
                table.insert(v423, v437, {
                    Name = v435, 
                    Action = v436
                });
            end;
        end;
    end;
    local function v443() --[[ Line: 1755 ]] --[[ Name: hotbarAdds ]]
        -- upvalues: v16 (ref), l_Item_10 (copy), v423 (copy)
        if v16:CanSlot(l_Item_10) then
            if not v16:IsSlotted(l_Item_10) then
                local function v439() --[[ Line: 1758 ]]
                    -- upvalues: v16 (ref), l_Item_10 (ref)
                    v16:Slot(l_Item_10);
                end;
                local v440 = nil or #v423 + 1;
                table.insert(v423, v440, {
                    Name = "Add to Hotbar", 
                    Action = v439
                });
                return;
            else
                local function v441() --[[ Line: 1762 ]]
                    -- upvalues: v16 (ref), l_Item_10 (ref)
                    v16:Remove(l_Item_10);
                end;
                local v442 = nil or #v423 + 1;
                table.insert(v423, v442, {
                    Name = "Remove from Hotbar", 
                    Action = v441
                });
            end;
        end;
    end;
    if l_Item_10.Parent and l_Item_10.Parent.ClassName == "Container" then
        if l_Item_10.Parent.IsCarried then
            v425 = true;
        else
            v424 = true;
            local function v444() --[[ Line: 1777 ]]
                -- upvalues: v51 (ref), l_Item_10 (copy), v5 (ref)
                v51(l_Item_10);
                v5:Send("Inventory Pickup Item", l_Item_10.Id);
            end;
            table.insert(v423, 100 or #v423 + 1, {
                Name = "Pick up", 
                Action = v444
            });
        end;
    end;
    if v2.CosmeticSlots[l_Item_10.EquipSlot] and not v6:IsDiscovered(l_Item_10.Name) then
        local function v445() --[[ Line: 1786 ]]
            -- upvalues: v5 (ref), l_Item_10 (copy)
            v5:Send("Inventory Unlock Item", l_Item_10.Id);
        end;
        table.insert(v423, nil or #v423 + 1, {
            Name = "Unlock", 
            Action = v445
        });
    end;
    if l_Item_10.Type == "Ammo" then
        if l_Item_10.SubType == "Magazine" then
            if l_Item_10.Parent and l_Item_10.Parent.ClassName == "Item" and l_Item_10.Parent.Attachments.Ammo == l_Item_10 then
                local v446 = "Unload from " .. l_Item_10.Parent.DisplayName;
                local function v447() --[[ Line: 1794 ]]
                    -- upvalues: v5 (ref), l_Item_10 (copy)
                    v5:Send("Inventory Remove Attachment", l_Item_10.Id, l_Item_10.Parent.Id);
                end;
                table.insert(v423, nil or #v423 + 1, {
                    Name = v446, 
                    Action = v447
                });
            else
                local function v448() --[[ Line: 1798 ]]
                    -- upvalues: v5 (ref), l_Item_10 (copy)
                    v5:Send("Inventory Unload Ammo", l_Item_10.Id);
                end;
                table.insert(v423, nil or #v423 + 1, {
                    Name = "Empty to box", 
                    Action = v448
                });
                v448 = function() --[[ Line: 1802 ]]
                    -- upvalues: v5 (ref), l_Item_10 (copy)
                    v5:Send("Inventory Fill Ammo", l_Item_10.Id);
                end;
                table.insert(v423, nil or #v423 + 1, {
                    Name = "Fill from box", 
                    Action = v448
                });
            end;
            if v427 then
                for _, v450 in next, v422 do
                    if v450.Caliber == l_Item_10.Caliber then
                        local l_MagazineTypes_0 = v450.MagazineTypes;
                        local l_Name_0 = l_Item_10.Name;
                        local v453;
                        for _, v455 in next, l_MagazineTypes_0 do
                            if v455 == l_Name_0 then
                                v453 = true;
                                v419 = true;
                            end;
                            if v419 then
                                break;
                            end;
                        end;
                        if not v419 then
                            v453 = false;
                        end;
                        v419 = false;
                        if v453 then
                            v453 = "Load into " .. v450.DisplayName;
                            l_MagazineTypes_0 = function() --[[ Line: 1810 ]]
                                -- upvalues: v450 (copy), v427 (ref), l_Item_10 (copy)
                                v450:OnReload(v427, l_Item_10);
                            end;
                            table.insert(v423, nil or #v423 + 1, {
                                Name = v453, 
                                Action = l_MagazineTypes_0
                            });
                        end;
                    end;
                end;
            end;
        else
            if l_Item_10.Amount > 0 then
                local function v456() --[[ Line: 1820 ]]
                    -- upvalues: v5 (ref), l_Item_10 (copy)
                    v5:Send("Inventory Spread Ammo", l_Item_10.Id);
                end;
                table.insert(v423, nil or #v423 + 1, {
                    Name = "Spread ammo", 
                    Action = v456
                });
            end;
            local function v457() --[[ Line: 1825 ]]
                -- upvalues: v5 (ref), l_Item_10 (copy)
                v5:Send("Inventory Collect Ammo", l_Item_10.Id);
            end;
            table.insert(v423, nil or #v423 + 1, {
                Name = "Collect ammo", 
                Action = v457
            });
            if v427 then
                for _, v459 in next, v422 do
                    if v459.FireConfig.InternalMag and v459.Caliber == l_Item_10.Caliber then
                        local v460 = "Load into " .. v459.DisplayName;
                        local function v461() --[[ Line: 1832 ]]
                            -- upvalues: v459 (copy), v427 (ref), l_Item_10 (copy)
                            v459:OnReload(v427, l_Item_10);
                        end;
                        table.insert(v423, nil or #v423 + 1, {
                            Name = v460, 
                            Action = v461
                        });
                    end;
                end;
            end;
        end;
    elseif l_Item_10.Type == "Attachment" then
        if l_Item_10.Parent and l_Item_10.Parent.ClassName == "Item" and l_Item_10.Parent.Attachments[l_Item_10.Slot] == l_Item_10 then
            local v462 = "Detach from " .. l_Item_10.Parent.DisplayName;
            local function v463() --[[ Line: 1842 ]]
                -- upvalues: v5 (ref), l_Item_10 (copy)
                v5:Send("Inventory Remove Attachment", l_Item_10.Id, l_Item_10.Parent.Id);
            end;
            table.insert(v423, nil or #v423 + 1, {
                Name = v462, 
                Action = v463
            });
        else
            for _, v465 in next, v422 do
                local l_AttachmentTypes_0 = v465.AttachmentTypes;
                local l_Name_1 = l_Item_10.Name;
                local v468;
                for _, v470 in next, l_AttachmentTypes_0 do
                    if v470 == l_Name_1 then
                        v468 = true;
                        v420 = true;
                    end;
                    if v420 then
                        break;
                    end;
                end;
                if not v420 then
                    v468 = false;
                end;
                v420 = false;
                if v468 and v465.OnCraft then
                    v468 = "Attach onto " .. v465.DisplayName;
                    l_AttachmentTypes_0 = function() --[[ Line: 1848 ]]
                        -- upvalues: v465 (copy), v427 (ref), l_Item_10 (copy)
                        v465:OnCraft(v427, l_Item_10);
                    end;
                    table.insert(v423, nil or #v423 + 1, {
                        Name = v468, 
                        Action = l_AttachmentTypes_0
                    });
                end;
            end;
        end;
    elseif l_Item_10.Type == "Firearm" then
        v438();
        if l_Item_10.Attachments then
            local v471 = false;
            if l_Item_10.Attachments.Ammo then
                local v472 = "Unload " .. l_Item_10.Attachments.Ammo.DisplayName;
                local function v473() --[[ Line: 1862 ]]
                    -- upvalues: v5 (ref), l_Item_10 (copy)
                    v5:Send("Inventory Remove Attachment", l_Item_10.Attachments.Ammo.Id, l_Item_10.Id);
                end;
                table.insert(v423, nil or #v423 + 1, {
                    Name = v472, 
                    Action = v473
                });
            end;
            for v474, v475 in next, l_Item_10.Attachments do
                if v474 ~= "Ammo" then
                    v471 = true;
                    local v476 = "Detach" .. " " .. v475.DisplayName;
                    local function v477() --[[ Line: 1873 ]]
                        -- upvalues: v5 (ref), v475 (copy), l_Item_10 (copy)
                        v5:Send("Inventory Remove Attachment", v475.Id, l_Item_10.Id);
                    end;
                    table.insert(v423, nil or #v423 + 1, {
                        Name = v476, 
                        Action = v477
                    });
                end;
            end;
            if v471 then
                local function v478() --[[ Line: 1880 ]]
                    -- upvalues: v5 (ref), l_Item_10 (copy)
                    v5:Send("Inventory Strip Attachments", l_Item_10.Id);
                end;
                table.insert(v423, nil or #v423 + 1, {
                    Name = "Strip Attachments", 
                    Action = v478
                });
            end;
        end;
        if not v424 then
            v443();
        end;
    elseif l_Item_10.Type == "Melee" then
        v438();
        if not v424 then
            v443();
        end;
    elseif l_Item_10.Type == "Utility" then
        if l_Item_10.GetRightClickActions then
            for v479, v480 in next, l_Item_10:GetRightClickActions(v427) do
                table.insert(v423, nil or #v423 + 1, {
                    Name = v479, 
                    Action = v480
                });
            end;
        end;
        if l_Item_10.CanSlotAsUtility and v427 and v427.Inventory then
            if not v427.Inventory:IsUtilitySlotted(l_Item_10) then
                local function v481() --[[ Line: 1914 ]]
                    -- upvalues: v5 (ref), l_Item_10 (copy)
                    v5:Send("Inventory Slot Utility", l_Item_10.Id);
                end;
                table.insert(v423, nil or #v423 + 1, {
                    Name = "Slot Utility", 
                    Action = v481
                });
            else
                local function v482() --[[ Line: 1918 ]]
                    -- upvalues: v5 (ref), l_Item_10 (copy)
                    v5:Send("Inventory Remove Utility", l_Item_10.Id);
                end;
                table.insert(v423, nil or #v423 + 1, {
                    Name = "Remove Utility", 
                    Action = v482
                });
            end;
        end;
        if not v424 then
            v443();
        end;
    elseif l_Item_10.EquipSlot ~= nil then
        v438();
    end;
    if l_Item_10.ConsumeConfig then
        local v483 = "Use";
        if l_Item_10.Type == "Consumable" then
            v483 = "Consume";
        end;
        local l_v483_0 = v483;
        local function v485() --[[ Line: 1940 ]]
            -- upvalues: v427 (ref), l_Item_10 (copy)
            if v427 then
                v427:EquipOverwriteUseSequence(l_Item_10);
            end;
        end;
        table.insert(v423, nil or #v423 + 1, {
            Name = l_v483_0, 
            Action = v485
        });
        if not v424 then
            v443();
        end;
    end;
    if l_Item_10.CanTakeCosmeticSkins then
        if l_Item_10.SkinId ~= "" then
            local function v486() --[[ Line: 1953 ]]
                -- upvalues: v5 (ref), l_Item_10 (copy)
                v5:Send("Inventory Unpaint Item", l_Item_10.Id);
            end;
            table.insert(v423, nil or #v423 + 1, {
                Name = "Remove Skin", 
                Action = v486
            });
            v486 = function() --[[ Line: 1957 ]]
                -- upvalues: v4 (ref)
                local v487 = v4:Get("GameMenu");
                if v487 then
                    local l_v487_API_0 = v487:GetAPI("Skins");
                    if l_v487_API_0 then
                        l_v487_API_0:SetTab("Collection");
                        v487:Show("Skins");
                    end;
                end;
            end;
            table.insert(v423, nil or #v423 + 1, {
                Name = "Change Skin", 
                Action = v486
            });
        else
            local function v491() --[[ Line: 1970 ]]
                -- upvalues: v4 (ref)
                local v489 = v4:Get("GameMenu");
                if v489 then
                    local l_v489_API_0 = v489:GetAPI("Skins");
                    if l_v489_API_0 then
                        l_v489_API_0:SetTab("Collection");
                        v489:Show("Skins");
                    end;
                end;
            end;
            table.insert(v423, nil or #v423 + 1, {
                Name = "Add Skin", 
                Action = v491
            });
        end;
    end;
    if v425 then
        local function v492() --[[ Line: 1986 ]]
            -- upvalues: v48 (ref), l_Item_10 (copy), v5 (ref)
            v48(l_Item_10);
            v5:Send("Inventory Drop Item", l_Item_10.Id);
        end;
        table.insert(v423, nil or #v423 + 1, {
            Name = "Drop", 
            Action = v492
        });
    end;
    if #v423 > 0 then
        v18:Open(v423);
    end;
end;
return v24;