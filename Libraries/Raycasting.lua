local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_Players_0 = game:GetService("Players");
local v3 = l_RunService_0:IsServer();
local v4 = nil;
v4 = if v3 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local _ = v4.require("Configs", "Globals");
local v6 = v4.require("Configs", "GroundData");
local v7 = v4.require("Libraries", "Resources");
local v8 = v7:Find("Workspace.Characters");
local v9 = v7:Find("Workspace.Zombies.Mobs");
local v10 = v7:Find("Workspace.Loot");
local v11 = v7:Find("Workspace.Map.Shared.LootBins");
local v12 = v7:Find("Workspace.Corpses");
local v13 = v7:Find("Workspace.Vehicles.Spawned");
local _ = v7:Find("Workspace.Map.Sea");
local v15 = {};
local v16 = {
    v7:Find("Workspace.Effects"), 
    v7:Find("Workspace.Sounds"), 
    v7:Find("Workspace.Locations"), 
    v7:Find("Workspace.Spawns")
};
local function v17(...) --[[ Line: 49 ]] --[[ Name: returnFalse ]]
    return false;
end;
local function v22(v18, v19, v20, ...) --[[ Line: 53 ]] --[[ Name: findAndDo ]]
    local l_v18_FirstChild_0 = v18:FindFirstChild(v19);
    if l_v18_FirstChild_0 then
        v20(l_v18_FirstChild_0, ...);
        return true;
    else
        return false;
    end;
end;
v15.Debug = function(_, v24, v25, v26) --[[ Line: 67 ]] --[[ Name: Debug ]]
    if not v26 then
        v26 = Instance.new("Part");
        v26.Anchored = true;
        v26.CanCollide = false;
    end;
    v26.Size = Vector3.new(0.3, 0.3, v24.Direction.Magnitude);
    v26.CFrame = CFrame.new(v24.Direction * 0.5, v24.Direction) + v24.Origin;
    v26.Color = v25 or v26.Color;
    if not v26.Parent then
        v26.Parent = workspace:WaitForChild("Effects");
    end;
    return v26;
end;
v15.DebugPoint = function(_, v28, v29, v30) --[[ Line: 85 ]] --[[ Name: DebugPoint ]]
    if not v30 then
        v30 = Instance.new("Part");
        v30.Anchored = true;
        v30.CanCollide = false;
        v30.Shape = Enum.PartType.Ball;
    end;
    v30.Size = Vector3.new(0.25, 0.25, 0.25, 0);
    v30.CFrame = CFrame.new(v28);
    v30.Color = v29 or v30.Color;
    if not v30.Parent then
        v30.Parent = workspace:WaitForChild("Effects");
    end;
    return v30;
end;
v15.CastWithWhiteList = function(_, v32, v33) --[[ Line: 105 ]] --[[ Name: CastWithWhiteList ]]
    local v34 = RaycastParams.new();
    v34.FilterDescendantsInstances = v33;
    v34.FilterType = Enum.RaycastFilterType.Whitelist;
    local v35 = workspace:Raycast(v32.Origin, v32.Direction, v34);
    if v35 then
        return v35.Instance, v35.Position, v35.Normal, v35.Material;
    else
        return nil, v32.Origin + v32.Direction, Vector3.new(0, 1, 0, 0), Enum.Material.Air;
    end;
end;
v15.CastWithIgnoreList = function(_, v37, v38, v39) --[[ Line: 123 ]] --[[ Name: CastWithIgnoreList ]]
    -- upvalues: v17 (copy), v16 (copy)
    local v40 = v39 or v17;
    local v41 = v38 or {};
    for _, v43 in next, v16 do
        table.insert(v41, v43);
    end;
    local v44 = RaycastParams.new();
    v44.FilterDescendantsInstances = v41;
    v44.FilterType = Enum.RaycastFilterType.Blacklist;
    local v45 = nil;
    repeat
        local v46 = false;
        v45 = workspace:Raycast(v37.Origin, v37.Direction, v44);
        if v45 then
            local v47, v48 = v40(v45.Instance, v45.Position, v45.Normal, v45.Material);
            if v47 then
                v44:AddToFilter(v48 or v45.Instance);
                v46 = true;
            end;
        end;
    until not v46;
    if v45 then
        return v45.Instance, v45.Position, v45.Normal, v45.Material;
    else
        return nil, v37.Origin + v37.Direction, Vector3.new(0, 1, 0, 0), Enum.Material.Air;
    end;
