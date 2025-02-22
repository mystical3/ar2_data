local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "ItemData");
local v2 = v0.require("Configs", "Globals");
local v3 = v0.require("Configs", "PerkTuning");
local v4 = v0.require("Libraries", "Network");
local v5 = v0.require("Libraries", "Resources");
local v6 = v0.require("Libraries", "Raycasting");
local v7 = v0.require("Libraries", "Garbage");
local v8 = v0.require("Libraries", "Geometry");
local v9 = v0.require("Libraries", "UserSettings");
local v10 = v0.require("Libraries", "World");
local v11 = v0.require("Classes", "SoundMixer");
local v12 = v0.require("Classes", "Animators");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v16 = v5:Find("Workspace.Effects");
local v17 = v5:Find("Workspace.Sounds");
local _ = game:GetService("CollectionService");
local v19 = v5:Find("ReplicatedStorage.Assets.Particles");
local v20 = v5:Find("ReplicatedStorage.Assets.Sounds.Shooting");
local v21 = v5:Find("Workspace.Characters");
local v22 = v5:Find("Workspace.Zombies");
local v23 = {
    DamageMarkersEnabled = true
};
local v24 = {};
local v25 = v11.new();
local v26 = 0;
local l_ScreenGui_0 = Instance.new("ScreenGui");
l_ScreenGui_0.Parent = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
l_ScreenGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Global;
l_ScreenGui_0.DisplayOrder = 0;
local v28 = 0;
local v29 = nil;
local v30 = nil;
local v31 = Random.new();
local l_Part_0 = Instance.new("Part");
l_Part_0.CFrame = CFrame.new();
l_Part_0.Anchored = true;
l_Part_0.CanCollide = false;
l_Part_0.Transparency = 1;
l_Part_0.Parent = v16;
local v33 = {
    RightHand = true, 
    RightLowerArm = true, 
    RightUpperArm = true, 
    LeftHand = true, 
    LeftLowerArm = true, 
    LeftUpperArm = true, 
    RightFoot = true, 
    RightLowerLeg = true, 
    RightUpperLeg = true, 
    LeftFoot = true, 
    LeftLowerLeg = true, 
    LeftUpperLeg = true
};
local v34 = {
    ["100%"] = 1, 
    ["150%"] = 1.5, 
    ["200%"] = 2, 
    ["250%"] = 2.5, 
    ["300%"] = 3
};
local l_Children_0 = v5:Find("ReplicatedStorage.Assets.Sounds.Bullet Whiz.Whiz"):GetChildren();
local v36 = 0;
for _, v38 in next, l_Children_0 do
    v36 = math.max(v38.RollOffMaxDistance, v36);
end;
v29 = v36;
l_Children_0 = v5:Find("ReplicatedStorage.Assets.Sounds.Bullet Whiz.Pop"):GetChildren();
v36 = 0;
for _, v40 in next, l_Children_0 do
    v36 = math.max(v40.RollOffMaxDistance, v36);
end;
v30 = v36;
l_Children_0 = function(v41, v42, v43) --[[ Line: 123 ]] --[[ Name: lerp ]]
    return v41 + (v42 - v41) * v43;
end;
v36 = function(v44, v45, v46, v47, v48) --[[ Line: 127 ]] --[[ Name: remapClamped ]]
    return v47 + (v48 - v47) * math.clamp((v44 - v45) / (v46 - v45), 0, 1);
