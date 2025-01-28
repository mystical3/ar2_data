local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Libraries", "Raycasting");
local v4 = v0.require("Libraries", "World");
local v5 = v0.require("Libraries", "Resources");
local v6 = v0.require("Classes", "Maids");
local _ = v0.require("Classes", "Signals");
local _ = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local function _(v10) --[[ Line: 23 ]] --[[ Name: attackComboLogic ]]
    local v11 = os.clock();
    if v10.ComboAfter <= v11 and v11 <= v10.ComboLimit then
        v10.ComboIndex = v10.ComboIndex + 1;
        if v10.ComboIndex > #v10.AttackConfig then
            v10.ComboIndex = 1;
        end;
        return true;
    elseif v10.ComboAfter < v11 then
        v10.ComboIndex = 1;
        return true;
    else
        return false;
    end;
end;
local function _(v13, v14) --[[ Line: 47 ]] --[[ Name: getAnimationLength ]]
    -- upvalues: v5 (copy)
    local v15 = v5:Search("ReplicatedStorage.Assets.Animations." .. v13);
    local v16 = v14 or 1;
    if v15 then
        local l_v15_Attribute_0 = v15:GetAttribute("Length");
        if l_v15_Attribute_0 then
            return l_v15_Attribute_0 / v16;
        end;
    end;
    return 0;
end;
local function _(v19, v20) --[[ Line: 62 ]] --[[ Name: equipLogic ]]
    local l_EquippedItem_0 = v20.EquippedItem;
    if l_EquippedItem_0 and l_EquippedItem_0.Id == v19.Id then
        return true;
    else
        return v20:Equip(v19);
    end;
end;
local function _(v23, v24) --[[ Line: 72 ]] --[[ Name: getEquipModel ]]
    if v23.Instance then
        local l_Equipped_0 = v23.Instance:FindFirstChild("Equipped");
        if l_Equipped_0 then
            return l_Equipped_0:FindFirstChild(v24.Name);
        end;
    end;
    return nil;
end;
local function v31(v27) --[[ Line: 84 ]] --[[ Name: getCastingHitboxes ]]
    local v28 = {};
    for _, v30 in next, v27:GetDescendants() do
        if v30.Name == "Hitbox" then
            table.insert(v28, v30);
        end;
    end;
    return v28;
end;
local function _(v32) --[[ Line: 96 ]] --[[ Name: staggerZombie ]]
    -- upvalues: v0 (copy)
    local v33 = v0.Classes.Animators.find(v32);
    if v33 then
        v33:DamageStaggerTry();
    end;