end;
v15.BlockCastWithIgnoreList = function(_, v50, v51, v52, v53, v54) --[[ Line: 169 ]] --[[ Name: BlockCastWithIgnoreList ]]
    -- upvalues: v16 (copy)
    local v55 = v53 or {};
    for _, v57 in next, v16 do
        table.insert(v55, v57);
    end;
    local v58 = RaycastParams.new();
    v58.FilterDescendantsInstances = v55;
    v58.FilterType = Enum.RaycastFilterType.Blacklist;
    local v59 = nil;
    repeat
        local v60 = false;
        v59 = workspace:Blockcast(v50, v52, v51, v58);
        if v59 and v54 then
            local v61, v62 = v54(v59.Instance, v59.Position, v59.Normal, v59.Material);
            if v61 then
                table.insert(v55, v62 or v59.Instance);
                v58.FilterDescendantsInstances = v55;
                v60 = true;
            end;
        end;
    until not v60;
    if v59 then
        return v59.Instance, v59.Position, v59.Normal, v59.Material;
    else
        return nil, v50.Position + v51, Vector3.new(0, 1, 0, 0), Enum.Material.Air;
    end;
end;
local v63 = {
    [Enum.Material.CorrodedMetal] = true, 
    [Enum.Material.DiamondPlate] = true, 
    [Enum.Material.Foil] = true, 
    [Enum.Material.Metal] = true
};
local l_v63_0 = v63 --[[ copy: 19 -> 22 ]];
v15.IsObjectMetal = function(_, v66) --[[ Line: 226 ]] --[[ Name: IsObjectMetal ]]
    -- upvalues: l_v63_0 (copy), l_CollectionService_0 (copy)
    if not v66 then
        return false;
    elseif l_v63_0[v66.Material] then
        return true;
    elseif l_CollectionService_0:HasTag(v66, "Vehicle Part") then
        return true;
    else
        return;
    end;
end;
v63 = {
    ["Step Sound Carpet"] = "Dirt", 
    ["Step Sound Concrete"] = "Concrete", 
    ["Step Sound Grass"] = "Dirt", 
    ["Step Sound Linoleum"] = "Concrete", 
    ["Step Sound Metal"] = "Metal", 
    ["Step Sound Sand"] = "Dirt", 
    ["Step Sound Water"] = "Water", 
    ["Step Sound Wood"] = "Wood", 
    ["Step Sound Gravel"] = "Dirt", 
    ["Step Sound Glass"] = "Concrete"
};
local v67 = {
    [Enum.Material.Plastic] = "Generic", 
    [Enum.Material.SmoothPlastic] = "Generic", 
    [Enum.Material.Air] = "Generic", 
    [Enum.Material.Concrete] = "Concrete", 
    [Enum.Material.Marble] = "Rock", 
    [Enum.Material.Granite] = "Rock", 
    [Enum.Material.Brick] = "Brick", 
    [Enum.Material.Pebble] = "Gravel", 
    [Enum.Material.Cobblestone] = "Rock", 
    [Enum.Material.Rock] = "Rock", 
    [Enum.Material.Sandstone] = "Rock", 
    [Enum.Material.Neon] = "Generic", 
    [Enum.Material.Glass] = "Generic", 
    [Enum.Material.Asphalt] = "Concrete", 
    [Enum.Material.Salt] = "Gravel", 
    [Enum.Material.Limestone] = "Rock", 
    [Enum.Material.Pavement] = "Concrete", 
    [Enum.Material.ForceField] = "Ice", 
    [Enum.Material.Wood] = "Wood", 
    [Enum.Material.Fabric] = "Generic", 
    [Enum.Material.WoodPlanks] = "Wood", 
    [Enum.Material.CorrodedMetal] = "Metal", 
    [Enum.Material.DiamondPlate] = "Metal", 
    [Enum.Material.Foil] = "Ice", 
    [Enum.Material.Metal] = "Metal", 
    [Enum.Material.Grass] = "Grass", 
    [Enum.Material.LeafyGrass] = "Grass", 
    [Enum.Material.Glacier] = "Dirt", 
    [Enum.Material.Basalt] = "Rock", 
    [Enum.Material.Ground] = "Dirt", 
    [Enum.Material.CrackedLava] = "Rock", 
    [Enum.Material.Mud] = "Dirt", 
    [Enum.Material.Slate] = "Rock", 
    [Enum.Material.Sand] = "Dirt", 
    [Enum.Material.Snow] = "Snow", 
    [Enum.Material.Ice] = "Ice", 
    [Enum.Material.Water] = "Water"
};
local l_v63_1 = v63 --[[ copy: 19 -> 23 ]];
local l_v67_0 = v67 --[[ copy: 20 -> 24 ]];
v15.GetImpactMaterial = function(_, v71) --[[ Line: 303 ]] --[[ Name: GetImpactMaterial ]]
    -- upvalues: l_CollectionService_0 (copy), l_v63_1 (copy), l_v67_0 (copy)
    if v71.Name == "Water" then
        return "Water";
    else
        for _, v73 in next, l_CollectionService_0:GetTags(v71) do
            if l_v63_1[v73] then
                return l_v63_1[v73];
            end;
        end;
        if l_v67_0[v71.Material] then
            return l_v67_0[v71.Material];
        else
            return "Dirt";
        end;
    end;
