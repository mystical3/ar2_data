local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "ItemData");
local _ = v0.require("Configs", "Globals");
local v3 = v0.require("Libraries", "Network");
local v4 = v0.require("Libraries", "Resources");
local _ = v0.require("Libraries", "World");
local v6 = v0.require("Libraries", "Raycasting");
local v7 = v0.require("Classes", "Signals");
local v8 = v0.require("Classes", "Containers");
local v9 = v0.require("Classes", "Items");
local v10 = v0.require("Classes", "Maids");
local _ = game:GetService("RunService");
local _ = v4:Find("Workspace.Map.Client.Elements");
local _ = v4:Find("Workspace.Corpses");
local v14 = {};
v14.__index = v14;
v14.ClassName = "Inventory";
local function _() --[[ Line: 32 ]] --[[ Name: findCurrentInventory ]]
    -- upvalues: v0 (copy)
    local l_Players_0 = v0.Classes.Players;
    local v16 = l_Players_0 and l_Players_0.get();
    local v17 = v16 and v16.Character;
    return v17 and v17.Inventory;
end;
local function _(v19, v20) --[[ Line: 42 ]] --[[ Name: checkForUnequip ]]
    if v19.Parent and v19.Parent.EquippedItem and v19.Parent.EquippedItem.Id == v20.Id then
        v19.Parent:Unequip();
    end;
end;
local function _(v22, v23) --[[ Line: 50 ]] --[[ Name: isSameValue ]]
    if type(v22) == "table" and type(v23) == "table" then
        for v24 in next, v23 do
            if v22[v24] ~= v23[v24] then
                return false;
            end;
        end;
        return true;
    else
        return v22 == v23;
    end;
end;
local function v26(v27, v28) --[[ Line: 64 ]] --[[ Name: setProperties ]]
    -- upvalues: v26 (copy), v9 (copy)
    local v29 = false;
    local v30 = false;
    local v31 = {};
    v27.Changed:Disable();
    for v32, v33 in next, v28 do
        if v33 == "__NIL" then
            v33 = nil;
        end;
        if type(v33) == "table" and v32 == "Attachments" then
            for v34, v35 in next, v27.Attachments do
                if not v28.Attachments[v34] or v28.Attachments[v34].Id ~= v35.Id then
                    v27.Attachments[v34]:Destroy();
                    v27.Attachments[v34] = nil;
                    v30 = true;
                    v31 = true;
                elseif v28.Attachments[v34].Id ~= v35.Id or v26(v27.Attachments[v34], v28.Attachments[v34]) then

                end;
            end;
            for v36, v37 in next, v28.Attachments do
                if not v27.Attachments[v36] then
                    v27.Attachments[v36] = v9.new(v37.Name, v37.Id, v27);
                    if not v27.Attachments[v36] or v26(v27.Attachments[v36], v37) then

                    end;
                    v31 = true;
                end;
            end;
        elseif v32 ~= "Parent" and v32 ~= "Id" and v32 ~= "Name" then
            local v38 = v27[v32];
            local l_v33_0 = v33;
            local v40;
            if type(v38) == "table" and type(l_v33_0) == "table" then
                for v41 in next, l_v33_0 do
                    if v38[v41] ~= l_v33_0[v41] then
                        v40 = false;
                        v29 = true;
                    end;
                    if v29 then
                        break;
                    end;
                end;
                if not v29 then
                    v40 = true;
                end;
            else
                v40 = v38 == l_v33_0;
            end;
            v29 = false;
            if not v40 then
                v27[v32] = v33;
                v30 = true;
            end;
        end;
    end;
    v27.Changed:Enable();
    if v30 then
        v27.Changed:Fire();
    end;
    if v31 then
        v27:FireChanged("Attachments");
    end;
    return v30;