end;
local function v84(v35, v36, v37, v38, v39) --[[ Line: 104 ]] --[[ Name: connectHitDetection ]]
    -- upvalues: v31 (copy), v2 (copy), l_RunService_0 (copy), v3 (copy), v4 (copy), v0 (copy)
    local v40 = v31(v37);
    local v41 = {
        v36.Instance
    };
    local v42 = false;
    local function _(v43) --[[ Line: 112 ]] --[[ Name: ignore ]]
        -- upvalues: v41 (copy)
        if v43 then
            table.insert(v41, v43);
        end;
    end;
    local function _() --[[ Line: 118 ]] --[[ Name: abortCheck ]]
        -- upvalues: v38 (copy), v42 (ref)
        if not v38.AttackConfig.CanHitMultipleTargets then
            v38.Maid:CleanIndex("HitCasting");
            v42 = true;
        end;
    end;
    local function _(v46, v47, v48) --[[ Line: 125 ]] --[[ Name: criticalHit ]]
        -- upvalues: v38 (copy), v42 (ref), v41 (copy), v2 (ref), v35 (copy), v39 (copy)
        if not v38.AttackConfig.CanHitMultipleTargets then
            v38.Maid:CleanIndex("HitCasting");
            v42 = true;
        end;
        if v48 then
            table.insert(v41, v48);
        end;
        v2:Send("Melee Hit Register", v35.Id, v39, v46, v47, false);
    end;
    local function _(v50, v51, v52) --[[ Line: 132 ]] --[[ Name: genericHit ]]
        -- upvalues: v41 (copy), v2 (ref), v35 (copy), v39 (copy)
        if v52 then
            table.insert(v41, v52);
        end;
        v2:Send("Melee Hit Register", v35.Id, v39, v50, v51, true);
    end;
    v38.Maid.HitCasting = l_RunService_0.Stepped:Connect(function() --[[ Line: 139 ]]
        -- upvalues: v38 (copy), v42 (ref), v40 (copy), v3 (ref), v41 (copy), v4 (ref), v2 (ref), v35 (copy), v39 (copy), v0 (ref)
        if not v38.DamageEnabled then
            return;
        elseif v42 then
            return;
        else
            for _, v55 in next, v40 do
                if not v42 then
                    local l_CFrame_0 = v55.CFrame;
                    local l_Size_0 = v55.Size;
                    local v58 = l_CFrame_0 * Vector3.new(0, 0, l_Size_0.Z * 0.5);
                    local v59 = l_CFrame_0.LookVector * l_Size_0.Z;
                    local v60 = Ray.new(v58, v59);
                    local v61, v62 = v3:BulletCastLight(v60, false, v41);
                    if v61 then
                        local l_v4_Interactable_0 = v4:GetInteractable(v61);
                        if l_v4_Interactable_0 then
                            if l_v4_Interactable_0.Type == "Window" and l_v4_Interactable_0:CanBreak() then
                                v4:Interact(l_v4_Interactable_0);
                                local l_Instance_0 = l_v4_Interactable_0.Instance;
                                if l_Instance_0 then
                                    table.insert(v41, l_Instance_0);
                                end;
                                if not v38.AttackConfig.CanHitMultipleTargets then
                                    v38.Maid:CleanIndex("HitCasting");
                                    v42 = true;
                                end;
                            else
                                local l_Instance_1 = l_v4_Interactable_0.Instance;
                                if l_Instance_1 then
                                    table.insert(v41, l_Instance_1);
                                end;
                                v2:Send("Melee Hit Register", v35.Id, v39, v61, "Window", true);
                            end;
                        end;
                        if v42 then
                            return;
                        else
                            local v66 = v3:IsHitCharacter(v61);
                            if v66 then
                                if not v38.AttackConfig.CanHitMultipleTargets then
                                    v38.Maid:CleanIndex("HitCasting");
                                    v42 = true;
                                end;
                                if v66 then
                                    table.insert(v41, v66);
                                end;
                                v2:Send("Melee Hit Register", v35.Id, v39, v61, "Flesh", false);
                            end;
                            if v42 then
                                return;
                            else
                                local v67 = v3:IsHitZombie(v61);
                                if v67 then
                                    if not v38.AttackConfig.CanHitMultipleTargets then
                                        v38.Maid:CleanIndex("HitCasting");
                                        v42 = true;
                                    end;
                                    if v67 then
                                        table.insert(v41, v67);
                                    end;
                                    v2:Send("Melee Hit Register", v35.Id, v39, v61, "Flesh", false);
                                    local v68 = v0.Classes.Animators.find(v67);
                                    if v68 then
                                        v68:DamageStaggerTry();
                                    end;
                                end;
                                if v42 then
                                    return;
                                else
                                    local v69 = v3:IsHitVehicle(v61);
                                    if v69 then
                                        local v70 = v3:VehicleCollisionRay(v69, v60, v62);
                                        local v71 = nil;
                                        local v72 = nil;
                                        if v70.Internal.Hit then
                                            local l_Windows_0 = v69:FindFirstChild("Windows");
                                            local l_Wheels_0 = v69:FindFirstChild("Wheels");
                                            if l_Windows_0 and v70.Internal.Hit:IsDescendantOf(l_Windows_0) then
                                                v72 = v70.Internal.Hit;
                                                v71 = v70.Internal.Hit;
                                            elseif l_Wheels_0 and v70.Internal.Hit:IsDescendantOf(l_Wheels_0) then
                                                local v75 = nil;
                                                for _, v77 in next, l_Wheels_0:GetChildren() do
                                                    if v70.Internal.Hit:IsDescendantOf(v77) then
                                                        v75 = v77;
                                                        break;
                                                    end;
                                                end;
                                                if v75 then
                                                    v71 = v75;
                                                    v72 = v70.Internal.Hit;
                                                end;
                                            end;
                                        else
                                            local l_Body_0 = v69:FindFirstChild("Body");
                                            if l_Body_0 then
                                                table.insert(v41, l_Body_0);
                                            end;
                                            l_Body_0 = v69:FindFirstChild("Collision");
                                            if l_Body_0 then
                                                table.insert(v41, l_Body_0);
                                            end;
                                            l_Body_0 = v69:FindFirstChild("Lights");
                                            if l_Body_0 then
                                                table.insert(v41, l_Body_0);
                                            end;
                                            l_Body_0 = v69:FindFirstChild("Seats");
                                            if l_Body_0 then
                                                table.insert(v41, l_Body_0);
                                            end;
                                            v72 = v70.Body.Hit;
                                        end;
                                        if v72 then
                                            local l_v72_0 = v72;
                                            local l_v71_0 = v71;
                                            if not v38.AttackConfig.CanHitMultipleTargets then
                                                v38.Maid:CleanIndex("HitCasting");
                                                v42 = true;
                                            end;
                                            if l_v71_0 then
                                                table.insert(v41, l_v71_0);
                                            end;
                                            v2:Send("Melee Hit Register", v35.Id, v39, l_v72_0, "Vehicle", false);
                                        end;
                                    end;
                                    if v42 then
                                        return;
                                    else
                                        local v81 = "Generic";
                                        if v3:IsObjectMetal(v61) then
                                            v81 = "Metal";
                                        end;
                                        local l_v81_0 = v81;
                                        local l_Parent_0 = v61.Parent;
                                        if l_Parent_0 then
                                            table.insert(v41, l_Parent_0);
                                        end;
                                        v2:Send("Melee Hit Register", v35.Id, v39, v61, l_v81_0, true);
                                    end;
                                end;
                            end;
                        end;
                    end;
                else
                    break;
                end;
            end;
            return;
        end;
    end);