end;
v15.IsHitCharacter = function(_, v75) --[[ Line: 323 ]] --[[ Name: IsHitCharacter ]]
    -- upvalues: v8 (copy)
    if v75 and v75:IsA("Model") and v75.Parent == v8 then
        return v75;
    else
        if v75 and v75:IsDescendantOf(v8) then
            local l_v75_0 = v75;
            while l_v75_0.Parent do
                l_v75_0 = l_v75_0.Parent;
                if l_v75_0.Parent == v8 or l_v75_0 == game then
                    break;
                end;
            end;
            if l_v75_0.Parent and l_v75_0.Parent == v8 then
                return l_v75_0;
            end;
        end;
        return;
    end;
end;
v15.IsHitZombie = function(_, v78) --[[ Line: 348 ]] --[[ Name: IsHitZombie ]]
    -- upvalues: v9 (copy)
    if v78 and v78:IsA("Model") and v78.Parent == v9 then
        return v78;
    else
        if v78 and v78:IsDescendantOf(v9) then
            local l_v78_0 = v78;
            while l_v78_0.Parent do
                l_v78_0 = l_v78_0.Parent;
                if l_v78_0.Parent == v9 or l_v78_0 == game then
                    break;
                end;
            end;
            if l_v78_0.Parent and l_v78_0.Parent == v9 then
                return l_v78_0;
            end;
        end;
        return;
    end;
end;
v15.IsHitVehicle = function(_, v81) --[[ Line: 373 ]] --[[ Name: IsHitVehicle ]]
    -- upvalues: v13 (copy)
    if v81 and v81:IsA("Model") and v81.Parent == v13 then
        return v81;
    else
        if v81 and v81:IsDescendantOf(v13) then
            local l_v81_0 = v81;
            while l_v81_0.Parent do
                l_v81_0 = l_v81_0.Parent;
                if l_v81_0.Parent == v13 or l_v81_0 == game then
                    break;
                end;
            end;
            if l_v81_0.Parent and l_v81_0.Parent == v13 then
                return l_v81_0;
            end;
        end;
        return;
    end;
end;
v15.GetHitMaterialType = function(v83, v84) --[[ Line: 398 ]] --[[ Name: GetHitMaterialType ]]
    if v83:IsHitZombie(v84) or v83:IsHitCharacter(v84) then
        return "Flesh";
    elseif v83:IsObjectMetal(v84) then
        return "Metal";
    else
        return "Generic";
    end;
end;
v15.bulletCastLightFilter = function(v85, v86) --[[ Line: 411 ]] --[[ Name: bulletCastLightFilter ]]
    -- upvalues: l_CollectionService_0 (copy)
    if l_CollectionService_0:HasTag(v85, "Bullets Penetrate") then
        return true;
    elseif v86 and l_CollectionService_0:HasTag(v85, "Window Part") then
        return true;
    elseif l_CollectionService_0:HasTag(v85, "World Mesh") then
        return true;
    elseif v85.Transparency == 1 and v85.CanCollide == false then
        return true;
    else
        return false;
    end;
end;
v15.BulletCastLight = function(v87, v88, v89, v90) --[[ Line: 428 ]] --[[ Name: BulletCastLight ]]
    return v87:CastWithIgnoreList(v88, v90 or {}, function(v91) --[[ Line: 429 ]]
        -- upvalues: v87 (copy), v89 (copy)
        return v87.bulletCastLightFilter(v91, v89);
    end);
end;
v15.BulletCast = function(v92, v93, v94, v95) --[[ Line: 434 ]] --[[ Name: BulletCast ]]
    local v96, v97, v98 = v92:BulletCastLight(v93, v94, v95);
    if v96 then
        local v99 = v92:IsHitCharacter(v96) or v92:IsHitZombie();
        if v99 then
            local v100, v101, v102 = v92:CastWithWhiteList(v93, {
                v99:FindFirstChild("Head"), 
                v99:FindFirstChild("UpperTorso"), 
                v99:FindFirstChild("LowerTorso")
            });
            if v100 then
                v96 = v100;
                v97 = v101;
                v98 = v102;
            end;
        end;
    end;
    return v96, v97, v98;