end;
local function v56(v42, v43, v44) --[[ Line: 138 ]] --[[ Name: setContainerInventory ]]
    -- upvalues: v26 (copy), v9 (copy)
    local v45 = false;
    for _, v47 in next, v43.Occupants do
        local v48 = 0;
        local v49 = nil;
        for v50, v51 in next, v44 do
            if v51.Id == v47.Id then
                v48 = v50;
                v49 = v51;
                break;
            end;
        end;
        if v49 then
            local l_GridPosition_0 = v47.GridPosition;
            if v26(v47, v49) then
                v45 = true;
            end;
            if v43 == v42.GroundContainer then
                v47.GridPosition = l_GridPosition_0;
            end;
            v44[v48] = nil;
        elseif v43:Remove(v47.Id) then
            v45 = true;
            if v42.Parent and v42.Parent.EquippedItem and v42.Parent.EquippedItem.Id == v47.Id then
                v42.Parent:Unequip();
            end;
            v47:Destroy();
        end;
    end;
    for _, v54 in next, v44 do
        local v55 = v9.new(v54.Name, v54.Id, v43);
        if v55 then
            v26(v55, v54);
            if v43 == v42.GroundContainer then
                v43:Insert(v55);
            else
                v43.Occupants[v55.Id] = v55;
                if v43.IsCarried then
                    v42.CarriedItemAdded:Fire(v55);
                end;
            end;
            v45 = true;
        end;
    end;
    v43:RebuildGrid();
    if v45 then
        v42.InventoryChanged:Fire();
    end;
end;
local function v71(v57, v58) --[[ Line: 211 ]] --[[ Name: setEquipment ]]
    -- upvalues: v26 (copy), v9 (copy)
    local v59 = false;
    for v60, v61 in next, v57.Equipment do
        if v57:IsEquipSlotList(v60) then
            for v62, v63 in next, v61.Items do
                local v64 = v58[v60].Items[v62];
                if v64 and v64.Id == v63.Id then
                    if v26(v63, v64) then
                        v59 = true;
                    end;
                    v58[v60].Items[v62] = nil;
                elseif not v64 then
                    if v57.Parent and v57.Parent.EquippedItem and v57.Parent.EquippedItem.Id == v63.Id then
                        v57.Parent:Unequip();
                    end;
                    v61.Items[v62] = nil;
                    v57.EquipmentRemoved:Fire(v63);
                    v63:Destroy();
                    v59 = true;
                end;
            end;
        elseif v58[v60] and v58[v60].Id == v61.Id then
            if v26(v61, v58[v60]) then
                v59 = true;
            end;
            v58[v60] = nil;
        elseif not v58[v60] then
            if v57.Parent and v57.Parent.EquippedItem and v57.Parent.EquippedItem.Id == v61.Id then
                v57.Parent:Unequip();
            end;
            v57.Equipment[v60] = nil;
            v57.EquipmentRemoved:Fire(v61);
            v61:Destroy();
            v59 = true;
        end;
    end;
    for v65, v66 in next, v58 do
        if v57:IsEquipSlotList(v65) then
            for v67, v68 in next, v66.Items do
                local v69 = v9.new(v68.Name, v68.Id, v57);
                if v69 then
                    v26(v69, v68);
                    v57.Equipment[v65].Items[v67] = v69;
                    v57.EquipmentAdded:Fire(v68);
                    v57.CarriedItemAdded:Fire(v68);
                    v59 = true;
                end;
            end;
        else
            local v70 = v9.new(v66.Name, v66.Id, v57);
            if v70 then
                v26(v70, v66);
                v57.Equipment[v65] = v70;
                v57.EquipmentAdded:Fire(v70);
                v57.CarriedItemAdded:Fire(v70);
                v59 = true;
            end;
        end;
    end;
    if v59 then
        v57.EquipmentChanged:Fire();
        v57.InventoryChanged:Fire();
    end;
