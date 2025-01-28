local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "ItemData");
local v2 = v0.require("Configs", "Globals");
local v3 = v0.require("Configs", "PerkTuning");
local v4 = v0.require("Libraries", "Interface");
local v5 = v0.require("Libraries", "World");
local v6 = v0.require("Libraries", "Network");
local v7 = v0.require("Libraries", "Resources");
local v8 = v0.require("Libraries", "Keybinds");
local v9 = v0.require("Libraries", "Raycasting");
local v10 = v0.require("Libraries", "UserSettings");
local _ = v0.require("Classes", "Items");
local v12 = v0.require("Classes", "Steppers");
local v13 = v4:Get("Vehicle");
local v14 = v4:Get("Mouse");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local _ = v7:Find("Workspace.Map.Client");
local _ = v7:Find("Workspace.Map.Shared");
local v20 = v7:Find("Workspace.Map.Shared.LootBins");
local v21 = v7:Find("ReplicatedStorage.Chunking.Container Data");
local _ = v7:Find("Workspace.Characters");
local _ = v7:Find("Workspace.Zombies");
local v24 = v7:Find("Workspace.Corpses");
local v25 = {
    Gui = v4:GetGui("Interact")
};
local v26 = nil;
local v27 = nil;
local v28 = 0;
local v29 = nil;
local v30 = false;
local v31 = nil;
local v32 = nil;
local v33 = "";
local v34 = nil;
local l_IconImages_0 = v4:Get("Controls"):GetIconImages();
local l_KeyAliases_0 = v4:Get("Controls"):GetKeyAliases();
local l_Lengths_0, v38 = v4:Get("Controls"):GetLengths();
local _ = Color3.fromRGB(255, 190, 40);
local _ = Color3.fromRGB(255, 40, 40);
local v41 = Color3.fromRGB(143, 143, 143);
local function _() --[[ Line: 62 ]] --[[ Name: getMouseRay ]]
    -- upvalues: l_UserInputService_0 (copy)
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    local v43 = workspace.CurrentCamera:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y);
    return (Ray.new(v43.Origin, v43.Direction * 150));
end;
local _ = function(_) --[[ Line: 70 ]] --[[ Name: getWorldInfo ]]
    -- upvalues: l_UserInputService_0 (copy), v9 (copy)
    local l_l_UserInputService_0_MouseLocation_1 = l_UserInputService_0:GetMouseLocation();
    local v47 = workspace.CurrentCamera:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_1.X, l_l_UserInputService_0_MouseLocation_1.Y);
    local v48 = Ray.new(v47.Origin, v47.Direction * 150);
    l_l_UserInputService_0_MouseLocation_1, v47 = v9:InteractCast(v48);
    return l_l_UserInputService_0_MouseLocation_1, v47, v48;
end;
local function v50() --[[ Line: 77 ]] --[[ Name: defaultFindItemDataReturn ]]
    return Vector3.new(), false;
end;
local function v66(v51, v52) --[[ Line: 81 ]] --[[ Name: findVehicleInteractPoint ]]
    -- upvalues: v13 (copy), l_CollectionService_0 (copy)
    local l_Interaction_0 = v51:FindFirstChild("Interaction");
    local l_Wheels_0 = v51:FindFirstChild("Wheels");
    if l_Interaction_0 then
        local l_v13_InteractionRange_0 = v13:GetInteractionRange();
        local l_l_Interaction_0_Children_0 = l_Interaction_0:GetChildren();
        local v57 = {};
        if l_Wheels_0 then
            for _, v59 in next, l_Wheels_0:GetChildren() do
                local v60 = v59:FindFirstChild("Rim") or v59.PrimaryPart;
                if v60 then
                    table.insert(l_l_Interaction_0_Children_0, v60);
                end;
            end;
        end;
        for _, v62 in next, l_l_Interaction_0_Children_0 do
            if v62:IsA("BasePart") and not l_CollectionService_0:HasTag(v62, "Vehicle Interact Ignore") then
                local l_Magnitude_0 = (v62.Position - v52).Magnitude;
                if l_Magnitude_0 <= l_v13_InteractionRange_0 then
                    table.insert(v57, {
                        Part = v62, 
                        Distance = l_Magnitude_0
                    });
                end;
            end;
        end;
        table.sort(v57, function(v64, v65) --[[ Line: 117 ]]
            return v64.Distance < v65.Distance;
        end);
        return v57[1];
    else
        return nil;
    end;