end;
v15.LootNodeCast = function(v103, v104, v105) --[[ Line: 464 ]] --[[ Name: LootNodeCast ]]
    -- upvalues: v8 (copy), v9 (copy), v12 (copy), v10 (copy), l_CollectionService_0 (copy)
    local v106 = {
        v8, 
        v9, 
        v12
    };
    if v105 then
        table.insert(v106, v10);
    end;
    return v103:CastWithIgnoreList(v104, v106, function(v107) --[[ Line: 475 ]]
        -- upvalues: l_CollectionService_0 (ref)
        if l_CollectionService_0:HasTag(v107, "World Mesh") then
            return true;
        elseif l_CollectionService_0:HasTag(v107, "World Water Part") then
            return true;
        elseif v107.Transparency == 1 and v107.CanCollide == false then
            return true;
        else
            return;
        end;
    end);
end;
v15.InteractCast = function(v108, v109, v110) --[[ Line: 486 ]] --[[ Name: InteractCast ]]
    -- upvalues: v8 (copy), v9 (copy), l_CollectionService_0 (copy), v10 (copy)
    return v108:CastWithIgnoreList(v109, {
        v8, 
        v9
    }, function(v111) --[[ Line: 492 ]]
        -- upvalues: l_CollectionService_0 (ref), v110 (copy), v108 (copy), v109 (copy), v10 (ref)
        if l_CollectionService_0:HasTag(v111, "Interact Ignores") then
            return true;
        elseif l_CollectionService_0:HasTag(v111, "Vehicle Interact Ignore") then
            return true;
        elseif l_CollectionService_0:HasTag(v111, "World Mesh") then
            return true;
        elseif l_CollectionService_0:HasTag(v111, "World Water Part") then
            return true;
        elseif not v110 and l_CollectionService_0:HasTag(v111, "Loot Hitbox Part") and v108:CastWithWhiteList(v109, {
            v10
        }) then
            return true;
        else
            return;
        end;
    end);
end;
v15.DrinkCast = function(v112, v113) --[[ Line: 510 ]] --[[ Name: DrinkCast ]]
    -- upvalues: v8 (copy), v9 (copy), l_CollectionService_0 (copy)
    return v112:CastWithIgnoreList(v113, {
        v8, 
        v9
    }, function(v114) --[[ Line: 516 ]]
        -- upvalues: l_CollectionService_0 (ref)
        if l_CollectionService_0:HasTag(v114, "Interact Ignores") then
            return true;
        elseif l_CollectionService_0:HasTag(v114, "Vehicle Interact Ignore") then
            return true;
        elseif l_CollectionService_0:HasTag(v114, "World Mesh") then
            return true;
        elseif l_CollectionService_0:HasTag(v114, "Loot Hitbox Part") then
            return true;
        else
            return;
        end;
    end);
end;
v15.CameraCast = function(v115, v116, v117) --[[ Line: 529 ]] --[[ Name: CameraCast ]]
    -- upvalues: v8 (copy), v9 (copy), v12 (copy), l_CollectionService_0 (copy)
    local v118 = v117 or {};
    table.insert(v118, v8);
    table.insert(v118, v9);
    table.insert(v118, v12);
    return v115:CastWithIgnoreList(v116, v118, function(v119) --[[ Line: 536 ]]
        -- upvalues: l_CollectionService_0 (ref)
        if l_CollectionService_0:HasTag(v119, "World Mesh") then
            return true;
        elseif (v119.Transparency == 1 or v119.CanCollide == false) and v119.Name ~= "Sea Floor" then
            return true;
        else
            return;
        end;
    end);
end;
v15.LavaCheckCast = function(v120, v121) --[[ Line: 547 ]] --[[ Name: LavaCheckCast ]]
    -- upvalues: v8 (copy), v9 (copy), v12 (copy), v10 (copy), l_CollectionService_0 (copy)
    local v123, v124, v125 = v120:CastWithIgnoreList(Ray.new(v121 + Vector3.new(0, 1, 0, 0), (Vector3.new(-0, -7, -0, -0))), {
        v8, 
        v9, 
        v12, 
        v10
    }, function(v122) --[[ Line: 557 ]]
        -- upvalues: l_CollectionService_0 (ref)
        if v122.Transparency == 1 or v122.CanCollide == false then
            return true;
        elseif l_CollectionService_0:HasTag(v122, "World Mesh") then
            return true;
        elseif l_CollectionService_0:HasTag(v122, "World Water Part") then
            return true;
        else
            return;
        end;
    end);
    if v123 and v123.Name == "LavaPart" then
        return true, v123, v124, v125;
    else
        return false, nil, v124, v125;
    end;