end;
local function v84(v72, v73) --[[ Line: 293 ]] --[[ Name: setUtilities ]]
    -- upvalues: v26 (copy), v9 (copy)
    local v74 = false;
    local v75 = {};
    for v76, v77 in next, v73 do
        v75[tonumber(v76)] = v77;
    end;
    for v78, v79 in next, v72.Utilities do
        local v80 = v75[v78];
        if v80 and v80.Id == v79.Id then
            if v26(v79, v75[v78]) then
                v74 = true;
            end;
            v75[v78] = nil;
        elseif not v75[v78] then
            if v72.Parent and v72.Parent.EquippedItem and v72.Parent.EquippedItem.Id == v79.Id then
                v72.Parent:Unequip();
            end;
            v72.Utilities[v78] = nil;
            v72.UtilityRemoved:Fire(v79);
            v79:Destroy();
            v74 = true;
        end;
    end;
    for v81, v82 in next, v75 do
        local v83 = v9.new(v82.Name, v82.Id, v72);
        if v83 then
            v26(v83, v82);
            v72.Utilities[v81] = v83;
            v72.UtilityAdded:Fire(v83);
            v72.CarriedItemAdded:Fire(v83);
            v74 = true;
        end;
    end;
    if v74 then
        v72.UtilityChanged:Fire();
        v72.InventoryChanged:Fire();
    end;
end;
v14.new = function(v85, v86) --[[ Line: 353 ]] --[[ Name: new ]]
    -- upvalues: v14 (copy), v10 (copy), v7 (copy), v0 (copy), v8 (copy), v56 (copy), v71 (copy), v84 (copy)
    local l_Id_0 = v86.Inventory.Id;
    local l_Dump_0 = v86.Inventory.Dump;
    local v89 = setmetatable({}, v14);
    v89.Id = l_Id_0;
    v89.Parent = v85;
    v89.Containers = {};
    v89.Utilities = {};
    v89.Equipment = {
        Accessory = {
            IsMultiSlot = true, 
            Indexes = {
                "1", 
                "2"
            }, 
            Items = {}
        }
    };
    v89.BaseContainer = nil;
    v89.GroundContainer = nil;
    v89.Maid = v10.new();
    v89.ContainerAdded = v89.Maid:Give(v7.new());
    v89.ContainerRemoved = v89.Maid:Give(v7.new());
    v89.EquipmentChanged = v89.Maid:Give(v7.new());
    v89.EquipmentRemoved = v89.Maid:Give(v7.new());
    v89.EquipmentAdded = v89.Maid:Give(v7.new());
    v89.UtilityChanged = v89.Maid:Give(v7.new());
    v89.UtilityRemoved = v89.Maid:Give(v7.new());
    v89.UtilityAdded = v89.Maid:Give(v7.new());
    v89.InventoryChanged = v89.Maid:Give(v7.new());
    v89.CarriedItemAdded = v89.Maid:Give(v7.new());
    for _, v91 in next, l_Dump_0.Containers do
        local v92 = v89:AddContainer(v91.Id, v91.Type, v91.Name, v91.Displayname, v91.Size, v91.IsCarried);
        if v91.Name == "Ground" then
            v92.Insert = function(v93, v94, v95) --[[ Line: 400 ]]
                -- upvalues: v0 (ref), v8 (ref), v92 (copy)
                local v96 = v0.Libraries.Interface:IsVisible("GameMenu");
                local l_InventoryOpening_0 = v93.InventoryOpening;
                if v96 or l_InventoryOpening_0 then
                    return v8.Insert(v92, v94, v95);
                else
                    v93.Occupants[v94.Id] = v94;
                    v93.OccupantAdded:Fire(v94);
                    return true;
                end;
            end;
            v89.GroundContainer = v92;
        end;
        v56(v89, v92, v91.Occupants);
    end;
    v71(v89, l_Dump_0.Equipment);
    v84(v89, l_Dump_0.Utilities);
    v89.EquipmentRemoved:Connect(function(v98) --[[ Line: 425 ]]
        -- upvalues: v89 (copy)
        if v89.Parent.EquippedItem == v98 then
            v89.Parent:Unequip();
        end;
    end);
    v89.UtilityRemoved:Connect(function(v99) --[[ Line: 431 ]]
        -- upvalues: v89 (copy)
        if v89.Parent.EquippedItem == v99 then
            v89.Parent:Unequip();
        end;
    end);
    return v89;
