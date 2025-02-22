local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "ItemData");
local v2 = v0.require("Configs", "GroundData");
local v3 = v0.require("Configs", "Character");
local v4 = v0.require("Configs", "PerkTuning");
local v5 = v0.require("Libraries", "Network");
local v6 = v0.require("Libraries", "Resources");
local v7 = v0.require("Libraries", "Raycasting");
local v8 = v0.require("Libraries", "GunBuilder");
local v9 = v0.require("Libraries", "Welds");
local v10 = v0.require("Classes", "SteppedSprings");
local v11 = v0.require("Classes", "Springs");
local v12 = v0.require("Classes", "Randomizer");
local v13 = v0.require("Classes", "Signals");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v16 = v6:Find("ReplicatedStorage.Assets.Items");
local _ = v6:Find("ReplicatedStorage.Assets.Particles");
local v18 = v6:Find("ReplicatedStorage.Assets.Sounds.Footsteps");
local _ = v6:Find("Workspace.Effects");
local v20 = CFrame.new();
local v21 = Random.new();
local v22 = {
    Forwards = Vector3.new(0, 0, -1, 0), 
    ForwardsRight = Vector3.new(1, 0, -1, 0).unit, 
    Right = Vector3.new(1, 0, 0, 0), 
    BackwardsRight = Vector3.new(1, 0, 1, 0).unit, 
    Backwards = Vector3.new(0, 0, 1, 0), 
    BackwardsLeft = Vector3.new(-1, 0, 1, 0).unit, 
    Left = Vector3.new(-1, 0, 0, 0), 
    ForwardsLeft = Vector3.new(-1, 0, -1, 0).unit
};
local v23 = {
    Walking = "Standing", 
    Running = "Standing", 
    Crouching = "Crouching", 
    Swimming = "Swimming", 
    SprintSwimming = "Swimming", 
    Climbing = "Standing", 
    Sitting = "Sitting", 
    Falling = "Standing"
};
local v24 = {
    Walking = "Walking", 
    Running = "Running", 
    Crouching = "Crouching", 
    Swimming = "Walking", 
    SprintSwimming = "Running", 
    Climbing = "Walking", 
    Sitting = "Crouching", 
    Falling = nil
};
local v25 = {
    Crouching = {
        Walking = Vector3.new(-1, -4, 2, 0), 
        Running = Vector3.new(0, -3, 0, 0)
    }, 
    Walking = {
        Crouching = Vector3.new(1, -2, 0, 0), 
        Running = Vector3.new(0, -3, 0, 0)
    }, 
    Running = {
        Crouching = Vector3.new(0, 3, -3, 0), 
        Walking = Vector3.new(0, 3, -3, 0)
    }, 
    Falling = {
        Crouching = Vector3.new(0, -3, 0, 0), 
        Running = Vector3.new(0, -3, 0, 0), 
        Walking = Vector3.new(0, -3, 0, 0)
    }
};
local v26 = {
    RightHand = true, 
    RightLowerArm = true, 
    RightUpperArm = true, 
    LeftHand = true, 
    LeftLowerArm = true, 
    LeftUpperArm = true, 
    Head = false, 
    UpperTorso = false, 
    LowerTorso = false, 
    RightFoot = false, 
    RightLowerLeg = false, 
    RightUpperLeg = false, 
    LeftFoot = false, 
    LeftLowerLeg = false, 
    LeftUpperLeg = false
};
local function v27(v28) --[[ Line: 144 ]] --[[ Name: copyTable ]]
    -- upvalues: v27 (copy)
    local v29 = {};
    for v30, v31 in next, v28 do
        if typeof(v31) == "table" then
            v31 = v27(v31);
        end;
        v29[v30] = v31;
    end;
    return v29;
end;
local function _(v32, v33, v34) --[[ Line: 158 ]] --[[ Name: lerp ]]
    return v32 + (v33 - v32) * v34;
end;
local function _(v36, v37, v38, v39, v40) --[[ Line: 162 ]] --[[ Name: remap ]]
    return v39 + (v40 - v39) * ((v36 - v37) / (v38 - v37));
end;
local function _(v42) --[[ Line: 166 ]] --[[ Name: flatCF ]]
    return CFrame.new(v42.p, v42.p + v42.lookVector * Vector3.new(1, 0, 1, 0));
end;
local function _(v44, v45) --[[ Line: 170 ]] --[[ Name: pivotCF ]]
    return (v45 + v44) * CFrame.new(-v44);
end;
local function v49(_) --[[ Line: 174 ]] --[[ Name: getCameraCFrame ]]
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    return l_CurrentCamera_0.CFrame, l_CurrentCamera_0.Focus;
end;
local function v66(v50, v51, v52, v53, v54, v55) --[[ Line: 180 ]] --[[ Name: solveIK ]]
    local v56 = CFrame.new(v50.Position, v51) * Vector3.new(0, v55 or 0, v54 or 0);
    local v57 = v50.Rotation + v56;
    local v58 = v57:pointToObjectSpace(v51);
    local l_unit_0 = v58.unit;
    local l_magnitude_0 = v58.magnitude;
    local v61 = Vector3.new(0, 0, -1, 0):Cross(l_unit_0);
    local v62 = math.acos(-l_unit_0.Z);
    local v63 = v57 * CFrame.fromAxisAngle(v61, v62);
    if l_magnitude_0 < math.max(v53, v52) - math.min(v53, v52) then
        return v63 * CFrame.new(0, 0, math.max(v53, v52) - math.min(v53, v52) - l_magnitude_0), -1.5707963267948966, 3.141592653589793;
    elseif v52 + v53 < l_magnitude_0 then
        return v63 * CFrame.new(0, 0, v52 + v53 - l_magnitude_0), 1.5707963267948966, 0;
    else
        local v64 = -math.acos((-(v53 * v53) + v52 * v52 + l_magnitude_0 * l_magnitude_0) / (2 * v52 * l_magnitude_0));
        local v65 = math.acos((v53 * v53 - v52 * v52 + l_magnitude_0 * l_magnitude_0) / (2 * v53 * l_magnitude_0));
        return v63, v64 + 1.5707963267948966, v65 - v64;
    end;
end;
local function v71(v67, v68) --[[ Line: 205 ]] --[[ Name: setModelTransparency ]]
    if not v67 then
        return;
    else
        for _, v70 in next, v67:GetDescendants() do
            if v70:IsA("BasePart") or v70:IsA("Texture") then
                v70.Transparency = v68;
            end;
        end;
        return;
    end;
end;
local function v96(v72, v73, v74) --[[ Line: 219 ]] --[[ Name: setTransparency ]]
    -- upvalues: v26 (copy)
    local l_Hair_0 = v72.Instance:FindFirstChild("Hair");
    local l_Equipment_0 = v72.Instance:FindFirstChild("Equipment");
    local l_Equipped_0 = v72.Instance:FindFirstChild("Equipped");
    for v78, v79 in next, v72.BodyParts do
        local l_v73_0 = v73;
        if v26[v78] and not v74 then
            l_v73_0 = 0;
        end;
        v79.LocalTransparencyModifier = l_v73_0;
    end;
    local l_Face_0 = v72.BodyParts.Head:FindFirstChild("Face");
    if l_Face_0 then
        l_Face_0.LocalTransparencyModifier = v72.BodyParts.Head.LocalTransparencyModifier;
    end;
    if l_Hair_0 then
        for _, v83 in next, l_Hair_0:GetDescendants() do
            if v83:IsA("BasePart") or v83:IsA("Decal") then
                v83.LocalTransparencyModifier = v73;
            end;
        end;
    end;
    if l_Equipped_0 then
        local v84 = 0;
        if v74 then
            v84 = 1;
        end;
        for _, v86 in next, l_Equipped_0:GetDescendants() do
            if v86:IsA("BasePart") or v86:IsA("Decal") then
                v86.LocalTransparencyModifier = v84;
            end;
        end;
    end;
    if l_Equipment_0 then
        for _, v88 in next, l_Equipment_0:GetChildren() do
            if v88:GetAttribute("Is3DClothing") then
                for _, v90 in next, v88:GetChildren() do
                    local l_v73_1 = v73;
                    if v26[v90.Name] and not v74 then
                        l_v73_1 = 0;
                    end;
                    for _, v93 in next, v90:GetDescendants() do
                        if v93:IsA("BasePart") or v93:IsA("Decal") then
                            v93.LocalTransparencyModifier = l_v73_1;
                        end;
                    end;
                end;
            else
                for _, v95 in next, v88:GetDescendants() do
                    if v95:IsA("BasePart") or v95:IsA("Decal") then
                        v95.LocalTransparencyModifier = v73;
                    end;
                end;
            end;
        end;
    end;
end;
local function v103(v97, v98, v99) --[[ Line: 296 ]] --[[ Name: playSound ]]
    -- upvalues: v6 (copy), v0 (copy)
    if v97.Muted then
        return;
    else
        local v100 = nil;
        if v97.Instance and v97.Instance.PrimaryPart then
            v100 = v97.Instance.PrimaryPart;
        end;
        if not v100 then
            return;
        else
            local v101 = nil;
            v101 = if typeof(v98) == "string" then v6:Find("ReplicatedStorage.Assets.Sounds." .. v98) else v98;
            if not v101 then
                warn("Failed to play sound:", v98, "found:", v101);
                return;
            else
                local v102 = v101:Clone();
                v102.Parent = v100;
                v102.Ended:Connect(function() --[[ Line: 327 ]]
                    -- upvalues: v0 (ref), v102 (copy)
                    v0.destroy(v102, "Ended");
                end);
                v102.SoundGroup = v6:Find("SoundService.Characters");
                if v99 then
                    v99(v102);
                end;
                v102:Play();
                return v102;
            end;
        end;
    end;
end;
local v104 = 100;
local v105 = v6:Find("ReplicatedStorage.Assets.Sounds.Footsteps");
for _, v107 in next, v105:GetChildren() do
    local v108 = {
        v107:FindFirstChild("Crouching"), 
        v107:FindFirstChild("Walking"), 
        v107:FindFirstChild("Running")
    };
    for _, v110 in next, v108 do
        v104 = math.max(v104, v110:GetAttribute("MaxDistance") or 0);
    end;
end;
v104 = v104 + 50;
v105 = function(v111) --[[ Line: 363 ]] --[[ Name: playFootstepSound ]]
    -- upvalues: v104 (ref), v7 (copy), v6 (copy), v18 (copy), v12 (copy), v103 (copy), v21 (copy), v4 (copy)
    local v112 = nil;
    if v111.Instance and v111.Instance.PrimaryPart then
        v112 = v111.Instance.PrimaryPart;
    end;
    if not v112 then
        return;
    elseif v111.DistanceToCamera > v104 then
        return;
    else
        local v113 = "Carpet";
        local v114 = "Walking";
        if v111.DistanceToCamera < v104 then
            v113 = v111.GroundMaterial;
        end;
        if v111.States.MoveState == "Crouching" then
            v114 = "Crouching";
        elseif v111.States.MoveState == "Running" or v111.States.MoveState == "SprintSwimming" then
            v114 = "Running";
        end;
        if v111.States.MoveState == "Swimming" or v111.States.MoveState == "SprintSwimming" then
            v113 = "Water";
        end;
        if v111.States.MoveState == "Climbing" then
            v113 = "Metal";
            local v115 = Ray.new(v112.Position, v112.CFrame.LookVector * 2);
            local v117 = v7:CastWithIgnoreList(v115, {
                v111.Instance
            }, function(v116) --[[ Line: 405 ]]
                if v116.Name ~= "Ladder" and v116.Name ~= "LadderTopMount" then
                    return true;
                else
                    return;
                end;
            end);
            if v117 and (v117.Name == "Ladder" or v117.name == "LadderTopMount") then
                local l_v7_FootstepCorrection_0 = v7:FindFootstepCorrection(v117);
                if l_v7_FootstepCorrection_0 then
                    v113 = l_v7_FootstepCorrection_0;
                end;
            end;
        end;
        if v111.States.Clown then
            v113 = "Clown";
        end;
        local v119 = v6:SearchFrom(v18, v113 .. "." .. v114);
        local v120 = v6:SearchFrom(v18, v113 .. ".Movement");
        local v121 = v12.new(v120:GetChildren());
        if v121 and v119 then
            v103(v111, v121:Roll(), function(v122) --[[ Line: 429 ]]
                -- upvalues: v119 (copy), v21 (ref), v111 (copy), v4 (ref), v114 (ref)
                local v123 = v119:Clone();
                v123.Parent = v122;
                v122.Volume = v123:GetAttribute("Volume") or v122.Volume;
                v122.RollOffMaxDistance = v123:GetAttribute("MaxDistance") or v122.RollOffMaxDistance;
                v122.RollOffMinDistance = v123:GetAttribute("MinDistance") or v122.RollOffMinDistance;
                v122.PlaybackSpeed = v21:NextNumber(1 - (v123:GetAttribute("PitchRange") or 0), 1 + (v123:GetAttribute("PitchRange") or 0));
                if v111.States.Ninja then
                    local v124 = v4("Padded Soles");
                    v122.Volume = v122.Volume * v124.TotalVolumeMod;
                    if v114 == "Crouching" then
                        v122.RollOffMaxDistance = v122.RollOffMaxDistance * v124.CrouchDistanceMod;
                        v122.RollOffMinDistance = v122.RollOffMinDistance * v124.CrouchDistanceMod;
                    end;
                end;
                if not v111.IsNetworked then
                    v122.Volume = v122.Volume * 0.5;
                end;
            end);
        end;
        return v113;
    end;
end;
local function v135(v125) --[[ Line: 462 ]] --[[ Name: playJumpSound ]]
    -- upvalues: v6 (copy), v18 (copy), v12 (copy), v103 (copy), v21 (copy), v4 (copy)
    local v126 = nil;
    if v125.Instance and v125.Instance.PrimaryPart then
        v126 = v125.Instance.PrimaryPart;
    end;
    if not v126 then
        return;
    else
        local l_GroundMaterial_0 = v125.GroundMaterial;
        local l_LastGroundedMoveState_0 = v125.LastGroundedMoveState;
        local v129 = v6:SearchFrom(v18, l_GroundMaterial_0 .. "." .. l_LastGroundedMoveState_0);
        local v130 = v6:SearchFrom(v18, l_GroundMaterial_0 .. ".Jump");
        local v131 = v12.new(v130:GetChildren());
        if v131 and v129 then
            v103(v125, v131:Roll(), function(v132) --[[ Line: 481 ]]
                -- upvalues: v129 (copy), v21 (ref), v125 (copy), v4 (ref)
                local v133 = v129:Clone();
                v133.Parent = v132;
                v132.Volume = v132.Volume * (v133:GetAttribute("Volume") or 1);
                v132.RollOffMaxDistance = v133:GetAttribute("MaxDistance") or v132.RollOffMaxDistance;
                v132.RollOffMinDistance = v133:GetAttribute("MinDistance") or v132.RollOffMinDistance;
                v132.PlaybackSpeed = v132.PlaybackSpeed + v21:NextNumber(v133:GetAttribute("PitchRange") or 0, v133:GetAttribute("PitchRange") or 0);
                if v125.States.Ninja then
                    local v134 = v4("Padded Soles");
                    v132.Volume = v132.Volume * v134.TotalVolumeMod;
                end;
                if not v125.IsNetworked then
                    v132.Volume = v132.Volume * 0.5;
                end;
            end);
        end;
        return l_GroundMaterial_0;
    end;