end;
v15.CharacterPathCast = function(v126, v127) --[[ Line: 574 ]] --[[ Name: CharacterPathCast ]]
    -- upvalues: v13 (copy), v8 (copy), v9 (copy), v12 (copy), v10 (copy), l_CollectionService_0 (copy)
    return v126:CastWithIgnoreList(v127, {
        v13, 
        v8, 
        v9, 
        v12, 
        v10
    }, function(v128) --[[ Line: 583 ]]
        -- upvalues: l_CollectionService_0 (ref)
        if l_CollectionService_0:HasTag(v128, "World Mesh") then
            return true;
        elseif l_CollectionService_0:HasTag(v128, "World Water Part") then
            return true;
        elseif l_CollectionService_0:HasTag(v128, "Ladder Part") then
            return true;
        elseif l_CollectionService_0:HasTag(v128, "Interactable Part") then
            return true;
        elseif l_CollectionService_0:HasTag(v128, "Hitbox Part") then
            return true;
        elseif v128.Transparency == 1 or v128.CanCollide == false then
            return true;
        else
            return;
        end;
    end);
end;
v63 = {
    ["Hitbox Engine"] = true, 
    ["Hitbox Fuel"] = true
};
v67 = {
    Body = {}, 
    Internal = {}
};
local l_v67_1 = v67 --[[ copy: 20 -> 25 ]];
local l_v63_2 = v63 --[[ copy: 19 -> 26 ]];
v15.VehicleCollisionRay = function(_, v132, v133, v134) --[[ Line: 613 ]] --[[ Name: VehicleCollisionRay ]]
    -- upvalues: v15 (copy), l_v67_1 (copy), v22 (copy), l_v63_2 (copy)
    if typeof(v132) == "Instance" then
        v132 = {
            Instance = v132, 
            SeatedCharacters = {}
        };
    end;
    if not v15:CastWithWhiteList(v133, {
        v132.Instance
    }) then
        return l_v67_1;
    else
        local l_unit_0 = v133.Direction.unit;
        local l_Magnitude_0 = (v133.Origin - v134).Magnitude;
        local v137 = v133.Origin + l_unit_0 * l_Magnitude_0 - l_unit_0 * 10;
        local v138 = Ray.new(v137, l_unit_0 * (l_Magnitude_0 + 60));
        local v139 = {};
        local v140 = {};
        v22(v132.Instance, "Interaction", function(v141) --[[ Line: 636 ]]
            -- upvalues: l_v63_2 (ref), v139 (copy)
            for _, v143 in next, v141:GetChildren() do
                if l_v63_2[v143.Name] and not v143:HasTag("Bullets Penetrate") then
                    table.insert(v139, v143);
                end;
            end;
        end);
        v22(v132.Instance, "Wheels", function(v144) --[[ Line: 646 ]]
            -- upvalues: v139 (copy)
            for _, v146 in next, v144:GetChildren() do
                if v146.PrimaryPart and not v146.PrimaryPart:HasTag("Bullets Penetrate") then
                    table.insert(v139, v146.PrimaryPart);
                end;
            end;
        end);
        v22(v132.Instance, "Windows", function(v147) --[[ Line: 654 ]]
            -- upvalues: v139 (copy)
            for _, v149 in next, v147:GetChildren() do
                if v149.Transparency < 1 and not v149:HasTag("Bullets Penetrate") then
                    table.insert(v139, v149);
                end;
            end;
        end);
        for _, v151 in next, v132.SeatedCharacters do
            if v151.Character and v151.Character.Instance then
                table.insert(v139, v151.Character.Instance);
            end;
        end;
        v22(v132.Instance, "Collision", function(v152) --[[ Line: 668 ]]
            -- upvalues: v140 (copy)
            for _, v154 in next, v152:GetChildren() do
                if not v154:HasTag("Bullets Penetrate") then
                    table.insert(v140, v154);
                end;
            end;
        end);
        local v155, v156 = v15:CastWithWhiteList(v138, v140);
        local v157, v158 = v15:CastWithWhiteList(v138, v139);
        if (v138.Origin - v156).Magnitude > (v138.Origin - v158).Magnitude then
            v155 = nil;
        end;
        return {
            Body = {
                Hit = v155, 
                Pos = v156
            }, 
            Internal = {
                Hit = v157, 
                Pos = v158
            }
        };
    end;
