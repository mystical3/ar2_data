local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Configs", "GroundData");
local v3 = v0.require("Libraries", "Resources");
local v4 = v0.require("Libraries", "Raycasting");
local v5 = v0.require("Libraries", "ZombieConfigs");
local v6 = v0.require("Classes", "SteppedSprings");
local v7 = v0.require("Classes", "Springs");
local _ = v0.require("Classes", "Maids");
local v9 = v0.require("Classes", "Randomizer");
local v10 = v0.require("Classes", "SoundMixer");
local v11 = v3:Find("ReplicatedStorage.Assets.Sounds.Zombies.Footsteps");
local l_RunService_0 = game:GetService("RunService");
local v13 = Random.new();
local v14 = Color3.fromRGB(255, 74, 74);
local v15 = Color3.fromRGB(255, 255, 255);
local v16 = Color3.fromRGB(255, 190, 40);
local function _(v17, v18, v19, v20, v21) --[[ Line: 33 ]] --[[ Name: remapClamped ]]
    return v20 + (v21 - v20) * math.clamp((v17 - v18) / (v19 - v18), 0, 1);
end;
local function _(v23, v24, v25) --[[ Line: 37 ]] --[[ Name: lerp ]]
    return v23 + (v24 - v23) * v25;
end;
local function _(v27, v28, v29) --[[ Line: 41 ]] --[[ Name: findAndDo ]]
    local l_v27_FirstChild_0 = v27:FindFirstChild(v28);
    if l_v27_FirstChild_0 then
        return v29(l_v27_FirstChild_0);
    else
        return;
    end;
end;
local function v38(v32, v33, v34) --[[ Line: 49 ]] --[[ Name: playSound ]]
    -- upvalues: v3 (copy), v0 (copy)
    local v35 = nil;
    if v32.Instance and v32.Instance.PrimaryPart then
        v35 = v32.Instance.PrimaryPart;
    end;
    if not v35 then
        return;
    else
        local v36 = nil;
        v36 = if typeof(v33) == "string" then v3:Find("ReplicatedStorage.Assets.Sounds." .. v33) else v33;
        if not v36 then
            warn("Failed to play sound:", v33, "found:", v36);
            return nil;
        else
            local v37 = v36:Clone();
            v37.Parent = v35;
            v37.Ended:Connect(function() --[[ Line: 76 ]]
                -- upvalues: v0 (ref), v37 (copy)
                v0.destroy(v37, "Ended");
            end);
            v37.SoundGroup = v3:Find("SoundService.Infected");
            if v34 then
                v34(v37);
            end;
            v37:Play();
            return v37;
        end;
    end;
end;
local _ = function(v39, v40, v41) --[[ Line: 94 ]] --[[ Name: playMixedSound ]]
    -- upvalues: v38 (copy)
    return v38(v39, v40, function(v42) --[[ Line: 95 ]]
        -- upvalues: v39 (copy), v41 (copy)
        v39.SoundMixer:Add(v42, v41, 0.6);
        v42.Ended:Connect(function() --[[ Line: 98 ]]
            -- upvalues: v39 (ref), v42 (copy)
            v39.SoundMixer:Remove(v42);
        end);
        v42.AncestryChanged:Connect(function(_, v44) --[[ Line: 102 ]]
            -- upvalues: v39 (ref), v42 (copy)
            if v44 == nil and v39.SoundMixer then
                v39.SoundMixer:Remove(v42);
            end;
        end);
    end);
end;
local _ = function(_, _, _) --[[ Line: 110 ]] --[[ Name: dustEmit ]]

end;
local function v59(v50) --[[ Line: 126 ]] --[[ Name: playFootstepSound ]]
    -- upvalues: v3 (copy), v11 (copy), v9 (copy), v38 (copy), v13 (copy)
    if v50.DistanceToCamera > 300 then
        return;
    else
        local v51 = nil;
        if v50.Instance and v50.Instance.PrimaryPart then
            v51 = v50.Instance.PrimaryPart;
        end;
        if not v51 then
            return;
        else
            local v52 = "Carpet";
            local v53 = v50.States.MoveState or "Walking";
            v52 = if v50.Config.FootstepSoundGroupOverride then v50.Config.FootstepSoundGroupOverride else v50.GroundMaterial;
            local v54 = v3:SearchFrom(v11, v52 .. "." .. v53);
            local v55 = v3:SearchFrom(v11, v52 .. ".Movement");
            local v56 = v9.new(v55:GetChildren());
            if v56 and v54 then
                v38(v50, v56:Roll(), function(v57) --[[ Line: 157 ]]
                    -- upvalues: v54 (copy), v13 (ref)
                    local v58 = v54:Clone();
                    v58.Parent = v57;
                    v57.Volume = v58:GetAttribute("Volume") or v57.Volume;
                    v57.RollOffMaxDistance = v58:GetAttribute("MaxDistance") or v57.RollOffMaxDistance;
                    v57.RollOffMinDistance = v58:GetAttribute("MinDistance") or v57.RollOffMinDistance;
                    v57.PlaybackSpeed = v13:NextNumber(1 - (v58:GetAttribute("PitchRange") or 0), 1 + (v58:GetAttribute("PitchRange") or 0));
                end);
            end;
            return v52;
        end;
    end;