end;
local function v143(v136) --[[ Line: 509 ]] --[[ Name: playGroundImpactSound ]]
    -- upvalues: v6 (copy), v18 (copy), v12 (copy), v103 (copy), v4 (copy)
    local v137 = nil;
    if v136.Instance and v136.Instance.PrimaryPart then
        v137 = v136.Instance.PrimaryPart;
    end;
    if not v137 then
        return;
    else
        local l_GroundMaterial_1 = v136.GroundMaterial;
        local v139 = v6:SearchFrom(v18, l_GroundMaterial_1 .. ".Impact");
        local v140 = v12.new(v139:GetChildren());
        if v140 then
            v103(v136, v140:Roll(), function(v141) --[[ Line: 525 ]]
                -- upvalues: v136 (copy), v4 (ref)
                if v136.States.Ninja then
                    local v142 = v4("Padded Soles");
                    v141.Volume = v141.Volume * v142.TotalVolumeMod;
                end;
                if not v136.IsNetworked then
                    v141.Volume = v141.Volume * 0.5;
                end;
            end);
        end;
        return l_GroundMaterial_1;
    end;
end;
local function v150(v144, v145) --[[ Line: 541 ]] --[[ Name: playMeleeSwingSounds ]]
    -- upvalues: v1 (copy), v103 (copy)
    local l_EquippedItem_0 = v144.States.EquippedItem;
    if l_EquippedItem_0 and v1[l_EquippedItem_0.ItemName] then
        local l_AttackConfig_0 = v1[l_EquippedItem_0.ItemName].AttackConfig;
        if l_AttackConfig_0 then
            for v148 = 1, #l_AttackConfig_0 do
                local v149 = l_AttackConfig_0[v148];
                if v149.Animation:find(v145) then
                    v103(v144, v149.Sound);
                    return;
                end;
            end;
        end;
    end;
end;
local function _(v151, v152) --[[ Line: 561 ]] --[[ Name: playBoxingSwing ]]
    -- upvalues: v103 (copy)
    local v153 = "Whoosh 2";
    if v152 == "Box Left Jab" or v152 == "Box Right Jab" then
        v153 = "Whoosh 1";
    end;
    v103(v151, "Melee." .. v153);
end;
local function v161(v155, v156) --[[ Line: 571 ]] --[[ Name: equipItemModel ]]
    -- upvalues: v16 (copy), v1 (copy), v9 (copy)
    if v155.Instance then
        local l_Equipped_1 = v155.Instance:FindFirstChild("Equipped");
        local l_v16_FirstChild_0 = v16:FindFirstChild(v156);
        local v159 = v1[v156];
        if l_Equipped_1 and l_v16_FirstChild_0 and v159 then
            local v160 = l_v16_FirstChild_0:Clone();
            if v159.Type == "Firearm" then
                v9.AttachFirearmToCharacter(v160, v155.Instance);
            else
                v9.AttachMeleeToCharacter(v160, v155.Instance);
            end;
            v160.Parent = l_Equipped_1;
            return v160;
        end;
    end;
    return nil;
end;
local _ = function(_, _, _, v165, v166) --[[ Line: 595 ]] --[[ Name: updateItemModel ]]
    -- upvalues: v8 (copy)
    v8:BuildFromSerialization(v165, v166);
end;
local function v172(v168) --[[ Line: 599 ]] --[[ Name: getFirearmLasers ]]
    local v169 = {};
    for _, v171 in next, v168:GetDescendants() do
        if v171.Name == "Laser Dot" then
            table.insert(v169, v171);
        end;
    end;
    return v169;
end;
local _ = function(_, _, _) --[[ Line: 611 ]] --[[ Name: dustEmit ]]

end;
local v177 = nil;
local v178 = v6:Find("ReplicatedStorage.Assets.Animations");
local v218 = {
    Footstep = function(v179, v180, _) --[[ Line: 633 ]] --[[ Name: Footstep ]]
        -- upvalues: v105 (copy)
        v180:GetMarkerReachedSignal("Step"):Connect(function() --[[ Line: 634 ]]
            -- upvalues: v179 (copy), v105 (ref)
            if not v179:IsAnimationPlaying("Actions.Jump", "Actions.Running Jump", "Actions.VaultHigh", "Actions.VaultLow", "Falling.Forwards", "Falling.Backwards") then
                local _ = v105(v179);
                local _ = v179;
            end;
        end);
    end, 
    Jump = function(v184, _, _) --[[ Line: 651 ]] --[[ Name: Jump ]]
        -- upvalues: v135 (copy)
        local _ = v135(v184);
        v184.JumpFadeStart = tick() + 0.5;
    end, 
    Impact = function(v188, v189, _) --[[ Line: 664 ]] --[[ Name: Impact ]]
        -- upvalues: v143 (copy)
        v189:GetMarkerReachedSignal("Impact"):Connect(function() --[[ Line: 665 ]]
            -- upvalues: v143 (ref), v188 (copy)
            local _ = v143(v188);
            local _ = v188;
        end);
    end, 
    Consume = function(v193, v194, _) --[[ Line: 671 ]] --[[ Name: Consume ]]
        -- upvalues: v1 (copy), v103 (copy)
        local l_EquippedItem_1 = v193.States.EquippedItem;
        if l_EquippedItem_1 and l_EquippedItem_1.ItemName then
            local v197 = v1[l_EquippedItem_1.ItemName];
            if v197 and v197.ConsumeConfig and v197.ConsumeConfig.Sound then
                local v199 = v103(v193, v197.ConsumeConfig.Sound, function(v198) --[[ Line: 679 ]]
                    -- upvalues: v194 (copy)
                    v198.PlaybackSpeed = v194.Speed;
                end);
                v194.Stopped:Connect(function() --[[ Line: 683 ]]
                    -- upvalues: v199 (copy)
                    if v199 then
                        v199:Stop();
                    end;
                end);
            end;
            if v193:IsAnimationPlaying("Actions.Inventory Search") then
                v193:SetAnimationWeight("Actions.Inventory Search", 0.001, 0.2);
                v194.Stopped:Connect(function() --[[ Line: 693 ]]
                    -- upvalues: v193 (copy)
                    v193:SetAnimationWeight("Actions.Inventory Search", 1, 0.3);
                end);
            end;
        end;
    end, 
    MeleeSwing = function(v200, v201, _) --[[ Line: 700 ]] --[[ Name: MeleeSwing ]]
        -- upvalues: v150 (copy)
        local v203 = {};
        for _, v205 in next, v200.EquipBin:GetDescendants() do
            if v205:IsA("Trail") and v205.Name == "SwingTrail" then
                table.insert(v203, v205);
            end;
        end;
        v201:GetMarkerReachedSignal("Swing"):Connect(function(v206) --[[ Line: 709 ]]
            -- upvalues: v150 (ref), v200 (copy), v201 (copy), v203 (copy)
            if v206 == "Begin" then
                v150(v200, v201.Animation.Name);
            end;
            for _, v208 in next, v203 do
                v208.Enabled = v206 == "Begin";
            end;
        end);
        v201.Stopped:Connect(function() --[[ Line: 719 ]]
            -- upvalues: v203 (copy)
            for _, v210 in next, v203 do
                v210.Enabled = false;
            end;
            table.clear(v203);
        end);
    end, 
    BoxingAttack = function(v211, v212, _) --[[ Line: 728 ]] --[[ Name: BoxingAttack ]]
        -- upvalues: v103 (copy)
        v212:GetMarkerReachedSignal("Swing"):Connect(function(v214) --[[ Line: 729 ]]
            -- upvalues: v211 (copy), v212 (copy), v103 (ref)
            if v214 == "Begin" then
                local l_v211_0 = v211;
                local l_Name_0 = v212.Animation.Name;
                local v217 = "Whoosh 2";
                if l_Name_0 == "Box Left Jab" or l_Name_0 == "Box Right Jab" then
                    v217 = "Whoosh 1";
                end;
                v103(l_v211_0, "Melee." .. v217);
            end;
        end);
    end
};
local v219 = {
    ["Walking.Forwards"] = v218.Footstep, 
    ["Running.Forwards"] = v218.Footstep, 
    ["Crouching.Forwards"] = v218.Footstep, 
    ["Swimming.Forwards"] = v218.Footstep, 
    ["Falling.Forwards"] = v218.Footstep, 
    ["Climbing.Forwards"] = v218.Footstep, 
    ["Sitting.Forwards"] = v218.Footstep, 
    ["Actions.Jump"] = v218.Jump, 
    ["Actions.Running Jump"] = v218.Jump, 
    ["Actions.Fall Impact"] = v218.Impact
};
for _, v221 in next, v178:GetDescendants() do
    if v221:IsA("Animation") then
        if v221:FindFirstChild("MeleeAnimation") then
            v219[v221.Parent.Name .. "." .. v221.Name] = v218.MeleeSwing;
        elseif v221:FindFirstChild("BoxingAnimation") then
            v219[v221.Parent.Name .. "." .. v221.Name] = v218.BoxingAttack;
        elseif v221:FindFirstChild("ConsumeSoundPlayback") then
            v219[v221.Parent.Name .. "." .. v221.Name] = v218.Consume;
        end;
    end;
end;
local l_v219_0 = v219 --[[ copy: 50 -> 56 ]];
v177 = function(v223, v224, v225) --[[ Line: 763 ]] --[[ Name: keyframeEventHooks ]]
    -- upvalues: l_v219_0 (copy)
    if l_v219_0[v224] then
        l_v219_0[v224](v223, v225);
    end;
end;
v178 = nil;
v218 = {};
local l_v218_0 = v218 --[[ copy: 49 -> 57 ]];
v178 = function(v227) --[[ Line: 779 ]] --[[ Name: isRealAnimation ]]
    -- upvalues: l_v218_0 (copy), v6 (copy)
    if l_v218_0[v227] == nil then
        if v6:Search("ReplicatedStorage.Assets.Animations." .. v227) then
            l_v218_0[v227] = true;
        else
            l_v218_0[v227] = false;
        end;
    end;
    return l_v218_0[v227];
end;
v218 = nil;
v219 = {};
local v228 = {};
local l_v219_1 = v219 --[[ copy: 50 -> 58 ]];
local l_v228_0 = v228 --[[ copy: 51 -> 59 ]];
v218 = function(v231) --[[ Line: 796 ]] --[[ Name: getFlashObjects ]]
    -- upvalues: l_v219_1 (copy), l_v228_0 (copy)
    if not l_v219_1[v231] then
        l_v219_1[v231] = v231.AncestryChanged:Connect(function(_, v233) --[[ Line: 798 ]]
            -- upvalues: l_v219_1 (ref), v231 (copy), l_v228_0 (ref)
            if not v233 then
                l_v219_1[v231]:Disconnect();
                l_v219_1[v231] = nil;
                l_v228_0[v231] = nil;
            end;
        end);
    end;
    if not l_v228_0[v231] then
        local v234 = {};
        for _, v236 in next, v231:GetDescendants() do
            if v236:IsA("ParticleEmitter") or v236:IsA("Light") then
                table.insert(v234, v236);
            end;
        end;
        l_v228_0[v231] = v234;
    end;
    return l_v228_0[v231];
end;
v219 = function(v237, v238, v239) --[[ Line: 826 ]] --[[ Name: animateMuzzleFlash ]]
    -- upvalues: v4 (copy), v21 (copy), v218 (ref)
    if v238 and v239 then
        local l_Barrel_0 = v238:FindFirstChild("Barrel");
        local v241 = nil;
        v241 = if l_Barrel_0 then l_Barrel_0:FindFirstChild("MuzzleFlash") else v238:FindFirstChild("MuzzleFlash");
        if v241 then
            local v242 = v241:GetAttribute("MuzzleFlashChance") or 1;
            if v237.States.CleanGun then
                local v243 = os.clock();
                if os.clock() - v237.LastMuzzleFlash < v4("Gun Cleaning Kit", "FlashModResetTimer") then
                    v242 = v242 * v4("Gun Cleaning Kit", "FlashModifier");
                end;
                v237.LastMuzzleFlash = v243;
            end;
            local v244 = v21:NextNumber(0, 1) < v242;
            for _, v246 in next, v218(v241) do
                local l_v246_Attribute_0 = v246:GetAttribute("EmitCount");
                local l_v246_Attribute_1 = v246:GetAttribute("EmitFor");
                local l_v246_Attribute_2 = v246:GetAttribute("ChanceTied");
                local v250 = true;
                if l_v246_Attribute_2 and not v244 then
                    v250 = false;
                end;
                if v250 then
                    if l_v246_Attribute_1 then
                        local v251 = (v246:GetAttribute("EmitId") or 0) + 1;
                        v246:SetAttribute("EmitId", v251);
                        v246.Enabled = true;
                        task.delay(l_v246_Attribute_1, function() --[[ Line: 870 ]]
                            -- upvalues: v246 (copy), v251 (copy)
                            if v246:GetAttribute("EmitId") == v251 then
                                v246.Enabled = false;
                            end;
                        end);
                    elseif v246:IsA("ParticleEmitter") then
                        v246:Emit(l_v246_Attribute_0 or 1);
                    end;
                end;
            end;
        end;
    end;
end;
v228 = function(v252) --[[ Line: 885 ]] --[[ Name: getLightObject ]]
    -- upvalues: v6 (copy)
    local v253 = v6:Search("ReplicatedStorage.Assets.Particles.LightPresets." .. (v252 or ""));
    if v253 then
        local v254 = v253:Clone();
        for _, v256 in next, v254:GetDescendants() do
            if v256:IsA("Light") then
                v256.Enabled = true;
                v256.Shadows = true;
            end;
        end;
        return v254;
    else
        return nil;
    end;