end;
v14.Destroy = function(v100) --[[ Line: 444 ]] --[[ Name: Destroy ]]
    if v100.Destroyed then
        return;
    else
        v100.Destroyed = true;
        for _, v102 in next, v100.Equipment do
            if v102.IsMultiSlot then
                for _, v104 in next, v102.Items do
                    if v104.Destroy then
                        v104:Destroy();
                    end;
                end;
                table.clear(v102.Items);
            elseif v102.Destroy then
                v102:Destroy();
            end;
        end;
        for _, v106 in next, v100.Utilities do
            v106:Destroy();
        end;
        for _, v108 in next, v100.Containers do
            v108:Destroy();
        end;
        if v100.Maid then
            v100.Maid:Destroy();
            v100.Maid = nil;
        end;
        setmetatable(v100, nil);
        table.clear(v100);
        v100.Destroyed = true;
        return;
    end;
end;
v14.IsEquipSlotList = function(v109, v110) --[[ Line: 486 ]] --[[ Name: IsEquipSlotList ]]
    if v109.Equipment then
        local v111 = v109.Equipment[v110];
        if typeof(v111) == "table" and v111.IsMultiSlot then
            return true;
        end;
    end;
    return false;
end;
v14.IsItemEquipped = function(v112, v113) --[[ Line: 498 ]] --[[ Name: IsItemEquipped ]]
    if v113 and v113.EquipSlot then
        if v112:IsEquipSlotList(v113.EquipSlot) then
            for v114, v115 in next, v112.Equipment[v113.EquipSlot].Items do
                if v115.Id == v113.Id then
                    return true, v113.EquipSlot, v114;
                end;
            end;
        else
            local v116 = v112.Equipment[v113.EquipSlot];
            if v116 and v116.Id == v113.Id then
                return true, v113.EquipSlot, nil;
            end;
        end;
    end;
    return false, nil, nil;
end;
v14.IsUtilitySlotted = function(v117, v118) --[[ Line: 518 ]] --[[ Name: IsUtilitySlotted ]]
    if not v118 then
        return false, 0;
    else
        local l_v118_0 = v118;
        if typeof(l_v118_0) == "table" then
            l_v118_0 = v118.Id;
        end;
        for v120, v121 in next, v117.Utilities do
            if v121.Id == l_v118_0 then
                return true, v120;
            end;
        end;
        return false, 0;
    end;
end;
v14.FindContainer = function(v122, v123) --[[ Line: 538 ]] --[[ Name: FindContainer ]]
    for _, v125 in next, v122.Containers do
        if v125.Id == v123 then
            return v125;
        end;
    end;
end;
v14.FindItem = function(v126, v127, v128) --[[ Line: 546 ]] --[[ Name: FindItem ]]
    if not v128 then
        for v129, v130 in next, v126.Equipment do
            if v126:IsEquipSlotList(v129) then
                for _, v132 in next, v130.Items do
                    if v132.Id == v127 then
                        return v132, v126;
                    end;
                end;
            elseif v130.Id == v127 then
                return v130, v126;
            end;
        end;
        for _, v134 in next, v126.Utilities do
            if v134.Id == v127 then
                return v134, v126;
            end;
        end;
    end;
    for _, v136 in next, v126.Containers do
        for _, v138 in next, v136.Occupants do
            if v138.Id == v127 then
                return v138, v136;
            end;
        end;
    end;
    return nil;