end;
local v60 = nil;
local v61 = v3:Find("ReplicatedStorage.Assets.Animations");
local v121 = {
    Footstep = function(v62, v63) --[[ Line: 179 ]] --[[ Name: Footstep ]]
        -- upvalues: v59 (copy)
        v63:GetMarkerReachedSignal("Step"):Connect(function() --[[ Line: 180 ]]
            -- upvalues: v63 (copy), v59 (ref), v62 (copy)
            if v63.WeightCurrent > 0.5 then
                local _ = v59(v62);
                local _ = v62;
            end;
        end);
    end, 
    Attack = function(v66, v67) --[[ Line: 188 ]] --[[ Name: Attack ]]
        -- upvalues: v38 (copy)
        v67:GetMarkerReachedSignal("Roar"):Connect(function() --[[ Line: 189 ]]
            -- upvalues: v66 (copy), v38 (ref)
            local l_v66_0 = v66;
            local v69 = v66.SoundRandomizers.Attacking:Roll();
            local l_v38_0 = v38;
            local l_l_v66_0_0 = l_v66_0;
            local l_v69_0 = v69;
            local v73 = 6;
            l_v38_0 = l_v38_0(l_l_v66_0_0, l_v69_0, function(v74) --[[ Line: 95 ]]
                -- upvalues: l_v66_0 (copy), v73 (copy)
                l_v66_0.SoundMixer:Add(v74, v73, 0.6);
                v74.Ended:Connect(function() --[[ Line: 98 ]]
                    -- upvalues: l_v66_0 (ref), v74 (copy)
                    l_v66_0.SoundMixer:Remove(v74);
                end);
                v74.AncestryChanged:Connect(function(_, v76) --[[ Line: 102 ]]
                    -- upvalues: l_v66_0 (ref), v74 (copy)
                    if v76 == nil and l_v66_0.SoundMixer then
                        l_v66_0.SoundMixer:Remove(v74);
                    end;
                end);
            end);
            v38(v66, "Melee.Whoosh 1");
        end);
    end, 
    Rage = function(v77, v78) --[[ Line: 195 ]] --[[ Name: Rage ]]
        -- upvalues: v38 (copy)
        v78:GetMarkerReachedSignal("Scream"):Connect(function() --[[ Line: 196 ]]
            -- upvalues: v77 (copy), v38 (ref)
            local l_v77_0 = v77;
            local v80 = v77.SoundRandomizers.TargetFound:Roll();
            local l_v38_1 = v38;
            local l_l_v77_0_0 = l_v77_0;
            local l_v80_0 = v80;
            local v84 = 6;
            l_v38_1 = l_v38_1(l_l_v77_0_0, l_v80_0, function(v85) --[[ Line: 95 ]]
                -- upvalues: l_v77_0 (copy), v84 (copy)
                l_v77_0.SoundMixer:Add(v85, v84, 0.6);
                v85.Ended:Connect(function() --[[ Line: 98 ]]
                    -- upvalues: l_v77_0 (ref), v85 (copy)
                    l_v77_0.SoundMixer:Remove(v85);
                end);
                v85.AncestryChanged:Connect(function(_, v87) --[[ Line: 102 ]]
                    -- upvalues: l_v77_0 (ref), v85 (copy)
                    if v87 == nil and l_v77_0.SoundMixer then
                        l_v77_0.SoundMixer:Remove(v85);
                    end;
                end);
            end);
        end);
    end, 
    Confused = function(v88, v89) --[[ Line: 201 ]] --[[ Name: Confused ]]
        -- upvalues: v38 (copy)
        v89:GetMarkerReachedSignal("Groan"):Connect(function() --[[ Line: 202 ]]
            -- upvalues: v88 (copy), v38 (ref)
            local l_v88_0 = v88;
            local v91 = v88.SoundRandomizers.TargetLost:Roll();
            local l_v38_2 = v38;
            local l_l_v88_0_0 = l_v88_0;
            local l_v91_0 = v91;
            local v95 = 6;
            l_v38_2 = l_v38_2(l_l_v88_0_0, l_v91_0, function(v96) --[[ Line: 95 ]]
                -- upvalues: l_v88_0 (copy), v95 (copy)
                l_v88_0.SoundMixer:Add(v96, v95, 0.6);
                v96.Ended:Connect(function() --[[ Line: 98 ]]
                    -- upvalues: l_v88_0 (ref), v96 (copy)
                    l_v88_0.SoundMixer:Remove(v96);
                end);
                v96.AncestryChanged:Connect(function(_, v98) --[[ Line: 102 ]]
                    -- upvalues: l_v88_0 (ref), v96 (copy)
                    if v98 == nil and l_v88_0.SoundMixer then
                        l_v88_0.SoundMixer:Remove(v96);
                    end;
                end);
            end);
        end);
    end, 
    IdleNoise = function(v99, v100) --[[ Line: 207 ]] --[[ Name: IdleNoise ]]
        -- upvalues: v38 (copy)
        v100:GetMarkerReachedSignal("Growl"):Connect(function() --[[ Line: 208 ]]
            -- upvalues: v99 (copy), v38 (ref)
            if v99.States.AgroState == "Wandering" then
                local l_v99_0 = v99;
                local v102 = v99.SoundRandomizers.Wandering:Roll();
                local l_v38_3 = v38;
                local l_l_v99_0_0 = l_v99_0;
                local l_v102_0 = v102;
                local v106 = 6;
                l_v38_3 = l_v38_3(l_l_v99_0_0, l_v102_0, function(v107) --[[ Line: 95 ]]
                    -- upvalues: l_v99_0 (copy), v106 (copy)
                    l_v99_0.SoundMixer:Add(v107, v106, 0.6);
                    v107.Ended:Connect(function() --[[ Line: 98 ]]
                        -- upvalues: l_v99_0 (ref), v107 (copy)
                        l_v99_0.SoundMixer:Remove(v107);
                    end);
                    v107.AncestryChanged:Connect(function(_, v109) --[[ Line: 102 ]]
                        -- upvalues: l_v99_0 (ref), v107 (copy)
                        if v109 == nil and l_v99_0.SoundMixer then
                            l_v99_0.SoundMixer:Remove(v107);
                        end;
                    end);
                end);
                return;
            else
                if v99.States.AgroState == "Investigating" then
                    local l_v99_1 = v99;
                    local v111 = v99.SoundRandomizers.Investigating:Roll();
                    local l_v38_4 = v38;
                    local l_l_v99_1_0 = l_v99_1;
                    local l_v111_0 = v111;
                    local v115 = 6;
                    l_v38_4 = l_v38_4(l_l_v99_1_0, l_v111_0, function(v116) --[[ Line: 95 ]]
                        -- upvalues: l_v99_1 (copy), v115 (copy)
                        l_v99_1.SoundMixer:Add(v116, v115, 0.6);
                        v116.Ended:Connect(function() --[[ Line: 98 ]]
                            -- upvalues: l_v99_1 (ref), v116 (copy)
                            l_v99_1.SoundMixer:Remove(v116);
                        end);
                        v116.AncestryChanged:Connect(function(_, v118) --[[ Line: 102 ]]
                            -- upvalues: l_v99_1 (ref), v116 (copy)
                            if v118 == nil and l_v99_1.SoundMixer then
                                l_v99_1.SoundMixer:Remove(v116);
                            end;
                        end);
                    end);
                end;
                return;
            end;
        end);
    end, 
    Generic = function(_, _) --[[ Line: 218 ]] --[[ Name: Generic ]]

    end
};
local v122 = {
    ["Zombies.Attack 1"] = v121.Attack, 
    ["Zombies.Attack 2"] = v121.Attack, 
    ["Zombies.Running"] = v121.Footstep, 
    ["Zombies.Walking"] = v121.Footstep, 
    ["Zombies.Rage"] = v121.Rage, 
    ["Zombies.Confused"] = v121.Confused, 
    ["Zombies.Idle Look 1"] = v121.IdleNoise, 
    ["Zombies.Idle Look 2"] = v121.IdleNoise, 
    ["Claws Dual Jab"] = v121.Attack, 
    ["Claws Dual Slash"] = v121.Attack, 
    ["Claws Left Swing"] = v121.Attack, 
    ["Claws Right Swing"] = v121.Attack, 
    ["One Handed Chop"] = v121.Attack, 
    ["One Handed Slash"] = v121.Attack, 
    ["One Handed Stab"] = v121.Attack, 
    Shove = v121.Attack, 
    ["Two Handed Chop"] = v121.Attack
};
for _, v124 in next, v61:GetDescendants() do
    if v124:IsA("Animation") then
        if v124:FindFirstChild("MeleeAnimation") then
            v122[v124.Parent.Name .. "." .. v124.Name] = v121.MeleeSwing;
        elseif v124:FindFirstChild("BoxingAnimation") then
            v122[v124.Parent.Name .. "." .. v124.Name] = v121.BoxingAttack;
        end;
    end;