end;
return function(v257) --[[ Line: 907 ]]
    -- upvalues: v10 (copy), v11 (copy), v13 (copy), v177 (ref), v49 (copy), v20 (copy), v66 (copy), v1 (copy), l_TweenService_0 (copy), v0 (copy), v6 (copy), v71 (copy), v8 (copy), v161 (copy), v172 (copy), v24 (copy), v22 (copy), v178 (ref), v23 (copy), v25 (copy), v228 (copy), v103 (copy), v219 (copy), v27 (copy), l_RunService_0 (copy), v5 (copy), v21 (copy), v7 (copy), v96 (copy), v3 (copy), v2 (copy)
    v257.LodVisibleCutOff = 300;
    v257.GroundMaterial = "Sand";
    v257.GroundCastDebounce = os.clock();
    local l_States_0 = v257.States;
    local l_Instance_0 = v257.Instance;
    local l_HumanoidRootPart_0 = l_Instance_0:WaitForChild("HumanoidRootPart");
    local l_Equipped_2 = l_Instance_0:WaitForChild("Equipped");
    local l_Equipment_1 = l_Instance_0:WaitForChild("Equipment");
    local v263 = {
        RootPart = l_HumanoidRootPart_0, 
        Head = l_Instance_0:WaitForChild("Head"), 
        UpperTorso = l_Instance_0:WaitForChild("UpperTorso"), 
        LowerTorso = l_Instance_0:WaitForChild("LowerTorso"), 
        LeftUpperArm = l_Instance_0:WaitForChild("LeftUpperArm"), 
        LeftLowerArm = l_Instance_0:WaitForChild("LeftLowerArm"), 
        LeftHand = l_Instance_0:WaitForChild("LeftHand"), 
        RightUpperArm = l_Instance_0:WaitForChild("RightUpperArm"), 
        RightLowerArm = l_Instance_0:WaitForChild("RightLowerArm"), 
        RightHand = l_Instance_0:WaitForChild("RightHand"), 
        LeftUpperLeg = l_Instance_0:WaitForChild("LeftUpperLeg"), 
        LeftLowerLeg = l_Instance_0:WaitForChild("LeftLowerLeg"), 
        LeftFoot = l_Instance_0:WaitForChild("LeftFoot"), 
        RightUpperLeg = l_Instance_0:WaitForChild("RightUpperLeg"), 
        RightLowerLeg = l_Instance_0:WaitForChild("RightLowerLeg"), 
        RightFoot = l_Instance_0:WaitForChild("RightFoot")
    };
    local v264 = {
        Root = v263.LowerTorso:WaitForChild("Root"), 
        Neck = v263.Head:WaitForChild("Neck"), 
        Waist = v263.UpperTorso:WaitForChild("Waist"), 
        LeftShoulder = v263.LeftUpperArm:WaitForChild("LeftShoulder"), 
        LeftElbow = v263.LeftLowerArm:WaitForChild("LeftElbow"), 
        LeftWrist = v263.LeftHand:WaitForChild("LeftWrist"), 
        RightShoulder = v263.RightUpperArm:WaitForChild("RightShoulder"), 
        RightElbow = v263.RightLowerArm:WaitForChild("RightElbow"), 
        RightWrist = v263.RightHand:WaitForChild("RightWrist"), 
        LeftHip = v263.LeftUpperLeg:WaitForChild("LeftHip"), 
        LeftKnee = v263.LeftLowerLeg:WaitForChild("LeftKnee"), 
        LeftAnkle = v263.LeftFoot:WaitForChild("LeftAnkle"), 
        RightHip = v263.RightUpperLeg:WaitForChild("RightHip"), 
        RightKnee = v263.RightLowerLeg:WaitForChild("RightKnee"), 
        RightAnkle = v263.RightFoot:WaitForChild("RightAnkle")
    };
    local v265 = {
        Transparency = v10.new(0, 12, 1), 
        RootAngle = v10.new(0, 5, 0.95), 
        WaistAngles = v10.new(Vector3.new(0, 0, 0, 0), 5, 0.95), 
        LookDirection = v10.new(Vector3.new(0, 0, 0, 0), 5, 1), 
        ClimbTwist = v10.new(0, 10, 1), 
        StanceBounce = v10.new(Vector3.new(0, 0, 0, 0), 1.8, 0.7), 
        ShoulderSwapBounce = v10.new(Vector3.new(0, 0, 0, 0), 1.8, 0.7), 
        ShoulderVelocity = v10.new(Vector3.new(0, 0, 0, 0), 5, 0.9), 
        ShoulderVelocitySoooth = v11.new(Vector3.new(0, 0, 0, 0), 3, 1), 
        ShoulderRotVelocity = v11.new(Vector3.new(0, 0, 0, 0), 3, 0.9), 
        WobblePos = v10.new(Vector3.new(0, 0, 0, 0), 5, 1), 
        WobbleRot = v10.new(Vector3.new(0, 0, 0, 0), 5, 1), 
        RotationVelocity = v10.new(Vector3.new(0, 0, 0, 0), 5, 1), 
        MoveVelocity = v10.new(Vector3.new(0, 0, 0, 0), 5, 1), 
        MoveVector = v10.new(Vector3.new(0, 0, 0, 0), 2, 1), 
        ToolOffset = v10.new(Vector3.new(0, 0, 0, 0), 10, 1), 
        ToolAngles = v10.new(Vector3.new(0, 0, 0, 0), 10, 1), 
        RightHand = v10.new(Vector3.new(0, 0, 0, 0), 10, 1), 
        LeftHand = v10.new(Vector3.new(0, 0, 0, 0), 10, 1), 
        RightHandRoll = v10.new(0, 10, 1), 
        LeftHandRoll = v10.new(0, 10, 1), 
        AimOffset = v10.new(Vector3.new(0, 0, 0, 0), 3, 1), 
        AimAngles = v10.new(Vector3.new(0, 0, 0, 0), 3, 1), 
        AimRightHand = v10.new(Vector3.new(0, 0, 0, 0), 3, 1), 
        AimLeftHand = v10.new(Vector3.new(0, 0, 0, 0), 3, 1), 
        AimRightHandRoll = v10.new(0, 3, 1), 
        AimLeftHandRoll = v10.new(0, 3, 1), 
        RaiseSpring = v10.new(0, 18, 0.95), 
        ShiftSpring = v10.new(Vector2.new(), 18, 0.95), 
        SlideSpring = v10.new(0, 18, 0.95), 
        KickSpring = v10.new(0, 8, 0.95), 
        KickVelocity = {
            Spring = v11.new(0, 0, 0), 
            ProcessQueue = {}, 
            TimeStack = 0
        }
    };
    local v266 = {};
    for v267, v268 in next, v264 do
        v266[v267] = {
            C0 = v268.C0, 
            C1 = v268.C1
        };
    end;
    local v269 = {};
    v257.Springs = v265;
    v257.BodyParts = v263;
    v257.EquipBin = l_Equipped_2;
    v257.Joints = v264;
    v257.FootstepCache = {};
    v257.InvisibleCases = {};
    v257.Muted = false;
    v257.JumpFadeStart = 0;
    v257.LastGroundedMoveState = v257.States.MoveState;
    v257.StateChangeSpeed = 0.1;
    v257.LastMuzzleFlash = os.clock();
    v257.ReloadAnimationPlayed = v13.new();
    v257.ReloadAnimationStopped = v13.new();
    local v270 = nil;
    local v271 = nil;
    local v272 = nil;
    local v273 = nil;
    local v274 = nil;
    local v275 = nil;
    local v276 = {};
    local v277 = nil;
    local v278 = nil;
    local v279 = false;
    local v280 = 0;
    local v281 = 0;
    local v282 = false;
    local v283 = false;
    local v284 = false;
    local v285 = false;
    local v286 = 0;
    local v287 = 0;
    local v288 = 0;
    local l_Position_0 = l_HumanoidRootPart_0.Position;
    local l_CFrame_0 = l_HumanoidRootPart_0.CFrame;
    v257.Maid:Give(function() --[[ Line: 1070 ]]
        -- upvalues: v263 (ref), v264 (ref), v257 (copy), v265 (ref), v266 (ref), l_States_0 (ref), l_Instance_0 (ref), l_HumanoidRootPart_0 (ref), l_Equipped_2 (ref), v270 (ref), v271 (ref), v272 (ref), v273 (ref), v274 (ref), v275 (ref), v277 (ref), v278 (ref), v276 (ref)
        for v291, _ in next, v263 do
            v263[v291] = nil;
        end;
        for v293, _ in next, v264 do
            v264[v293] = nil;
        end;
        for _, v296 in next, v257.FootstepCache do
            if v296.Randomizer then
                v296.Randomizer:Destroy();
                v296.Randomizer = nil;
            end;
            v296.Eq = nil;
        end;
        v265 = nil;
        v266 = nil;
        v263 = nil;
        v264 = nil;
        l_States_0 = nil;
        l_Instance_0 = nil;
        l_HumanoidRootPart_0 = nil;
        l_Equipped_2 = nil;
        v270 = nil;
        v271 = nil;
        v272 = nil;
        v273 = nil;
        v274 = nil;
        v275 = nil;
        v277 = nil;
        v278 = nil;
        v276 = nil;
        v257.ReloadAnimationPlayed:Destroy();
        v257.ReloadAnimationPlayed = nil;
        v257.ReloadAnimationStopped:Destroy();
        v257.ReloadAnimationStopped = nil;
        v257.ReloadCallback = nil;
        v257.FirearmPoseInfo = nil;
        v257.FootstepCache = nil;
        v257.InvisibleCases = nil;
        v257.Springs = nil;
        v257.BodyParts = nil;
        v257.EquipBin = nil;
        v257.Joints = false;
        if v257.LightObject then
            v257.LightObject:Destroy();
            v257.LightObject = nil;
        end;
        if v257.BinocularModel then
            v257.BinocularModel:Destroy();
            v257.BinocularModel = nil;
        end;
        if v257.GroundSoundLoop then
            v257.GroundSoundLoop:Stop();
            v257.GroundSoundLoop:Destroy();
            v257.GroundSoundLoop = nil;
        end;
    end);
    local l_PlayAnimation_0 = v257.PlayAnimation;
    v257.PlayAnimation = function(v298, v299, ...) --[[ Line: 1147 ]] --[[ Name: PlayAnimation ]]
        -- upvalues: l_PlayAnimation_0 (copy), v177 (ref)
        local v300 = l_PlayAnimation_0(v298, v299, ...);
        local v301 = v298.Animations[v299];
        if v301 then
            v177(v298, v299, v301);
        end;
        return v300;
    end;
    v257.IsEquipFading = function(v302) --[[ Line: 1158 ]] --[[ Name: IsEquipFading ]]
        return v302.EquipFading == true;
    end;
    v257.IsReloadPlaying = function(_, _) --[[ Line: 1162 ]] --[[ Name: IsReloadPlaying ]]
        -- upvalues: v277 (ref), v284 (ref), v279 (ref)
        if not v277 or not v284 then
            return false;
        else
            return v279;
        end;
    end;
    v257.AddInvisibleCase = function(v305, v306, v307) --[[ Line: 1170 ]] --[[ Name: AddInvisibleCase ]]
        v305.InvisibleCases[v306] = v307;
    end;
    v257.RemoveInvisibleCase = function(v308, v309) --[[ Line: 1174 ]] --[[ Name: RemoveInvisibleCase ]]
        v308.InvisibleCases[v309] = nil;
    end;
    local function v310() --[[ Line: 1184 ]] --[[ Name: queueTransparencySet ]]
        -- upvalues: v257 (copy)
        v257.InvisibleMode = nil;
        v257.AllPartsInvisible = nil;
    end;
    local function _(v311, v312) --[[ Line: 1189 ]] --[[ Name: getFirearmStat ]]
        -- upvalues: v274 (ref)
        if v274 and v274[v311] then
            local v313 = v274[v311];
            if v313.Calculated then
                return v313.Calculated;
            else
                local v314 = v313.Multiplier or 1;
                local v315 = v313.Bonus or 0;
                return v312 * v314 + v315;
            end;
        else
            return v312;
        end;
    end;
    local function v318(v317) --[[ Line: 1206 ]] --[[ Name: getLimbBaseJoint ]]
        -- upvalues: v264 (ref)
        if v317 == "Head" then
            return v264.Neck, 1;
        elseif v317 == "UpperTorso" or v317 == "LowerTorso" then
            return v264.Waist, 1;
        elseif v317:find("Hand") or v317:find("Arm") then
            return v264[(v317:find("Right") and "Right" or "Left") .. (v317:find("Upper") and "Shoulder" or "Elbow")], -1;
        elseif v317:find("Foot") or v317:find("Leg") then
            return v264[(v317:find("Right") and "Right" or "Left") .. (v317:find("Upper") and "Hip" or "Knee")], -1;
        else
            return nil, 0;
        end;
    end;
    local function v324(v319) --[[ Line: 1228 ]] --[[ Name: getToolLookCFrame ]]
        -- upvalues: v49 (ref), l_States_0 (ref), v257 (copy), v263 (ref), v265 (ref), l_HumanoidRootPart_0 (ref)
        if v319 then
            return v49();
        else
            local v320 = false;
            if l_States_0.MoveState == "Running" or l_States_0.AtEase then
                v320 = true;
            end;
            if not v257.IsNetworked and v257.Parent and v257.Parent.Freeze then
                v320 = true;
            end;
            if v257.States.Shoving or v257.States.Staggered then
                v320 = true;
            end;
            if v320 then
                return v263.UpperTorso.CFrame;
            else
                local v321 = v265.LookDirection:GetPosition() * Vector3.new(0, 1, 0, 0);
                local v322 = l_HumanoidRootPart_0.CFrame.lookVector * Vector3.new(1, 0, 1, 0);
                local l_p_0 = v263.UpperTorso.CFrame.p;
                return CFrame.new(Vector3.new(0, 0, 0, 0), v321 + v322) + l_p_0;
            end;
        end;
    end;
    local function v329(v325) --[[ Line: 1261 ]] --[[ Name: mapAnimationParts ]]
        local v326 = {};
        for _, v328 in next, v325:GetDescendants() do
            if v328:IsA("Motor6D") then
                v326[v328.Parent.Name] = {
                    Motor = v328, 
                    C0 = v328.C0, 
                    C1 = v328.C1
                };
            end;
        end;
        return v326;
    end;
    local function v360(v330, v331, v332, v333) --[[ Line: 1277 ]] --[[ Name: solveArm ]]
        -- upvalues: l_States_0 (ref), v273 (ref), v266 (ref), v263 (ref), v20 (ref), v282 (ref), v265 (ref), v257 (copy), v275 (ref), v283 (ref), v66 (ref)
        local v334 = v333 or {};
        local l_v331_0 = v331;
        local l_v330_0 = v330;
        if l_States_0.ShoulderSwap then
            v330 = l_v330_0 == "Left" and "Right" or "Left";
        end;
        if v330 == "Left" then
            l_v331_0 = v332;
        end;
        local v337 = l_v330_0 == "Right" and 1 or -1;
        local l_v273_0 = v273;
        if not l_States_0.FirstPerson and l_v273_0 == "Aiming" then
            l_v273_0 = "Idle";
        end;
        local l_C0_0 = v266[l_v330_0 .. "Shoulder"].C0;
        local v340 = CFrame.new(0, v266[v330 .. "Elbow"].C0.Y, 0);
        local l_CFrame_1 = v263.UpperTorso.CFrame;
        local l_v20_0 = v20;
        local l_l_v273_0_0 = l_v273_0;
        if l_l_v273_0_0 ~= "Aiming" or v282 then
            l_l_v273_0_0 = "Idle";
        end;
        local v344 = v265[v330 .. "Hand"];
        local v345 = v265[v330 .. "HandRoll"];
        local v346 = v265["Aim" .. v330 .. "Hand"];
        if l_States_0.FirstPerson and not v257.IsNetworked then
            local v347 = v275 and v275.PoseData.FirstPersonPoseData[l_v273_0][v330 .. "HandOffset"] or Vector3.new(0, 0, 0, 0);
            local v348 = v275 and v275.PoseData.FirstPersonPoseData[l_l_v273_0_0][v330 .. "HandOffset"] or Vector3.new(0, 0, 0, 0);
            if v334.EmptyHandOffset then
                v347 = Vector3.new(0, 0, 0, 0);
                v348 = Vector3.new(0, 0, 0, 0);
            end;
            v346:SetGoal(v348);
            if l_v273_0 == "Aiming" then
                v347 = v346:GetPosition();
            else
                v346:GetPosition();
            end;
            local l_CurrentCamera_1 = workspace.CurrentCamera;
            local l_CFrame_2 = l_CurrentCamera_1.CFrame;
            local _ = l_CurrentCamera_1.Focus;
            l_v20_0 = l_CFrame_2 * CFrame.new(v337 * 1.2, -1.5, 0);
            v344:SetGoal(v347);
        else
            local v352 = "ThirdPersonPoseData";
            if l_States_0.MoveState == "Crouching" then
                v352 = "ThirdPersonCrouchPoseData";
            end;
            local v353 = v275 and v275.PoseData[v352][l_v273_0][v330 .. "HandOffset"] or Vector3.new(0, 0, 0, 0);
            local v354 = v275 and v275.PoseData[v352][l_l_v273_0_0][v330 .. "HandOffset"] or Vector3.new(0, 0, 0, 0);
            if v334.EmptyHandOffset then
                v353 = Vector3.new(0, 0, 0, 0);
                v354 = Vector3.new(0, 0, 0, 0);
            end;
            v346:SetGoal(v354);
            if l_v273_0 == "Aiming" then
                v353 = v346:GetPosition();
            else
                v346:GetPosition();
            end;
            l_v20_0 = l_CFrame_1 * l_C0_0;
            v344:SetGoal(v353);
        end;
        if v283 then
            v344:SnapTo();
            v346:SnapTo();
        end;
        local v355 = CFrame.Angles(0, 0, v337 * v345:GetPosition());
        local v356 = l_CFrame_1 * Vector3.new(-0.25 * v337, 0, 0) - l_CFrame_1.p + l_v331_0 * (v344:GetPosition() * Vector3.new(-v337, 1, 1));
        local v357, v358, v359 = v66(l_v20_0 * v355, v356, v334.L1 or 0.515, v334.L2 or 1.1031, v334.PushIn, v334.PushDown);
        return l_CFrame_1:toObjectSpace(v357) * CFrame.Angles(v358, 0, 0), v340 * CFrame.Angles(v359, 0, 0);
    end;
    local function v361() --[[ Line: 1389 ]] --[[ Name: resetToolValues ]]
        -- upvalues: v275 (ref), v270 (ref), v271 (ref), v272 (ref), v274 (ref), v278 (ref), v284 (ref), v265 (ref)
        v275 = nil;
        v270 = nil;
        v271 = nil;
        v272 = nil;
        v274 = nil;
        v278 = nil;
        v284 = false;
        v265.AimOffset:SnapTo();
        v265.AimAngles:SnapTo();
        v265.AimRightHand:SnapTo();
        v265.AimLeftHand:SnapTo();
        v265.AimRightHandRoll:SnapTo();
        v265.AimLeftHandRoll:SnapTo();
    end;
    local function _(v362, v363) --[[ Line: 1406 ]] --[[ Name: findAndValidateTool ]]
        -- upvalues: v361 (copy), v270 (ref), v275 (ref), v271 (ref), v272 (ref), v278 (ref), v329 (copy), v284 (ref)
        v361();
        v270 = v362;
        v275 = v363;
        if v275.Type == "Firearm" then
            v271 = v270:WaitForChild("Base");
            v272 = v271:WaitForChild("Handle");
            v278 = v329(v270);
            v284 = true;
        end;
    end;
    local function v382(v365, v366) --[[ Line: 1421 ]] --[[ Name: getBaseLayerPoses ]]
        -- upvalues: l_States_0 (ref), v257 (copy), v265 (ref), l_HumanoidRootPart_0 (ref), v275 (ref), v283 (ref), v20 (ref), l_Equipment_1 (copy)
        if l_States_0.MoveState == "Climbing" then
            if not v257.IsNetworked and v257.Parent then
                local v367 = -v257.Parent.MoveVector.X;
                if v257.Parent.Mounting or v257.Parent.Dismounting then
                    v367 = 0;
                end;
                v265.ClimbTwist:SetGoal(1.5707963267948966 * v367);
            end;
        else
            v265.ClimbTwist:SetGoal(0);
        end;
        if v257:IsAnimationPlayingWithTag("ResetLookDirection") then
            v265.LookDirection:SetGoal(l_HumanoidRootPart_0.CFrame.lookVector);
        elseif l_States_0.LookDirection then
            v265.LookDirection:SetGoal(l_States_0.LookDirection);
        end;
        local l_Position_1 = v265.LookDirection:GetPosition();
        local v369 = l_HumanoidRootPart_0.CFrame:VectorToObjectSpace(l_Position_1);
        if v369.Magnitude > 0 then
            v369 = v369.Unit;
        end;
        local v370 = math.asin(v369.Y) / 2;
        local v371 = math.atan2(-v369.X, -v369.Z) / 2;
        if math.abs(v371) > 1.3089969389957472 then
            v371 = 0;
        end;
        v265.WaistAngles:SetGoal((Vector3.new(v370, v371, 0)));
        l_Position_1 = v257:IsAnimationPlaying("Actions.Inventory Search", "Melees.Shove", "Actions.VaultLow", "Actions.VaultHigh", "Actions.Fall Impact");
        v369 = l_States_0.MoveState == "Running";
        v370 = l_Position_1 or v369 or l_States_0.AtEase;
        v371 = v275 and v275.Type == "Firearm" or false;
        local v372 = v257:IsReloadPlaying(v365);
        if not v370 and v371 and not v372 then
            v265.RootAngle:SetGoal(-0.7853981633974483 * v366);
        else
            v265.RootAngle:SetGoal(0);
        end;
        if v283 then
            v265.RootAngle:SnapTo();
            v265.LookDirection:SnapTo();
            v265.WaistAngles:SnapTo();
        end;
        if l_States_0.MoveState == "Swimming" then
            v265.RootAngle:SetGoal(0);
            v265.WaistAngles:SetGoal((Vector3.new(0, 0, 0, 0)));
        end;
        l_Position_1 = {};
        if v365 then
            l_Position_1.Root = v20;
            l_Position_1.Waist = v20;
            l_Position_1.Neck = v20;
            return l_Position_1;
        else
            v369 = v265.SlideSpring:GetPosition();
            v370 = v265.RootAngle:GetPosition() - v369 * 0.25;
            v371 = v265.WaistAngles:GetPosition();
            v372 = v371.X;
            local l_Y_0 = v371.Y;
            local l_Position_2 = v265.ClimbTwist:GetPosition();
            local l_Position_3 = v265.MoveVector:GetPosition();
            if v257.States.MoveState == "Sitting" then
                l_Position_3 = Vector3.new(0, 0, 0, 0);
            end;
            local v376 = math.rad(-l_Position_3.X * 5 / 20);
            local v377 = CFrame.Angles(0, v376, v376);
            local v378 = 0.5 * (l_Equipment_1:GetAttribute("NeckIKTilt") or 1);
            local v379 = 0.5 * (l_Equipment_1:GetAttribute("NeckIKTurn") or 1);
            local v380 = 0.5 * (l_Equipment_1:GetAttribute("WaistIKTilt") or 1);
            local v381 = 0.2 * (l_Equipment_1:GetAttribute("WaistIKTurn") or 1);
            l_Position_1.Root = CFrame.Angles(0, v370, 0);
            l_Position_1.Waist = v377 * CFrame.Angles(v372 * v380, l_Y_0 * v381 + l_Position_2 * 0.4, 0);
            l_Position_1.Neck = CFrame.Angles(0, v376, 0) * CFrame.Angles(v372 * v378, l_Position_2 * 0.4 - v370 + l_Y_0 * v379, 0);
            return l_Position_1;
        end;
    end;
    local function v448(v383, v384, v385, v386, v387) --[[ Line: 1536 ]] --[[ Name: findToolPoses ]]
        -- upvalues: v284 (ref), v324 (copy), v275 (ref), v274 (ref), v257 (copy), l_States_0 (ref), v273 (ref), v270 (ref), v1 (ref), v282 (ref), v265 (ref), v283 (ref), v288 (ref), l_TweenService_0 (ref), v286 (ref), v0 (ref), v287 (ref), v271 (ref)
        if not v284 then
            return {};
        else
            local v388 = v324(v383);
            local v389 = Vector3.new(0, 0, 0, 0);
            local v390 = Vector3.new(0, 0, 0, 0);
            local v391 = 0.4;
            local v392 = 0;
            local v393 = 0;
            local v394 = 0.1;
            local l_Quart_0 = Enum.EasingStyle.Quart;
            local v396 = Vector3.new(1, v384, v384);
            local v397 = Vector3.new(v384, 1, 1);
            if v275.Handling and v274 then
                local v398 = v275.Handling.EquipFade or 0.1;
                if v274 and v274.EquipFade then
                    local l_EquipFade_0 = v274.EquipFade;
                    if l_EquipFade_0.Calculated then
                        v394 = l_EquipFade_0.Calculated;
                    else
                        local v400 = l_EquipFade_0.Multiplier or 1;
                        local v401 = l_EquipFade_0.Bonus or 0;
                        v394 = v398 * v400 + v401;
                    end;
                else
                    v394 = v398;
                end;
                if v275.Handling.EquipFadeStyle then
                    l_Quart_0 = Enum.EasingStyle[v275.Handling.EquipFadeStyle];
                end;
            end;
            local v402 = v257:IsAnimationPlaying("Melees.Shove", "Actions.VaultLow", "Actions.VaultHigh");
            local v403 = v257:IsAnimationPlaying("Actions.Inventory Search");
            if l_States_0.MoveState == "Running" then
                v273 = "Running";
            elseif l_States_0.AtEase then
                v273 = "AtEase";
            elseif l_States_0.Zooming and l_States_0.FirstPerson then
                v273 = "Aiming";
            else
                v273 = "Idle";
            end;
            if v257:IsAnimationPlaying("Actions.Fall Impact") then
                v273 = "AtEase";
            end;
            if v402 or v403 or v257.States.Staggered then
                v273 = "AtEase";
            end;
            local l_SightLine_0 = v270:FindFirstChild("SightLine");
            local l_Sight_0 = v270:FindFirstChild("Sight");
            if l_Sight_0 then
                local l_RealName_0 = l_Sight_0:FindFirstChild("RealName");
                if l_RealName_0 then
                    l_SightLine_0 = l_Sight_0:FindFirstChild("SightLine") or l_SightLine_0;
                    v391 = v1[l_RealName_0.Value].Distance;
                end;
            end;
            local l_SightLineOffset_0 = v270:FindFirstChild("SightLineOffset");
            local l_SightLineSize_0 = v270:FindFirstChild("SightLineSize");
            local l_ProjectionOffset_0 = v270:FindFirstChild("ProjectionOffset");
            local l_ProjectionSize_0 = v270:FindFirstChild("ProjectionSize");
            local v411 = Vector3.new(0, 0, -v391);
            if l_SightLineOffset_0 then
                v411 = l_SightLineOffset_0.Value + v411;
            end;
            local v412 = Vector3.new(0, 0, 0, 0);
            local v413 = Vector3.new(0, 0, 0, 0);
            local v414 = 0;
            local v415 = 0;
            local l_v273_1 = v273;
            if l_v273_1 ~= "Aiming" or v282 then
                l_v273_1 = "Idle";
            end;
            if v383 then
                v412 = v275.PoseData.FirstPersonPoseData[l_v273_1].Rotation;
                v413 = v275.PoseData.FirstPersonPoseData[l_v273_1].Position;
                if l_v273_1 == "Aiming" then
                    v412 = v412 * 0;
                    v413 = v411 - v413;
                    if l_Sight_0 then
                        v413 = v411;
                    end;
                end;
                v414 = v275.PoseData.FirstPersonPoseData[l_v273_1].LeftHandRoll;
                v415 = v275.PoseData.FirstPersonPoseData[l_v273_1].RightHandRoll;
            else
                local v417 = "ThirdPersonPoseData";
                if l_States_0.MoveState == "Crouching" then
                    v417 = "ThirdPersonCrouchPoseData";
                end;
                v412 = v275.PoseData[v417][l_v273_1].Rotation;
                v413 = v275.PoseData[v417][l_v273_1].Position;
                v414 = v275.PoseData[v417][l_v273_1].LeftHandRoll;
                v415 = v275.PoseData[v417][l_v273_1].RightHandRoll;
            end;
            v265.AimAngles:SetGoal(v412);
            v265.AimOffset:SetGoal(v413);
            v265.AimLeftHandRoll:SetGoal(v414);
            v265.AimRightHandRoll:SetGoal(v415);
            if v283 then
                v265.AimAngles:SnapTo();
                v265.AimOffset:SnapTo();
                v265.AimRightHandRoll:SnapTo();
                v265.AimRightHandRoll:SnapTo();
            end;
            if v383 then
                if v273 ~= "Aiming" then
                    v389 = v275.PoseData.FirstPersonPoseData[v273].Rotation;
                    v390 = v275.PoseData.FirstPersonPoseData[v273].Position;
                else
                    v389 = v275.PoseData.FirstPersonPoseData[v273].Rotation * 0;
                    v390 = v411 - v275.PoseData.FirstPersonPoseData[v273].Position;
                    if l_Sight_0 then
                        v390 = v411;
                    end;
                end;
                v392 = v275.PoseData.FirstPersonPoseData[v273].LeftHandRoll;
                v393 = v275.PoseData.FirstPersonPoseData[v273].RightHandRoll;
            else
                v412 = "ThirdPersonPoseData";
                if l_States_0.MoveState == "Crouching" then
                    v412 = "ThirdPersonCrouchPoseData";
                end;
                v389 = v275.PoseData[v412][v273].Rotation;
                v390 = v275.PoseData[v412][v273].Position;
                v392 = v275.PoseData[v412][v273].LeftHandRoll;
                v393 = v275.PoseData[v412][v273].RightHandRoll;
            end;
            if v273 == "Aiming" then
                v389 = v265.AimAngles:GetPosition();
                v390 = v265.AimOffset:GetPosition();
                v392 = v265.AimLeftHandRoll:GetPosition();
                v393 = v265.AimRightHandRoll:GetPosition();
            else
                v265.AimAngles:GetPosition();
                v265.AimOffset:GetPosition();
                v265.AimLeftHandRoll:GetPosition();
                v265.AimRightHandRoll:GetPosition();
            end;
            if tick() - v288 <= v394 then
                v412 = l_TweenService_0:GetValue((tick() - v288) / v394, l_Quart_0, Enum.EasingDirection.In);
                v413 = "FirstPersonPoseData";
                if not v383 then
                    v413 = "ThirdPersonPoseData";
                    if l_States_0.MoveState == "Crouching" then
                        v413 = "ThirdPersonCrouchPoseData";
                    end;
                end;
                v414 = v275.PoseData[v413].AtEase.Rotation;
                v415 = v275.PoseData[v413].AtEase.Position;
                l_v273_1 = v275.PoseData[v413].AtEase.LeftHandRoll;
                local l_RightHandRoll_0 = v275.PoseData[v413].AtEase.RightHandRoll;
                if v383 then
                    v415 = v415 - Vector3.new(0, 1, 0, 0);
                end;
                v389 = v414 + (v389 - v414) * v412;
                local l_v415_0 = v415;
                v390 = l_v415_0 + (v390 - l_v415_0) * v412;
                v392 = l_v273_1 + (v392 - l_v273_1) * v412;
                v393 = l_RightHandRoll_0 + (v393 - l_RightHandRoll_0) * v412;
                v257.EquipFadeAlpha = v412;
                v257.EquipFading = true;
            else
                v257.EquipFadeAlpha = 1;
                v257.EquipFading = false;
            end;
            v265.ToolAngles:SetGoal(v389 * v396);
            v265.ToolOffset:SetGoal(v390 * v397);
            v265.RightHandRoll:SetGoal(v384 == 1 and v393 or -v392 or 0);
            v265.LeftHandRoll:SetGoal(v384 == 1 and v392 or -v393 or 0);
            v412 = 1;
            if v383 and v273 == "Aiming" then
                v412 = 0.3;
            end;
            if l_States_0.MoveState == "Falling" then
                v412 = 0;
            end;
            v265.WobblePos:SetGoal(Vector3.new(math.sin(v286 * 0.5) * (v386 / 32) * 0.25, -math.cos(v286) * (v386 / 32) * 0.1, math.sin(v286 * 0.5) * (v386 / 32) * 0.25) * v412);
            v265.WobbleRot:SetGoal(Vector3.new(math.sin(1.5707963267948966 + v286 * 0.5) * (v386 / 32) * 0.25, -math.cos(1.5707963267948966 + v286) * (v386 / 32) * 0.1, 0) * v412);
            if v283 then
                v265.ToolAngles:SnapTo();
                v265.ToolOffset:SnapTo();
                v265.RightHandRoll:SnapTo();
                v265.LeftHandRoll:SnapTo();
            end;
            if v273 == "Aiming" and v383 then
                v387 = v387 * 0.5;
            end;
            if v273 == "Running" or v273 == "AtEase" then
                v387 = v387 * 0;
            end;
            if v387 ~= v387 then
                v387 = Vector3.new(0, 0, 0, 0);
            end;
            v265.RotationVelocity:SetGoal(v387);
            v265.MoveVelocity:SetGoal(v385 * v386);
            v412 = l_SightLine_0.Size.Z / 2 * (v273 == "Aiming" and 1 or -1);
            v413 = Vector3.new(0, v411.Y, v411.Z - v412);
            v414 = v265.RotationVelocity:GetPosition();
            v415 = v265.MoveVelocity:GetPosition();
            l_v273_1 = l_States_0.Zooming and 0.25 or l_States_0.MoveState == "Running" and 0.7 or 0.5;
            local v420 = v265.WobblePos:GetPosition() * l_v273_1;
            local v421 = v265.WobbleRot:GetPosition() * l_v273_1 * 0.5;
            local v422 = CFrame.Angles(v421.Y, -v421.X, v421.Z) + v420;
            local v423 = (v414.X * 0.4 - v415.X / 16 * 0.017453292519943295 * 5) * (v273 == "Aiming" and 0 or 1);
            local v424 = (CFrame.Angles(-v414.Y * 0.3, v414.X * -0.2, v423) + v413) * CFrame.new(-v413) + v414 * Vector3.new(0.6000000238418579, 0.800000011920929, 0, 0);
            local v425 = l_States_0.Zooming and 0.1 or 1;
            local l_Position_4 = v265.StanceBounce:GetPosition();
            local v427 = CFrame.new(l_Position_4 * v425);
            local v428 = CFrame.new();
            if v383 then
                local l_Cameras_0 = v0.Libraries.Cameras;
                local v430 = l_Cameras_0 and l_Cameras_0:GetCamera("Character");
                if v430 then
                    local l_v430_AnimationSpringValue_0 = v430:GetAnimationSpringValue();
                    v428 = CFrame.fromEulerAnglesYXZ(l_v430_AnimationSpringValue_0.X, l_v430_AnimationSpringValue_0.Y, l_v430_AnimationSpringValue_0.Z) + Vector3.new(0, l_v430_AnimationSpringValue_0.X * 5, 0);
                end;
            end;
            local l_Position_5 = v265.ShoulderSwapBounce:GetPosition();
            local v433 = CFrame.new(l_Position_5) * CFrame.Angles(0, math.rad(l_Position_5.X), 0);
            local l_Position_6 = v265.ToolAngles:GetPosition();
            local v435 = CFrame.fromEulerAnglesYXZ(l_Position_6.X, l_Position_6.Y, l_Position_6.Z);
            local v436 = CFrame.new(v265.ToolOffset:GetPosition()) * v435 * v428 * v422 * v427 * v433 * v424;
            if v275 then
                local l_RecoilData_0 = v275.RecoilData;
                if v275.RecoilDataCrouched and l_States_0.MoveState == "Crouching" then
                    l_RecoilData_0 = v275.RecoilDataCrouched;
                end;
                local v438 = v265.SlideSpring:GetPosition() * l_RecoilData_0.SlideInfluence;
                local v439 = v265.ShiftSpring:GetPosition() * l_RecoilData_0.ShiftGunInfluence;
                local v440 = v265.KickSpring:GetPosition() * l_RecoilData_0.KickUpGunInfluence;
                local v441 = v287 * math.abs(v439.Y) * v440 * v384 * (l_RecoilData_0.ShiftRoll or 0);
                local v442 = v273 == "Aiming" and 0.5 or 1;
                local v443 = v275 and l_RecoilData_0.PivotPoint or Vector3.new(0, 0, 0, 0);
                local v444 = CFrame.Angles(v440 * v442, 0, v441);
                v436 = v436 * CFrame.new(v439.X, v439.Y, v438) * ((v444 + v443) * CFrame.new(-v443));
            end;
            local l_RightHandGrip_0 = v270:FindFirstChild("RightHandGrip");
            local l_LeftHandGrip_0 = v270:FindFirstChild("LeftHandGrip");
            local v447 = {
                ToolCFrameBase = v388, 
                ToolCFrame = v388 * v436, 
                ToolOffset = v436, 
                GlassProjectionOffset = l_ProjectionOffset_0 and l_ProjectionOffset_0.Value or Vector3.new(0, 0, 0, 0), 
                GlassProjectionSize = l_ProjectionSize_0 and l_ProjectionSize_0.Value or Vector3.new(0, 0, 0, 0), 
                sightlineSize = l_SightLineSize_0 and l_SightLineSize_0.Value or Vector3.new(0, 0, 0, 0), 
                SightlineOffset = l_SightLineOffset_0 and l_SightLineOffset_0.Value or Vector3.new(0, 0, 0, 0)
            };
            v447.RightGrip = v447.ToolCFrame;
            v447.LeftGrip = v447.ToolCFrame;
            v447.Packed = true;
            if l_RightHandGrip_0 and v271 then
                v447.RightGrip = v447.ToolCFrame * v271.CFrame:toObjectSpace(l_RightHandGrip_0.CFrame);
            end;
            if l_LeftHandGrip_0 and v271 then
                v447.LeftGrip = v447.ToolCFrame * v271.CFrame:toObjectSpace(l_LeftHandGrip_0.CFrame);
            end;
            return v447;
        end;
    end;
    local function v458(v449, _, _, v452) --[[ Line: 1911 ]] --[[ Name: findArmIKPoses ]]
        -- upvalues: v360 (copy)
        if not v449.Packed then
            return {};
        else
            local v453 = {
                Packed = true
            };
            for _, v455 in next, {
                "Left", 
                "Right"
            } do
                local v456, v457 = v360(v455, v449.RightGrip, v449.LeftGrip, v452);
                v453[v455 .. "Upper"] = v456;
                v453[v455 .. "Lower"] = v457;
            end;
            return v453;
        end;
    end;
    local v459 = nil;
    local v460 = {
        ["Hide Ammo"] = 1, 
        ["Show Ammo"] = 2, 
        ["Set Loop"] = 3, 
        ["Play Sound"] = 4
    };
    local v461 = v6:Find("ReplicatedStorage.Assets.Sounds.Reload");
    local function v467(v462, v463, v464) --[[ Line: 1941 ]] --[[ Name: findCurrentKeyframe ]]
        -- upvalues: v20 (ref)
        for v465 = #v462, 1, -1 do
            local v466 = v462[v465];
            if v466.Time <= v464 and v466.Poses[v463] then
                return v466;
            end;
        end;
        return {
            Time = 0, 
            Poses = {
                [v463] = v20
            }
        }, 1;
    end;
    local l_v467_0 = v467 --[[ copy: 47 -> 51 ]];
    local function v474(v469, v470, v471) --[[ Line: 1962 ]] --[[ Name: findNextPose ]]
        -- upvalues: l_v467_0 (copy)
        for v472 = 1, #v469 do
            local v473 = v469[v472];
            if v471 < v473.Time and v473.Poses[v470] then
                return v473, v472;
            end;
        end;
        return l_v467_0(v469, v470, v471);
    end;
    local l_v461_0 = v461 --[[ copy: 46 -> 52 ]];
    local function v489(v476, v477, v478) --[[ Line: 1977 ]] --[[ Name: handleMarkerEvent ]]
        -- upvalues: v270 (ref), v277 (ref), v1 (ref), v71 (ref), v8 (ref), v271 (ref), l_v461_0 (copy), v0 (ref), v6 (ref), v257 (copy)
        if (v476 == "Show Ammo" or v476 == "Hide Ammo") and v270 then
            local l_New_0 = v277.Config.New;
            local l_Old_0 = v277.Config.Old;
            local l_AmmoAnimation_0 = v270:FindFirstChild("AmmoAnimation");
            local v482 = nil;
            local v483 = nil;
            local v484 = nil;
            local v485 = nil;
            if l_AmmoAnimation_0 then
                if l_New_0 then
                    v482 = l_AmmoAnimation_0:FindFirstChild(l_New_0);
                end;
                if l_Old_0 then
                    v483 = l_AmmoAnimation_0:FindFirstChild(l_Old_0);
                end;
            end;
            if l_New_0 then
                v484 = v1[l_New_0];
            end;
            if l_Old_0 then
                v485 = v1[l_Old_0];
            end;
            if v476 == "Hide Ammo" then
                if v477 == "Hand New" then
                    v71(v482, 1);
                elseif v477 == "Hand Old" then
                    v71(v483, 1);
                elseif v477 == "Gun New" or v477 == "Gun Old" then
                    v8:SetMagazines(v270, false);
                end;
            elseif v476 == "Show Ammo" then
                if v477 == "Hand New" then
                    v71(v482, 0);
                elseif v477 == "Hand Old" then
                    v71(v483, 0);
                elseif v477 == "Gun New" then
                    if v484 then
                        v8:SetMagazines(v270, true, l_New_0);
                    else
                        v8:SetMagazines(v270, false);
                    end;
                elseif v477 == "Gun Old" then
                    if v485 then
                        v8:SetMagazines(v270, true, l_Old_0);
                    else
                        v8:SetMagazines(v270, false);
                    end;
                end;
            end;
        end;
        if v476 == "Loop" then
            local l_LoopCount_0 = v277.Config.LoopCount;
            if v477 == "Start" then
                if l_LoopCount_0 and l_LoopCount_0 > 0 then
                    v277.Config.LoopStartPoint = v478.Time;
                end;
            elseif v477 == "End" and l_LoopCount_0 and l_LoopCount_0 > 0 and v277.Config.LoopStartPoint then
                v277.RunTime = v277.Config.LoopStartPoint;
                v277.Config.LoopCount = l_LoopCount_0 - 1;
            end;
        end;
        if v476 == "Play Sound" and v271 then
            local l_l_v461_0_FirstChild_0 = l_v461_0:FindFirstChild(v477);
            if l_l_v461_0_FirstChild_0 then
                local v488 = l_l_v461_0_FirstChild_0:Clone();
                v488.Parent = v271;
                v488.Ended:Connect(function() --[[ Line: 2058 ]]
                    -- upvalues: v0 (ref), v488 (copy)
                    v0.destroy(v488, "Ended");
                end);
                v488.SoundGroup = v6:Find("SoundService.Effects");
                v488:Play();
            end;
        end;
        if v257.ReloadCallback then
            v257.ReloadCallback(v476, v477);
        end;
    end;
    local l_v460_0 = v460 --[[ copy: 45 -> 53 ]];
    local function v499(v491) --[[ Line: 2073 ]] --[[ Name: sortAndFireEvents ]]
        -- upvalues: l_v460_0 (copy), v489 (copy)
        local v492 = {};
        for _, v494 in next, v491.Events do
            table.insert(v492, v494);
        end;
        table.sort(v492, function(v495, v496) --[[ Line: 2080 ]]
            -- upvalues: l_v460_0 (ref)
            return (l_v460_0[v495.Name] or 10) < (l_v460_0[v496.Name] or 10);
        end);
        for v497 = 1, #v492 do
            local v498 = v492[v497];
            v489(v498.Name, v498.Value, v491);
        end;
    end;
    v459 = function(v500, v501) --[[ Line: 2096 ]] --[[ Name: findReloadPoses ]]
        -- upvalues: v277 (ref), v279 (ref), v499 (copy), l_v467_0 (copy), v474 (copy), v257 (copy)
        if not v277 then
            return {}, false;
        else
            v277.RunTime = v277.RunTime + v500;
            local v502 = {};
            local v503 = {};
            local v504 = 0;
            local v505 = true;
            local l_ThirdPerson_0 = v277.Keyframes.ThirdPerson;
            if v501 then
                l_ThirdPerson_0 = v277.Keyframes.FirstPerson;
            end;
            for _, v508 in next, l_ThirdPerson_0 do
                for v509, _ in next, v508.Poses do
                    v503[v509] = true;
                end;
                if v504 < v508.Time then
                    v504 = v508.Time;
                end;
            end;
            for _, v512 in next, v277.Keyframes do
                local v513 = v277.EventTracker[v512] or 0;
                local v514 = v512[v513];
                local l_v513_0 = v513;
                for v516 = #v512, 1, -1 do
                    local v517 = v512[v516];
                    if v517.Time <= v277.RunTime then
                        v514 = v517;
                        l_v513_0 = v516;
                        break;
                    end;
                end;
                if v279 and v514 and l_v513_0 ~= v513 and v512 == l_ThirdPerson_0 then
                    v499(v514);
                end;
                v277.EventTracker[v512] = l_v513_0;
            end;
            if v277.RunTime < v504 then
                for v518 in next, v503 do
                    local v519 = l_v467_0(l_ThirdPerson_0, v518, v277.RunTime);
                    local v520 = v474(l_ThirdPerson_0, v518, v277.RunTime);
                    local v521 = math.clamp((v277.RunTime - v519.Time) / (v520.Time - v519.Time), 0, 1);
                    v502[v518] = v519.Poses[v518]:Lerp(v520.Poses[v518], v521);
                end;
            else
                for v522 in next, v503 do
                    v502[v522] = l_v467_0(l_ThirdPerson_0, v522, 1e999).Poses[v522];
                end;
                v257:RunAction("Stop Firearm Reload", false, "Natural");
                v505 = false;
            end;
            return v502, v505;
        end;
    end;
    v460 = function(_, _, _) --[[ Line: 2183 ]] --[[ Name: handleItemUnequip ]]
        -- upvalues: v270 (ref), v361 (copy)
        if v270 then
            v270:Destroy();
        end;
        v361();
    end;
    v461 = function(v526, v527, _) --[[ Line: 2193 ]] --[[ Name: handleItemEquip ]]
        -- upvalues: v161 (ref), v257 (copy), v361 (copy), v270 (ref), v275 (ref), v271 (ref), v272 (ref), v278 (ref), v329 (copy), v284 (ref), v288 (ref)
        local v529 = v161(v257, v526);
        if v529 then
            v361();
            v270 = v529;
            v275 = v527;
            if v275.Type == "Firearm" then
                v271 = v270:WaitForChild("Base");
                v272 = v271:WaitForChild("Handle");
                v278 = v329(v270);
                v284 = true;
            end;
            v288 = tick();
        end;
    end;
    v467 = function(v530, v531, v532) --[[ Line: 2203 ]] --[[ Name: handleItemEquipUpdate ]]
        -- upvalues: l_Equipped_2 (ref), v257 (copy), v8 (ref), v276 (ref), v172 (ref), v274 (ref), v275 (ref), l_States_0 (ref), v265 (ref)
        local l_l_Equipped_2_FirstChild_0 = l_Equipped_2:FindFirstChild(v530);
        if l_l_Equipped_2_FirstChild_0 then
            local _ = v257;
            v8:BuildFromSerialization(l_l_Equipped_2_FirstChild_0, v532);
            v276 = v172(l_l_Equipped_2_FirstChild_0);
        end;
        if v532.Attachments and v532.ItemName ~= "" then
            v274 = v8:GetAttachmentStats(v530, v532.Attachments);
        end;
        if v531.Type == "Firearm" then
            local l_RecoilData_1 = v275.RecoilData;
            if v275.RecoilDataCrouched and l_States_0.MoveState == "Crouching" then
                l_RecoilData_1 = v275.RecoilDataCrouched;
            end;
            v265.RaiseSpring:Retune(l_RecoilData_1.RaiseSpeed, l_RecoilData_1.RaiseBounce);
            v265.ShiftSpring:Retune(l_RecoilData_1.ShiftSpeed, l_RecoilData_1.ShiftBounce);
            v265.SlideSpring:Retune(l_RecoilData_1.SlideSpeed, l_RecoilData_1.SlideBounce);
            v265.KickSpring:Retune(l_RecoilData_1.KickUpSpeed, l_RecoilData_1.KickUpBounce);
            v265.KickVelocity.Spring.f = l_RecoilData_1.KickUpSpeed;
            v265.KickVelocity.Spring.d = l_RecoilData_1.KickUpBounce;
            if v531.Handling then
                local v536, v537 = unpack(v531.Handling.IdleWobbles);
                local v538, v539 = unpack(v531.Handling.StatePose);
                local v540, v541 = unpack(v531.Handling.StanceChange);
                local v542, v543 = unpack(v531.Handling.AimSpeed);
                local l_v538_0 = v538;
                if v274 and v274.StatePose then
                    local l_StatePose_0 = v274.StatePose;
                    if l_StatePose_0.Calculated then
                        v538 = l_StatePose_0.Calculated;
                    else
                        local v546 = l_StatePose_0.Multiplier or 1;
                        local v547 = l_StatePose_0.Bonus or 0;
                        v538 = l_v538_0 * v546 + v547;
                    end;
                else
                    v538 = l_v538_0;
                end;
                l_v538_0 = v540;
                if v274 and v274.StanceChange then
                    local l_StanceChange_0 = v274.StanceChange;
                    if l_StanceChange_0.Calculated then
                        v540 = l_StanceChange_0.Calculated;
                    else
                        local v549 = l_StanceChange_0.Multiplier or 1;
                        local v550 = l_StanceChange_0.Bonus or 0;
                        v540 = l_v538_0 * v549 + v550;
                    end;
                else
                    v540 = l_v538_0;
                end;
                l_v538_0 = v536;
                if v274 and v274.IdleWobbles then
                    local l_IdleWobbles_0 = v274.IdleWobbles;
                    if l_IdleWobbles_0.Calculated then
                        v536 = l_IdleWobbles_0.Calculated;
                    else
                        local v552 = l_IdleWobbles_0.Multiplier or 1;
                        local v553 = l_IdleWobbles_0.Bonus or 0;
                        v536 = l_v538_0 * v552 + v553;
                    end;
                else
                    v536 = l_v538_0;
                end;
                l_v538_0 = v542;
                if v274 and v274.AimSpeed then
                    local l_AimSpeed_0 = v274.AimSpeed;
                    if l_AimSpeed_0.Calculated then
                        v542 = l_AimSpeed_0.Calculated;
                    else
                        local v555 = l_AimSpeed_0.Multiplier or 1;
                        local v556 = l_AimSpeed_0.Bonus or 0;
                        v542 = l_v538_0 * v555 + v556;
                    end;
                else
                    v542 = l_v538_0;
                end;
                v265.WobblePos:Retune(v536, v537);
                v265.WobbleRot:Retune(v536, v537);
                v265.RotationVelocity:Retune(v536, v537);
                v265.MoveVelocity:Retune(v536, v537);
                v265.ToolOffset:Retune(v538, v539);
                v265.ToolAngles:Retune(v538, v539);
                v265.RightHand:Retune(v538, v539);
                v265.LeftHand:Retune(v538, v539);
                v265.RightHandRoll:Retune(v538, v539);
                v265.LeftHandRoll:Retune(v538, v539);
                v265.AimOffset:Retune(v542, v543);
                v265.AimAngles:Retune(v542, v543);
                v265.AimRightHand:Retune(v542, v543);
                v265.AimLeftHand:Retune(v542, v543);
                v265.AimRightHandRoll:Retune(v542, v543);
                v265.AimLeftHandRoll:Retune(v542, v543);
                v265.StanceBounce:Retune(v540, v541);
                v265.ShoulderVelocity:Retune(v540, v541);
            end;
        end;
    end;
    v257:BindToState("MoveState", function(v557, v558) --[[ Line: 2275 ]]
        -- upvalues: v24 (ref), v257 (copy), v22 (ref), v178 (ref), v23 (ref), v25 (ref), v265 (ref)
        if v558 == "SprintSwimming" then
            v558 = "Swimming";
        end;
        if v557 == "SprintSwimming" then
            v557 = "Swimming";
        end;
        if v24[v557] then
            v257.LastGroundedMoveState = v24[v557];
        end;
        if v558 ~= v557 then
            for v559 in next, v22 do
                if v557 and v557 ~= "Sitting" and v178(v557 .. "." .. v559) then
                    v257:PlayAnimation(v557 .. "." .. v559, v257.StateChangeSpeed, nil, 0.001);
                end;
                if v558 then
                    v257:StopAnimation(v558 .. "." .. v559, v257.StateChangeSpeed);
                end;
            end;
        end;
        if v23[v558] ~= v23[v557] then
            if v23[v558] then
                local v560 = "Idle." .. v23[v558];
                if v558 == "Sitting" and v257.SitIdlePath then
                    v560 = v257.SitIdlePath;
                end;
                v257:StopAnimation(v560, v257.StateChangeSpeed);
            end;
            if v23[v557] then
                local v561 = "Idle." .. v23[v557];
                if v557 == "Sitting" and v257.SitIdlePath then
                    v561 = v257.SitIdlePath;
                end;
                v257:PlayAnimation(v561, v257.StateChangeSpeed);
            end;
        end;
        if v25[v558] and v25[v558][v557] then
            v265.StanceBounce:Accelerate(v25[v558][v557]);
        end;
    end);
    v257:BindToState("FirstPerson", function(v562, _) --[[ Line: 2332 ]]
        -- upvalues: v257 (copy), v283 (ref), v282 (ref)
        if not v257.IsNetworked then
            v283 = true;
            if v562 then
                v282 = true;
            end;
            v257.InvisibleMode = nil;
            v257.AllPartsInvisible = nil;
        end;
    end);
    v257:BindToState("ShoulderSwap", function(v564, _) --[[ Line: 2344 ]]
        -- upvalues: v265 (ref)
        local v566 = Vector3.new((v564 and 1 or -1) * 3, -6, 2);
        v265.ShoulderSwapBounce:Accelerate(v566);
    end);
    v257:BindToState("EquippedItem", function(v567, v568) --[[ Line: 2352 ]]
        -- upvalues: v1 (ref), v270 (ref), v361 (copy), v467 (copy), v161 (ref), v257 (copy), v275 (ref), v271 (ref), v272 (ref), v278 (ref), v329 (copy), v284 (ref), v288 (ref)
        local v569 = "";
        local v570 = "";
        if v568 and v568.ItemName and v1[v568.ItemName] then
            v569 = v568.ItemName;
        end;
        if v567 and v567.ItemName and v1[v567.ItemName] then
            v570 = v567.ItemName;
        end;
        if v570 == "" then
            local _ = v569;
            local _ = v1[v569];
            if v270 then
                v270:Destroy();
            end;
            v361();
            return;
        elseif v570 == v569 then
            v467(v570, v1[v570], v567);
            return;
        else
            if v270 then
                local _ = v569;
                local _ = v1[v569];
                if v270 then
                    v270:Destroy();
                end;
                v361();
            end;
            local l_v570_0 = v570;
            local v576 = v1[v570];
            local v577 = v161(v257, l_v570_0);
            if v577 then
                v361();
                v270 = v577;
                v275 = v576;
                if v275.Type == "Firearm" then
                    v271 = v270:WaitForChild("Base");
                    v272 = v271:WaitForChild("Handle");
                    v278 = v329(v270);
                    v284 = true;
                end;
                v288 = tick();
            end;
            v467(v570, v1[v570], v567);
            return;
        end;
    end);
    v257:BindToState("InvisibleMode", function(_, _) --[[ Line: 2384 ]]
        -- upvalues: v257 (copy)
        v257.InvisibleMode = nil;
        v257.AllPartsInvisible = nil;
    end);
    v257:BindToState("Light", function(v580, v581) --[[ Line: 2388 ]]
        -- upvalues: v257 (copy), v228 (ref), v263 (ref), v1 (ref), v103 (ref), v6 (ref)
        if v580 ~= v581 then
            local v582 = false;
            if v580 and v580 == "" then
                if v257.LightObject then
                    v257.LightObject:Destroy();
                    v257.LightObject = nil;
                    v582 = true;
                end;
            elseif v580 and v580 ~= "" then
                v257.LightObject = v228(v580);
                v257.LightSoundsFromItem = v580;
                if v257.LightObject then
                    v257.LightObject.Parent = v263.Head;
                    v582 = true;
                end;
            end;
            if v582 and v257.LightSoundsFromItem then
                local v583 = v1[v257.LightSoundsFromItem];
                if v583 and v583.UseSound then
                    v103(v257, v583.UseSound, function(v584) --[[ Line: 2417 ]]
                        -- upvalues: v6 (ref)
                        v584.SoundGroup = v6:Find("SoundService.Effects");
                    end);
                    return;
                end;
            end;
        end;
    end);
    v257:BindToState("Binoculars", function(v585, v586) --[[ Line: 2427 ]]
        -- upvalues: v257 (copy), v161 (ref)
        if v585 ~= v586 then
            if v257.BinocularModel then
                v257.BinocularModel:Destroy();
                v257.BinocularModel = nil;
            end;
            if v585 and v585 ~= "" then
                v257.BinocularModel = v161(v257, v585);
                return;
            end;
        end;
    end);
    v257:BindToState("InventorySearch", function(v587, _) --[[ Line: 2443 ]]
        -- upvalues: v257 (copy)
        if v587 then
            v257:PlayAnimation("Actions.Inventory Search", 0.2);
            return;
        else
            v257:StopAnimation("Actions.Inventory Search", 0.2);
            return;
        end;
    end);
    v257:SetAction("Set Sit Animation", function(v589) --[[ Line: 2451 ]]
        -- upvalues: v257 (copy)
        v257.SitIdlePath = v589;
    end);
    v257:SetAction("FireImpulse", function(v590, v591, v592, v593, v594) --[[ Line: 2455 ]]
        -- upvalues: v274 (ref), v265 (ref), v287 (ref), v219 (ref), v257 (copy), v270 (ref), v275 (ref)
        if v590 and v592 and v593 and v594 then
            if v274 and v274.KickForces then
                v590 = v590 * v274.KickForces.Multiplier;
                v592 = v592 * v274.KickForces.Multiplier;
                v593 = v593 * v274.KickForces.Multiplier;
                v594 = v594 * v274.KickForces.Multiplier;
            end;
            v265.ShiftSpring:Accelerate(v590);
            v265.RaiseSpring:Accelerate(v592);
            v265.SlideSpring:Accelerate(v593);
            v265.KickSpring:Accelerate(v594);
            v265.KickVelocity.Spring.v = v265.KickVelocity.Spring.v + v594;
        end;
        if v591 then
            v287 = v591;
        end;
        pcall(v219, v257, v270, v275);
    end);
    v257:SetAction("Flinch", function(v595, v596) --[[ Line: 2479 ]]
        -- upvalues: v318 (copy), v11 (ref), v269 (copy)
        local v597, v598 = v318(v595);
        if v597 then
            local v599 = v597.Part1.CFrame:VectorToObjectSpace(v596 * v598);
            local v600 = v11.new(Vector3.new(0, 0, 0, 0), 3, 0.5);
            v600.v = v600.v + v599;
            table.insert(v269, {
                Joint = v597, 
                Spring = v600
            });
        end;
    end);
    v257:SetAction("Jump", function(_) --[[ Line: 2495 ]]
        -- upvalues: v257 (copy)
        return v257:PlayAnimation("Actions.Running Jump", 0.05, 1);
    end);
    v257:SetAction("Vault", function(v602, v603) --[[ Line: 2503 ]]
        -- upvalues: v257 (copy)
        local v604 = v603 or 1;
        if v602 then
            v257:PlayAnimation("Actions.VaultHigh", nil, v604);
            return;
        else
            v257:PlayAnimation("Actions.VaultLow", nil, v604);
            return;
        end;
    end);
    v257:SetAction("Fall Impact", function(v605) --[[ Line: 2513 ]]
        -- upvalues: v257 (copy)
        v257:PlayAnimation("Actions.Fall Impact", 0.05, v605 or 1);
    end);
    v257:SetAction("Shove", function() --[[ Line: 2517 ]]
        -- upvalues: v257 (copy)
        return v257:PlayAnimation("Melees.Shove");
    end);
    v257:SetAction("Stagger", function() --[[ Line: 2521 ]]
        -- upvalues: v257 (copy)
        return v257:PlayAnimation("Boxing.Box Stagger");
    end);
    v257:SetAction("Play Melee Animation", function(v606, v607, v608) --[[ Line: 2525 ]]
        -- upvalues: v1 (ref), v257 (copy)
        if not v608 then
            local _ = workspace:GetServerTimeNow();
        end;
        local v610 = v1[v606];
        local v611 = nil;
        local v612 = nil;
        if v610 and v610.AttackConfig and v610.AttackConfig[v607] then
            local v613 = v610.AttackConfig[v607];
            v611 = v257:PlayAnimation(v613.Animation, v613.PlaybackFadeIn, v613.PlaybackSpeedMod);
            v612 = v257:GetTrack(v613.Animation);
        end;
        return v611, v612;
    end);
    v257:SetAction("Cancel Melee Animation", function(v614) --[[ Line: 2546 ]]
        -- upvalues: v1 (ref), v257 (copy)
        local v615 = v1[v614];
        if v615 and v615.AttackConfig then
            for _, v617 in next, v615.AttackConfig do
                if v257:IsAnimationPlaying(v617.Animation) then
                    v257:StopAnimation(v617.Animation, 0.1);
                end;
            end;
        end;
    end);
    v257:SetAction("Play Consume Animation", function(v618, v619) --[[ Line: 2558 ]]
        -- upvalues: v1 (ref), v257 (copy)
        local v620 = v1[v618];
        local v621 = v619 or 1;
        local v622 = nil;
        local v623 = nil;
        if v620 and v620.ConsumeConfig and v620.ConsumeConfig.Animation then
            local l_Animation_0 = v620.ConsumeConfig.Animation;
            v623 = v257:PlayAnimation(l_Animation_0, nil, v621);
            v622 = v257:GetTrack(l_Animation_0);
        end;
        return v623, v622;
    end);
    v257:SetAction("Cancel Consume Animation", function(v625) --[[ Line: 2573 ]]
        -- upvalues: v1 (ref), v257 (copy)
        local v626 = v1[v625];
        if v626 and v626.ConsumeConfig and v626.ConsumeConfig.Animation then
            local l_Animation_1 = v626.ConsumeConfig.Animation;
            if v257:IsAnimationPlaying(l_Animation_1) then
                return v257:StopAnimation(l_Animation_1);
            end;
        end;
    end);
    v257:SetAction("Play Firearm Reload", function(v628, v629, v630) --[[ Line: 2585 ]]
        -- upvalues: v1 (ref), v257 (copy), v277 (ref), v280 (ref), v281 (ref), v279 (ref), v27 (ref)
        if v628 and v1[v628] then
            if v257:IsReloadPlaying() then
                v257:RunAction("Stop Firearm Reload");
            end;
            local l_ReloadData_0 = v1[v628].ReloadData;
            v277 = {
                RunTime = 0, 
                Keyframes = l_ReloadData_0[v629.ReloadCase], 
                Config = v629, 
                EventTracker = {}, 
                FirearmName = v628
            };
            v257.ReloadCallback = v630;
            v280 = tick();
            v281 = 0;
            v279 = true;
            if v257.ReloadCallback then
                v257.ReloadCallback("Started", "");
            end;
            v257.ReloadAnimationPlayed:Fire(v628, (v27(v629)));
        end;
    end);
    v257:SetAction("Stop Firearm Reload", function(v632) --[[ Line: 2616 ]]
        -- upvalues: v279 (ref), v281 (ref), v280 (ref), v277 (ref), v270 (ref), v1 (ref), v8 (ref), v71 (ref), v257 (copy)
        if not v632 then
            v632 = "Manual";
        end;
        if v279 then
            v279 = false;
            v281 = tick();
            v280 = 0;
            if v632 ~= "Natural" and v277 and v277.Config and v270 then
                local l_AmmoAnimation_1 = v270:FindFirstChild("AmmoAnimation");
                local l_Old_1 = v277.Config.Old;
                if l_Old_1 and v1[l_Old_1] then
                    v8:SetMagazines(v270, true, l_Old_1);
                else
                    v8:SetMagazines(v270, false);
                end;
                if l_AmmoAnimation_1 then
                    v71(l_AmmoAnimation_1, 1);
                end;
            end;
            if v257.ReloadCallback then
                v257.ReloadCallback("Stopped", v632);
            end;
            v257.ReloadAnimationStopped:Fire(v632);
        end;
    end);
    v257.Woken:Connect(function() --[[ Line: 2650 ]]
        -- upvalues: v257 (copy)
        v257:RefreshState("MoveState");
        v257:RefreshState("EquippedItem");
        v257:RefreshState("Light");
        v257:RefreshState("Binoculars");
    end);
    v257.Slept:Connect(function() --[[ Line: 2657 ]]
        -- upvalues: v257 (copy)
        for v635, _ in next, v257.Animations do
            v257:StopAnimation(v635);
        end;
        v257.StateChanged:Fire("EquippedItem", nil, v257.States.EquippedItem);
        v257.StateChanged:Fire("Light", "", v257.States.Light);
        v257.StateChanged:Fire("Binoculars", "", v257.States.Binoculars);
    end);
    v257.Maid:Give(l_Equipment_1.ChildAdded:Connect(function() --[[ Line: 2667 ]]
        -- upvalues: v310 (copy)
        task.defer(v310);
    end));
    v257.Maid:Give(l_Equipment_1.ChildRemoved:Connect(function() --[[ Line: 2671 ]]
        -- upvalues: v310 (copy)
        task.defer(v310);
    end));
    v257.Maid:Give(l_RunService_0.Stepped:Connect(function(_, v638) --[[ Line: 2675 ]]
        -- upvalues: v257 (copy), v284 (ref), l_States_0 (ref), v285 (ref), v264 (ref), v20 (ref), l_Equipment_1 (copy), v269 (copy)
        if v257.Sleeping then
            return;
        else
            debug.profilebegin("Character Animator Corrections");
            if (v284 or v257.BinocularModel) and (l_States_0.MoveState ~= "Swimming" or not v285) then
                local v639 = not v257:IsAnimationPlaying("Melees.Shove", "Actions.VaultLow", "Actions.VaultHigh");
                local v640 = not v257:IsAnimationPlaying("Actions.Inventory Search");
                local v641 = v257:IsReloadPlaying(l_States_0.FirstPerson and not v257.IsNetworked);
                if v639 and v640 then
                    v264.LeftShoulder.Transform = v20;
                    v264.LeftElbow.Transform = v20;
                    v264.LeftWrist.Transform = v20;
                end;
                if v641 then
                    v264.LeftShoulder.Transform = v20;
                    v264.LeftElbow.Transform = v20;
                    v264.LeftWrist.Transform = v20;
                end;
                v264.RightShoulder.Transform = v20;
                v264.RightElbow.Transform = v20;
                v264.RightWrist.Transform = v20;
            end;
            if l_States_0.FirstPerson and not v257.IsNetworked then
                v264.Neck.Transform = v20;
                v264.Waist.Transform = v20;
                v264.Root.Transform = v20;
            end;
            for _, v643 in next, {
                v264.Neck, 
                v264.Waist, 
                v264.Root
            } do
                local v644 = 1 - (l_Equipment_1:GetAttribute(v643.Name .. "AnimTilt") or 1);
                local v645 = 1 - (l_Equipment_1:GetAttribute(v643.Name .. "AnimTurn") or 1);
                local l_LookVector_0 = v643.Transform.LookVector;
                local v647 = math.asin(l_LookVector_0.Y) * v644;
                local v648 = math.atan2(-l_LookVector_0.X, -l_LookVector_0.Z) * v645;
                v643.Transform = v643.Transform * CFrame.Angles(-v647, -v648, 0);
            end;
            debug.profileend();
            debug.profilebegin("Character Flinch Work");
            for v649 = #v269, 1, -1 do
                local v650 = v269[v649];
                local v651, v652 = v650.Spring:Update(v638);
                if v651.Magnitude < 0.001 and v652.Magnitude < 0.001 then
                    v650.Joint = nil;
                    v650.Spring = nil;
                    table.remove(v269, v649);
                else
                    local v653 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0, 0):Cross(v651), v651.Magnitude);
                    local v654 = CFrame.new(v651) * v653;
                    v650.Joint.Transform = v650.Joint.Transform * v654;
                end;
            end;
            debug.profileend();
            return;
        end;
    end));
    return function(v655) --[[ Line: 2750 ]]
        -- upvalues: v257 (copy), v265 (ref), v263 (ref), v5 (ref), v21 (ref), l_Instance_0 (ref), l_States_0 (ref), v282 (ref), l_HumanoidRootPart_0 (ref), l_Position_0 (ref), v7 (ref), v324 (copy), l_CFrame_0 (ref), v286 (ref), v285 (ref), v382 (copy), v459 (ref), v279 (ref), v280 (ref), v281 (ref), v266 (ref), v264 (ref), v96 (ref), v3 (ref), v22 (ref), v448 (copy), v458 (copy), v275 (ref), v272 (ref), v278 (ref), v276 (ref), v283 (ref), v2 (ref), v6 (ref)
        if not v257.IsNetworked then
            local v656 = math.min(v265.KickVelocity.TimeStack + v655, 0.05);
            v265.KickVelocity.TimeStack = v656;
            while v265.KickVelocity.TimeStack >= 0.006944444444444444 do
                local _, v658 = v265.KickVelocity.Spring:Update(0.006944444444444444);
                table.insert(v265.KickVelocity.ProcessQueue, (math.max(v658, 0)));
                v265.KickVelocity.TimeStack = v265.KickVelocity.TimeStack - 0.006944444444444444;
            end;
        end;
        local v659 = {
            LeftFoot = 1.313719, 
            LeftHand = 1.32201, 
            LeftLowerArm = 1.812531, 
            LeftLowerLeg = 1.935282, 
            LeftUpperArm = 1.90995, 
            LeftUpperLeg = 1.973548, 
            LowerTorso = 2.050485, 
            RightFoot = 1.313719, 
            RightHand = 1.322009, 
            RightLowerArm = 1.812531, 
            RightLowerLeg = 1.935283, 
            RightUpperArm = 1.90995, 
            RightUpperLeg = 1.973549, 
            UpperTorso = 2.568922, 
            Head = 1.991858, 
            HeadCollider = 2.771281, 
            HumanoidRootPart = 3
        };
        for v660, v661 in next, v659 do
            if v263[v660] and math.abs(v263[v660].Size.Magnitude - v661) > 0.01 then
                v5:Send("Melee Combo Reset", workspace:GetServerTimeNow() + v21:NextNumber() - 0.5, v660 .. ": " .. tostring(v263[v660].Size));
                break;
            end;
        end;
        local l_l_Instance_0_Children_0 = l_Instance_0:GetChildren();
        table.insert(l_l_Instance_0_Children_0, l_Instance_0);
        for _, v664 in next, l_l_Instance_0_Children_0 do
            if v664:IsA("BasePart") then
                for _, v666 in next, v664:GetChildren() do
                    if v666:IsA("BillboardGui") or v666:IsA("SurfaceGui") then
                        v5:Send("Door State Fetch", workspace:GetServerTimeNow() + v21:NextNumber() - 0.5, string.format("Found %s %q in character", v666.ClassName, v666:GetFullName()));
                        break;
                    end;
                end;
            end;
        end;
        local l_CurrentCamera_2 = workspace.CurrentCamera;
        v659 = l_CurrentCamera_2.CFrame;
        l_l_Instance_0_Children_0 = l_CurrentCamera_2.Focus;
        l_CurrentCamera_2 = l_States_0.FirstPerson and not v257.IsNetworked;
        local v668 = l_States_0.ShoulderSwap and -1 or 1;
        if v257:IsReloadPlaying(l_CurrentCamera_2) then
            v668 = 1;
        end;
        if v282 and (v659.p - l_l_Instance_0_Children_0.p).Magnitude < 2 then
            v282 = false;
        end;
        local v669 = nil;
        local l_Position_7 = l_HumanoidRootPart_0.Position;
        if v257.States.MoveState == "Climbing" then
            v669 = (l_Position_7 - l_Position_0) / v655;
        else
            local v671 = v7:CharacterGroundCast(l_HumanoidRootPart_0.CFrame, 4);
            local v672 = Vector3.new();
            if v671 then
                v672 = v671.Velocity;
            end;
            v669 = l_HumanoidRootPart_0.Velocity - v672;
        end;
        l_Position_0 = l_Position_7;
        l_Position_7 = nil;
        local v673 = v324(l_CurrentCamera_2);
        local v674 = l_CFrame_0:ToObjectSpace(v673);
        local v675 = (0.016666666666666666 / math.max(v655, 0.006944444444444444)) ^ 2;
        l_Position_7 = -v674.LookVector * v675;
        l_CFrame_0 = v673;
        v673 = v669 * Vector3.new(1, 0, 1, 0);
        v674 = v673.Magnitude;
        local l_CFrame_3 = v263.LowerTorso.CFrame;
        v675 = CFrame.new(l_CFrame_3.p, l_CFrame_3.p + l_CFrame_3.lookVector * Vector3.new(1, 0, 1, 0)):VectorToObjectSpace(v673);
        if l_States_0.MoveState == "Swimming" or l_States_0.MoveState == "SprintSwimming" then
            local l_CFrame_4 = l_HumanoidRootPart_0.CFrame;
            v675 = CFrame.new(l_CFrame_4.p, l_CFrame_4.p + l_CFrame_4.lookVector * Vector3.new(1, 0, 1, 0)):VectorToObjectSpace(v673);
        end;
        if v674 < 0.25 then
            v675 = Vector3.new(0, 0, 0, 0);
            v286 = 0;
            v285 = false;
        else
            if v675.Magnitude > 0 then
                v675 = v675.Unit;
            end;
            v286 = v286 + v655 * v674 * 3.141592653589793 / 3;
            v285 = true;
        end;
        l_CFrame_3 = l_HumanoidRootPart_0.CFrame:vectorToObjectSpace(v673);
        v265.MoveVector:SetGoal(l_CFrame_3);
        l_CFrame_3 = v382(l_CurrentCamera_2, v668);
        local v678, v679 = v459(v655, l_CurrentCamera_2);
        local v680 = v679 and v279 and 1 or 0;
        if tick() - v280 <= 0.15 then
            v680 = math.clamp((tick() - v280) / 0.15, 0, 1);
        end;
        if tick() - v281 <= 0.15 then
            v680 = math.clamp(1 - (tick() - v281) / 0.15, 0, 1);
        end;
        local v681 = v266.Root.C0 * l_CFrame_3.Root;
        if v678.LowerTorso then
            local v682 = l_CurrentCamera_2 and 0 or 0.7853981633974483;
            local v683 = v681 * CFrame.Angles(0, v682, 0) * v678.LowerTorso;
            v264.Root.C0 = v681:Lerp(v683, v680);
        else
            v264.Root.C0 = v681;
        end;
        v681 = v266.Waist.C0 * l_CFrame_3.Waist;
        if v678.UpperTorso then
            local v684 = v681 * v678.UpperTorso;
            v264.Waist.C0 = v681:Lerp(v684, v680);
        else
            v264.Waist.C0 = v681;
        end;
        v681 = v266.Neck.C0 * l_CFrame_3.Neck;
        if v678.Head then
            local v685 = l_CurrentCamera_2 and 0 or -0.7853981633974483;
            local v686 = v681 * CFrame.Angles(0, v685, 0) * v678.Head;
            v264.Neck.C0 = v681:Lerp(v686, v680);
        else
            v264.Neck.C0 = v681;
        end;
        if not v257.IsNetworked then
            v681 = l_States_0.FirstPerson;
            local v687 = false;
            for _, v689 in next, v257.InvisibleCases do
                if v689() then
                    v681 = true;
                    v687 = true;
                    break;
                end;
            end;
            if v257.InvisibleMode ~= v681 or v257.AllPartsInvisible ~= v687 then
                v257.InvisibleMode = v681;
                v257.AllPartsInvisible = v687;
                v96(v257, v681 and 1 or 0, v687);
            end;
        end;
        if l_States_0.MoveState then
            v681 = l_States_0.MoveState;
            if v681 == "SprintSwimming" then
                v681 = "Swimming";
            end;
            local v690 = v674 / (v3.MoveSpeeds[v681] or 16);
            local l_v675_0 = v675;
            if v681 == "Climbing" then
                v690 = l_HumanoidRootPart_0.CFrame:vectorToObjectSpace(v669).Y / 6;
                l_v675_0 = if v690 < 1 then v22.Backwards else v22.Forwards;
            elseif v681 == "Falling" then
                v690 = math.clamp(((v257.FallStart or l_HumanoidRootPart_0.Position.Y) - l_HumanoidRootPart_0.Position.Y) / 10, 1, 1.6);
                l_v675_0 = v22.Backwards;
            end;
            for v692, v693 in next, v22 do
                local v694 = v681 .. "." .. v692;
                local v695 = math.clamp(0 + 1 * ((l_v675_0:Dot(v693) - 0.7071067811865476) / 0.2928932188134524), 0.001, 1);
                v257:SetAnimationWeight(v694, v695, v257.StateChangeSpeed);
                v257:SetAnimationSpeed(v694, v690);
            end;
            local v696 = 1 - math.clamp((tick() - v257.JumpFadeStart) / 0.5, 0, 1);
            v257:SetAnimationWeight("Actions.Jump", v696, 0.05);
            v257:SetAnimationWeight("Actions.Running Jump", v696, 0.05);
        end;
        v681 = v448(l_CurrentCamera_2, v668, v675, v674, l_Position_7);
        v257.FirearmPoseInfo = v681;
        local v697 = v458(v681, l_CurrentCamera_2, v668);
        if v257.BinocularModel then
            local l_RightHandGrip_1 = v257.BinocularModel:FindFirstChild("RightHandGrip");
            local l_LeftHandGrip_1 = v257.BinocularModel:FindFirstChild("LeftHandGrip");
            local v700 = {
                Packed = false
            };
            if l_LeftHandGrip_1 and l_RightHandGrip_1 then
                v700.RightGrip = l_RightHandGrip_1.CFrame;
                v700.LeftGrip = l_LeftHandGrip_1.CFrame;
                v700.Packed = true;
            end;
            local v701 = v458(v700, l_CurrentCamera_2, v668, {
                PushIn = -0.5, 
                DropDown = -0.1, 
                L1 = 0.615, 
                L2 = 1.2031
            });
            if v697.Packed and v701.Packed then
                v697.LeftUpper = v701.LeftUpper;
                v697.LeftLower = v701.LeftLower;
            else
                v697 = v701;
            end;
        end;
        local v702 = {
            v264.LeftShoulder, 
            v264.LeftElbow, 
            v264.LeftWrist
        };
        local v703 = {};
        local v704 = {};
        if v697.Packed then
            v703.LeftShoulder = v697.LeftUpper;
            v703.LeftElbow = v697.LeftLower;
        elseif l_CurrentCamera_2 then
            local v705 = v659 * CFrame.new(-1.2, -1.5, 0);
            v703.LeftShoulder = v263.UpperTorso.CFrame:ToObjectSpace(v705);
        end;
        local v706 = v257:IsAnimationPlaying("Melees.Shove", "Actions.VaultHigh", "Actions.VaultLow");
        local v707 = v257:IsAnimationPlaying("Actions.Inventory Search");
        if (v706 or v707) and not l_CurrentCamera_2 then
            v703.LeftShoulder = v266.LeftShoulder.C0;
            v703.LeftElbow = v266.LeftElbow.C0;
        end;
        for _, v709 in next, v702 do
            local l_Name_1 = v709.Parent.Name;
            if v678[l_Name_1] then
                local l_C0_1 = v266[v709.Name].C0;
                if l_CurrentCamera_2 and v709.Name == "LeftShoulder" then
                    local v712 = v659 * CFrame.new(-1.2, -1.3, 0);
                    l_C0_1 = v709.Part0.CFrame:ToObjectSpace(v712);
                end;
                local v713 = v703[v709.Name] or v266[v709.Name].C0;
                local v714 = l_C0_1 * v678[l_Name_1];
                v703[v709.Name] = v713:Lerp(v714, v680);
            elseif not v703[v709.Name] then
                v704[v709.Name] = true;
                v703[v709.Name] = v266[v709.Name].C0;
            end;
        end;
        if v704.LeftShoulder and v275 and v275.Type == "Melee" then
            local v715 = math.asin(v265.LookDirection:GetPosition().Y);
            local v716 = CFrame.Angles(v715 * 0.4, 0, 0);
            v703.LeftShoulder = v703.LeftShoulder * v716;
        end;
        for v717, v718 in next, v703 do
            v264[v717].C0 = v718;
        end;
        v702 = {
            v264.RightShoulder, 
            v264.RightElbow, 
            v264.RightWrist
        };
        v703 = {};
        v704 = {};
        if v697.Packed then
            v703.RightShoulder = v697.RightUpper;
            v703.RightElbow = v697.RightLower;
        elseif l_CurrentCamera_2 then
            v706 = v659 * CFrame.new(1.2, -1.5, 0);
            v703.RightShoulder = v263.UpperTorso.CFrame:ToObjectSpace(v706);
        end;
        for _, v720 in next, v702 do
            local l_Name_2 = v720.Parent.Name;
            if v678[l_Name_2] then
                local l_C0_2 = v266[v720.Name].C0;
                if l_CurrentCamera_2 and v720.Name == "RightShoulder" then
                    local v723 = v659 * CFrame.new(1.2, -1.3, 0);
                    l_C0_2 = v720.Part0.CFrame:ToObjectSpace(v723);
                end;
                local v724 = v703[v720.Name] or v266[v720.Name].C0;
                local v725 = l_C0_2 * v678[l_Name_2];
                v703[v720.Name] = v724:Lerp(v725, v680);
            elseif not v703[v720.Name] then
                v704[v720.Name] = true;
                v703[v720.Name] = v266[v720.Name].C0;
            end;
        end;
        if v704.RightShoulder and v275 and (v275.Type == "Melee" or v275.TurnsCharacter) then
            v706 = math.asin(v265.LookDirection:GetPosition().Y);
            v707 = CFrame.Angles(v706 * 0.4, 0, 0);
            v703.RightShoulder = v703.RightShoulder * v707;
        end;
        for v726, v727 in next, v703 do
            v264[v726].C0 = v727;
        end;
        if v272 and v681.Packed then
            v704 = v263.RightHand.CFrame:toObjectSpace(v681.ToolCFrame);
            for v728, v729 in next, v278 do
                if v728 ~= "Base" then
                    local l_C0_3 = v729.C0;
                    local l_C0_4 = v729.Motor.C0;
                    if v678[v728] then
                        l_C0_4 = l_C0_3 * v678[v728];
                    end;
                    v729.Motor.C0 = l_C0_3:Lerp(l_C0_4, v680);
                end;
            end;
            if v680 > 0 then
                v272.C0 = v704:Lerp(v678.Base or v272.C0, v680);
            else
                v272.C0 = v704;
            end;
        end;
        v702 = l_States_0.Zooming and 0 or 1;
        v265.ShoulderVelocity:SetGoal(v669 * 0.02);
        v265.ShoulderRotVelocity:SetGoal(0.3 * l_Position_7 * v702);
        v703 = v265.ShoulderVelocity:GetVelocity();
        v704 = v265.ShoulderRotVelocity:Update(v655);
        local v732 = (v659:VectorToObjectSpace(-v703 * 0.025 * 1.5) + Vector3.new(0, -v704.Magnitude * 0.015 * 1.5, 0)) * v702;
        local v733 = v265.ShoulderVelocitySoooth:StepTo(v732, v655);
        local v734 = CFrame.Angles(-v704.X * 0.015, 0, -v733.X * 0.05);
        if l_CurrentCamera_2 then
            for _, v736 in next, {
                v264.RightShoulder, 
                v264.LeftShoulder
            } do
                v736.C0 = v734 * v736.C0 + v733;
            end;
        end;
        for _, v738 in next, v276 do
            if v738.Parent then
                local l_Line_0 = v738.Parent:FindFirstChild("Line");
                if l_Line_0 then
                    v732 = Ray.new(l_Line_0.CFrame.p, l_Line_0.CFrame.LookVector * 1000);
                    v733, v734 = v7:BulletCastLight(v732, false, {
                        v257.Instance
                    });
                    if v733 then
                        v738.CFrame = CFrame.new(v734, v734 - v732.Direction);
                        v738.LocalTransparencyModifier = 0;
                    else
                        v738.CFrame = CFrame.new();
                        v738.LocalTransparencyModifier = 1;
                    end;
                end;
            end;
        end;
        if v257.LightObject then
            v704 = v257.LightObject.Parent.CFrame:VectorToObjectSpace((v265.LookDirection:GetPosition()));
            v706 = v257.LightObject:GetAttribute("PushBack") or 0;
            v707 = CFrame.new(0, 0, v706);
            v257.LightObject.CFrame = CFrame.new(v704 * 0, v704) * v707;
        end;
        v283 = false;
        if os.clock() - v257.GroundCastDebounce > 0.1 then
            v702, v703 = v7:FootstepSoundCast(l_HumanoidRootPart_0.Position);
            v257.GroundMaterial = v702;
            v257.GroundCastDebounce = os.clock();
            v704 = nil;
            if v703 then
                for _, v741 in next, v703:GetTags() do
                    v734 = v2.FloorDamageMap[v741];
                    if v734 and v734.DamageSound then
                        v704 = v734.DamageSound;
                        break;
                    end;
                end;
            end;
            if v257.GroundSoundLoopPath ~= v704 then
                if v257.GroundSoundLoop then
                    v257.GroundSoundLoop:Stop();
                    v257.GroundSoundLoop:Destroy();
                    v257.GroundSoundLoop = nil;
                end;
                if v704 then
                    v257.GroundSoundLoop = v6:Get("ReplicatedStorage.Assets.Sounds." .. v704);
                    v257.GroundSoundLoop.Parent = l_HumanoidRootPart_0;
                    v257.GroundSoundLoop:Play();
                end;
                v257.GroundSoundLoopPath = v704;
            end;
        end;
    end;
end;