end;
local function v103(v85, v86, v87, v88, v89) --[[ Line: 271 ]] --[[ Name: playMeleeAnimation ]]
    -- upvalues: v6 (copy), v84 (copy)
    local v90 = {};
    for _, v92 in next, v87:GetDescendants() do
        if v92:IsA("Trail") and v92.Name == "SwingTrail" then
            table.insert(v90, v92);
        end;
    end;
    local v93 = v85.AttackConfig[v88];
    local v94 = {
        DamageEnabled = false, 
        AttackConfig = v93, 
        Maid = v6.new()
    };
    v84(v85, v86, v87, v94, v89);
    v94.Maid:Give(v86.EquipmentChanged:Connect(function() --[[ Line: 291 ]]
        -- upvalues: v86 (copy), v85 (copy), v94 (copy)
        if v86.EquippedItem == nil or v86.EquippedItem.Id ~= v85.Id then
            v94.Maid:Clean();
            v86.Animator:RunAction("Cancel Melee Animation", v85.Name);
        end;
    end));
    local v95, v96 = v86.Animator:RunAction("Play Melee Animation", v85.Name, v88);
    if v96 then
        v94.Maid:Give(v96:GetMarkerReachedSignal("Swing"):Connect(function(v97) --[[ Line: 308 ]]
            -- upvalues: v94 (copy), v86 (copy), v93 (copy)
            v94.DamageEnabled = v97 == "Begin";
            if v97 == "Begin" and v86.MoveImpulses and v93.MoveImpulse then
                local l_CFrame_1 = v86.RootPart.CFrame;
                local v99, v100 = unpack(v93.MoveImpulse);
                table.insert(v86.MoveImpulses, {
                    Direction = l_CFrame_1:VectorToWorldSpace(v99), 
                    Durration = v100
                });
            end;
        end));
    end;
    if v95 then
        v95:Wait();
    end;
    for _, v102 in next, v90 do
        v102.Enabled = false;
    end;
    v94.Maid:Destroy();
    v94.Maid = nil;
end;
return function(v104, _, v106) --[[ Line: 340 ]]
    -- upvalues: v5 (copy), v2 (copy), v103 (copy)
    v104.ComboAfter = os.clock();
    v104.ComboLimit = os.clock();
    v104.ComboIndex = 1;
    v104.Animating = false;
    if not v106 then
        return;
    else
        v104.OnUse = function(v107, v108) --[[ Line: 354 ]]
            -- upvalues: v5 (ref), v2 (ref), v103 (ref)
            local v109 = false;
            local v110 = false;
            local l_EquippedItem_1 = v108.EquippedItem;
            if l_EquippedItem_1 and l_EquippedItem_1.Id == v107.Id or v108:Equip(v107) then
                local v112;
                if v108.Instance then
                    l_EquippedItem_1 = v108.Instance:FindFirstChild("Equipped");
                    if l_EquippedItem_1 then
                        v112 = l_EquippedItem_1:FindFirstChild(v107.Name);
                        v109 = true;
                    end;
                end;
                if not v109 then
                    v112 = nil;
                end;
                v109 = false;
                local v113 = os.clock();
                if v107.ComboAfter <= v113 and v113 <= v107.ComboLimit then
                    v107.ComboIndex = v107.ComboIndex + 1;
                    if v107.ComboIndex > #v107.AttackConfig then
                        v107.ComboIndex = 1;
                    end;
                    l_EquippedItem_1 = true;
                elseif v107.ComboAfter < v113 then
                    v107.ComboIndex = 1;
                    l_EquippedItem_1 = true;
                else
                    l_EquippedItem_1 = false;
                end;
                if l_EquippedItem_1 and v112 then
                    v113 = v107.AttackConfig[v107.ComboIndex];
                    local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
                    local v115 = os.clock();
                    local l_Animation_0 = v113.Animation;
                    local l_PlaybackSpeedMod_0 = v113.PlaybackSpeedMod;
                    local v118 = v5:Search("ReplicatedStorage.Assets.Animations." .. l_Animation_0);
                    local v119 = l_PlaybackSpeedMod_0 or 1;
                    local v120;
                    if v118 then
                        local l_v118_Attribute_0 = v118:GetAttribute("Length");
                        if l_v118_Attribute_0 then
                            v120 = l_v118_Attribute_0 / v119;
                            v110 = true;
                        end;
                    end;
                    if not v110 then
                        v120 = 0;
                    end;
                    v110 = false;
                    v107.Animating = true;
                    v107.ComboAfter = v115 + v120 - 1;
                    v107.ComboLimit = v115 + v120 + 0.4;
                    v2:Send("Melee Swing", l_workspace_ServerTimeNow_0, v107.Id, v107.ComboIndex);
                    v103(v107, v108, v112, v107.ComboIndex, l_workspace_ServerTimeNow_0);
                    v107.Animating = false;
                end;
            end;
            return false;
        end;
        return;
    end;
end;