end;
v67 = v4.require("Configs", "GroundData").FloorDamageMap;
local l_v67_2 = v67 --[[ copy: 20 -> 27 ]];
v15.CharacterGroundShapeCast = function(_, v161, v162, v163) --[[ Line: 707 ]] --[[ Name: CharacterGroundShapeCast ]]
    -- upvalues: v8 (copy), v9 (copy), v12 (copy), v10 (copy), v15 (copy), l_CollectionService_0 (copy), l_v67_2 (copy)
    local v164 = (v162 or 0) + 1;
    local v165 = v161.UpVector * -v164;
    local v166 = {
        v8, 
        v9, 
        v12, 
        v10
    };
    local v167 = RaycastParams.new();
    v167.FilterType = Enum.RaycastFilterType.Exclude;
    v167.FilterDescendantsInstances = v166;
    local v172, v173, v174 = v15:BlockCastWithIgnoreList(v161, v165, Vector3.new(1.850000023841858, 1.850000023841858, 0.8500000238418579, 0), v166, function(v168) --[[ Line: 731 ]]
        -- upvalues: l_CollectionService_0 (ref), l_v67_2 (ref)
        if l_CollectionService_0:HasTag(v168, "World Mesh") then
            return true;
        elseif l_CollectionService_0:HasTag(v168, "World Water Part") then
            return true;
        elseif v168.Transparency == 1 and v168.CanCollide == false then
            return true;
        else
            if v168.CanCollide == false then
                local v169 = false;
                for _, v171 in next, v168:GetTags() do
                    if l_v67_2[v171] then
                        v169 = true;
                        break;
                    end;
                end;
                if not v169 then
                    return true;
                end;
            end;
            return;
        end;
    end);
    if v163 then
        if (v161.Position - v173).Magnitude < v163 then
            return v172, v173, v174;
        end;
    elseif v172 then
        return v172, v173, v174;
    end;
end;
v67 = v4.require("Configs", "GroundData").FloorDamageMap;
local v175 = {
    Vector3.new(0, 1, 0, 0), 
    Vector3.new(1, 1, 0, 0), 
    Vector3.new(-1, 1, 0, 0), 
    Vector3.new(0, 1, 0.5, 0), 
    Vector3.new(0, 1, -0.5, 0), 
    Vector3.new(1, 1, 0.5, 0), 
    Vector3.new(1, 1, -0.5, 0), 
    Vector3.new(-1, 1, 0.5, 0), 
    (Vector3.new(-1, 1, -0.5, 0))
};
local l_v67_3 = v67 --[[ copy: 20 -> 28 ]];
v15.CharacterGroundCast = function(v177, v178, v179, v180) --[[ Line: 830 ]] --[[ Name: CharacterGroundCast ]]
    -- upvalues: v8 (copy), v9 (copy), v12 (copy), v10 (copy), v175 (copy), l_CollectionService_0 (copy), l_v67_3 (copy)
    v179 = (v179 or 0) + 1;
    local v181 = {
        v8, 
        v9, 
        v12, 
        v10
    };
    for v182 = 1, #v175 do
        debug.profilebegin("ground cast " .. v182);
        local v183 = v178 * v175[v182];
        local v188, v189, v190 = v177:CastWithIgnoreList(Ray.new(v183, Vector3.new(-0, -1, -0, -0) * v179), v181, function(v184) --[[ Line: 846 ]]
            -- upvalues: l_CollectionService_0 (ref), l_v67_3 (ref)
            if l_CollectionService_0:HasTag(v184, "World Mesh") then
                return true;
            elseif l_CollectionService_0:HasTag(v184, "World Water Part") then
                return true;
            elseif v184.Transparency == 1 and v184.CanCollide == false then
                return true;
            else
                if v184.CanCollide == false then
                    local v185 = false;
                    for _, v187 in next, v184:GetTags() do
                        if l_v67_3[v187] then
                            v185 = true;
                            break;
                        end;
                    end;
                    if not v185 then
                        return true;
                    end;
                end;
                return;
            end;
        end);
        debug.profileend();
        if v180 then
            if (v183 - v189).Magnitude < v180 then
                return v188, v189, v190;
            end;
        elseif v188 then
            return v188, v189, v190;
        end;
    end;
    return nil, v178 * Vector3.new(-0, -1, -0, -0) + Vector3.new(-0, -1, -0, -0) * v179, (Vector3.new(0, 1, 0, 0));