end;
local l_v122_0 = v122 --[[ copy: 27 -> 33 ]];
local l_v121_0 = v121 --[[ copy: 26 -> 34 ]];
v60 = function(v127, v128, v129) --[[ Line: 254 ]] --[[ Name: keyframeEventHooks ]]
    -- upvalues: l_v122_0 (copy), l_v121_0 (copy)
    if l_v122_0[v128] then
        l_v122_0[v128](v127, v129);
    end;
    l_v121_0.Generic(v127, v129);
end;
v61 = function(v130) --[[ Line: 263 ]] --[[ Name: getSoundRandomizers ]]
    -- upvalues: v9 (copy), v3 (copy)
    local function _(v131) --[[ Line: 264 ]] --[[ Name: new ]]
        -- upvalues: v9 (ref), v3 (ref)
        v131 = "ReplicatedStorage.Assets.Sounds." .. v131;
        return v9.new(v3:Find(v131):GetChildren());
    end;
    local v133 = {};
    local v134 = "ReplicatedStorage.Assets.Sounds." .. (v130.Config.TargetLostSounds or "Zombies.Action Growls.Target Lost");
    v133.TargetLost = v9.new(v3:Find(v134):GetChildren());
    v134 = "ReplicatedStorage.Assets.Sounds." .. (v130.Config.TargetFoundSounds or "Zombies.Action Growls.Target Found");
    v133.TargetFound = v9.new(v3:Find(v134):GetChildren());
    v134 = "ReplicatedStorage.Assets.Sounds." .. (v130.Config.TargetFoundAltSounds or "Zombies.Action Growls.Target Found Alt");
    v133.TargetFoundAlt = v9.new(v3:Find(v134):GetChildren());
    v134 = "ReplicatedStorage.Assets.Sounds." .. (v130.Config.InvestigateSounds or "Zombies.Action Growls.Investigate");
    v133.Investigate = v9.new(v3:Find(v134):GetChildren());
    v134 = "ReplicatedStorage.Assets.Sounds." .. (v130.Config.ChasingSounds or "Zombies.Ambient Growls.Chasing");
    v133.Chasing = v9.new(v3:Find(v134):GetChildren());
    v134 = "ReplicatedStorage.Assets.Sounds." .. (v130.Config.InvestigatingSounds or "Zombies.Ambient Growls.Investigating");
    v133.Investigating = v9.new(v3:Find(v134):GetChildren());
    v134 = "ReplicatedStorage.Assets.Sounds." .. (v130.Config.WanderingSounds or "Zombies.Ambient Growls.Wandering");
    v133.Wandering = v9.new(v3:Find(v134):GetChildren());
    v134 = "ReplicatedStorage.Assets.Sounds." .. (v130.Config.AttackingSounds or "Zombies.Attacking");
    v133.Attacking = v9.new(v3:Find(v134):GetChildren());
    return v133;