end;
v14.SetVisibility = function(v139) --[[ Line: 579 ]] --[[ Name: SetVisibility ]]
    -- upvalues: v6 (copy)
    local l_p_0 = workspace.CurrentCamera.CFrame.p;
    local l_Position_0 = v139.Parent.RootPart.Position;
    if v139.GroundContainer then
        for _, v143 in next, v139.GroundContainer.Occupants do
            if v143.NodeObject and not v143.NodeObject:GetAttribute("Locked") then
                local l_p_1 = v143.NodeObject.Value.p;
                local v145 = false;
                local v146 = ((l_p_1 - l_Position_0) * Vector3.new(1, 0, 1, 0)).Magnitude <= 5;
                if math.abs(l_p_1.Y - l_Position_0.Y) <= 7 and v146 then
                    for _, v148 in next, {
                        l_p_0, 
                        l_Position_0
                    } do
                        local v149 = Ray.new(v148, l_p_1 - v148);
                        local _, v151 = v6:LootNodeCast(v149, true);
                        if (l_p_1 - v151).magnitude < 0.3 then
                            v145 = true;
                            break;
                        end;
                    end;
                end;
                v143.Visible = v145;
            else
                v143.Visible = false;
            end;
        end;
    end;
end;
v14.AddContainer = function(v152, v153, v154, v155, v156, v157, v158) --[[ Line: 614 ]] --[[ Name: AddContainer ]]
    -- upvalues: v8 (copy)
    local l_v152_Container_0 = v152:FindContainer(v153);
    if l_v152_Container_0 then
        return l_v152_Container_0;
    else
        local v160 = v8.new(v153, v154, v155, v157, v152);
        v160.DisplayName = v156 or v155;
        v160.IsCarried = not not v158;
        table.insert(v152.Containers, v160);
        v152.ContainerAdded:Fire(v160);
        return v160;
    end;
end;
v14.RemoveContainer = function(v161, v162) --[[ Line: 631 ]] --[[ Name: RemoveContainer ]]
    local v163 = nil;
    if type(v162) == "table" and v162.ClassName == "Container" then
        v163 = v162;
    else
        for _, v165 in next, v161.Containers do
            if v165.Id == v162 then
                v163 = v165;
                break;
            end;
        end;
    end;
    if v163 then
        for v166, v167 in next, v161.Containers do
            if v167 == v163 then
                local v168 = table.remove(v161.Containers, v166);
                v161.ContainerRemoved:Fire(v167);
                return v168;
            end;
        end;
    end;
    return false;
end;
v14.Refresh = function(v169) --[[ Line: 660 ]] --[[ Name: Refresh ]]
    for _, v171 in next, v169.Containers do
        v171.GridRebuilt:Fire();
    end;
    v169.EquipmentChanged:Fire();
end;
v14.IsItemHeld = function(v172, v173, v174, v175) --[[ Line: 668 ]] --[[ Name: IsItemHeld ]]
    if not v173 then
        return false;
    else
        local l_v173_0 = v173;
        if typeof(v173) == "table" then
            l_v173_0 = v173.Id;
        end;
        if not v174 then
            for v177, v178 in next, v172.Equipment do
                if v172:IsEquipSlotList(v177) then
                    for _, v180 in next, v178.Items do
                        if v180.Id == l_v173_0 then
                            return true, true;
                        end;
                    end;
                elseif v178.Id == l_v173_0 then
                    return true, true;
                end;
            end;
        end;
        if not v175 then
            for _, v182 in next, v172.Utilities do
                if v182.Id == l_v173_0 then
                    return true, true;
                end;
            end;
        end;
        for _, v184 in next, v172.Containers do
            for _, v186 in next, v184.Occupants do
                if v186.Id == l_v173_0 then
                    return true, v184.IsCarried;
                end;
            end;
        end;
        return false, false;
    end;