end;
local function _(v49) --[[ Line: 131 ]] --[[ Name: pickRandom ]]
    -- upvalues: v31 (copy)
    return v49[v31:NextInteger(1, #v49)];
end;
local function _() --[[ Line: 135 ]] --[[ Name: getShotId ]]
    -- upvalues: v28 (ref)
    v28 = (v28 + 1) % 69420;
    return v28;
end;
local function _(v52) --[[ Line: 141 ]] --[[ Name: isNetworkableHit ]]
    -- upvalues: v6 (copy), v10 (copy)
    if v6:IsHitCharacter(v52) then
        return true, "Character";
    elseif v6:IsHitZombie(v52) then
        return true, "Zombie";
    elseif v6:IsHitVehicle(v52) then
        return true, "Vehicle";
    elseif v10:GetInteractable(v52) then
        return true, "Interactable";
    else
        return false, "World";
    end;
end;
local function _(v54) --[[ Line: 161 ]] --[[ Name: isHitLocalCharacter ]]
    -- upvalues: l_Players_0 (copy)
    if not v54 then
        return false;
    else
        local l_Character_0 = l_Players_0.LocalPlayer.Character;
        if l_Character_0 and v54:IsDescendantOf(l_Character_0) then
            return true;
        else
            return false;
        end;
    end;
end;
local function v61(v57, v58) --[[ Line: 176 ]] --[[ Name: tryStackingDamage ]]
    -- upvalues: v24 (copy)
    if typeof(v58) ~= "number" then
        return false;
    else
        for _, v60 in next, v24 do
            if v60.Key == v57 then
                v60.Damage = v60.Damage + v58;
                v60.DespawnTimer = 0;
                if v60.Gui then
                    v60.Gui.Text = tostring((math.floor(v60.Damage)));
                end;
                return true;
            end;
        end;
        return false;
    end;
end;
local function v76(v62, v63, v64, v65) --[[ Line: 197 ]] --[[ Name: newDamageDisplay ]]
    -- upvalues: v31 (copy), v19 (copy), v0 (copy), v24 (copy), v26 (ref), v9 (copy), v34 (copy), l_ScreenGui_0 (copy)
    local v66 = math.sign(v31:NextNumber() - 0.5);
    local v67 = v31:NextNumber(-0.4, 0.4);
    local l_Unit_0 = Vector2.new(v66, v67).Unit;
    local v69 = l_Unit_0 * v31:NextInteger(50, 80);
    local v70 = l_Unit_0 * v31:NextInteger(5, 15);
    local v71 = nil;
    if typeof(v64) == "number" then
        v71 = v19.DamageNumber:Clone();
        v71.Text = tostring((math.floor(v64)));
        v71.TextColor3 = v65;
    else
        local l_Icon_0 = v0.Libraries.Interface:Get("Vehicle"):GetIcon(v64);
        if l_Icon_0 then
            v71 = v19.DamageIcon:Clone();
            v71.Image = l_Icon_0;
            v71.ImageColor3 = v65;
        elseif tostring(v64) then
            v71 = v19.DamageNumber:Clone();
            v71.Text = tostring(v64);
            v71.TextColor3 = Color3.new(1, 1, 1);
        end;
    end;
    if v71 then
        table.insert(v24, {
            RunTime = 0, 
            DespawnTimer = 0, 
            TimeScale = v31:NextNumber(0.8, 1.2), 
            Damage = v64, 
            Key = v62, 
            Position = v63, 
            Gui = v71, 
            Origin = v70, 
            Target = v69
        });
        v26 = v26 + 2;
        local l_Shadow_0 = v71:FindFirstChild("Shadow");
        local l_v26_0 = v26;
        if v26 > 10000 then
            v26 = 0;
        end;
        if l_Shadow_0 then
            l_Shadow_0.ZIndex = l_v26_0 - 1;
        end;
        local v75 = v34[v9:GetSetting("User Interface", "Indicator Size")] or 1;
        if v75 ~= 1 then
            Instance.new("UIScale", v71).Scale = v75;
        end;
        v71.ZIndex = l_v26_0;
        v71.Position = UDim2.new(-1, 0, -1, 0);
        v71.Parent = l_ScreenGui_0;
    end;
end;
local function v88(v77) --[[ Line: 272 ]] --[[ Name: manageDamageNumbers ]]
    -- upvalues: v24 (copy), l_TweenService_0 (copy)
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    for v79 = #v24, 1, -1 do
        local v80 = v24[v79];
        local v81 = v77 * v80.TimeScale;
        v80.RunTime = v80.RunTime + v81;
        v80.DespawnTimer = v80.DespawnTimer + v81;
        if v80.DespawnTimer > 1 then
            v80.Gui:destroy();
            v80.Gui = nil;
            table.remove(v24, v79);
        else
            local v82, v83 = l_CurrentCamera_0:WorldToScreenPoint(v80.Position);
            if v83 then
                local v84 = math.clamp(v80.RunTime / 0.3, 0, 1);
                local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v84, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                local v86 = v80.Origin + (v80.Target - v80.Origin) * l_l_TweenService_0_Value_0;
                local v87 = UDim2.fromOffset(v82.X + v86.X, v82.Y + v86.Y);
                v80.Gui.Position = v87;
                v80.Gui.Visible = true;
            else
                v80.Gui.Visible = false;
            end;
        end;
    end;
end;
local function v94(v89, v90, v91) --[[ Line: 306 ]] --[[ Name: getSpreadVector ]]
    local v92 = v89:NextNumber(0, v91);
    local v93 = v89:NextNumber(-3.141592653589793, 3.141592653589793);
    return (CFrame.new(v90 * 0, v90) * (CFrame.Angles(0, 0, v93) * CFrame.Angles(v92, 0, 0))).LookVector;
end;
local function v107(v95, v96, v97) --[[ Line: 316 ]] --[[ Name: getSpredAngle ]]
    -- upvalues: v3 (copy)
    local l_RecoilData_0 = v97.RecoilData;
    if v97.RecoilDataCrouched and v95.MoveState == "Crouching" then
        l_RecoilData_0 = v97.RecoilDataCrouched;
    end;
    local v99 = l_RecoilData_0.SpreadBase or 0;
    local v100 = 1;
    local v101 = 0;
    local v102 = 1;
    local v103 = 0;
    local v104 = false;
    if v97.AttachmentStatMods then
        local l_HipSpread_0 = v97.AttachmentStatMods.HipSpread;
        local l_AimingSpread_0 = v97.AttachmentStatMods.AimingSpread;
        if l_HipSpread_0 then
            v100 = l_HipSpread_0.Multiplier or v100;
            v101 = l_HipSpread_0.Bonus or v101;
        end;
        if l_AimingSpread_0 then
            v102 = l_AimingSpread_0.Multiplier or v102;
            v103 = l_AimingSpread_0.Bonus or v103;
        end;
    end;
    if v96.FirstPerson then
        if v95.Zooming then
            v99 = v99 + (l_RecoilData_0.SpreadAddFPSZoom or 0);
            v104 = true;
        else
            v99 = v99 + (l_RecoilData_0.SpreadAddFPSHip or 0);
            v104 = false;
        end;
    elseif v95.Zooming then
        v99 = v99 + (l_RecoilData_0.SpreadAddTPSZoom or 0);
        v104 = true;
    else
        v99 = v99 + (l_RecoilData_0.SpreadAddTPSHip or 0);
        v104 = false;
    end;
    if v95.MoveState == "Falling" then
        v99 = v99 + 3;
    end;
    if v95:HasPerk("Gun Cleaning Kit") then
        v99 = v99 * v3("Gun Cleaning Kit", "AccuracyModifier");
    end;
    if v104 then
        return (math.rad(v99 * v102 + v103));
    else
        return (math.rad(v99 * v100 + v101));
    end;
end;
local function v127(v108, v109, v110) --[[ Line: 389 ]] --[[ Name: getFireImpulse ]]
    -- upvalues: v31 (copy)
    local v111 = Vector2.new(math.sign(v31:NextNumber() - 0.5), (math.sign(v31:NextNumber() - 0.5)));
    local v112 = 1;
    local v113 = 1;
    local v114 = 1;
    local v115 = 1;
    local v116 = 1;
    local v117 = 1;
    local l_RecoilData_1 = v109.RecoilData;
    if v109.RecoilDataCrouched and v108.States.MoveState == "Crouching" then
        l_RecoilData_1 = v109.RecoilDataCrouched;
    end;
    if v110 and v109.FireConfig and v109.FireConfig.BurstWeights then
        v116 = v109.FireConfig.BurstWeights[v110] or v116;
    end;
    if v109.FireConfig and v109.FireConfig.RecoilModifier then
        v117 = v109.FireConfig.RecoilModifier;
    end;
    if v111.Magnitude > 0 then
        v111 = v111.unit;
    end;
    local v119 = Vector2.new(unpack(l_RecoilData_1.ShiftShape)) * v111;
    local l_Velocity_0 = v108.Springs.ShiftSpring:GetVelocity();
    local v121 = l_RecoilData_1.RollLeftBias or -1;
    local v122 = l_RecoilData_1.RollRightBias or 1;
    if v122 < v121 then
        local l_v122_0 = v122;
        v122 = v121;
        v121 = l_v122_0;
    end;
    if l_Velocity_0.magnitude > 0 then
        local l_unit_0 = l_Velocity_0.unit;
        local v125 = l_unit_0 + (v119 - l_unit_0) * 0.7;
        if v125.Magnitude > 0 then
            v125 = v125.unit;
        end;
        v119 = v125;
    end;
    if v109.Attachments and v109.Attachments.Underbarrel then
        local l_Underbarrel_0 = v109.Attachments.Underbarrel;
        if l_Underbarrel_0.StatModifiers then
            v112 = v112 * l_Underbarrel_0.StatModifiers.Kick.Force;
            v113 = v113 * l_Underbarrel_0.StatModifiers.Raise.Force;
            v114 = v114 * l_Underbarrel_0.StatModifiers.Shift.Force;
            v115 = v115 * l_Underbarrel_0.StatModifiers.Slide.Force;
        end;
    end;
    return v119 * l_RecoilData_1.ShiftForce * v114 * v116 * v117, -v31:NextNumber(v121, v122) * v116 * v117, l_RecoilData_1.RaiseForce * v113 * v116 * v117, l_RecoilData_1.SlideForce * v115 * v116 * v117, l_RecoilData_1.KickUpForce * v112 * v116 * v117;
end;
local function v157(v128, v129, v130, v131, _, v133, v134) --[[ Line: 453 ]] --[[ Name: impactEffects ]]
    -- upvalues: v6 (copy), v9 (copy), v33 (copy), v5 (copy), v31 (copy), l_Part_0 (copy), v17 (copy), v12 (copy), v7 (copy), v19 (copy), v16 (copy)
    debug.profilebegin("bullet impact");
    local v135 = v6:IsHitCharacter(v129);
    local v136 = v6:IsHitZombie(v129);
    local v137 = v9:GetSetting("Game Quality", "Impact Particles") == "On";
    local v138 = CFrame.fromMatrix(v130, Vector3.new(0, 1, 0, 0):Cross(v131), v131);
    local l_Magnitude_0 = (v130 - workspace.CurrentCamera.CFrame.Position).Magnitude;
    if v135 or v136 then
        local v140 = "Bodyshot";
        if v129.Name == "Head" then
            v140 = "Headshot";
        elseif v33[v129.Name] then
            v140 = "Limbshot";
        end;
        local v141 = v5:Get("ReplicatedStorage.Assets.Sounds.Impact." .. v140);
        v141.SoundGroup = v5:Find("SoundService.Effects");
        v141.PlaybackSpeed = v141.PlaybackSpeed + v31:NextNumber(-0.1, 0.1);
        v141.MaxDistance = 20;
        local v142 = nil;
        if not v134 then
            v142 = Instance.new("Attachment");
            v142.CFrame = CFrame.new(v130);
            v142.Parent = l_Part_0;
            v141.Parent = v142;
        else
            v141.Parent = v17;
            if v136 then
                local v143 = v12.find(v136);
                if v143 then
                    v143:RunAction("Flinch", v129.Name, v133 * 5);
                end;
            end;
            if v135 then
                local v144 = v12.find(v135);
                if v144 then
                    local v145 = v133 * 4;
                    if v128.FireConfig.PelletCount > 1 then
                        v145 = v145 / v128.FireConfig.PelletCount;
                    end;
                    v144:RunAction("Flinch", v129.Name, v145);
                end;
            end;
        end;
        if not v134 then
            v141:Play();
        else
            task.delay(0.05, function() --[[ Line: 515 ]]
                -- upvalues: v141 (copy)
                v141:Play();
            end);
        end;
        if v137 then

        end;
        v7:Add(2, v141, v142);
    else
        local l_v6_ImpactMaterial_0 = v6:GetImpactMaterial(v129);
        if v137 then
            local v147 = (v19.Impact:FindFirstChild(l_v6_ImpactMaterial_0) or v19.Impact.Dirt):Clone();
            v147.CFrame = v138;
            v147.Parent = l_Part_0;
            for _, v149 in next, v147:GetDescendants() do
                if v149:IsA("ParticleEmitter") then
                    v149:Emit(v149:GetAttribute("EmitCount") or 0);
                end;
            end;
            v7:Add(5, v147);
        end;
        if v137 and not v129:HasTag("Bullet Impact Dot Ignore") then
            local v150 = CFrame.new(v130, v130 + v131);
            local v151 = v19.BulletHole:Clone();
            v151.Transparency = NumberSequence.new(0.75);
            v151.Parent = v16;
            v151.Attachment0 = Instance.new("Attachment");
            v151.Attachment0.Parent = v129;
            v151.Attachment0.WorldCFrame = v150 * CFrame.new(-0.05, 0, -0.01);
            v151.Attachment1 = Instance.new("Attachment");
            v151.Attachment1.Parent = v129;
            v151.Attachment1.WorldCFrame = v150 * CFrame.new(0.05, 0, -0.01);
            local l_v151_0 = v151 --[[ copy: 15 -> 21 ]];
            task.delay(10, function() --[[ Line: 573 ]]
                -- upvalues: l_v151_0 (copy)
                if l_v151_0.Attachment0 then
                    l_v151_0.Attachment0:Destroy();
                end;
                if l_v151_0.Attachment1 then
                    l_v151_0.Attachment1:Destroy();
                end;
                l_v151_0:Destroy();
            end);
        end;
        local v153 = "ReplicatedStorage.Assets.Sounds.Bullet Impact." .. (l_v6_ImpactMaterial_0 or "Generic");
        local l_Children_1 = v5:Find(v153):GetChildren();
        local v155 = l_Children_1[v31:NextInteger(1, #l_Children_1)];
        if l_Magnitude_0 < v155.RollOffMaxDistance then
            l_Children_1 = Instance.new("Attachment");
            l_Children_1.CFrame = CFrame.new(v130);
            l_Children_1.Parent = l_Part_0;
            local v156 = v155:Clone();
            v156.SoundGroup = v5:Find("SoundService.Effects");
            v156.PlaybackSpeed = v156.PlaybackSpeed + v31:NextNumber(-0.05, 0.05);
            v156.Parent = l_Children_1;
            v156:Play();
            v7:Add(2, v156, l_Children_1);
        end;
    end;
    debug.profileend();
end;
local function v173(v158, v159, v160, v161) --[[ Line: 610 ]] --[[ Name: flintchCamera ]]
    -- upvalues: v0 (copy), l_Players_0 (copy), v2 (copy)
    local l_Camera_0 = v0.Libraries.Cameras:GetCamera("Character");
    if l_Camera_0 then
        local l_CFrame_0 = l_Camera_0.Instance.CFrame;
        local v164 = v159:PointToObjectSpace(l_CFrame_0.Position);
        local v165;
        if not v161 then
            v165 = false;
        else
            local l_Character_1 = l_Players_0.LocalPlayer.Character;
            v165 = l_Character_1 and v161:IsDescendantOf(l_Character_1) and true or false;
        end;
        local v167 = math.acos((Vector3.new(0, 0, -1, 0):Dot(v164.unit)));
        local v168 = math.atan(v2.FlinchMaxDistance / 30);
        local v169 = 1 + -1 * math.clamp((v167 - v168) / (1 - v168), 0, 1);
        local l_Magnitude_1 = (v160 - l_CFrame_0.Position).Magnitude;
        local l_FlinchMaxDistance_0 = v2.FlinchMaxDistance;
        local v172 = 1 + -1 * math.clamp((l_Magnitude_1 - 0) / (l_FlinchMaxDistance_0 - 0), 0, 1);
        l_FlinchMaxDistance_0 = v158.FireConfig.FlinchForce or v158.FireConfig.Damage * v158.HitModifiers.Head;
        l_Camera_0:Flinch(v160, v169 * v172 * l_FlinchMaxDistance_0, v165);
    end;
end;
local function v180(v174, v175, _) --[[ Line: 636 ]] --[[ Name: playWhizSound ]]
    -- upvalues: v29 (ref), v5 (copy), l_Part_0 (copy), v31 (copy)
    if v29 < v175 then
        return;
    else
        local l_Children_2 = v5:Find("ReplicatedStorage.Assets.Sounds.Bullet Whiz.Whiz"):GetChildren();
        local v178 = Instance.new("Attachment", l_Part_0);
        v178.CFrame = CFrame.new(v174);
        local v179 = l_Children_2[v31:NextInteger(1, #l_Children_2)]:Clone();
        v179.SoundGroup = v5:Find("SoundService.Effects");
        v179.PlaybackSpeed = v179.PlaybackSpeed + v31:NextNumber(-0.05, 0.05);
        v179.Parent = v178;
        v179.Ended:Connect(function() --[[ Line: 652 ]]
            -- upvalues: v178 (copy), v179 (copy)
            v178:Destroy();
            v179:Destroy();
        end);
        v179:Play();
        return;
    end;
end;
local function v191(_, v182, v183, _) --[[ Line: 660 ]] --[[ Name: playCrackSound ]]
    -- upvalues: v30 (ref), v5 (copy), l_Part_0 (copy), v31 (copy)
    if v30 < v182 then
        return;
    else
        local v185 = "ReplicatedStorage.Assets.Sounds.Bullet Whiz." .. "Pop";
        local l_Children_3 = v5:Find(v185):GetChildren();
        local l_Position_0 = workspace.CurrentCamera.CFrame.Position;
        local v188 = l_Position_0 + (v183.Position - l_Position_0).Unit * v182;
        local v189 = Instance.new("Attachment", l_Part_0);
        v189.CFrame = CFrame.new(v188);
        local v190 = l_Children_3[v31:NextInteger(1, #l_Children_3)]:Clone();
        v190.PlaybackSpeed = v190.PlaybackSpeed + v31:NextNumber(-0.05, 0.05);
        v190.SoundGroup = v5:Find("SoundService.Effects");
        v190.Parent = v189;
        v190.Ended:Connect(function() --[[ Line: 681 ]]
            -- upvalues: v189 (copy), v190 (copy)
            v189:Destroy();
            v190:Destroy();
        end);
        v190:Play();
        return;
    end;
end;
local function v206(v192, v193, v194, v195, v196) --[[ Line: 689 ]] --[[ Name: handleBulletPassBy ]]
    -- upvalues: v8 (copy), v180 (copy), v173 (copy), v191 (copy)
    local l_HasWhizzed_0 = v192.HasWhizzed;
    local l_HasCracked_0 = v192.HasCracked;
    if l_HasWhizzed_0 and l_HasCracked_0 then
        return;
    else
        local v199 = Ray.new(v195.Origin + v195.Direction, v195.Direction);
        local l_CFrame_1 = workspace.CurrentCamera.CFrame;
        local l_Position_1 = l_CFrame_1.Position;
        local v202 = false;
        if l_CFrame_1:PointToObjectSpace(v195.Origin + v195.Direction * 0.5).Z > 0 then
            v202 = true;
        end;
        local v203 = v8.getClampedClosestPointToRay(v195, l_Position_1);
        local l_magnitude_0 = (l_Position_1 - v203).magnitude;
        local l_magnitude_1 = (l_Position_1 - v8.getClampedClosestPointToRay(v199, l_Position_1)).magnitude;
        if v196 then
            l_magnitude_1 = 1e999;
        end;
        if l_magnitude_0 < l_magnitude_1 then
            if not v192.HasWhizzed then
                v180(v203, l_magnitude_0, v194);
                v173(v193, v194, v203, v196);
                v192.HasWhizzed = true;
            end;
            if not v192.HasCracked and v193.AmmoIsSuperSonic then
                v191(v203, l_magnitude_0, v194, v202);
                v192.HasCracked = true;
            end;
        end;
        return;
    end;
end;
local function v228(v207, v208, v209, v210) --[[ Line: 738 ]] --[[ Name: playShootSound ]]
    -- upvalues: v1 (copy), v5 (copy), l_Part_0 (copy), v16 (copy), v20 (copy), v31 (copy), v7 (copy)
    local v211 = v1[v207];
    local l_FireSound_0 = v211.FireSound;
    if v209 and v211.SuppressedFireSound then
        l_FireSound_0 = v211.SuppressedFireSound;
    end;
    if v211.ReChamberActionSound then
        local v213 = v5:Find("ReplicatedStorage.Assets.Sounds." .. v211.ReChamberActionSound);
        local l_Magnitude_2 = (workspace.CurrentCamera.CFrame.Position - v208).Magnitude;
        if v213 and l_Magnitude_2 < v213.RollOffMaxDistance then
            local v215 = nil;
            if not v210 then
                v215 = Instance.new("Attachment");
                v215.CFrame = CFrame.new(v208);
                v215.Parent = l_Part_0;
            end;
            local v216 = v213:Clone();
            v216.Parent = v215 or v16;
            v216.SoundGroup = v5:Find("SoundService.Effects");
            local l_v216_0 = v216 --[[ copy: 9 -> 16 ]];
            do
                local l_v215_0 = v215;
                v216.Ended:Connect(function() --[[ Line: 764 ]]
                    -- upvalues: l_v216_0 (copy), l_v215_0 (ref)
                    l_v216_0:Destroy();
                    if l_v215_0 then
                        l_v215_0:Destroy();
                    end;
                end);
                task.delay(v211.ReChamberActionSoundDelay or 0, function() --[[ Line: 772 ]]
                    -- upvalues: l_v216_0 (copy)
                    l_v216_0:Play();
                end);
            end;
        end;
    end;
    local l_v20_FirstChild_0 = v20:FindFirstChild(l_FireSound_0);
    if not l_v20_FirstChild_0 then
        warn("Couldn't load firearm sound:", l_FireSound_0, "for gun:", v207);
        return;
    else
        local l_magnitude_2 = (workspace.CurrentCamera.CFrame.p - v208).magnitude;
        local v221 = l_magnitude_2 / 1800;
        local v222 = nil;
        if l_v20_FirstChild_0.RollOffMaxDistance < l_magnitude_2 then
            return;
        else
            if not v210 then

            end;
            local v223 = l_v20_FirstChild_0:Clone();
            v223.PlaybackSpeed = v223.PlaybackSpeed + v31:NextNumber(-0.01, 0.01);
            v223.SoundGroup = v5:Find("SoundService.Effects");
            local l_RollOffMinDistance_0 = v223.RollOffMinDistance;
            local l_v223_Attribute_0 = v223:GetAttribute("FullDistanceEffectAt");
            if not v210 then
                local v226 = Instance.new("EqualizerSoundEffect", v223);
                v226.HighGain = 0 + (v223:GetAttribute("DistanceHighGain") - 0) * math.clamp((l_magnitude_2 - l_RollOffMinDistance_0) / (l_v223_Attribute_0 - l_RollOffMinDistance_0), 0, 1);
                v226.MidGain = 0 + (v223:GetAttribute("DistanceMidGain") - 0) * math.clamp((l_magnitude_2 - l_RollOffMinDistance_0) / (l_v223_Attribute_0 - l_RollOffMinDistance_0), 0, 1);
                v226.LowGain = 0 + (v223:GetAttribute("DistanceLowGain") - 0) * math.clamp((l_magnitude_2 - l_RollOffMinDistance_0) / (l_v223_Attribute_0 - l_RollOffMinDistance_0), 0, 1);
                v226.Priority = 1;
                local v227 = Instance.new("ReverbSoundEffect", v223);
                v227.WetLevel = -65 + 55 * math.clamp((l_magnitude_2 - l_RollOffMinDistance_0) / (l_v223_Attribute_0 - l_RollOffMinDistance_0), 0, 1);
                v227.DryLevel = 0 + -3 * math.clamp((l_magnitude_2 - l_RollOffMinDistance_0) / (l_v223_Attribute_0 - l_RollOffMinDistance_0), 0, 1);
                v227.DecayTime = 4;
                v227.Density = 1;
                v227.Diffusion = 1;
                v227.Priority = 2;
            end;
            if v210 then
                v223.Parent = v16;
                v221 = 0;
            else
                v222 = Instance.new("Attachment");
                v222.CFrame = CFrame.new(v208);
                v222.Parent = l_Part_0;
                v223.Parent = v222;
            end;
            v223.Ended:Connect(function() --[[ Line: 836 ]]
                -- upvalues: v7 (ref), v223 (copy), v222 (ref)
                v7:Add(4, v223, v222);
            end);
            if v221 > 0 then
                task.delay(v221, function() --[[ Line: 841 ]]
                    -- upvalues: v223 (copy)
                    v223:Play();
                end);
            else
                v223:Play();
            end;
            return;
        end;
    end;
end;
local function v234(v229, v230) --[[ Line: 850 ]] --[[ Name: getTracer ]]
    -- upvalues: v19 (copy), v16 (copy), l_Part_0 (copy)
    local v231 = v19.BulletTracer:Clone();
    v231.Segments = 1;
    v231.Parent = v16;
    v231.Attachment0 = Instance.new("Attachment");
    v231.Attachment0.CFrame = CFrame.new(v229);
    v231.Attachment0.Parent = l_Part_0;
    v231.Attachment1 = Instance.new("Attachment");
    v231.Attachment1.CFrame = CFrame.new(v229);
    v231.Attachment1.Parent = l_Part_0;
    local v232 = v19.BulletGlow:Clone();
    v232.Segments = 1;
    v232.Parent = v16;
    v232.Attachment0 = Instance.new("Attachment");
    v232.Attachment0.CFrame = CFrame.new(v229);
    v232.Attachment0.Parent = l_Part_0;
    v232.Attachment1 = Instance.new("Attachment");
    v232.Attachment1.CFrame = CFrame.new(v229);
    v232.Attachment1.Parent = l_Part_0;
    local v233 = {
        Tail = v231, 
        Ball = v232
    };
    if v230 and v230.TracerConfig then
        v233.MaxLength = v230.TracerConfig.MaxLength;
        v233.Transparency = v230.TracerConfig.Transparency;
        v233.Tail.Color = ColorSequence.new(v230.TracerConfig.TailColor);
        v233.Tail.Texture = v230.TracerConfig.TailTexture;
        v233.Tail.Width0 = v230.TracerConfig.TailSize;
        v233.Tail.Width1 = v230.TracerConfig.TailSize;
        v233.Ball.Color = ColorSequence.new(v230.TracerConfig.FrontColor);
        v233.Ball.Texture = v230.TracerConfig.FrontTexture;
        v233.Ball.Width0 = v230.TracerConfig.FrontSize;
        v233.Ball.Width1 = v230.TracerConfig.FrontSize;
        return v233;
    else
        v233.MaxLength = 10000;
        v233.Transparency = 0;
        return v233;
    end;
end;
local function v246(v235, v236, v237, v238) --[[ Line: 901 ]] --[[ Name: updateTracer ]]
    debug.profilebegin("tracer update");
    local v239 = v237 - v236;
    if v239.Magnitude > v235.MaxLength then
        v237 = v236 - v239.Unit * v235.MaxLength;
    end;
    local l_CFrame_2 = workspace.CurrentCamera.CFrame;
    local _ = l_CFrame_2.LookVector;
    local _ = l_CFrame_2.Position;
    local l_UpVector_0 = l_CFrame_2.UpVector;
    local v244 = 1 + (v235.Transparency - 1) * math.clamp((v238 - 0) / 10, 0, 1);
    local v245 = l_UpVector_0 * v235.Ball.Width0 * 0.5;
    v235.Tail.Attachment0.Position = v236;
    v235.Tail.Attachment1.Position = v237;
    v235.Tail.Transparency = NumberSequence.new(1, v244);
    v235.Tail.Enabled = true;
    v235.Ball.Transparency = NumberSequence.new(v244);
    v235.Ball.Attachment0.Position = v237 + v245;
    v235.Ball.Attachment1.Position = v237 - v245;
    v235.Ball.Enabled = true;
    debug.profileend();
end;
local function v248(v247) --[[ Line: 943 ]] --[[ Name: destroyTracer ]]
    v247.Tail.Attachment0:Destroy();
    v247.Tail.Attachment1:Destroy();
    v247.Tail:Destroy();
    v247.Tail = nil;
    v247.Ball.Attachment1:Destroy();
    v247.Ball.Attachment0:Destroy();
    v247.Ball:Destroy();
    v247.Ball = nil;
end;
local function v258(v249, _, v251) --[[ Line: 955 ]] --[[ Name: playRicochetSound ]]
    -- upvalues: v5 (copy), v31 (copy), l_Part_0 (copy)
    local l_Magnitude_3 = (v249 - workspace.CurrentCamera.CFrame.Position).Magnitude;
    local v253 = "Bullet Ricochet.Fast";
    if v251 and v251.RicochetConfig and v251.RicochetConfig.RicochetSoundGroup then
        v253 = v251.RicochetConfig.RicochetSoundGroup;
    end;
    local v254 = "ReplicatedStorage.Assets.Sounds." .. v253;
    local l_Children_4 = v5:Find(v254):GetChildren();
    local v256 = l_Children_4[v31:NextInteger(1, #l_Children_4)];
    if l_Magnitude_3 < v256.RollOffMaxDistance then
        l_Children_4 = Instance.new("Attachment", l_Part_0);
        l_Children_4.CFrame = CFrame.new(v249);
        local v257 = v256:Clone();
        v257.SoundGroup = v5:Find("SoundService.Effects");
        v257.PlaybackSpeed = v257.PlaybackSpeed + v31:NextNumber(-0.05, 0.05);
        v257.Parent = l_Children_4;
        v257.Ended:Connect(function() --[[ Line: 976 ]]
            -- upvalues: l_Children_4 (copy), v257 (copy)
            l_Children_4:Destroy();
            v257:Destroy();
        end);
        v257:Play();
    end;
end;
local function v259(v260, v261, v262, v263, v264, v265, v266, v267) --[[ Line: 985 ]] --[[ Name: tryRicochet ]]
    -- upvalues: v1 (copy), v248 (copy), v6 (copy), v10 (copy), v2 (copy), v31 (copy), v258 (copy), v157 (copy), v94 (copy), v234 (copy), v16 (copy), v17 (copy), v21 (copy), v22 (copy), l_RunService_0 (copy), v246 (copy), v259 (copy)
    if not v1[v260] then
        if v265 then
            v248(v265);
        end;
        return;
    else
        local v268 = v1[v260];
        local v269;
        if v6:IsHitCharacter(v262) then
            local _ = true;
            v269 = "Character";
        elseif v6:IsHitZombie(v262) then
            local _ = true;
            v269 = "Zombie";
        elseif v6:IsHitVehicle(v262) then
            local _ = true;
            v269 = "Vehicle";
        elseif v10:GetInteractable(v262) then
            local _ = true;
            v269 = "Interactable";
        else
            local _ = false;
            v269 = "World";
        end;
        if v269 ~= "World" then
            if v265 then
                v248(v265);
            end;
            return;
        elseif v262 and v262:HasTag("World Water Part") then
            if v265 then
                v248(v265);
            end;
            return;
        elseif v268 and v268.RicochetConfig and not v268.RicochetConfig.CanRicochet then
            if v265 then
                v248(v265);
            end;
            return;
        else
            local v275 = v268.FireConfig.MuzzleVelocity * v2.MuzzleVelocityMod;
            local v276 = 0.3490658503988659;
            local v277 = 1000;
            local v278 = v266 or v275;
            local v279 = v275 * 0.1;
            local v280 = false;
            local v281 = false;
            local v282 = true;
            local v283 = true;
            if v268.RicochetConfig then
                v278 = v278 * v31:NextNumber(unpack(v268.RicochetConfig.SpeedChange));
                v279 = v268.RicochetConfig.MinRicochetSpeed;
                v276 = math.rad(v268.RicochetConfig.MaxDirectionChange);
                v277 = v268.RicochetConfig.MaxTravelDistance;
                v283 = v268.RicochetConfig.CanPlayRicochetSound;
                v282 = v268.RicochetConfig.MultiBounce;
                local v284 = -v261.Unit:Dot(v264);
                if v284 > 0 then
                    v280 = math.rad(v268.RicochetConfig.MaxImpactAngle) > 1.5707963267948966 - math.acos(v284);
                end;
                v281 = v31:NextNumber() <= v268.RicochetConfig.ChanceToRicochet;
            else
                v278 = v278 * v31:NextNumber(0.2, 0.7);
                v280 = math.abs((v261.Unit:Dot(v264))) < 0.25;
                v281 = v31:NextNumber() <= 0.5;
            end;
            if v280 and v281 and v279 < v278 then
                if v283 then
                    v258(v263, v262, v268);
                    if v267 and v262 then
                        v157(v268, v262, v263, v264, v263, v261);
                    end;
                end;
                local v285 = v261 - 2 * (v261:Dot(v264) * v264);
                local v286 = v94(v31, v285, v276).Unit * v278;
                local v287 = v265 or v234(v263, v268);
                local v288 = 0;
                local v289 = 0;
                local l_v263_0 = v263;
                local v291 = nil;
                local v292 = nil;
                local v293 = nil;
                local v294 = nil;
                local v295 = {
                    v16, 
                    v17, 
                    v21, 
                    v22
                };
                repeat
                    local v296 = l_RunService_0.Heartbeat:Wait();
                    debug.profilebegin("ricochet bullet step");
                    v288 = v288 + v296;
                    local v297 = v2.ProjectileGravity * Vector3.new(0, 1, 0, 0) * 4 * v288 ^ 2;
                    local v298 = v263 + v286 * v288 + v297;
                    local v299 = Ray.new(l_v263_0, v298 - l_v263_0);
                    local l_l_v263_0_0 = l_v263_0;
                    local l_v289_0 = v289;
                    local v302, v303, v304 = v6:BulletCast(v299, true, v295);
                    v292 = v302;
                    v293 = v303;
                    v294 = v304;
                    v289 = v289 + (l_v263_0 - v293).magnitude;
                    l_v263_0 = v293;
                    v291 = v299;
                    v246(v287, l_l_v263_0_0, v293, l_v289_0);
                    debug.profileend();
                until v292 ~= nil or v277 < v289;
                if v291 and v282 then
                    v259(v260, v291.Direction, v292, v293, v294, v287, v278, true);
                    return;
                elseif v287 then
                    v248(v287);
                    return;
                end;
            elseif v265 then
                v248(v265);
            end;
            return;
        end;
    end;
end;
local function v340(v305, v306, v307, v308, v309, v310, v311, v312) --[[ Line: 1121 ]] --[[ Name: castLocalBullet ]]
    -- upvalues: v2 (copy), v16 (copy), v17 (copy), v234 (copy), v6 (copy), v157 (copy), v246 (copy), l_RunService_0 (copy), v248 (copy), v259 (copy), v10 (copy), v4 (copy)
    local v313 = v311 * v309.FireConfig.MuzzleVelocity * v2.MuzzleVelocityMod;
    local l_v310_0 = v310;
    local v315 = 0;
    local v316 = 0;
    local v317 = nil;
    local v318 = nil;
    local v319 = nil;
    local v320 = nil;
    local v321 = true;
    local v322 = 0;
    local v323 = {
        v16, 
        v17, 
        v308.Instance
    };
    local v324 = nil;
    if not v312 then
        v324 = v234(v310, v309);
    end;
    while v321 do
        while v322 > 0.016666666666666666 do
            debug.profilebegin("local bullet step");
            v322 = v322 - 0.016666666666666666;
            v316 = v316 + 0.016666666666666666;
            local v325 = v2.ProjectileGravity * Vector3.new(0, 1, 0, 0) * v316 ^ 2;
            local v326 = v310 + v313 * v316 + v325;
            local v327 = Ray.new(l_v310_0, v326 - l_v310_0);
            local l_l_v310_0_0 = l_v310_0;
            local l_v315_0 = v315;
            local v330, v331, v332 = v6:BulletCast(v327, true, v323);
            v317 = v330;
            v318 = v331;
            v319 = v332;
            if v317 and v317:HasTag("World Water Part") then
                v157(v309, v317, v318, v319, v310, v311);
                table.insert(v323, v317);
                v330, v331, v332 = v6:BulletCast(v327, true, v323);
                v317 = v330;
                v318 = v331;
                v319 = v332;
            end;
            v315 = v315 + (l_v310_0 - v318).magnitude;
            l_v310_0 = v318;
            v320 = v327;
            if v324 then
                v246(v324, l_l_v310_0_0, v318, l_v315_0);
            end;
            if v317 or v2.ShotMaxDistance < v315 then
                v321 = false;
                break;
            else
                debug.profileend();
            end;
        end;
        v322 = v322 + l_RunService_0.Heartbeat:Wait();
    end;
    if v324 then
        v248(v324);
    end;
    if v317 and v320 then
        v157(v309, v317, v318, v319, v310, v311, true);
        if v324 then
            task.spawn(v259, v309.Name, v320.Direction, v317, v318, v319);
        end;
        local l_v317_0 = v317;
        local v334;
        if v6:IsHitCharacter(l_v317_0) then
            v334 = true;
            local _ = "Character";
        elseif v6:IsHitZombie(l_v317_0) then
            v334 = true;
            local _ = "Zombie";
        elseif v6:IsHitVehicle(l_v317_0) then
            v334 = true;
            local _ = "Vehicle";
        elseif v10:GetInteractable(l_v317_0) then
            v334 = true;
            local _ = "Interactable";
        else
            v334 = false;
            local _ = "World";
        end;
        if v334 then
            l_v317_0 = {
                v317.CFrame:PointToObjectSpace(v320.Origin), 
                v317.CFrame:VectorToObjectSpace(v320.Direction), 
                v317.CFrame:PointToObjectSpace(v318)
            };
            v4:Send("Bullet Impact", v305, v309.Id, v306, v307, v317, v318, l_v317_0);
        end;
    end;
end;
local function v372(v341, v342, v343, v344, v345, v346) --[[ Line: 1213 ]] --[[ Name: castReplicatedBullet ]]
    -- upvalues: v2 (copy), v16 (copy), v17 (copy), v234 (copy), l_RunService_0 (copy), v6 (copy), v206 (copy), v246 (copy), v248 (copy), v157 (copy), v259 (copy)
    local v347 = CFrame.new(v344, v344 + v345);
    local v348 = v347.LookVector * v343.FireConfig.MuzzleVelocity * v2.MuzzleVelocityMod;
    local l_v344_0 = v344;
    local v350 = 0;
    local v351 = 0;
    local v352 = 0;
    local v353 = nil;
    local v354 = nil;
    local v355 = nil;
    local v356 = nil;
    local v357 = true;
    local v358 = false;
    local v359 = {
        v16, 
        v17, 
        v341
    };
    local v360 = {
        HasCracked = false, 
        HasWhizzed = false
    };
    if not v343.AmmoIsSuperSonic then
        v360.HasCracked = true;
    end;
    local v361 = nil;
    if not v346 then
        v361 = v234(v344, v343);
    end;
    while v357 do
        local v362 = l_RunService_0.Heartbeat:Wait();
        debug.profilebegin("replicated bullet step");
        local v363 = 0;
        if v352 < 3 and not v358 then
            v352 = v352 + 1;
            v363 = v342 / 3;
        end;
        v351 = v351 + v362 + v363;
        local v364 = v2.ProjectileGravity * Vector3.new(0, 1, 0, 0) * v351 ^ 2;
        local v365 = v344 + v348 * v351 + v364;
        local v366 = Ray.new(l_v344_0, v365 - l_v344_0);
        local l_l_v344_0_0 = l_v344_0;
        local l_v350_0 = v350;
        local v369, v370, v371 = v6:BulletCast(v366, true, v359);
        v353 = v369;
        v354 = v370;
        v355 = v371;
        v350 = v350 + (l_v344_0 - v354).magnitude;
        l_v344_0 = v354;
        v356 = v366;
        debug.profilebegin("bullet fly by");
        v206(v360, v343, v347, v366, v353);
        debug.profileend();
        if v361 then
            v246(v361, l_l_v344_0_0, v354, l_v350_0);
        end;
        if v353 or v2.ShotMaxDistance < v350 then
            v357 = false;
        end;
        v358 = false;
        debug.profileend();
    end;
    if v361 then
        v248(v361);
    end;
    if v353 and v356 then
        v157(v343, v353, v354, v355, v344, v345, false);
        if v361 then
            task.spawn(v259, v343.Name, v356.Direction, v353, v354, v355);
        end;
    end;
end;
v23.Fire = function(_, v374, v375, v376, v377, v378, v379) --[[ Line: 1303 ]] --[[ Name: Fire ]]
    -- upvalues: v107 (copy), v28 (ref), v94 (copy), v340 (copy), v4 (copy), v127 (copy), v228 (copy)
    local v380 = v107(v374, v375, v376);
    local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
    v28 = (v28 + 1) % 69420;
    local l_v28_0 = v28;
    local v383 = Random.new(l_workspace_ServerTimeNow_0 * 10000);
    local v384 = false;
    if v376.SuppressedByDefault then
        v384 = true;
    elseif v376.Attachments then
        for _, v386 in next, v376.Attachments do
            if v386.SuppressesFirearm then
                v384 = true;
                break;
            end;
        end;
    end;
    for v387 = 1, math.max(v376.FireConfig.PelletCount, 1) do
        local v388 = v94(v383, v378, v380);
        coroutine.wrap(v340)(l_v28_0, l_workspace_ServerTimeNow_0, v387, v374, v376, v377, v388, v384);
    end;
    v4:Send("Bullet Fired", l_v28_0, l_workspace_ServerTimeNow_0, v376.Id, v377, v378);
    v374.Animator:RunAction("FireImpulse", v127(v374.Animator, v376, v379));
    v228(v376.Name, v377, v384, true);
    return l_workspace_ServerTimeNow_0;
end;
v23.GetSpreadAngle = function(_, v390, v391) --[[ Line: 1337 ]] --[[ Name: GetSpreadAngle ]]
    -- upvalues: v107 (copy)
    local l_EquippedItem_0 = v390.EquippedItem;
    if l_EquippedItem_0 and l_EquippedItem_0.Type ~= "Firearm" then
        l_EquippedItem_0 = nil;
    end;
    if l_EquippedItem_0 and v391 then
        return (v107(v390, v391, l_EquippedItem_0));
    else
        return 0;
    end;
end;
l_RunService_0.Heartbeat:Connect(function(_) --[[ Line: 1357 ]]
    -- upvalues: v25 (copy)
    debug.profilebegin("Bullet sounds mixing");
    v25:Mix();
    debug.profileend();
end);
l_RunService_0:BindToRenderStep("Damage Numbers", 100, function(v394) --[[ Line: 1363 ]]
    -- upvalues: v88 (copy)
    debug.profilebegin("Damage Numbers");
    v88(v394);
    debug.profileend();
end);
v4:Add("Replicate Shot", function(v395, v396, v397, v398, v399, v400, v401, v402) --[[ Line: 1369 ]]
    -- upvalues: v1 (copy), v94 (copy), v372 (copy), v228 (copy), v12 (copy), v127 (copy)
    local v403 = v1[v396];
    local v404 = Random.new(v400 * 10000);
    for _ = 1, math.max(v403.FireConfig.PelletCount, 1) do
        local v406 = v94(v404, v398, v401);
        coroutine.wrap(v372)(v395.Character, v399, v403, v397, v406, v402);
    end;
    v228(v396, v397, v402, false);
    if v395.Character then
        local v407 = v12.find(v395.Character);
        if v407 and v403 then
            v407:RunAction("FireImpulse", v127(v407, v403));
        end;
    end;
end);
v4:Add("Toggle Damage Markers", function() --[[ Line: 1391 ]]
    -- upvalues: v23 (copy)
    v23.DamageMarkersEnabled = not v23.DamageMarkersEnabled;
end);
v4:Add("Bullet Damage", function(v408, v409, v410, v411) --[[ Line: 1395 ]]
    -- upvalues: v23 (copy), v0 (copy), v61 (copy), v76 (copy)
    if not v23.DamageMarkersEnabled then
        return;
    else
        if v0.Libraries.Interface.AllVisible and not v61(v408, v410) then
            v76(v408, v409, v410, v411);
        end;
        return;
    end;
end);
v4:Add("Last Bullet Sound Play", function(v412, v413, v414) --[[ Line: 1405 ]]
    -- upvalues: v1 (copy), l_Players_0 (copy), v5 (copy), l_Part_0 (copy)
    local v415 = v1[v414];
    if v412 ~= l_Players_0.LocalPlayer and v415 and v415.LastBulletActionSound then
        local l_Magnitude_4 = (workspace.CurrentCamera.CFrame.Position - v413).Magnitude;
        local v417 = v5:Find("ReplicatedStorage.Assets.Sounds." .. v415.LastBulletActionSound);
        if v417 and l_Magnitude_4 < v417.RollOffMaxDistance then
            local l_Attachment_0 = Instance.new("Attachment");
            l_Attachment_0.CFrame = CFrame.new(v413);
            l_Attachment_0.Parent = l_Part_0;
            local v419 = v417:Clone();
            v419.Parent = l_Attachment_0;
            v419.SoundGroup = v5:Find("SoundService.Effects");
            v419.Ended:Connect(function() --[[ Line: 1421 ]]
                -- upvalues: l_Attachment_0 (copy), v419 (copy)
                l_Attachment_0:Destroy();
                v419:Destroy();
            end);
            task.delay(v415.LastBulletActionSoundDelay or 0, function() --[[ Line: 1426 ]]
                -- upvalues: v419 (copy)
                v419:Play();
            end);
        end;
    end;
end);
v9:BindToSetting("User Interface", "Damage Indicators", function(v420) --[[ Line: 1433 ]]
    -- upvalues: v23 (copy)
    v23.DamageMarkersEnabled = v420 == "On";
end);
return v23;