end;
v121 = function(v135) --[[ Line: 287 ]] --[[ Name: stopChasingLoop ]]
    -- upvalues: v0 (copy)
    local l_ChaseLoopSound_0 = v135.ChaseLoopSound;
    if v135.ChaseLoopSound then
        v135.ChaseLoopSound = nil;
    end;
    if l_ChaseLoopSound_0 then
        l_ChaseLoopSound_0:Stop();
        v0.destroy(l_ChaseLoopSound_0, "Ended");
    end;
end;
v122 = function(v137) --[[ Line: 301 ]] --[[ Name: startChasingLoop ]]
    -- upvalues: v38 (copy), v122 (copy), v0 (copy)
    local v138 = v137.SoundRandomizers.Chasing:Roll();
    local l_v38_5 = v38;
    local l_v137_0 = v137;
    local l_v138_0 = v138;
    local v142 = 1;
    l_v38_5 = l_v38_5(l_v137_0, l_v138_0, function(v143) --[[ Line: 95 ]]
        -- upvalues: v137 (copy), v142 (copy)
        v137.SoundMixer:Add(v143, v142, 0.6);
        v143.Ended:Connect(function() --[[ Line: 98 ]]
            -- upvalues: v137 (ref), v143 (copy)
            v137.SoundMixer:Remove(v143);
        end);
        v143.AncestryChanged:Connect(function(_, v145) --[[ Line: 102 ]]
            -- upvalues: v137 (ref), v143 (copy)
            if v145 == nil and v137.SoundMixer then
                v137.SoundMixer:Remove(v143);
            end;
        end);
    end);
    l_v38_5.Ended:Connect(function() --[[ Line: 305 ]]
        -- upvalues: v137 (copy), v122 (ref), v0 (ref)
        if v137.States.AgroState == "Attacking" then
            v122(v137);
            return;
        else
            local l_v137_1 = v137;
            local l_ChaseLoopSound_1 = l_v137_1.ChaseLoopSound;
            if l_v137_1.ChaseLoopSound then
                l_v137_1.ChaseLoopSound = nil;
            end;
            if l_ChaseLoopSound_1 then
                l_ChaseLoopSound_1:Stop();
                v0.destroy(l_ChaseLoopSound_1, "Ended");
            end;
            return;
        end;
    end);
    l_v137_0 = v137.ChaseLoopSound;
    if v137.ChaseLoopSound then
        v137.ChaseLoopSound = nil;
    end;
    if l_v137_0 then
        l_v137_0:Stop();
        v0.destroy(l_v137_0, "Ended");
    end;
    v137.ChaseLoopSound = l_v38_5;
    v137.ChaseLoopSound:Play();