end;
v3:Add("Inventory Sound Replication", function(v187, v188) --[[ Line: 716 ]]
    -- upvalues: v4 (copy)
    if not v188 then
        return;
    else
        local v189 = v4:Get("ReplicatedStorage.Assets.Sounds." .. v187, v188);
        v189.SoundGroup = v4:Find("SoundService.Characters");
        v189.Ended:Connect(function() --[[ Line: 724 ]]
            -- upvalues: v189 (copy)
            v189:Destroy();
        end);
        v189:Play();
        return;
    end;
end);
v3:Add("Container Changed", function(v190) --[[ Line: 731 ]]
    -- upvalues: v0 (copy), v56 (copy)
    local l_Players_1 = v0.Classes.Players;
    local v192 = l_Players_1 and l_Players_1.get();
    local v193 = v192 and v192.Character;
    local v194 = v193 and v193.Inventory;
    if v194 then
        l_Players_1 = v194:FindContainer(v190.Id);
        if l_Players_1 then
            v56(v194, l_Players_1, v190.Occupants);
        end;
    end;
end);
v3:Add("Inventory Container Added", function(v195, v196) --[[ Line: 744 ]]
    -- upvalues: v0 (copy), v56 (copy)
    local l_Players_2 = v0.Classes.Players;
    local v198 = l_Players_2 and l_Players_2.get();
    local v199 = v198 and v198.Character;
    local v200 = v199 and v199.Inventory;
    if v200 and v200.Id == v195 then
        l_Players_2 = v200:AddContainer(v196.Id, v196.Type, v196.Name, v196.DisplayName, v196.Size, v196.IsCarried);
        l_Players_2.DisplayName = v196.DisplayName;
        l_Players_2.WorldPosition = v196.WorldPosition;
        l_Players_2.Instance = v196.Instance;
        v56(v200, l_Players_2, v196.Occupants);
    end;
end);
v3:Add("Inventory Container Removed", function(v201, v202) --[[ Line: 766 ]]
    -- upvalues: v0 (copy)
    local l_Players_3 = v0.Classes.Players;
    local v204 = l_Players_3 and l_Players_3.get();
    local v205 = v204 and v204.Character;
    local v206 = v205 and v205.Inventory;
    if v206 and v206.Id == v201 then
        l_Players_3 = v206:RemoveContainer(v202);
        if l_Players_3 then
            l_Players_3:Destroy();
        end;
    end;
end);
v3:Add("Inventory Equipment Changed", function(v207, v208) --[[ Line: 778 ]]
    -- upvalues: v0 (copy), v71 (copy)
    local l_Players_4 = v0.Classes.Players;
    local v210 = l_Players_4 and l_Players_4.get();
    local v211 = v210 and v210.Character;
    local v212 = v211 and v211.Inventory;
    if v212 and v212.Id == v207 then
        v71(v212, v208);
    end;
end);
v3:Add("Inventory Utilities Changed", function(v213, v214) --[[ Line: 786 ]]
    -- upvalues: v0 (copy), v84 (copy)
    local l_Players_5 = v0.Classes.Players;
    local v216 = l_Players_5 and l_Players_5.get();
    local v217 = v216 and v216.Character;
    local v218 = v217 and v217.Inventory;
    if v218 and v218.Id == v213 then
        v84(v218, v214);
    end;
end);
v3:Add("Inventory Item Changed", function(v219, v220, v221, v222) --[[ Line: 794 ]]
    -- upvalues: v0 (copy), v26 (copy)
    local l_Players_6 = v0.Classes.Players;
    local v224 = l_Players_6 and l_Players_6.get();
    local v225 = v224 and v224.Character;
    local v226 = v225 and v225.Inventory;
    if v226 and v226.Id == v219 then
        l_Players_6, v224 = v226:FindItem(v220);
        if l_Players_6 then
            v225 = l_Players_6.GridPosition;
            local l_v222_0 = v222;
            if l_v222_0 == nil then
                l_v222_0 = "__NIL";
            end;
            if v26(l_Players_6, {
                [v221] = l_v222_0
            }) then
                if l_Players_6.Parent == v226.GroundContainer then
                    l_Players_6.GridPosition = v225;
                end;
                v226.InventoryChanged:Fire();
            end;
        end;
    end;
end);
return v14;