end;
v15.CharacterGroundSearch = function(v191, v192, v193, v194) --[[ Line: 886 ]] --[[ Name: CharacterGroundSearch ]]
    local v195, v196, v197 = v191:CharacterGroundShapeCast(v192, v193, v194);
    if not v195 then
        return v191:CharacterGroundCast(v192, v193, v194);
    else
        return v195, v196, v197;
    end;
end;
v63 = {
    Vector3.new(0, -1, 0, 0), 
    Vector3.new(0.5, -1, 0.5, 0), 
    Vector3.new(0.5, -1, -0.5, 0), 
    Vector3.new(-0.5, -1, 0.5, 0), 
    (Vector3.new(-0.5, -1, -0.5, 0))
};
local l_v63_3 = v63 --[[ copy: 19 -> 29 ]];
v15.ZombieGroundCast = function(v199, v200, v201) --[[ Line: 905 ]] --[[ Name: ZombieGroundCast ]]
    -- upvalues: v8 (copy), v9 (copy), v12 (copy), v10 (copy), l_v63_3 (copy), l_CollectionService_0 (copy)
    local v202 = {
        v8, 
        v9, 
        v12, 
        v10
    };
    for v203 = 1, #l_v63_3 do
        debug.profilebegin("ground cast " .. v203);
        local v204 = v200 * l_v63_3[v203];
        local v206, v207, v208 = v199:CastWithIgnoreList(Ray.new(v204, Vector3.new(-0, -1, -0, -0) * v201), v202, function(v205) --[[ Line: 919 ]]
            -- upvalues: l_CollectionService_0 (ref)
            if l_CollectionService_0:HasTag(v205, "World Mesh") then
                return true;
            elseif l_CollectionService_0:HasTag(v205, "World Water Part") then
                return true;
            elseif v205.Transparency == 1 and v205.CanCollide == false then
                return true;
            elseif v205.CanCollide == false then
                return true;
            else
                return;
            end;
        end);
        debug.profileend();
        if v206 then
            return v206, v207, v208;
        end;
    end;
    return nil, v200 * Vector3.new(-0, -1, -0, -0) + Vector3.new(-0, -1, -0, -0) * v201, (Vector3.new(0, 1, 0, 0));
end;
v63 = function(v209) --[[ Line: 942 ]] --[[ Name: ignoreCallback ]]
    -- upvalues: l_CollectionService_0 (copy)
    local v210 = v209.CanCollide == true;
    local v211 = v209.Transparency == 1;
    if l_CollectionService_0:HasTag(v209, "World Mesh") then
        return true;
    elseif v211 and not v210 then
        return true;
    else
        return;
    end;
end;
v67 = {
    v8, 
    v12, 
    v9, 
    v10, 
    v11, 
    workspace.Terrain, 
    v13
};
v15.LedgeIgnoreCallback = v63;
v15.LedgeIgnoreDefault = v67;
v15.LedgeFindCast = function(_, v213, v214, v215) --[[ Line: 966 ]] --[[ Name: LedgeFindCast ]]
    -- upvalues: v67 (copy), v15 (copy), v63 (copy), l_CollectionService_0 (copy)
    local v216 = v213 * (Vector3.new(0, 1, 0, 0) * v214.HeightSinkDepth);
    local l_LookVector_0 = v213.LookVector;
    local v218 = {
        unpack(v67)
    };
    local _ = {
        Part = nil, 
        Position = nil, 
        Normal = nil, 
        HasVaultSpace = false
    };
    local v220 = Ray.new(v216, Vector3.new(0, 1, 0, 0) * (v214.LedgeFindUpHeight + (v215.ExtraHeight or 0)));
    local v221, v222 = v15:CastWithIgnoreList(v220, v218, v63);
    if v221 then
        return nil;
    else
        local v223 = Ray.new(v222, l_LookVector_0 * 2 + Vector3.new(0, 0.004999999888241291, 0, 0));
        local _, v225 = v15:CastWithIgnoreList(v223, v218, v63);
        if (v225 - v222).Magnitude < 1.5 then
            return nil;
        else
            for v226 = 1, 5 do
                local v227 = 0.5 + math.max(0, v214.LedgeFindDepth - 0.5) * (v226 / 5);
                local v228 = Ray.new(v222, l_LookVector_0 * v227 + Vector3.new(0, 0.004999999888241291, 0, 0));
                local v229, v230 = v15:CastWithIgnoreList(v228, v218, v63);
                if v229 then
                    return;
                else
                    local v231 = Ray.new(v230, Vector3.new(0, 1, 0, 0) * -(v214.LedgeFindDownHeight + 0.005 + (v215.ExtraHeight or 0)));
                    local v232, v233, v234 = v15:CastWithIgnoreList(v231, v218, v63);
                    if v232 and not l_CollectionService_0:HasTag(v232, "Vault Blocked") then
                        return v232, v233, v234, v218;
                    end;
                end;
            end;
            return nil;
        end;
    end;