end;
return function(v148) --[[ Line: 320 ]]
    -- upvalues: v7 (copy), v5 (copy), v6 (copy), v61 (copy), v10 (copy), v0 (copy), v60 (ref), v38 (copy), v122 (copy), l_RunService_0 (copy), v1 (copy), v15 (copy), v16 (copy), v14 (copy), v13 (copy), v4 (copy), v2 (copy), v3 (copy)
    local l_States_0 = v148.States;
    local l_Instance_0 = v148.Instance;
    v148.LodVisibleCutOff = 500;
    v148.RootPart = l_Instance_0:WaitForChild("HumanoidRootPart");
    v148.GroundMaterial = "Sand";
    v148.GroundCastDebounce = os.clock();
    local l_Status_0 = l_Instance_0:WaitForChild("Head"):WaitForChild("Status");
    local l_Agro_0 = l_Status_0:WaitForChild("Agro");
    local v153 = v7.new(0, 4, 1);
    local v154 = v7.new(0, 4, 1);
    local v155 = 0;
    local v156 = 0;
    v148.Config = v5:Get(v148.Instance.Name);
    local v157 = {
        RootPart = v148.RootPart, 
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
    local v158 = {
        Root = v157.LowerTorso:WaitForChild("Root"), 
        Neck = v157.Head:WaitForChild("Neck"), 
        Waist = v157.UpperTorso:WaitForChild("Waist"), 
        LeftShoulder = v157.LeftUpperArm:WaitForChild("LeftShoulder"), 
        LeftElbow = v157.LeftLowerArm:WaitForChild("LeftElbow"), 
        LeftWrist = v157.LeftHand:WaitForChild("LeftWrist"), 
        RightShoulder = v157.RightUpperArm:WaitForChild("RightShoulder"), 
        RightElbow = v157.RightLowerArm:WaitForChild("RightElbow"), 
        RightWrist = v157.RightHand:WaitForChild("RightWrist"), 
        LeftHip = v157.LeftUpperLeg:WaitForChild("LeftHip"), 
        LeftKnee = v157.LeftLowerLeg:WaitForChild("LeftKnee"), 
        LeftAnkle = v157.LeftFoot:WaitForChild("LeftAnkle"), 
        RightHip = v157.RightUpperLeg:WaitForChild("RightHip"), 
        RightKnee = v157.RightLowerLeg:WaitForChild("RightKnee"), 
        RightAnkle = v157.RightFoot:WaitForChild("RightAnkle")
    };
    local v159 = {};
    for v160, v161 in next, v158 do
        v159[v160] = {
            C0 = v161.C0, 
            C1 = v161.C1
        };
    end;
    local v162 = {
        LookDirection = v6.new(Vector3.new(0, 0, -1, 0), 2.5, 0.4), 
        Twitch = v6.new(Vector3.new(0, 0, 0, 0), 3, 0.5)
    };
    local v163 = {};
    v148.FootstepCache = {};
    v148.SoundRandomizers = v61(v148);
    v148.SoundMixer = v10.new();
    v148.Maid:Give(function() --[[ Line: 407 ]]
        -- upvalues: v148 (copy), v0 (ref), v157 (ref), v158 (ref), v159 (ref), v162 (ref), l_States_0 (ref), l_Instance_0 (ref)
        local l_v148_0 = v148;
        local l_ChaseLoopSound_2 = l_v148_0.ChaseLoopSound;
        if l_v148_0.ChaseLoopSound then
            l_v148_0.ChaseLoopSound = nil;
        end;
        if l_ChaseLoopSound_2 then
            l_ChaseLoopSound_2:Stop();
            v0.destroy(l_ChaseLoopSound_2, "Ended");
        end;
        for v166, _ in next, v157 do
            v157[v166] = nil;
        end;
        for v168, _ in next, v158 do
            v158[v168] = nil;
        end;
        for _, v171 in next, v148.SoundRandomizers do
            v171:Destroy();
        end;
        for _, v173 in next, v148.FootstepCache do
            if v173.Randomizer then
                v173.Randomizer:Destroy();
                v173.Randomizer = nil;
            end;
            v173.Eq = nil;
        end;
        if v148.SoundMixer then
            v148.SoundMixer:Destroy();
            v148.SoundMixer = nil;
        end;
        v148.SoundRandomizers = nil;
        v148.FootstepCache = nil;
        v148.RootPart = nil;
        v148.Config = nil;
        v157 = nil;
        v158 = nil;
        v159 = nil;
        v162 = nil;
        l_States_0 = nil;
        l_Instance_0 = nil;
        if v148.GroundSoundLoop then
            v148.GroundSoundLoop:Stop();
            v148.GroundSoundLoop:Destroy();
            v148.GroundSoundLoop = nil;
        end;
    end);
    local l_PlayAnimation_0 = v148.PlayAnimation;
    v148.PlayAnimation = function(v175, v176, ...) --[[ Line: 459 ]] --[[ Name: PlayAnimation ]]
        -- upvalues: l_PlayAnimation_0 (copy), v60 (ref)
        local v177 = l_PlayAnimation_0(v175, v176, ...);
        local v178 = v175.Animations[v176];
        if v178 then
            v60(v175, v176, v178);
        end;
        return v177;
    end;
    v148.DamageStaggerTry = function(v179) --[[ Line: 470 ]] --[[ Name: DamageStaggerTry ]]
        if v179.Config.CanGetStunned then
            v179:PlayAnimation("Zombies.Stun", 0.1, 0.1);
            v179.StunPredict = os.clock();
        end;
    end;
    local function v181(v180) --[[ Line: 479 ]] --[[ Name: getLimbBaseJoint ]]
        -- upvalues: v158 (ref)
        if v180 == "Head" then
            return v158.Neck, 1;
        elseif v180 == "UpperTorso" or v180 == "LowerTorso" then
            return v158.Waist, 1;
        elseif v180:find("Hand") or v180:find("Arm") then
            return v158[(v180:find("Right") and "Right" or "Left") .. (v180:find("Upper") and "Shoulder" or "Elbow")], -1;
        elseif v180:find("Foot") or v180:find("Leg") then
            return v158[(v180:find("Right") and "Right" or "Left") .. (v180:find("Upper") and "Hip" or "Knee")], -1;
        else
            return nil, 0;
        end;
    end;
    v148:BindToState("AgroState", function(v182, v183) --[[ Line: 502 ]]
        -- upvalues: v148 (copy), v38 (ref), v122 (ref), v0 (ref), v155 (ref), v156 (ref)
        if v182 == "Attacking" then
            if not v148:IsAnimationPlaying("Zombies.Rage") then
                local l_v148_1 = v148;
                local v185 = v148.SoundRandomizers.TargetFoundAlt:Roll();
                local l_v38_6 = v38;
                local l_l_v148_1_0 = l_v148_1;
                local l_v185_0 = v185;
                local v189 = 6;
                local l_l_v148_1_1 = l_v148_1 --[[ copy: 2 -> 9 ]];
                local l_v189_0 = v189 --[[ copy: 8 -> 10 ]];
                l_v38_6 = l_v38_6(l_l_v148_1_0, l_v185_0, function(v192) --[[ Line: 95 ]]
                    -- upvalues: l_l_v148_1_1 (copy), l_v189_0 (copy)
                    l_l_v148_1_1.SoundMixer:Add(v192, l_v189_0, 0.6);
                    v192.Ended:Connect(function() --[[ Line: 98 ]]
                        -- upvalues: l_l_v148_1_1 (ref), v192 (copy)
                        l_l_v148_1_1.SoundMixer:Remove(v192);
                    end);
                    v192.AncestryChanged:Connect(function(_, v194) --[[ Line: 102 ]]
                        -- upvalues: l_l_v148_1_1 (ref), v192 (copy)
                        if v194 == nil and l_l_v148_1_1.SoundMixer then
                            l_l_v148_1_1.SoundMixer:Remove(v192);
                        end;
                    end);
                end);
            end;
            v122(v148);
        else
            local l_v148_2 = v148;
            local l_ChaseLoopSound_3 = l_v148_2.ChaseLoopSound;
            if l_v148_2.ChaseLoopSound then
                l_v148_2.ChaseLoopSound = nil;
            end;
            if l_ChaseLoopSound_3 then
                l_ChaseLoopSound_3:Stop();
                v0.destroy(l_ChaseLoopSound_3, "Ended");
            end;
        end;
        if v182 == "Attacking" then
            v148:PlayAnimation("Zombies.Idle Agro");
            v148:StopAnimation("Zombies.Idle");
        elseif v182 == "Wandering" then
            v148:StopAnimation("Zombies.Idle Agro");
            v148:PlayAnimation("Zombies.Idle");
        end;
        if v182 == "Attacking" and v183 == "Investigating" then
            v155 = 1;
            v156 = os.clock();
        end;
        if v182 == "Investigating" then
            local l_v148_3 = v148;
            local v198 = v148.SoundRandomizers.Investigate:Roll();
            local l_v38_7 = v38;
            local l_l_v148_3_0 = l_v148_3;
            local l_v198_0 = v198;
            local v202 = 6;
            l_v38_7 = l_v38_7(l_l_v148_3_0, l_v198_0, function(v203) --[[ Line: 95 ]]
                -- upvalues: l_v148_3 (copy), v202 (copy)
                l_v148_3.SoundMixer:Add(v203, v202, 0.6);
                v203.Ended:Connect(function() --[[ Line: 98 ]]
                    -- upvalues: l_v148_3 (ref), v203 (copy)
                    l_v148_3.SoundMixer:Remove(v203);
                end);
                v203.AncestryChanged:Connect(function(_, v205) --[[ Line: 102 ]]
                    -- upvalues: l_v148_3 (ref), v203 (copy)
                    if v205 == nil and l_v148_3.SoundMixer then
                        l_v148_3.SoundMixer:Remove(v203);
                    end;
                end);
            end);
            if v183 == "Attacking" then
                v148:PlayAnimation("Zombies.Idle Look 2");
                return;
            else
                v148:PlayAnimation("Zombies.Idle Look 1");
            end;
        end;
    end);
    v148:SetAction("Enrage", function() --[[ Line: 538 ]]
        -- upvalues: v148 (copy)
        v148:PlayAnimation("Zombies.Rage");
    end);
    v148:SetAction("Stun", function(v206) --[[ Line: 542 ]]
        -- upvalues: v148 (copy), v38 (ref)
        local v207 = v206 or 1;
        v148:StopAnimation("Zombies.Attack 2");
        v148:StopAnimation("Zombies.Attack 1");
        if v148:IsAnimationPlaying("Zombies.Stun") and v148.StunPredict then
            v148:SetAnimationSpeed("Zombies.Stun", v207);
        else
            v148:PlayAnimation("Zombies.Stun", nil, v207);
        end;
        v148.StunPredict = nil;
        v38(v148, v148.SoundRandomizers.Attacking:Roll());
    end);
    v148:SetAction("Flinch", function(v208, v209) --[[ Line: 560 ]]
        -- upvalues: v181 (copy), v7 (ref), v163 (copy)
        local v210, v211 = v181(v208);
        if v210 then
            local v212 = v210.Part1.CFrame:VectorToObjectSpace(v209 * v211);
            local v213 = v7.new(Vector3.new(0, 0, 0, 0), 3, 0.5);
            v213.v = v213.v + v212;
            table.insert(v163, {
                Joint = v210, 
                Spring = v213
            });
        end;
    end);
    v148:SetAction("Vault", function(v214, v215) --[[ Line: 576 ]]
        -- upvalues: v148 (copy)
        local v216 = v215 or 1;
        if v214 then
            v148:PlayAnimation("Zombies.Vault", nil, v216);
            return;
        else
            v148:PlayAnimation("Zombies.Vault Low", nil, v216);
            return;
        end;
    end);
    v148:SetAction("Trip", function() --[[ Line: 586 ]]
        -- upvalues: v148 (copy)
        v148:PlayAnimation("Zombies.Trip");
    end);
    v148:SetAction("Attack", function(v217, v218) --[[ Line: 590 ]]
        -- upvalues: v148 (copy)
        v148:PlayAnimation(v217, nil, v218 or 1);
    end);
    v148:SetAction("Random Drop", function(v219, v220, _) --[[ Line: 594 ]]
        -- upvalues: v38 (ref), v148 (copy)
        v38(v148, v219);
        v148:PlayAnimation(v220);
    end);
    v148.Maid:Give(v148.Slept:Connect(function() --[[ Line: 600 ]]
        -- upvalues: v148 (copy), l_Status_0 (copy)
        for v222, _ in next, v148.Animations do
            v148:StopAnimation(v222);
        end;
        l_Status_0.Enabled = false;
    end));
    v148.Maid:Give(v148.Woken:Connect(function() --[[ Line: 608 ]]
        -- upvalues: v148 (copy), l_States_0 (ref), l_Status_0 (copy)
        v148.StateChanged:Fire("AgroState", l_States_0.AgroState, l_States_0.AgroState);
        v148:PlayAnimation("Zombies.Running", nil, 1, 0.001);
        v148:PlayAnimation("Zombies.Walking", nil, 1, 0.001);
        if v148.States.AgroState == "Attacking" then
            v148:PlayAnimation("Zombies.Idle Agro");
            v148:StopAnimation("Zombies.Idle");
        else
            v148:StopAnimation("Zombies.Idle Agro");
            v148:PlayAnimation("Zombies.Idle");
        end;
        l_Status_0.Enabled = true;
    end));
    v148.Maid:Give(l_RunService_0.Stepped:Connect(function(_, v225) --[[ Line: 626 ]]
        -- upvalues: v163 (copy), l_Status_0 (copy), v155 (ref), l_States_0 (ref), v153 (copy), v154 (copy), l_Agro_0 (copy), v1 (ref), v15 (ref), v16 (ref), v156 (ref), v14 (ref), v148 (copy)
        for v226 = #v163, 1, -1 do
            local v227 = v163[v226];
            local v228, v229 = v227.Spring:Update(v225);
            if v228.Magnitude < 0.001 and v229.Magnitude < 0.001 then
                v227.Joint = nil;
                v227.Spring = nil;
                table.remove(v163, v226);
            else
                local v230 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0, 0):Cross(v228), v228.Magnitude);
                local v231 = CFrame.new(v228) * v230;
                v227.Joint.Transform = v227.Joint.Transform * v231;
            end;
        end;
        if l_Status_0.Enabled then
            if v155 <= 0 and l_States_0.AgroPercent then
                local v232 = v153:StepTo(l_States_0.AgroPercent, v225);
                local v233 = v154:StepTo(l_States_0.AgroPercent > 0.01 and 1 or 0, v225);
                l_Agro_0.ImageColor3 = v1.lerp(v15, v16, v232);
                l_Agro_0.Inner.ImageColor3 = l_Agro_0.ImageColor3;
                l_Agro_0.Outter.ImageColor3 = l_Agro_0.ImageColor3;
                l_Agro_0.Inner.ImageTransparency = 1 + -1 * math.clamp((v232 - 0.2833333333333333) / 0.09999999999999998, 0, 1);
                l_Agro_0.Outter.ImageTransparency = 1 + -1 * math.clamp((v232 - 0.6166666666666666) / 0.10000000000000009, 0, 1);
                l_Agro_0.Size = UDim2.fromScale(v233, v233);
            else
                local v234 = os.clock() - v156;
                local v235 = v154:StepTo(1, v225);
                local v236 = (math.sin(v234 * 3.141592653589793 * 5) + 1) * 0.5;
                l_Agro_0.ImageColor3 = v1.lerp(v16, v14, v236);
                l_Agro_0.Inner.ImageColor3 = l_Agro_0.ImageColor3;
                l_Agro_0.Outter.ImageColor3 = l_Agro_0.ImageColor3;
                local l_Inner_0 = l_Agro_0.Inner;
                local l_ImageTransparency_0 = l_Agro_0.Inner.ImageTransparency;
                l_Inner_0.ImageTransparency = l_ImageTransparency_0 + (0 - l_ImageTransparency_0) * 0.6;
                l_Inner_0 = l_Agro_0.Outter;
                l_ImageTransparency_0 = l_Agro_0.Inner.ImageTransparency;
                l_Inner_0.ImageTransparency = l_ImageTransparency_0 + (0 - l_ImageTransparency_0) * 0.6;
                l_Agro_0.Size = UDim2.fromScale(v235, v235);
                v155 = v155 - v225;
            end;
        end;
        if v148:IsAnimationPlaying("Zombies.Stun") then
            local l_RootPart_0 = v148.RootPart;
            local function v241(v240) --[[ Line: 690 ]]
                v240.Velocity = v240.Velocity * Vector3.new(0, 1, 0, 0);
            end;
            local l_VectorForce_0 = l_RootPart_0:FindFirstChild("VectorForce");
            if l_VectorForce_0 then
                local _ = v241(l_VectorForce_0);
            end;
            if v148.StunPredict and os.clock() - v148.StunPredict >= 0.3 then
                v148:StopAnimation("Zombies.Stun");
                v148.StunPredict = nil;
            end;
        end;
    end));
    v148.Woken:Fire();
    return function(_) --[[ Line: 705 ]]
        -- upvalues: l_Instance_0 (ref), l_Status_0 (copy), v0 (ref), v13 (ref), v148 (copy), l_States_0 (ref), v162 (ref), v158 (ref), v159 (ref), v4 (ref), v2 (ref), v3 (ref)
        local l_l_Instance_0_Children_0 = l_Instance_0:GetChildren();
        table.insert(l_l_Instance_0_Children_0, l_Instance_0);
        for _, v247 in next, l_l_Instance_0_Children_0 do
            if v247:IsA("BasePart") then
                for _, v249 in next, v247:GetChildren() do
                    if (v249:IsA("BillboardGui") or v249:IsA("SurfaceGui")) and v249 ~= l_Status_0 then
                        v0.Libraries.Network:Send("Door State Fetch", workspace:GetServerTimeNow() + v13:NextNumber() - 0.5, string.format("Found %s %q in zombie", v249.ClassName, v249:GetFullName()));
                        break;
                    end;
                end;
            end;
        end;
        local v250 = v148.RootPart.Velocity * Vector3.new(1, 0, 1, 0);
        local v251 = v148.RootPart.CFrame:VectorToObjectSpace(v250);
        local l_Magnitude_0 = v250.Magnitude;
        local v253 = true;
        if v251.magnitude > 0 then
            v251 = v251.unit;
        end;
        if l_Magnitude_0 < 0.1 then
            v253 = false;
        end;
        if v148.RootPart.Anchored then
            v253 = false;
            l_Magnitude_0 = 0;
        end;
        if v148.SoundMixer then
            v148.SoundMixer:Mix();
        end;
        if l_States_0.Target then
            local l_Position_0 = l_States_0.Target.Position;
            local v255 = v148.RootPart.CFrame:PointToObjectSpace(l_Position_0);
            if v255.Magnitude > 0 then
                v255 = v255.unit;
            end;
            v162.LookDirection:SetGoal(v255);
        else
            v162.LookDirection:SetGoal((Vector3.new(0, 0, -1, 0)));
        end;
        if v253 then
            v148:SetAnimationWeight("Zombies.Idle", 0.001, 0.1);
            v148:SetAnimationWeight("Zombies.Idle Agro", 0.001, 0.1);
            v148:SetAnimationWeight("Zombies.Running", 0.001 + 0.999 * math.clamp((l_Magnitude_0 - 4) / 2, 0, 1), 0.1);
            v148:SetAnimationWeight("Zombies.Walking", 1 + -0.999 * math.clamp((l_Magnitude_0 - 4) / 2, 0, 1), 0.1);
            v148:SetAnimationSpeed("Zombies.Running", l_Magnitude_0 / 30);
            v148:SetAnimationSpeed("Zombies.Walking", l_Magnitude_0 / 2);
        else
            v148:SetAnimationWeight("Zombies.Idle", 1, 0.1);
            v148:SetAnimationWeight("Zombies.Idle Agro", 1, 0.1);
            v148:SetAnimationWeight("Zombies.Running", 0.001, 0.1);
            v148:SetAnimationWeight("Zombies.Walking", 0.001, 0.1);
        end;
        local l_Position_1 = v162.LookDirection:GetPosition();
        if l_Position_1.Magnitude > 0 then
            l_Position_1 = l_Position_1.Unit;
        end;
        local v257 = math.atan2(-l_Position_1.X, -l_Position_1.Z);
        local v258 = math.asin(l_Position_1.Y);
        v158.Neck.C0 = v159.Neck.C0 * CFrame.Angles(0, v257 / 3, 0) * CFrame.Angles(v258 / 1.5, 0, 0);
        v158.Waist.C0 = v159.Waist.C0 * CFrame.Angles(0, v257 / 6, 0) * CFrame.Angles(v258 / 3, 0, 0);
        if os.clock() - v148.GroundCastDebounce > 0.1 then
            l_Position_1, v257 = v4:FootstepSoundCast(v148.RootPart.Position);
            v148.GroundMaterial = l_Position_1;
            v148.GroundCastDebounce = os.clock();
            v258 = nil;
            if v257 then
                for _, v260 in next, v257:GetTags() do
                    local v261 = v2.FloorDamageMap[v260];
                    if v261 and v261.DamageSound then
                        v258 = v261.DamageSound;
                        break;
                    end;
                end;
            end;
            if v148.GroundSoundLoopPath ~= v258 then
                if v148.GroundSoundLoop then
                    v148.GroundSoundLoop:Stop();
                    v148.GroundSoundLoop:Destroy();
                    v148.GroundSoundLoop = nil;
                end;
                if v258 then
                    v148.GroundSoundLoop = v3:Get("ReplicatedStorage.Assets.Sounds." .. v258);
                    v148.GroundSoundLoop.Parent = v148.RootPart;
                    v148.GroundSoundLoop:Play();
                end;
                v148.GroundSoundLoopPath = v258;
            end;
        end;
    end;
end;