end;
local function v125(v67, v68, v69, v70) --[[ Line: 127 ]] --[[ Name: findItemData ]]
    -- upvalues: v50 (copy), v10 (copy), v0 (copy), v2 (copy), v13 (copy), v66 (copy), v24 (copy), v41 (copy), v20 (copy), v21 (copy), v5 (copy), v9 (copy), v3 (copy), l_CollectionService_0 (copy), l_UserInputService_0 (copy)
    if not v68 then
        return nil, "", v50, 0, "", nil;
    elseif v10:GetSetting("Character", "Automatic Ladders") == "Off" and v68:IsA("BasePart") and (v68.Name == "Ladder" or v68.Name == "LadderTopMount") and not v67.Parent.Climbing then
        return v68, "Ladders", function() --[[ Line: 136 ]] --[[ Name: getDrawPos ]]
            -- upvalues: v67 (copy), v68 (copy), v0 (ref), v2 (ref)
            local l_Position_0 = v67.Parent.RootPart.Position;
            local v72 = v68.CFrame:PointToObjectSpace(l_Position_0);
            local v73 = v68.Size.Y * 0.5 - 2;
            local v74 = -v73;
            if v73 < v74 then
                local l_v74_0 = v74;
                v74 = v73;
                v73 = l_v74_0;
            end;
            local v76 = math.clamp(v72.Y, v74, v73);
            local v77 = v68.CFrame * Vector3.new(0, v76, 0);
            local v78 = (l_Position_0 - v77).Magnitude < v0.Configs.Character.LadderMountDistance;
            local v79 = false;
            if v67.Parent and v67.Parent.FallingStarted and v67.Parent.MoveState == "Falling" then
                v79 = v67.Parent.FallingStarted - l_Position_0.Y > v2.FallDamageStart;
            end;
            if v78 and not v79 then
                return v77, true;
            else
                return v77, false;
            end;
        end, 0, "Climb";
    else
        if v13:GetVehicle() and not v13:IsInteracting() then
            local l_v13_Vehicle_0 = v13:GetVehicle();
            if v68:IsDescendantOf(l_v13_Vehicle_0) then
                local v81 = v66(l_v13_Vehicle_0, v69);
                if v81 and (v81.Part.Name:find("Seat") or v81.Part.Name == "Storage") then
                    local v82 = "Vehicle Sit";
                    local v83 = 0.5;
                    local v84 = "Sit";
                    if v81.Part.Name == "Storage" then
                        v82 = "Vehicle Storage";
                        v83 = 0.5;
                        v84 = "Storage";
                    end;
                    if v81.Part.Name == "Seat Driver" then
                        v84 = "Drive";
                    end;
                    return l_v13_Vehicle_0, v82, function() --[[ Line: 192 ]] --[[ Name: getDrawPos ]]
                        -- upvalues: v81 (copy)
                        return v81.Part.Position, true;
                    end, v83, v84;
                end;
            end;
        end;
        if v67.GroundContainer then
            for _, v86 in next, v67.GroundContainer.Occupants do
                if v86.NodeObject and v68:IsDescendantOf(v86.NodeObject) then
                    return v86, "Nodes", function() --[[ Line: 207 ]] --[[ Name: getDrawPos ]]
                        -- upvalues: v86 (copy), v69 (copy)
                        if v86.NodeObject and not v86.NodeObject:GetAttribute("Locked") then
                            return v86.NodeObject.Value.p, true;
                        else
                            return v69 * 0, false;
                        end;
                    end, 0, "";
                end;
            end;
        end;
        if v68:IsDescendantOf(v24) then
            local v87 = nil;
            for _, v89 in next, v24:GetChildren() do
                if v68:IsDescendantOf(v89) then
                    v87 = v89;
                end;
            end;
            do
                local l_v87_0 = v87;
                if l_v87_0 then
                    local l_l_v87_0_Attribute_0 = l_v87_0:GetAttribute("CorpseState");
                    if l_l_v87_0_Attribute_0 then
                        local v92 = nil;
                        local v93 = "";
                        local v94 = 0;
                        if l_l_v87_0_Attribute_0 == "Fresh" then
                            v93 = "Search";
                            v94 = 1;
                        elseif l_l_v87_0_Attribute_0 == "Empty" then
                            v92 = v41;
                            v93 = "Empty";
                            v94 = 1;
                        elseif l_l_v87_0_Attribute_0 == "Searched" then
                            v93 = "Loot";
                            v94 = 0.3;
                        end;
                        return l_v87_0, "Corpses", function() --[[ Line: 250 ]] --[[ Name: getDrawPos ]]
                            -- upvalues: l_v87_0 (ref), v69 (copy)
                            local v95 = l_v87_0:FindFirstChild("UpperTorso") or l_v87_0.PrimaryPart;
                            if v95 then
                                return v95.CFrame * Vector3.new(0, 0, -0.44999998807907104, 0), true;
                            else
                                return v69 * 0, false;
                            end;
                        end, v94, v93, v92;
                    end;
                end;
            end;
        end;
        if v68:IsDescendantOf(v20) then
            local l_Parent_0 = v68.Parent;
            local l_l_Parent_0_Attribute_0 = l_Parent_0:GetAttribute("LootGroupState");
            local l_l_Parent_0_Attribute_1 = l_Parent_0:GetAttribute("BehaviorHeritage");
            local l_l_Parent_0_Attribute_2 = l_Parent_0:GetAttribute("Position");
            local v100 = nil;
            local v101 = "";
            local v102 = 0;
            local v103 = nil;
            if l_l_Parent_0_Attribute_1 then
                local l_v21_FirstChild_0 = v21:FindFirstChild(l_l_Parent_0_Attribute_1);
                if l_v21_FirstChild_0 then
                    v103 = require(l_v21_FirstChild_0);
                end;
            end;
            if not v103 then
                v103 = {
                    InteractAliases = {
                        Fresh = "Search", 
                        Searched = "Open", 
                        Empty = "empty"
                    }, 
                    InteractTimes = {
                        Fresh = 0.65, 
                        Searched = 0.3, 
                        Empty = 0.3
                    }
                };
            end;
            if l_l_Parent_0_Attribute_0 then
                if l_l_Parent_0_Attribute_0 == "Fresh" then
                    v101 = "Search";
                    v102 = 0.65;
                elseif l_l_Parent_0_Attribute_0 == "Empty" then
                    v100 = v41;
                    v101 = "Empty";
                    v102 = 0.65;
                elseif l_l_Parent_0_Attribute_0 == "Searched" then
                    v101 = "Open";
                    v102 = 0.3;
                end;
            end;
            return v68.Parent, "Containers", function() --[[ Line: 324 ]] --[[ Name: getDrawPos ]]
                -- upvalues: l_l_Parent_0_Attribute_2 (copy), v69 (copy)
                if l_l_Parent_0_Attribute_2 then
                    return l_l_Parent_0_Attribute_2, true;
                else
                    return v69, false;
                end;
            end, v102, v101, v100;
        else
            if v5:GetInteractable(v68) then
                local l_v5_Interactable_0 = v5:GetInteractable(v68);
                local l_l_v5_Interactable_0_0 = l_v5_Interactable_0 --[[ copy: 4 -> 13 ]];
                local function v108() --[[ Line: 340 ]] --[[ Name: getDrawPos ]]
                    -- upvalues: l_l_v5_Interactable_0_0 (copy), v68 (copy), v69 (copy)
                    local l_l_l_v5_Interactable_0_0_InteractionPosition_0 = l_l_v5_Interactable_0_0:GetInteractionPosition(v68, v69);
                    if l_l_l_v5_Interactable_0_0_InteractionPosition_0 then
                        return l_l_l_v5_Interactable_0_0_InteractionPosition_0, true;
                    else
                        return v69 * 0, false;
                    end;
                end;
                if l_v5_Interactable_0.Type == "Door" and not l_v5_Interactable_0:IsTweening() then
                    local v109 = "Open";
                    if l_v5_Interactable_0.State == "Opened" then
                        v109 = "Close";
                    end;
                    if l_v5_Interactable_0.LockedDoor then
                        v109 = "Inaccessible";
                    end;
                    return l_v5_Interactable_0, "Doors", v108, 0, v109;
                elseif l_v5_Interactable_0.Type == "Fuel Pump" then
                    return l_v5_Interactable_0, "Fuel Pump", v108, 1.5, "Fill Fuel Cans";
                elseif l_v5_Interactable_0.Type == "Light" then
                    if l_v5_Interactable_0:GetInteractionPosition(v68, v69) then
                        local l_l_v5_Interactable_0_SwitchState_0 = l_v5_Interactable_0:GetSwitchState(v68, v69);
                        local v111 = "Turn";
                        return l_v5_Interactable_0, "Lights", v108, 0, if l_l_v5_Interactable_0_SwitchState_0 == "On" then v111 .. " Off" else v111 .. " On";
                    end;
                elseif l_v5_Interactable_0.Type == "Power Controllers" then
                    local l_l_v5_Interactable_0_InterctionText_0 = l_v5_Interactable_0:GetInterctionText(v68, v69);
                    local v113 = "???";
                    if l_l_v5_Interactable_0_InterctionText_0 == "Route Switch" then
                        v113 = "Route Power";
                        if l_v5_Interactable_0.Routed then
                            v113 = "Release Routing";
                        end;
                    elseif l_l_v5_Interactable_0_InterctionText_0 == "Power Switch" then
                        local v114 = "On";
                        if l_v5_Interactable_0.Powered then
                            v114 = "Off";
                        end;
                        v113 = "Switch Power " .. v114;
                    elseif l_l_v5_Interactable_0_InterctionText_0 == "Request Button" then
                        v113 = "Request Power Routing";
                    end;
                    return l_v5_Interactable_0, "Power Controllers", v108, 1, v113;
                elseif l_v5_Interactable_0.Type == "Power Station" then
                    local l_l_v5_Interactable_0_InterctionText_1 = l_v5_Interactable_0:GetInterctionText(v68, v69);
                    local _ = "???";
                    return l_v5_Interactable_0, "Power Station", v108, 1, l_v5_Interactable_0:IsSubstationRouted(l_l_v5_Interactable_0_InterctionText_1) and "Return Power" or "Route Power";
                elseif l_v5_Interactable_0.Type == "Rift" then
                    return l_v5_Interactable_0, "Rift", v108, 0, "Reach into the rift";
                elseif l_v5_Interactable_0.Type == "MedalArcade" and not l_v5_Interactable_0.Active then
                    return l_v5_Interactable_0, "MedalArcade", v108, 0, "Activate";
                end;
            end;
            if v67.Parent:HasPerk("Water Purification") then
                local v117 = v9:DrinkCast(v70);
                local v118 = v3("Water Purification");
                local v119 = nil;
                for v120, v121 in next, v118.Configs do
                    if l_CollectionService_0:HasTag(v117, v120) then
                        v119 = v121;
                        break;
                    end;
                end;
                if v119 then
                    return v117, "Water Purification", function() --[[ Line: 443 ]] --[[ Name: getDrawPos ]]
                        -- upvalues: l_UserInputService_0 (ref), v9 (ref), v117 (copy)
                        local l_l_UserInputService_0_MouseLocation_2 = l_UserInputService_0:GetMouseLocation();
                        local v123 = workspace.CurrentCamera:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_2.X, l_l_UserInputService_0_MouseLocation_2.Y);
                        local v124 = Ray.new(v123.Origin, v123.Direction * 150);
                        l_l_UserInputService_0_MouseLocation_2, v123 = v9:DrinkCast(v124);
                        if l_l_UserInputService_0_MouseLocation_2 == v117 then
                            return v123 + Vector3.new(0, -0.20000000298023224, 0, 0), true;
                        else
                            return v123 * 0, false;
                        end;
                    end, v119.UseTime, v119.UseText;
                end;
            end;
            return nil, "", v50, 0, "";
        end;
    end;
