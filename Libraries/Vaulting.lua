local l_RunService_0 = game:GetService("RunService");
local v1 = l_RunService_0:IsServer();
local _ = nil;
local v3 = (if v1 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework)).require("Libraries", "Raycasting");
local l_CollectionService_0 = game:GetService("CollectionService");
local v44 = {
    Configs = {
        Character = {
            HeightSinkDepth = -0.5, 
            MaxSideShift = 1, 
            LedgeMaxAngle = 0.8571673007021123, 
            LedgeFindUpHeight = 2.75, 
            LedgeFindDownHeight = 3.25, 
            LedgeFindDepth = 0.7, 
            SpaceFindDepth = 0.75, 
            SpaceFindHeight = 4.6, 
            SpaceFindWidth = 3.25, 
            SpaceFindSidePadding = 0.5, 
            LowPhysicsAnimationTime = 0.45, 
            LowVerticalAnimationModifier = 1.5, 
            LowHorizontalAnimationModifier = 3, 
            HighPhysicsAnimationTime = 0.7, 
            HighVerticalAnimationModifier = 1.1, 
            HighHorizontalAnimationModifier = 3, 
            LowHeightCuttoff = 3.25, 
            FallingLowHeightCutoff = 1, 
            VaultPaddingTime = 0.015, 
            PhysicsInsetDistance = 0.5, 
            PostVaultMoveImpulseTime = 0.15, 
            PostVaultMoveImpulseStrength = 2
        }, 
        Zombie = {
            HeightSinkDepth = -0.5, 
            MaxSideShift = 1, 
            LedgeMaxAngle = 0.8571673007021123, 
            LedgeFindUpHeight = 2.75, 
            LedgeFindDownHeight = 3.25, 
            LedgeFindDepth = 1, 
            SpaceFindDepth = 0.75, 
            SpaceFindHeight = 4.6, 
            SpaceFindWidth = 3.25, 
            SpaceFindSidePadding = 0.5, 
            LowPhysicsAnimationTime = 0.921, 
            LowVerticalAnimationModifier = 1.3, 
            LowHorizontalAnimationModifier = 3, 
            HighPhysicsAnimationTime = 0.7, 
            HighVerticalAnimationModifier = 1.1, 
            HighHorizontalAnimationModifier = 3, 
            LowHeightCuttoff = 3.25, 
            FallingLowHeightCutoff = 1, 
            VaultPaddingTime = 0.015, 
            PhysicsInsetDistance = 0.5, 
            PostVaultMoveImpulseTime = 0.15, 
            PostVaultMoveImpulseStrength = 2, 
            ZombieVaultOverrideTags = true
        }
    }, 
    GetVaultSequence = function(_, v6, v7, v8, v9, v10, v11) --[[ Line: 91 ]] --[[ Name: GetVaultSequence ]]
        -- upvalues: l_RunService_0 (copy)
        local l_Unit_0 = ((v9.Position - v6.Position) * Vector3.new(1, 0, 1, 0)).Unit;
        local v13 = CFrame.new(Vector3.new(0, 0, 0, 0), l_Unit_0) + v6.Position;
        local l_LowPhysicsAnimationTime_0 = v8.LowPhysicsAnimationTime;
        local l_LowVerticalAnimationModifier_0 = v8.LowVerticalAnimationModifier;
        local l_LowHorizontalAnimationModifier_0 = v8.LowHorizontalAnimationModifier;
        if v10 then
            l_LowPhysicsAnimationTime_0 = v8.HighPhysicsAnimationTime;
            l_LowVerticalAnimationModifier_0 = v8.HighVerticalAnimationModifier;
            l_LowHorizontalAnimationModifier_0 = v8.HighHorizontalAnimationModifier;
        end;
        local v17 = v13:PointToObjectSpace(v9.Position + Vector3.new(0, 1, 0, 0) * v7 + l_Unit_0 * v8.PhysicsInsetDistance);
        l_LowPhysicsAnimationTime_0 = l_LowPhysicsAnimationTime_0 * (v11 or 1);
        return v13, function(v18) --[[ Line: 112 ]]
            -- upvalues: l_LowPhysicsAnimationTime_0 (ref), v17 (copy), l_LowVerticalAnimationModifier_0 (ref), l_LowHorizontalAnimationModifier_0 (ref), v13 (copy), l_RunService_0 (ref)
            local v19 = os.clock();
            repeat
                local v20 = math.clamp((os.clock() - v19) / l_LowPhysicsAnimationTime_0, 0, 1);
                local v21 = v17 * Vector3.new(0, 1, 0, 0) * v20 ^ l_LowVerticalAnimationModifier_0;
                local v22 = v17 * Vector3.new(1, 0, 1, 0) * v20 ^ l_LowHorizontalAnimationModifier_0;
                local v23 = CFrame.new(v21 + v22);
                v18(v13, v23, v20);
                if v20 < 1 then
                    l_RunService_0.Stepped:Wait();
                end;
            until v20 >= 1;
        end;
    end, 
    FindVaultSpace = function(_, v25, v26, v27, v28) --[[ Line: 132 ]] --[[ Name: FindVaultSpace ]]
        -- upvalues: v3 (copy)
        local v29 = Ray.new(v26.Position, Vector3.new(0, 1, 0, 0) * v27.SpaceFindHeight);
        local _, v31, _ = v3:CastWithIgnoreList(v29, v28, v3.LedgeIgnoreCallback);
        local l_Magnitude_0 = (v26.Position - v31).Magnitude;
        if v27.SpaceFindHeight - l_Magnitude_0 < 0.025 then
            local l_RightVector_0 = v25.RightVector;
            local v35 = Vector3.new(0, 1, 0, 0) * v27.SpaceFindHeight;
            local v36 = v26.Position + v35 * 0.5;
            local v37 = Ray.new(v36, -l_RightVector_0 * v27.SpaceFindWidth * 0.5);
            local _, v39 = v3:CastWithIgnoreList(v37, v28, v3.LedgeIgnoreCallback);
            if v37.Direction.Magnitude - (v39 - v36).Magnitude < v27.SpaceFindSidePadding then
                local v40 = Ray.new(v39, l_RightVector_0 * v27.SpaceFindWidth);
                local _, v42 = v3:CastWithIgnoreList(v40, v28, v3.LedgeIgnoreCallback);
                if (v42 - v39).Magnitude >= v27.SpaceFindWidth then
                    local v43 = (v42 + v39) * 0.5 * Vector3.new(1, 0, 1, 0);
                    v26.Position = Vector3.new(0, 1, 0, 0) * v26.Position + v43;
                    return true;
                end;
            end;
        end;
        return false;
    end
};
v44.GetLedgeInfo = function(_, v46, v47, v48, v49, v50) --[[ Line: 175 ]] --[[ Name: GetLedgeInfo ]]
    -- upvalues: v3 (copy), l_CollectionService_0 (copy), v44 (copy)
    local v51, v52, v53, v54 = v3:LedgeFindCast(v46.CFrame, v48, v50);
    local v55 = v46.CFrame * (Vector3.new(0, 1, 0, 0) * -v47);
    if v51 then
        local v56 = v53.Y > v48.LedgeMaxAngle;
        local v57 = v52.Y - v55.Y;
        local v58 = l_CollectionService_0:HasTag(v51, "Vault Override");
        local v59 = l_CollectionService_0:HasTag(v51, "Vault Blocked");
        local v60 = l_CollectionService_0:HasTag(v51, "Zombie Vault Override");
        local _ = l_CollectionService_0:HasTag(v51, "Zombie Vault Blocked");
        if not v56 and (v58 or v60) then
            v56 = true;
        end;
        if v56 and v59 and not v60 then
            v56 = false;
        end;
        if v56 and v57 > 1.51 then
            local v62 = {
                Part = v51, 
                Normal = v53, 
                Position = v52
            };
            if v44:FindVaultSpace(v46.CFrame, v62, v48, v54) then
                local l_LowHeightCuttoff_0 = v48.LowHeightCuttoff;
                if v49 then
                    l_LowHeightCuttoff_0 = v48.FallingLowHeightCutoff;
                end;
                return true, v62, l_LowHeightCuttoff_0 <= v57;
            end;
        end;
    end;
end;
return v44;