end;
v15.LedgeWalkSafeCast = function(_, v236, v237) --[[ Line: 1023 ]] --[[ Name: LedgeWalkSafeCast ]]
    -- upvalues: v15 (copy)
    local v238 = -v237.unit:Cross(v236.Normal):Cross(v236.Normal);
    local v239 = v236.Position + Vector3.new(0, 0.20000000298023224, 0, 0);
    local v240 = {
        unpack(v15.LedgeIgnoreDefault)
    };
    local v241 = Ray.new(v239, v238 * 1.5);
    local v242, v243 = v15:CastWithIgnoreList(v241, v240, v15.LedgeIgnoreCallback);
    if not v242 then
        local v244 = Ray.new(v243, (Vector3.new(0, -14, 0, 0)));
        if v15:CastWithIgnoreList(v244, v240, v15.LedgeIgnoreCallback) then
            return true;
        end;
    end;
    return false;
end;
v15.FindFootstepCorrection = function(_, v246) --[[ Line: 1044 ]] --[[ Name: FindFootstepCorrection ]]
    -- upvalues: l_CollectionService_0 (copy), v6 (copy)
    local v247 = v246 and l_CollectionService_0:GetTags(v246);
    if v247 then
        for _, v249 in next, v247 do
            local v250 = v6.TagsToSounds[v249];
            if v250 then
                return v250;
            end;
        end;
    end;
    return nil;
end;
v15.GetGroundMaterial = function(v251, v252, v253) --[[ Line: 1060 ]] --[[ Name: GetGroundMaterial ]]
    -- upvalues: v6 (copy)
    local v254 = v253 or v252.Material;
    local v255 = v6.MaterialsToSounds[v254] or "Sand";
    local l_v251_FootstepCorrection_0 = v251:FindFootstepCorrection(v252);
    if l_v251_FootstepCorrection_0 then
        v255 = l_v251_FootstepCorrection_0;
    end;
    if v252 and (v252.Name == "Water" or v252.Name == "Sea Floor" or v252.Name == "Lake Floor") then
        v255 = "Water";
    end;
    return v255, v252;
end;
v15.FootstepSoundCast = function(v257, v258) --[[ Line: 1076 ]] --[[ Name: FootstepSoundCast ]]
    -- upvalues: v8 (copy), v9 (copy), v12 (copy), v10 (copy)
    local v260, _, _, v263 = v257:CastWithIgnoreList(Ray.new(v258 + Vector3.new(0, 2, 0, 0), (Vector3.new(-0, -6, -0, -0))), {
        v8, 
        v9, 
        v12, 
        v10
    }, function(v259) --[[ Line: 1089 ]]
        if v259.CanCollide == false and v259.Transparency == 1 then
            return true;
        else
            return;
        end;
    end);
    return v257:GetGroundMaterial(v260, v263);
end;
v15.BinocularsCast = function(v264, v265) --[[ Line: 1098 ]] --[[ Name: BinocularsCast ]]
    -- upvalues: l_Players_0 (copy), v4 (ref)
    local v266 = l_Players_0.LocalPlayer and l_Players_0.LocalPlayer.Character;
    local v267, _ = v264:BulletCastLight(Ray.new(v265.Origin, v265.Direction * 1500), true, {
        v266
    });
    local v269 = v264:IsHitCharacter(v267);
    if v269 then
        for _, v271 in next, l_Players_0:GetPlayers() do
            if v271.Character == v269 then
                return v271.Name;
            end;
        end;
    end;
    local v272 = v264:IsHitZombie(v267);
    if v272 then
        local v273 = v4.Libraries.ZombieConfigs:Get(v272.Name);
        if v273 and v273.DisplayName then
            return v273.DisplayName;
        else
            return v272.Name;
        end;
    else
        return nil;
    end;
end;
v15.RangefinderCast = function(v274, v275) --[[ Line: 1129 ]] --[[ Name: RangefinderCast ]]
    -- upvalues: l_Players_0 (copy)
    local v276 = l_Players_0.LocalPlayer and l_Players_0.LocalPlayer.Character;
    local v277, v278 = v274:BulletCastLight(Ray.new(v275.Origin, v275.Direction * 1500), true, {
        v276
    });
    if v277 then
        return string.format("%d studs", (v275.Origin - v278).Magnitude);
    else
        return "too far";
    end;
end;
return v15;