end;
local v177 = {
    MovingPlatform = function(_, v127, v128) --[[ Line: 465 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v127, v128);
    end, 
    Doors = function(_, v130, v131) --[[ Line: 469 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v130, v131);
    end, 
    MedalArcade = function(_, v133, v134) --[[ Line: 473 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v133, v134);
    end, 
    Windows = function(_, v136, v137) --[[ Line: 477 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v136, v137);
    end, 
    ["Fuel Pump"] = function(_, v139, v140) --[[ Line: 481 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v139, v140);
    end, 
    Lights = function(_, v142, v143) --[[ Line: 485 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v142, v143);
    end, 
    ["Power Controllers"] = function(_, v145, v146) --[[ Line: 489 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v145, v146);
    end, 
    ["Power Station"] = function(_, v148, v149) --[[ Line: 493 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v148, v149);
    end, 
    Ladders = function(v150, v151, v152) --[[ Line: 497 ]]
        v150.Character:TryClimbing(v151, v152);
    end, 
    ["Vehicle Sit"] = function(_, v154, v155) --[[ Line: 501 ]]
        -- upvalues: v66 (copy), v6 (copy)
        local v156 = v66(v154, v155);
        local v157 = v156 and v156.Part or nil;
        v6:Send("Vehicle Sit In", v154, v157);
    end, 
    Nodes = function(_, v159, _) --[[ Line: 508 ]]
        -- upvalues: v6 (copy), v4 (copy)
        v6:Send("Inventory Pickup Item", v159.NodeObject);
        if v159.InventoryPickupSound then
            v4:PlaySound("Inventory." .. v159.InventoryPickupSound);
            return;
        else
            v4:PlaySound("Interface.Item Pickup");
            return;
        end;
    end, 
    ["Vehicle Storage"] = function(v161, v162, _) --[[ Line: 518 ]]
        -- upvalues: v6 (copy)
        if v6:Fetch("Vehicle Container Group Connect", v162) then
            v161.Character.Actions.Inventory(v161.Character, "Begin");
        end;
    end, 
    Containers = function(v164, v165, _) --[[ Line: 524 ]]
        -- upvalues: v6 (copy)
        if v6:Fetch("Inventory Container Group Connect", v165) then
            v164.Character.Actions.Inventory(v164.Character, "Begin");
        end;
    end, 
    Corpses = function(v167, v168, _) --[[ Line: 530 ]]
        -- upvalues: v6 (copy)
        if v6:Fetch("Corpses Container Group Connect", v168) then
            v167.Character.Actions.Inventory(v167.Character, "Begin");
        end;
    end, 
    Rift = function(_, v171, v172) --[[ Line: 536 ]]
        -- upvalues: v5 (copy)
        v5:Interact(v171, v172);
    end, 
    ["Water Purification"] = function(_, _, _, v176) --[[ Line: 540 ]]
        -- upvalues: v6 (copy)
        v6:Send("Water Purification Use", v176);
    end
};
l_UserInputService_0.InputBegan:Connect(function(v178, v179) --[[ Line: 547 ]]
    -- upvalues: v8 (copy), v0 (copy), v26 (ref), v27 (ref)
    local l_MouseButton1_0 = Enum.UserInputType.MouseButton1;
    local l_v8_Bind_0 = v8:GetBind("Secondary Interact");
    if l_v8_Bind_0 then
        l_v8_Bind_0 = l_v8_Bind_0.Key;
    else
        l_v8_Bind_0 = l_MouseButton1_0;
    end;
    local v182 = v178.UserInputType == l_MouseButton1_0;
    local v183 = true;
    if v178.UserInputType ~= l_v8_Bind_0 then
        v183 = v178.KeyCode == l_v8_Bind_0;
    end;
    if (v182 or v183) and not v179 then
        local v184 = nil;
        if v0.Classes.Players then
            v184 = v0.Classes.Players.get();
        end;
        local v185 = true;
        local v186 = nil;
        local v187 = false;
        local v188 = false;
        local v189 = false;
        if v184 and v184.Character then
            v186 = v184.Character.EquippedItem;
            v187 = v184.Character.AtEaseInput;
            v188 = v184.Character.Sitting;
            v189 = v184.Character.BinocularsEnabled ~= "";
            if not v186 then
                v187 = false;
            end;
            if v186 and v186.Reloading then
                v187 = false;
            end;
        else
            v185 = false;
        end;
        if v182 and v186 and not v187 then
            v185 = false;
        end;
        if v183 and v186 and v187 then
            v185 = false;
        elseif v183 and not v186 then
            v185 = false;
        end;
        if v188 then
            v185 = false;
        end;
        if v189 then
            v185 = false;
        end;
        if v185 and v26 then
            v27 = tick();
        end;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v190, _) --[[ Line: 615 ]]
    -- upvalues: v8 (copy), v26 (ref), v27 (ref)
    local l_MouseButton1_1 = Enum.UserInputType.MouseButton1;
    local l_v8_Bind_1 = v8:GetBind("Secondary Interact");
    if l_v8_Bind_1 then
        l_v8_Bind_1 = l_v8_Bind_1.Key;
    else
        l_v8_Bind_1 = l_MouseButton1_1;
    end;
    local v194 = v190.UserInputType == l_MouseButton1_1;
    local v195 = true;
    if v190.UserInputType ~= l_v8_Bind_1 then
        v195 = v190.KeyCode == l_v8_Bind_1;
    end;
    if (v194 or v195) and v26 then
        v26 = nil;
        v27 = nil;
    end;
end);
v12.new(0.05, "Heartbeat", function() --[[ Line: 634 ]]
    -- upvalues: v0 (copy), v4 (copy), v29 (ref), v30 (ref), v31 (ref), v33 (ref), v34 (ref), v8 (copy), l_UserInputService_0 (copy), v9 (copy), v125 (copy), v28 (ref), v32 (ref), v27 (ref), v26 (ref), v177 (copy), v13 (copy), v14 (copy)
    local l_Players_0 = v0.Classes.Players;
    if not l_Players_0 then
        return;
    else
        local v197 = l_Players_0.get();
        local v198 = v4:IsVisible("GameMenu");
        local v199 = false;
        local v200 = false;
        local v201 = "";
        v29 = Enum.UserInputType.MouseButton1;
        v30 = false;
        v31 = nil;
        v33 = "";
        v34 = nil;
        if v197 and v197.Character and not v197.Character.Destroyed then
            if v197.Character.Health and v197.Character.Health:Get() > 0 then
                v199 = true;
            end;
            v200 = v197.Character.Sitting;
        end;
        if not v198 and v197 and v199 and not v200 then
            local l_EquippedItem_0 = v197.Character.EquippedItem;
            local l_AtEaseInput_0 = v197.Character.AtEaseInput;
            if l_EquippedItem_0 and l_EquippedItem_0.Reloading then
                l_AtEaseInput_0 = false;
            end;
            if l_EquippedItem_0 and not l_AtEaseInput_0 then
                local l_v8_Bind_2 = v8:GetBind("Secondary Interact");
                if l_v8_Bind_2 then
                    v29 = l_v8_Bind_2.Key;
                end;
            end;
            local l_l_UserInputService_0_MouseLocation_3 = l_UserInputService_0:GetMouseLocation();
            local v206 = workspace.CurrentCamera:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_3.X, l_l_UserInputService_0_MouseLocation_3.Y);
            local v207 = Ray.new(v206.Origin, v206.Direction * 150);
            l_l_UserInputService_0_MouseLocation_3, v206 = v9:InteractCast(v207);
            local l_l_l_UserInputService_0_MouseLocation_3_0 = l_l_UserInputService_0_MouseLocation_3;
            local l_v206_0 = v206;
            local l_v207_0 = v207;
            v207 = v197.Character.Inventory;
            local v211, v212, v213, v214;
            l_l_UserInputService_0_MouseLocation_3, v206, v211, v212, v213, v214 = v125(v207, l_l_l_UserInputService_0_MouseLocation_3_0, l_v206_0, l_v207_0);
            if (v197.Character.RootPart.Position - l_v206_0).magnitude > 10 then
                l_l_UserInputService_0_MouseLocation_3 = nil;
                v206 = nil;
            end;
            do
                local l_l_l_UserInputService_0_MouseLocation_3_1, l_v206_1 = l_l_UserInputService_0_MouseLocation_3, v206;
                if l_l_l_UserInputService_0_MouseLocation_3_1 then
                    v28 = v212;
                    v31 = v211;
                    if v32 ~= l_l_l_UserInputService_0_MouseLocation_3_1 and v27 then
                        v27 = tick();
                    end;
                    v26 = function() --[[ Line: 698 ]]
                        -- upvalues: v177 (ref), l_v206_1 (ref), v197 (copy), l_l_l_UserInputService_0_MouseLocation_3_1 (ref), l_v206_0 (copy), l_v207_0 (copy)
                        v177[l_v206_1](v197, l_l_l_UserInputService_0_MouseLocation_3_1, l_v206_0, l_v207_0);
                    end;
                    if l_v206_1 == "Nodes" then
                        v30 = true;
                    end;
                    v34 = v214;
                    v33 = v213;
                    v201 = l_v206_1;
                else
                    v27 = nil;
                    v26 = nil;
                    v34 = nil;
                    v33 = "";
                    v201 = "";
                end;
                v32 = l_l_l_UserInputService_0_MouseLocation_3_1;
            end;
        else
            v31 = nil;
            v29 = nil;
            v26 = nil;
            v32 = nil;
        end;
        local v217 = false;
        if v201 ~= "" and v201 ~= "Nodes" then
            v217 = true;
        end;
        if v13:IsInteracting() then
            v217 = true;
        end;
        if v197 and v197.Character and v197.Character.Zooming then
            v217 = false;
        end;
        if v4:IsVisible("Reticle") then
            v217 = false;
        end;
        if not v4:IsVisible("Map") then
            if v217 then
                v14:SetIconVisible("Grab", true);
            else
                v14:SetIconVisible("Grab", false);
            end;
        end;
        if v26 and v27 then
            local v218 = math.clamp((tick() - v27) / v28, 0, 1);
            if v28 == 0 or v218 >= 1 then
                local l_v26_0 = v26;
                v26 = nil;
                v27 = nil;
                if l_v26_0 then
                    l_v26_0();
                end;
            end;
        end;
        return;
    end;
end);
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 780 ]]
    -- upvalues: v29 (ref), v31 (ref), l_KeyAliases_0 (copy), l_IconImages_0 (copy), v25 (copy), l_Lengths_0 (copy), v38 (copy), v33 (ref), v34 (ref), v30 (ref), v26 (ref), v27 (ref), v28 (ref)
    debug.profilebegin("Interact UI step");
    if v29 and v31 then
        local v220 = l_KeyAliases_0[v29] or v29.Name;
        local v221 = l_IconImages_0[Enum.UserInputType.Keyboard];
        local v222 = #v220 > 1;
        if v29.EnumType == Enum.UserInputType then
            v25.Gui.Icon.TextLabel.Text = "";
            v221 = l_IconImages_0[v29];
            v222 = false;
        else
            v25.Gui.Icon.TextLabel.Text = v220;
        end;
        local v223, v224 = v31();
        local v225, v226 = workspace.CurrentCamera:WorldToScreenPoint(v223);
        if not v224 then
            v226 = false;
        end;
        if v226 then
            v25.Gui.Icon.Size = UDim2.new(0, v222 and l_Lengths_0 or v38, 0, 31);
            v25.Gui.Position = UDim2.new(0, v225.X, 0, v225.Y);
            v25.Gui.Icon.Image = v221.Up;
            if v33 == "" then
                v25.Gui.Icon.Box.Visible = false;
            else
                v25.Gui.Icon.Box.ContextName.Text = v33;
                v25.Gui.Icon.Box.ContextName.Backdrop.Text = v33;
                if v34 then
                    v25.Gui.Icon.Box.ContextName.TextColor3 = v34;
                else
                    v25.Gui.Icon.Box.ContextName.TextColor3 = Color3.new(1, 1, 1);
                end;
                local l_TextBounds_0 = v25.Gui.Icon.Box.ContextName.TextBounds;
                v25.Gui.Icon.Box.Size = UDim2.new(0, l_TextBounds_0.X + 26, 0, 25);
                v25.Gui.Icon.Box.Visible = true;
                local l_AbsolutePosition_0 = v25.Gui.Icon.AbsolutePosition;
                local v229 = v25.Gui.Icon.Box.AbsolutePosition + v25.Gui.Icon.Box.AbsoluteSize;
                v25.Gui.UseBar.Size = UDim2.new(0, v229.X - l_AbsolutePosition_0.X, 0, 10);
            end;
            if v30 then
                v25.Gui.Visible = false;
            else
                v25.Gui.Visible = true;
            end;
        else
            v25.Gui.Visible = false;
        end;
        if v26 and v27 then
            local v230 = math.clamp((tick() - v27) / v28, 0, 1);
            local v231 = false;
            if v28 == 0 then
                v230 = 1;
                v231 = true;
            end;
            v25.Gui.UseBar.Visible = not v231;
            v25.Gui.UseBar.Fill.Size = UDim2.new(v230, 0, 1, 0);
        elseif v25.Gui.UseBar.Visible then
            v25.Gui.UseBar.Visible = false;
        end;
    else
        v25.Gui.Visible = false;
    end;
    debug.profileend();
end);
return v25;