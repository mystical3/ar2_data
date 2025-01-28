local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "ItemData");
local v2 = v0.require("Configs", "Globals");
local v3 = v0.require("Libraries", "Network");
local v4 = v0.require("Libraries", "Resources");
local v5 = v0.require("Libraries", "GunBuilder");
local v6 = v0.require("Libraries", "UserSettings");
local v7 = v0.require("Libraries", "Raycasting");
local v8 = v0.require("Libraries", "DustEffects");
local v9 = v0.require("Classes", "Signals");
local v10 = v0.require("Classes", "Steppers");
local v11 = v0.require("Classes", "Maids");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Lighting_0 = game:GetService("Lighting");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ReplicatedFirst_0 = game:GetService("ReplicatedFirst");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v19 = {};
local v20 = {};
local _ = {};
local v22 = {};
local v23 = {};
local v24 = {};
local v25 = {};
local v26 = v4:Find("ReplicatedStorage.Chunking.Terrain Chunks");
local v27 = v4:Find("ReplicatedStorage.Chunking.Model Cache");
local v28 = v4:Find("ReplicatedStorage.Chunking.Chunk Data");
local v29 = v4:Find("ReplicatedStorage.Assets.LootModels");
local v30 = v4:Find("ReplicatedStorage.Chunking.Terrain Models");
local l_Folder_0 = Instance.new("Folder");
l_Folder_0.Name = "Detail Packs";
l_Folder_0.Parent = v4:Find("ReplicatedStorage.Chunking");
local v32 = v4:Find("Workspace.Map.Sea");
local v33 = v4:Find("Workspace.Map.Shared");
local v34 = v4:Find("Workspace.Map.Client.Elements");
local v35 = v4:Find("Workspace.Map.Client.TerrainElements");
local v36 = v4:Find("Workspace.Map.Shared.Interactables");
local v37 = v4:Find("Workspace.Zombies.Mobs");
local v38 = v4:Find("Workspace.Characters");
local v39 = v4:Find("Workspace.Loot");
local v40 = v4:Find("ReplicatedStorage.Client.Abstracts.Interaction");
local v41 = {};
local v42 = false;
local v43 = false;
local v44 = {};
local v45 = Random.new();
for v46, v47 in next, v2.DefaultWorldChunkingDistances do
    v44[v46] = v47;
end;
local function _(v48, v49, v50) --[[ Line: 87 ]] --[[ Name: lerp ]]
    return v48 + (v49 - v48) * v50;
end;
local function _(v52, v53, v54, v55, v56) --[[ Line: 91 ]] --[[ Name: remapClamped ]]
    return v55 + (v56 - v55) * math.clamp((v52 - v53) / (v54 - v53), 0, 1);
end;
local function _(v58, v59, v60, v61, v62) --[[ Line: 95 ]] --[[ Name: remap ]]
    return v61 + (v62 - v61) * ((v58 - v59) / (v60 - v59));
end;
local function _(v64) --[[ Line: 99 ]] --[[ Name: newYielder ]]
    local v65 = os.clock();
    return function() --[[ Line: 102 ]]
        -- upvalues: v65 (ref), v64 (copy)
        if os.clock() - v65 >= v64 then
            task.wait();
            v65 = os.clock();
        end;
    end;
end;
local function v69(v67, v68) --[[ Line: 111 ]] --[[ Name: yieldedDestroy ]]
    v67:Destroy();
    v68();
end;
local function v75(v70, v71) --[[ Line: 116 ]] --[[ Name: setModelTransparency ]]
    local v72 = v71 or 0;
    for _, v74 in next, v70:GetDescendants() do
        if v74:IsA("BasePart") or v74:IsA("Decal") then
            v74.LocalTransparencyModifier = v72;
        end;
    end;
end;
local function _(v76, v77) --[[ Line: 126 ]] --[[ Name: positionToChunk ]]
    -- upvalues: v2 (copy)
    local v78 = v76 - v2.MapLeftTopCorner;
    local v79 = v77 or v2.MapChunkSize;
    return math.floor(v78.X / v79), (math.floor(v78.Z / v79));
end;
local function v94(v81, v82, v83) --[[ Line: 136 ]] --[[ Name: getNearChunkNames ]]
    -- upvalues: v2 (copy)
    local v84 = v81 - v2.MapLeftTopCorner;
    local v85 = v83 or v2.MapChunkSize;
    local v86 = math.floor(v84.X / v85);
    local v87 = math.floor(v84.Z / v85);
    local l_v86_0 = v86;
    local l_v87_0 = v87;
    v84 = {};
    for v90 = -v82, v82 do
        for v91 = -v82, v82 do
            local v92 = l_v86_0 + v90;
            local v93 = l_v87_0 + v91;
            v84[(v92 < 10 and "0" .. v92 or tostring(v92)) .. "_" .. (v93 < 10 and "0" .. v93 or tostring(v93))] = true;
        end;
    end;
    return v84;
end;
local function v101(v95, v96) --[[ Line: 155 ]] --[[ Name: diffChunks ]]
    local v97 = {};
    local v98 = {};
    for v99 in next, v95 do
        if not v96[v99] then
            table.insert(v97, v99);
        end;
    end;
    for v100 in next, v96 do
        if not v95[v100] then
            table.insert(v98, v100);
        end;
    end;
    return v97, v98;
end;
local function v106(v102, ...) --[[ Line: 174 ]] --[[ Name: cleanModel ]]
    for _, v104 in next, {
        ...
    } do
        local l_v102_FirstChild_0 = v102:FindFirstChild(v104);
        if l_v102_FirstChild_0 then
            l_v102_FirstChild_0:Destroy();
        end;
    end;
end;
local _ = function(v107, v108) --[[ Line: 184 ]] --[[ Name: buildDetail ]]
    -- upvalues: l_Folder_0 (copy)
    local l_l_Folder_0_FirstChild_0 = l_Folder_0:FindFirstChild(v107.Name);
    if l_l_Folder_0_FirstChild_0 and #l_l_Folder_0_FirstChild_0:GetChildren() > 0 then
        local l_Model_0 = Instance.new("Model");
        l_Model_0.Name = "Detail";
        l_Model_0.Parent = v107;
        for _, v112 in next, l_l_Folder_0_FirstChild_0:GetChildren() do
            local v113 = v112:Clone();
            v113:PivotTo(v107.PrimaryPart.CFrame);
            v113.Parent = l_Model_0;
            v108();
        end;
    end;
end;
local _ = function(v115, v116, v117, v118) --[[ Line: 206 ]] --[[ Name: loadDetail ]]
    local l_Model_1 = Instance.new("Model");
    l_Model_1.Name = v115.Name;
    l_Model_1.Parent = v117;
    for _, v121 in next, v115:GetChildren() do
        local v122 = v121:Clone();
        v122:PivotTo(v116);
        v122.Parent = l_Model_1;
        v118();
    end;
    return l_Model_1;
end;
local _ = function(v124, v125) --[[ Line: 222 ]] --[[ Name: cleanModelDetail ]]
    local l_Detail_0 = v124:FindFirstChild("Detail");
    if l_Detail_0 then
        for _, v128 in next, l_Detail_0:GetChildren() do
            v128:Destroy();
            v125();
        end;
    end;
end;
local function v134(v130, v131) --[[ Line: 234 ]] --[[ Name: unloadDetail ]]
    for _, v133 in next, v130:GetChildren() do
        v133:Destroy();
        v131();
    end;
end;
local function v143(v135, v136, v137) --[[ Line: 243 ]] --[[ Name: createInteractable ]]
    -- upvalues: v40 (copy), l_CollectionService_0 (copy)
    local l_Name_0 = v136.Parent.Name;
    local l_v40_FirstChild_0 = v40:FindFirstChild(l_Name_0);
    if l_v40_FirstChild_0 then
        local v140 = require(l_v40_FirstChild_0).new(v135, v136, v137);
        for _, v142 in next, v136:GetDescendants() do
            l_CollectionService_0:AddTag(v142, "Interactable " .. v135);
        end;
        return v140;
    else
        return;
    end;
end;
local function v147(v144) --[[ Line: 262 ]] --[[ Name: destroyInteractable ]]
    -- upvalues: l_CollectionService_0 (copy)
    for _, v146 in next, l_CollectionService_0:GetTagged("Interactable " .. v144.Id) do
        l_CollectionService_0:RemoveTag(v146, "Interactable " .. v144.Id);
    end;
    v144:Destroy();
end;
local function _(v148, v149, v150) --[[ Line: 270 ]] --[[ Name: getLightState ]]
    if v148 and v149 then
        return v150 == "On";
    else
        return false;
    end;
end;
local function v160(v152, v153, v154) --[[ Line: 278 ]] --[[ Name: setStreetLight ]]
    for _, v156 in next, v153 do
        v156.Enabled = v152;
    end;
    for _, v158 in next, v154 do
        local v159 = nil;
        v159 = if v152 then v158:FindFirstChild("ColorOn") else v158:FindFirstChild("ColorOff");
        if v159 then
            v158.Color = v159.Value;
        end;
        if v152 then
            v158.Material = Enum.Material.Neon;
        else
            v158.Material = Enum.Material.Glass;
        end;
    end;
end;
local function v196(v161, v162) --[[ Line: 304 ]] --[[ Name: connectStreetLight ]]
    -- upvalues: v33 (copy), v11 (copy), l_RunService_0 (copy), v45 (copy), v160 (copy)
    local l_FirstChild_0 = v33.Powered.Lights:FindFirstChild(v162);
    local v164 = nil;
    if l_FirstChild_0 then
        for _, v166 in next, l_FirstChild_0:GetChildren() do
            if v166.Name == v161.Name then
                local v167 = v166:GetAttribute("Position") or Vector3.new();
                if (v161.PrimaryPart.Position - v167).Magnitude < 0.1 then
                    v164 = v166;
                    break;
                end;
            end;
        end;
    end;
    if v164 then
        local v168 = v164:GetAttribute("Region") or "";
        local l_FirstChild_1 = v33.Powered.Regions:FindFirstChild(v168);
        if l_FirstChild_1 then
            local v170 = v11.new();
            local v171 = 0;
            local v172 = true;
            local v173 = false;
            local v174 = {};
            local v175 = {};
            for _, v177 in next, v161:GetDescendants() do
                if v177:IsA("Light") or v177:IsA("Beam") then
                    table.insert(v174, v177);
                elseif v177:IsA("BasePart") and v177:FindFirstChild("ColorOn") then
                    table.insert(v175, v177);
                end;
            end;
            do
                local l_v170_0, l_v171_0, l_v172_0, l_v173_0, l_v174_0, l_v175_0 = v170, v171, v172, v173, v174, v175;
                l_v170_0:Give(l_RunService_0.Heartbeat:Connect(function() --[[ Line: 390 ]]
                    -- upvalues: l_v171_0 (ref), l_FirstChild_1 (copy), v164 (ref), l_v172_0 (ref), v45 (ref), v160 (ref), l_v174_0 (ref), l_v175_0 (ref), l_v173_0 (ref)
                    local v184 = os.clock();
                    if l_v171_0 < v184 then
                        local v185 = l_FirstChild_1:GetAttribute("LightsOn") or false;
                        local v186 = l_FirstChild_1:GetAttribute("Powered") or false;
                        local v187 = v164:GetAttribute("State") or "Off";
                        local v188 = l_FirstChild_1:GetAttribute("Flickering") or false;
                        if v186 and v188 then
                            if l_v172_0 then
                                local v189 = v45:NextNumber();
                                local v190 = 0;
                                if v189 > 0.8 then
                                    v190 = v45:NextNumber(1, 3);
                                elseif v189 > 0.5 then
                                    v190 = v45:NextNumber(0.15, 0.3);
                                end;
                                l_v171_0 = v184 + v190;
                                l_v172_0 = false;
                                v160(false, l_v174_0, l_v175_0);
                                return;
                            else
                                local v191 = v45:NextNumber();
                                local _ = 0;
                                l_v171_0 = v184 + if v191 > 0.8 then v45:NextNumber(0.15, 0.3) else v45:NextNumber(20, 120);
                                l_v172_0 = true;
                                v160(true, l_v174_0, l_v175_0);
                                return;
                            end;
                        else
                            local v193 = false;
                            if v186 and v185 then
                                v193 = v187 == "On";
                            end;
                            if l_v173_0 ~= v193 then
                                v160(v193, l_v174_0, l_v175_0);
                                l_v173_0 = v193;
                            end;
                            l_v171_0 = v184 + 1;
                        end;
                    end;
                end));
                l_v170_0:Give(function() --[[ Line: 457 ]]
                    -- upvalues: l_v174_0 (ref), l_v175_0 (ref)
                    l_v174_0 = nil;
                    l_v175_0 = nil;
                end);
                v160(false, l_v174_0, l_v175_0);
                l_v170_0:Give(v161.AncestryChanged:Connect(function(_, _) --[[ Line: 476 ]]
                    -- upvalues: v161 (copy), l_v170_0 (ref)
                    if not v161:IsDescendantOf(game) then
                        l_v170_0:Destroy();
                        l_v170_0 = nil;
                    end;
                end));
            end;
        end;
    end;
end;
local function v203(v197, v198) --[[ Line: 486 ]] --[[ Name: autoGroupIntoModels ]]
    local v199 = 0;
    local v200 = nil;
    for _, v202 in next, v197:GetChildren() do
        if not v202:IsA("Model") then
            if not v200 then
                v200 = Instance.new("Model");
                v200.Name = "Auto Detail Model";
                v200.Parent = v197;
                v199 = v198;
            end;
            v202.Parent = v200;
            v199 = v199 - 1;
            if v199 <= 0 then
                v200 = nil;
            end;
        end;
    end;
end;
local function v204(v205, v206, v207) --[[ Line: 510 ]] --[[ Name: softParentElement ]]
    -- upvalues: v204 (copy)
    local l_PrimaryPart_0 = v205.PrimaryPart;
    local v209 = {};
    for v210, v211 in next, v205:GetChildren() do
        v209[v210] = {
            Instance = v211
        };
        if v211:IsA("Model") then
            v209[v210].PrimaryPart = v211.PrimaryPart;
        end;
        v211.Parent = nil;
    end;
    local function _(v212, v213) --[[ Line: 526 ]] --[[ Name: softParent ]]
        -- upvalues: v207 (copy)
        v212.Parent = v213;
        v207();
    end;
    v205.Parent = v206;
    for _, v216 in next, v209 do
        if v216.Instance.Name == "Interactables" then
            v204(v216.Instance, v205, v207);
        else
            v216.Instance.Parent = v205;
            v207();
            if v216.PrimaryPart then
                v216.Instance.PrimaryPart = v216.PrimaryPart;
            end;
        end;
    end;
    v205.PrimaryPart = l_PrimaryPart_0;
    return v205;
end;
local function v227(v217) --[[ Line: 551 ]] --[[ Name: getElementDataForChunks ]]
    -- upvalues: v20 (copy)
    local v218 = {};
    local v219 = {};
    for _, v221 in next, v217 do
        local v222 = v20[v221];
        if v222 then
            for _, v224 in next, v222.Elements do
                if not v218[v224.Name] then
                    v218[v224.Name] = {};
                end;
                table.insert(v218[v224.Name], {
                    CFrame = v224.Value, 
                    Chunk = v221
                });
            end;
        end;
    end;
    for v225, _ in next, v218 do
        table.insert(v219, v225);
    end;
    return v218, v219;
end;
local function _(v228) --[[ Line: 579 ]] --[[ Name: isReplicatedAsset ]]
    -- upvalues: v27 (copy)
    if v27:FindFirstChild(v228) then
        return true;
    else
        return false;
    end;
end;
local _ = function(v230, v231, v232) --[[ Line: 587 ]] --[[ Name: getStreamingList ]]
    -- upvalues: v27 (copy)
    local v233 = {};
    local v234 = {};
    for _, v236 in next, v231 do
        if not (v27:FindFirstChild(v236) and true or false) then
            table.insert(v233, v236);
        end;
    end;
    for _, v238 in next, v232 do
        v238 = v238 .. " Detail";
        if not (v27:FindFirstChild(v238) and true or false) then
            table.insert(v233, v238);
        end;
    end;
    for v239, _ in next, v230 do
        if not table.find(v233, v239) then
            table.insert(v234, v239);
        end;
    end;
    return v233, v234;
end;
local function v258(v242, v243, v244, v245, v246) --[[ Line: 614 ]] --[[ Name: configureInteractables ]]
    -- upvalues: v22 (copy), v143 (copy)
    for _, v248 in next, v242:GetChildren() do
        for _, v250 in next, v248:GetChildren() do
            local l_p_0 = v250.PrimaryPart.CFrame.p;
            local v252 = nil;
            local v253 = 1e999;
            for _, v255 in next, v243:GetChildren() do
                if v255.Name == v250.Name then
                    local l_Magnitude_0 = (l_p_0 - v255:GetAttribute("Position")).Magnitude;
                    if l_Magnitude_0 < v253 then
                        v252 = v255;
                        v253 = l_Magnitude_0;
                        if l_Magnitude_0 < 0.01 then
                            break;
                        end;
                    end;
                end;
                v246();
            end;
            if v252 then
                local l_v252_Attribute_0 = v252:GetAttribute("Id");
                if not v245[v244.Chunk] then
                    v245[v244.Chunk] = {};
                end;
                v22[l_v252_Attribute_0] = v143(l_v252_Attribute_0, v250, v252);
                if v22[l_v252_Attribute_0] then
                    v245[v244.Chunk][l_v252_Attribute_0] = v22[l_v252_Attribute_0];
                end;
                v246();
            end;
        end;
    end;
end;
local function v268(v259, v260) --[[ Line: 660 ]] --[[ Name: prepareTerrainChunks ]]
    -- upvalues: v26 (ref), v19 (copy)
    local l_v26_Children_0 = v26:GetChildren();
    local v262 = #l_v26_Children_0;
    for v263 = 1, v262 do
        v260("Terrain", string.format("%d, %d", v263, v262));
        local v264 = l_v26_Children_0[v263];
        local v265 = {
            Name = v264.Name, 
            Objects = {}
        };
        for _, v267 in next, v264:GetChildren() do
            table.insert(v265.Objects, v267);
            v267.Parent = nil;
            v259();
        end;
        v264.Parent = nil;
        v19[v265.Name] = v265;
    end;
    v26:Destroy();
    v26 = nil;
end;
local v269 = nil;
local v270 = {};
do
    local l_v270_0 = v270;
    v269 = function(v272, v273) --[[ Line: 691 ]] --[[ Name: setTerrainChunks ]]
        -- upvalues: v94 (copy), v44 (copy), l_v270_0 (ref), v19 (copy), v34 (copy)
        local v274 = v94(v272, v44.Terrain);
        for v275, _ in next, l_v270_0 do
            if not v274[v275] and v19[v275] then
                for _, v278 in next, v19[v275].Objects do
                    v278.Parent = nil;
                    v273();
                end;
                v273();
            end;
        end;
        for v279 in next, v274 do
            if not l_v270_0[v279] and v19[v279] then
                v273();
                for _, v281 in next, v19[v279].Objects do
                    v281.Parent = v34;
                    v273();
                end;
            end;
        end;
        l_v270_0 = v274;
    end;
end;
v270 = function(v282) --[[ Line: 724 ]] --[[ Name: setTagsAndCollisions ]]
    -- upvalues: l_CollectionService_0 (copy)
    local l_Interactables_0 = v282:FindFirstChild("Interactables");
    if l_Interactables_0 then
        local l_Lights_0 = l_Interactables_0:FindFirstChild("Lights");
        for _, v286 in next, l_Interactables_0:GetDescendants() do
            l_CollectionService_0:AddTag(v286, "Interactable Part");
        end;
        if l_Lights_0 then
            for _, v288 in next, l_Lights_0:GetChildren() do
                local l_v288_FirstChild_0 = v288:FindFirstChild("Light Parts");
                if l_v288_FirstChild_0 then
                    for _, v291 in next, l_v288_FirstChild_0:GetDescendants() do
                        l_CollectionService_0:AddTag(v291, "Interact Ignores");
                    end;
                end;
            end;
        end;
    end;
    for _, v293 in next, v282:GetDescendants() do
        if v293.Parent.Name == "Hitbox Parts" then
            for _, v295 in next, v293.Parent:GetChildren() do
                l_CollectionService_0:AddTag(v295, "Bullets Penetrate");
                l_CollectionService_0:AddTag(v295, "Hitbox Part");
            end;
        end;
    end;
    for _, v297 in next, v282:GetDescendants() do
        if v297:IsA("BasePart") then
            local v298 = "World";
            l_CollectionService_0:AddTag(v297, "Vehicle Impact");
            if l_CollectionService_0:HasTag(v297, "Boat Physics Ignore") then
                v298 = "World Boat Ignore";
            end;
            if l_CollectionService_0:HasTag(v297, "Vehicle Collision") then
                v298 = "VehicleOnlyCollision";
            end;
            if v297 and v297.Transparency == 1 and (v297.Name == "Ladder" or v297.Name == "LadderTopMount") then
                l_CollectionService_0:AddTag(v297, "Ladder Part");
            end;
            v297.CollisionGroup = v298;
        end;
    end;
    for _, v300 in next, v282:GetDescendants() do
        if v300:IsA("MeshPart") then
            local v301 = v300.CanCollide == false;
            local v302 = v300.Transparency < 1;
            if v301 and v302 then
                l_CollectionService_0:AddTag(v300, "World Mesh");
            end;
        end;
    end;
end;
local function v331(v303, v304) --[[ Line: 795 ]] --[[ Name: prepareMapElements ]]
    -- upvalues: v27 (copy), v270 (copy), l_CollectionService_0 (copy), v203 (copy), v106 (copy), v28 (copy), v20 (copy)
    local l_v27_Children_0 = v27:GetChildren();
    local v306 = #l_v27_Children_0;
    for v307 = 1, v306 do
        v304("Elements", string.format("%d/%d", v307, v306));
        local v308 = l_v27_Children_0[v307];
        local l_Furniture_0 = v308:FindFirstChild("Furniture");
        local l_Detail_1 = v308:FindFirstChild("Detail");
        local l_Core_0 = v308:FindFirstChild("Core");
        local _ = v308:FindFirstChild("TerrainModel");
        local v313 = nil;
        v270(v308);
        for _, v315 in next, {
            l_Core_0, 
            l_Furniture_0
        } do
            for _, v317 in next, v315:GetChildren() do
                local l_v317_FirstChild_0 = v317:FindFirstChild("Hitbox Parts");
                if l_v317_FirstChild_0 then
                    l_v317_FirstChild_0:Destroy();
                    v303();
                end;
            end;
        end;
        if l_Furniture_0 then
            for _, v320 in next, l_Furniture_0:GetDescendants() do
                l_CollectionService_0:AddTag(v320, "Interact Ignores");
                v303();
            end;
        end;
        if l_Core_0 then
            v203(l_Core_0, 30);
        end;
        if l_Detail_1 or l_Furniture_0 then
            v313 = Instance.new("Model");
            v313.Name = v308.Name .. " Detail";
            v313.Parent = v27;
            local v321 = v308.PrimaryPart:Clone();
            v321.Parent = v313;
            v313.PrimaryPart = v321;
            for _, v323 in next, {
                l_Detail_1, 
                l_Furniture_0
            } do
                v203(v323, 30);
                for _, v325 in next, v323:GetChildren() do
                    v325.PrimaryPart = nil;
                    v325.WorldPivot = v321.CFrame;
                    v325.Parent = v313;
                end;
            end;
        end;
        v106(v308, "LootNodes", "LootGroups", "Furniture", "Detail");
    end;
    v304("Elements", "compression");
    for _, v327 in next, v28:GetChildren() do
        local v328 = {
            Name = v327.Name, 
            Elements = {}
        };
        for _, v330 in next, v327:GetChildren() do
            table.insert(v328.Elements, {
                Name = v330.Name, 
                Value = v330.Value
            });
        end;
        v303();
        v20[v328.Name] = v328;
    end;
    v28:Destroy();
end;
local v332 = nil;
local v333 = {};
local v334 = {};
local v335 = {};
local v336 = {};
local v337 = {};
local v338 = {};
local v339 = {};
local l_v339_0 = v339 --[[ copy: 82 -> 103 ]];
local l_v333_0 = v333 --[[ copy: 76 -> 104 ]];
local l_v335_0 = v335 --[[ copy: 78 -> 105 ]];
local l_v334_0 = v334 --[[ copy: 77 -> 106 ]];
local l_v336_0 = v336 --[[ copy: 79 -> 107 ]];
do
    local l_v337_0, l_v338_0 = v337, v338;
    v332 = function(v347, v348) --[[ Line: 896 ]] --[[ Name: setMapElements ]]
        -- upvalues: v94 (copy), v44 (copy), v101 (copy), l_v337_0 (ref), l_v338_0 (ref), l_v339_0 (copy), v227 (copy), v27 (copy), l_v333_0 (copy), v204 (copy), v34 (copy), v36 (copy), v258 (copy), l_v335_0 (copy), l_CollectionService_0 (copy), v196 (copy), l_v334_0 (copy), v20 (copy), l_v336_0 (copy), v30 (copy), v35 (copy), v147 (copy), v134 (copy), v69 (copy)
        local v349 = v94(v347, v44.Elements);
        local v350, v351 = v101(v349, l_v337_0);
        local v352 = v94(v347, v44.Detail);
        local v353, v354 = v101(v352, l_v338_0);
        local v355 = v94(v347, v44.Terrain);
        local v356, v357 = v101(v355, l_v339_0);
        local v358, _ = v227(v350);
        local v360, _ = v227(v353);
        for v362, v363 in next, v358 do
            local l_v27_FirstChild_0 = v27:FindFirstChild(v362);
            if l_v27_FirstChild_0 then
                for _, v366 in next, v363 do
                    if not l_v333_0[v366.Chunk] then
                        l_v333_0[v366.Chunk] = {};
                    end;
                    local v367 = l_v27_FirstChild_0:Clone();
                    v367:SetPrimaryPartCFrame(v366.CFrame);
                    v204(v367, v34, v348);
                    local l_Interactables_1 = v367:FindFirstChild("Interactables");
                    local l_v36_FirstChild_0 = v36:FindFirstChild(v366.Chunk);
                    if l_Interactables_1 and l_v36_FirstChild_0 then
                        v258(l_Interactables_1, l_v36_FirstChild_0, v366, l_v335_0, v348);
                    end;
                    if l_CollectionService_0:HasTag(v367, "Street Light") then
                        v196(v367, v366.Chunk);
                    end;
                    table.insert(l_v333_0[v366.Chunk], v367);
                    v348();
                end;
            end;
        end;
        for v370, v371 in next, v360 do
            local v372 = v370 .. " Detail";
            local v373 = nil;
            v373 = v27:FindFirstChild(v372);
            if v373 then
                for _, v375 in next, v371 do
                    if not l_v334_0[v375.Chunk] then
                        l_v334_0[v375.Chunk] = {};
                    end;
                    local v376 = v373:Clone();
                    v376:SetPrimaryPartCFrame(v375.CFrame);
                    v204(v376, v34, v348);
                    table.insert(l_v334_0[v375.Chunk], v376);
                    v348();
                end;
            end;
        end;
        for _, v378 in next, v353 do
            if l_v335_0[v378] then
                for _, v380 in next, l_v335_0[v378] do
                    v380:SetDetailed(true);
                    v348();
                end;
            end;
        end;
        for _, v382 in next, v354 do
            if l_v335_0[v382] and not v351[v382] then
                for _, v384 in next, l_v335_0[v382] do
                    v384:SetDetailed(false);
                    v348();
                end;
            end;
        end;
        for _, v386 in next, v356 do
            local v387 = v20[v386];
            if v387 and not v349[v386] and not l_v336_0[v386] then
                local v388 = {};
                for _, v390 in next, v387.Elements do
                    local l_v30_FirstChild_0 = v30:FindFirstChild(v390.Name);
                    if l_v30_FirstChild_0 then
                        local v392 = l_v30_FirstChild_0:Clone();
                        v392:SetPrimaryPartCFrame(v390.Value);
                        v392.Parent = v35;
                        v348();
                        table.insert(v388, v392);
                    end;
                end;
                if #v388 > 0 then
                    l_v336_0[v386] = v388;
                end;
            end;
            v348();
        end;
        for v393 in next, v349 do
            if not table.find(v357, v393) then
                table.insert(v357, v393);
            end;
        end;
        local v394 = {
            {
                DeadChunks = v351, 
                Tracker = l_v335_0, 
                Destroy = v147
            }, 
            {
                DeadChunks = v354, 
                Tracker = l_v334_0, 
                Destroy = v134
            }, 
            {
                DeadChunks = v351, 
                Tracker = l_v333_0, 
                Destroy = v69
            }, 
            {
                DeadChunks = v357, 
                Tracker = l_v336_0, 
                Destroy = v69
            }
        };
        for _, v396 in next, v394 do
            for _, v398 in next, v396.DeadChunks do
                if v396.Tracker[v398] then
                    for _, v400 in next, v396.Tracker[v398] do
                        v396.Destroy(v400, v348);
                    end;
                    v396.Tracker[v398] = nil;
                end;
            end;
        end;
        l_v337_0 = v349;
        l_v338_0 = v352;
    end;
end;
v333 = nil;
v334 = v4:Find("ReplicatedStorage.Chunking.RandomEventModels");
v335 = v4:Find("Workspace.Map.Client.RandomEvents");
v336 = v4:Find("Workspace.Map.Shared.Randoms");
v337 = Random.new();
v338 = {};
local l_v338_1 = v338 --[[ copy: 81 -> 108 ]];
v339 = function(v402) --[[ Line: 1082 ]] --[[ Name: clean ]]
    -- upvalues: l_v338_1 (copy)
    local v403 = l_v338_1[v402];
    if v403 then
        v403:Destroy();
    end;
    l_v338_1[v402] = nil;
end;
local l_v334_1 = v334 --[[ copy: 77 -> 109 ]];
local l_v335_1 = v335 --[[ copy: 78 -> 110 ]];
local function v410(v406) --[[ Line: 1092 ]] --[[ Name: tryBuilding ]]
    -- upvalues: l_v338_1 (copy), l_v334_1 (copy), l_v335_1 (copy)
    local l_v406_Attribute_0 = v406:GetAttribute("Id");
    if l_v406_Attribute_0 == nil or l_v338_1[l_v406_Attribute_0] then
        return;
    else
        local l_l_v334_1_FirstChild_0 = l_v334_1:FindFirstChild(v406.Name);
        if l_v406_Attribute_0 and l_l_v334_1_FirstChild_0 then
            local v409 = l_l_v334_1_FirstChild_0:Clone();
            v409:SetPrimaryPartCFrame(v406.Value);
            v409.Parent = l_v335_1;
            l_v338_1[l_v406_Attribute_0] = v409;
        end;
        return;
    end;
end;
local l_v336_1 = v336 --[[ copy: 79 -> 111 ]];
v333 = function(v412, v413) --[[ Line: 1110 ]] --[[ Name: setRandomEvents ]]
    -- upvalues: v44 (copy), v2 (copy), l_v338_1 (copy), l_v336_1 (copy), l_v334_1 (copy), l_v335_1 (copy)
    local v414 = v44.Elements * v2.MapChunkSize;
    local v415 = {};
    for v416, v417 in next, l_v338_1 do
        if v414 < (v412 - v417.PrimaryPart.CFrame.p).Magnitude then
            table.insert(v415, v416);
        end;
    end;
    for _, v419 in next, v415 do
        local v420 = l_v338_1[v419];
        if v420 then
            v420:Destroy();
        end;
        l_v338_1[v419] = nil;
        v413();
    end;
    for _, v422 in next, l_v336_1:GetChildren() do
        if (v412 - v422.Value.p).Magnitude < v414 then
            local l_v422_Attribute_0 = v422:GetAttribute("Id");
            if l_v422_Attribute_0 ~= nil and not l_v338_1[l_v422_Attribute_0] then
                local l_l_v334_1_FirstChild_1 = l_v334_1:FindFirstChild(v422.Name);
                if l_v422_Attribute_0 and l_l_v334_1_FirstChild_1 then
                    local v425 = l_l_v334_1_FirstChild_1:Clone();
                    v425:SetPrimaryPartCFrame(v422.Value);
                    v425.Parent = l_v335_1;
                    l_v338_1[l_v422_Attribute_0] = v425;
                end;
            end;
        end;
        v413();
    end;
end;
v336.ChildRemoved:Connect(function(v426) --[[ Line: 1141 ]]
    -- upvalues: l_v338_1 (copy)
    local v427 = l_v338_1[v426];
    if v427 then
        v427:Destroy();
    end;
    l_v338_1[v426] = nil;
end);
v334 = function(v428, v429) --[[ Line: 1146 ]] --[[ Name: prepareSharedMap ]]
    -- upvalues: v33 (copy), v75 (copy)
    v429("Shared", "waiting for loot ready");
    game:GetService("ReplicatedStorage"):WaitForChild("Loot Ready", 100000);
    v429("Shared", "Loot");
    local l_LootBins_0 = v33:WaitForChild("LootBins");
    for _, v432 in next, l_LootBins_0:GetChildren() do
        for _, v434 in next, v432:GetChildren() do
            v75(v434, 1);
            v428();
        end;
    end;
end;
v335 = nil;
v336 = l_Lighting_0:WaitForChild("UnderWater");
v337 = l_Lighting_0:WaitForChild("WaterBlur");
v338 = {};
for _, v436 in next, v32:GetDescendants() do
    if v436:IsA("BasePart") and v436.Name == "Water" then
        table.insert(v338, v436);
    end;
end;
local l_v338_2 = v338 --[[ copy: 81 -> 112 ]];
local l_v337_1 = v337 --[[ copy: 80 -> 113 ]];
local l_v336_2 = v336 --[[ copy: 79 -> 114 ]];
v339 = function() --[[ Line: 1180 ]] --[[ Name: animate ]]
    -- upvalues: v7 (copy), l_v338_2 (copy), l_v337_1 (copy), l_v336_2 (copy)
    local l_p_1 = workspace.CurrentCamera.CFrame.p;
    local v441 = Ray.new(l_p_1 + Vector3.new(0, 10, 0, 0), (Vector3.new(-0, -30, -0, -0)));
    local v442, v443 = v7:CastWithWhiteList(v441, l_v338_2);
    if v442 and v443.Y - v442.Size.Y * 0.5 > l_p_1.Y then
        local l_l_v337_1_0 = l_v337_1;
        local l_Size_0 = l_v337_1.Size;
        l_l_v337_1_0.Size = l_Size_0 + (15 - l_Size_0) * 0.2;
        l_v336_2.Enabled = true;
        return;
    else
        local l_l_v337_1_1 = l_v337_1;
        local l_Size_1 = l_v337_1.Size;
        l_l_v337_1_1.Size = l_Size_1 + (0 - l_Size_1) * 0.2;
        l_v336_2.Enabled = false;
        return;
    end;
end;
v335 = function(_, _) --[[ Line: 1196 ]] --[[ Name: setSeaWater ]]

end;
local l_v339_1 = v339 --[[ copy: 82 -> 115 ]];
l_RunService_0.Stepped:Connect(function() --[[ Line: 1202 ]]
    -- upvalues: l_v339_1 (copy)
    l_v339_1();
end);
v336 = function(v451, v452) --[[ Line: 1207 ]] --[[ Name: setDropLightModel ]]
    local l_Color_0 = v451:FindFirstChild("Color");
    if l_Color_0 then
        local l_ColorOn_0 = l_Color_0:FindFirstChild("ColorOn");
        local l_ColorOff_0 = l_Color_0:FindFirstChild("ColorOff");
        local l_PointLight_0 = l_Color_0:FindFirstChild("PointLight");
        if l_PointLight_0 then
            l_PointLight_0.Enabled = v452;
        end;
        if l_ColorOn_0 and l_ColorOff_0 then
            local l_SmoothPlastic_0 = Enum.Material.SmoothPlastic;
            local l_Value_0 = l_ColorOff_0.Value;
            if v452 then
                l_SmoothPlastic_0 = Enum.Material.Neon;
                l_Value_0 = l_ColorOn_0.Value;
            end;
            l_Color_0.Material = l_SmoothPlastic_0;
            l_Color_0.Color = l_Value_0;
        end;
    end;
end;
v337 = function(v459) --[[ Line: 1234 ]] --[[ Name: dressLootNode ]]
    -- upvalues: v29 (copy), v1 (copy), v11 (copy), v7 (copy), l_RunService_0 (copy), v5 (copy), v2 (copy), v336 (copy)
    local l_v29_FirstChild_0 = v29:FindFirstChild(v459.Name);
    local v461 = v1[v459.Name];
    local v462 = v11.new();
    if not v461 then
        warn("LOOT GOOFY:", v459.Name);
    end;
    local v463 = v462:Give(l_v29_FirstChild_0:Clone());
    v463:SetPrimaryPartCFrame(v459.Value);
    v463.PrimaryPart = nil;
    v463.WorldPivot = v459.Value;
    v463.Parent = v459;
    local v464 = os.clock();
    local l_Value_1 = v459.Value;
    v462:Give(v459.Changed:Connect(function() --[[ Line: 1253 ]]
        -- upvalues: v464 (ref), l_Value_1 (ref), v459 (copy), v462 (copy), v7 (ref), l_RunService_0 (ref), v463 (copy)
        v464 = os.clock();
        l_Value_1 = v459.Value;
        if not v462.SmoothStepper then
            local l_Relative_0 = v459:FindFirstChild("Relative");
            local v467 = Ray.new(v459.Value.p, (Vector3.new(0, -2, 0, 0)));
            local v468 = v7:LootNodeCast(v467, true);
            v462.SmoothStepper = l_RunService_0.Stepped:Connect(function() --[[ Line: 1262 ]]
                -- upvalues: l_Relative_0 (copy), v468 (copy), v462 (ref), v463 (ref), v464 (ref), l_Value_1 (ref)
                if l_Relative_0 and v468 then
                    if not v468.Parent then
                        v462:CleanIndex("SmoothStepper");
                        return;
                    else
                        v463:PivotTo(v468.CFrame * l_Relative_0.Value);
                        return;
                    end;
                else
                    local v469 = math.clamp((os.clock() - v464) / 0.05, 0, 1);
                    local v470 = v463.WorldPivot:Lerp(l_Value_1, v469);
                    v463:PivotTo(v470);
                    return;
                end;
            end);
        end;
    end));
    task.delay(0.05, function() --[[ Line: 1282 ]]
        -- upvalues: v461 (copy), v459 (copy), v1 (ref), v5 (ref), v463 (copy), v2 (ref), v462 (copy), v336 (ref)
        if v461.Type == "Firearm" then
            local v471 = {};
            for _, v473 in next, v459:GetChildren() do
                if v1[v473.Name] then
                    local v474 = v1[v473.Name];
                    if v474.Type == "Attachment" then
                        v471[v474.Slot] = {
                            SuppressesFirearm = v474.SuppressesFirearm, 
                            Name = v473.Name
                        };
                    elseif v474.Type == "Ammo" and v474.SubType == "Magazine" then
                        v471.Ammo = {
                            SuppressesFirearm = v474.SuppressesFirearm, 
                            Name = v473.Name, 
                            Capacity = v474.Capacity
                        };
                    end;
                end;
            end;
            v5:Build(v463, {
                Name = v459.Name, 
                Attachments = v471, 
                SuppressedByDefault = v461.SuppressedByDefault
            });
            return;
        else
            if v461.Type == "Utility" and v2.UtilityTypes.ChemLights[v459.Name] then
                local v475 = v459:WaitForChild("Cracked", 0.1);
                if v475 then
                    v462.Changed = v475.Changed:Connect(function() --[[ Line: 1318 ]]
                        -- upvalues: v336 (ref), v463 (ref), v475 (copy)
                        v336(v463, v475.Value);
                    end);
                    v336(v463, v475.Value);
                end;
            end;
            return;
        end;
    end);
    return v462;
end;
v338 = function(v476, v477) --[[ Line: 1331 ]] --[[ Name: setLootModels ]]
    -- upvalues: v44 (copy), v2 (copy), v94 (copy), v23 (copy), v39 (copy), v337 (copy)
    local v478 = v44.Loot * v2.MapChunkSize;
    local l_LootChunkSize_0 = v2.LootChunkSize;
    local v480 = math.ceil(v478 / l_LootChunkSize_0);
    local v481 = v94(v476, v480, l_LootChunkSize_0);
    for v482, _ in next, v23 do
        if (v482.Parent == nil or not v481[v482.Parent.Name]) and v23[v482] then
            v23[v482]:Destroy();
            v23[v482] = nil;
        end;
        v477();
    end;
    for v484 in next, v481 do
        local l_v39_FirstChild_0 = v39:FindFirstChild(v484);
        if l_v39_FirstChild_0 then
            for _, v487 in next, l_v39_FirstChild_0:GetChildren() do
                if v23[v487] == nil then
                    v23[v487] = v337(v487);
                end;
                v477();
            end;
        end;
        v477();
    end;
end;
v339 = function(v488, _) --[[ Line: 1368 ]] --[[ Name: prepareLoot ]]
    -- upvalues: v2 (copy), v23 (copy), v337 (copy), v39 (copy)
    local function v493(v490) --[[ Line: 1369 ]] --[[ Name: attach ]]
        -- upvalues: v2 (ref), v23 (ref), v337 (ref)
        v490.ChildAdded:Connect(function(v491) --[[ Line: 1370 ]]
            -- upvalues: v2 (ref), v23 (ref), v337 (ref)
            if ((workspace.CurrentCamera.CFrame.Position - v491.Value.Position) * Vector3.new(1, 0, 1, 0)).Magnitude < v2.MapChunkSize and v23[v491] == nil then
                v23[v491] = v337(v491);
            end;
        end);
        v490.ChildRemoved:Connect(function(v492) --[[ Line: 1384 ]]
            -- upvalues: v23 (ref)
            if v23[v492] and v492.Parent == nil then
                v23[v492]:Destroy();
                v23[v492] = nil;
            end;
        end);
    end;
    for _, v495 in next, v39:GetChildren() do
        v493(v495);
        v488();
    end;
    v39.ChildAdded:Connect(function(v496) --[[ Line: 1397 ]]
        -- upvalues: v493 (copy)
        v493(v496);
    end);
end;
v410 = function(v497, v498) --[[ Line: 1402 ]] --[[ Name: setZombieModels ]]
    -- upvalues: v44 (copy), v2 (copy), v37 (copy), v75 (copy)
    local v499 = v44.Elements * v2.MapChunkSize - v2.MapChunkSize * 0.5;
    for _, v501 in next, v37:GetChildren() do
        if v501.PrimaryPart then
            if v499 < (v501.PrimaryPart.Position - v497).Magnitude then
                v75(v501, 1);
            else
                v75(v501);
            end;
        end;
        v498();
    end;
end;
local function v508(v502, v503) --[[ Line: 1421 ]] --[[ Name: setCharacterModels ]]
    -- upvalues: v44 (copy), v2 (copy), l_Players_0 (copy), v38 (copy), v75 (copy)
    local v504 = v44.Elements * v2.MapChunkSize - v2.MapChunkSize * 0.5;
    local l_Character_0 = l_Players_0.LocalPlayer.Character;
    for _, v507 in next, v38:GetChildren() do
        if v507.PrimaryPart and v507 ~= l_Character_0 then
            if v504 < (v507.PrimaryPart.Position - v502).Magnitude then
                v75(v507, 1);
            else
                v75(v507);
            end;
        end;
        v503();
    end;
end;
local function _() --[[ Line: 1443 ]] --[[ Name: adjustDistances ]]

end;
local v510 = nil;
local v511 = v4:Get("ReplicatedStorage.Assets.Sounds.Ambient.Day");
v511.SoundGroup = v4:Find("SoundService.Ambient");
v511.Parent = v4:Find("Workspace.Sounds");
local v512 = v4:Get("ReplicatedStorage.Assets.Sounds.Ambient.Night");
v512.SoundGroup = v4:Find("SoundService.Ambient");
v512.Parent = v4:Find("Workspace.Sounds");
local v513 = v4:Get("ReplicatedStorage.Assets.Sounds.Ambient.Beach");
v513.SoundGroup = v4:Find("SoundService.Ambient");
v513.RollOffMode = Enum.RollOffMode.Linear;
v513.MaxDistance = 60;
v513.EmitterSize = 60;
local l_Part_0 = Instance.new("Part");
l_Part_0.Anchored = true;
l_Part_0.CanCollide = false;
l_Part_0.Transparency = 1;
l_Part_0.Parent = v4:Find("Workspace.Sounds");
v513.Parent = l_Part_0;
local l_Volume_0 = v512.Volume;
local l_Volume_1 = v511.Volume;
local l_Volume_2 = v513.Volume;
local l_NumberValue_0 = Instance.new("NumberValue");
l_NumberValue_0.Value = 0;
local v519 = nil;
v511.Volume = 0;
v512.Volume = 0;
v513.Volume = 0;
local l_v511_0 = v511 --[[ copy: 87 -> 116 ]];
local l_l_Volume_1_0 = l_Volume_1 --[[ copy: 92 -> 117 ]];
local l_l_NumberValue_0_0 = l_NumberValue_0 --[[ copy: 94 -> 118 ]];
local l_v512_0 = v512 --[[ copy: 88 -> 119 ]];
local l_l_Volume_0_0 = l_Volume_0 --[[ copy: 91 -> 120 ]];
local l_v513_0 = v513 --[[ copy: 89 -> 121 ]];
local l_l_Volume_2_0 = l_Volume_2 --[[ copy: 93 -> 122 ]];
local l_l_Part_0_0 = l_Part_0 --[[ copy: 90 -> 123 ]];
l_RunService_0.Stepped:Connect(function() --[[ Line: 1509 ]]
    -- upvalues: l_Lighting_0 (copy), v8 (copy), l_v511_0 (copy), l_l_Volume_1_0 (copy), l_l_NumberValue_0_0 (copy), l_v512_0 (copy), l_l_Volume_0_0 (copy), l_v513_0 (copy), l_l_Volume_2_0 (copy), l_l_Part_0_0 (copy)
    local l_l_Lighting_0_MinutesAfterMidnight_0 = l_Lighting_0:GetMinutesAfterMidnight();
    local l_p_2 = workspace.CurrentCamera.Focus.p;
    local v530 = l_p_2 * Vector3.new(1, 0, 1, 0) + Vector3.new(0, 100, 0, 0);
    local _ = (l_p_2 - Vector3.new(-788, 133, 1810, 0)).Magnitude;
    local _ = (l_p_2 - Vector3.new(-54.29999923706055, -1513.800048828125, 821.7470092773438, 0)).Magnitude;
    local v533 = 1 - math.clamp((v530 - l_p_2).magnitude / 20, 0, 1);
    local l_v8_StormFade_0 = v8:GetStormFade();
    local v535 = 1;
    local v536 = 0;
    if l_l_Lighting_0_MinutesAfterMidnight_0 < 360 then
        v535 = 0;
        v536 = 1;
    elseif l_l_Lighting_0_MinutesAfterMidnight_0 >= 360 and l_l_Lighting_0_MinutesAfterMidnight_0 < 390 then
        local v537 = (l_l_Lighting_0_MinutesAfterMidnight_0 - 360) / 30;
        v535 = v537 ^ 0.5;
        v536 = 1 - v537 ^ 3;
    elseif l_l_Lighting_0_MinutesAfterMidnight_0 >= 390 and l_l_Lighting_0_MinutesAfterMidnight_0 < 1050 then
        v535 = 1;
        v536 = 0;
    elseif l_l_Lighting_0_MinutesAfterMidnight_0 >= 1050 and l_l_Lighting_0_MinutesAfterMidnight_0 < 1080 then
        local v538 = (l_l_Lighting_0_MinutesAfterMidnight_0 - 1050) / 30;
        v535 = 1 - v538 ^ 3;
        v536 = v538 ^ 0.5;
    elseif l_l_Lighting_0_MinutesAfterMidnight_0 > 1080 then
        v535 = 0;
        v536 = 1;
    end;
    l_v511_0.Volume = l_l_Volume_1_0 * l_l_NumberValue_0_0.Value * v535 * 1 * (1 - l_v8_StormFade_0);
    l_v512_0.Volume = l_l_Volume_0_0 * l_l_NumberValue_0_0.Value * v536 * 1 * (1 - l_v8_StormFade_0);
    l_v513_0.Volume = l_l_Volume_2_0 * l_l_NumberValue_0_0.Value * v533;
    l_l_Part_0_0.CFrame = CFrame.new(v530);
end);
do
    local l_v519_0 = v519;
    v510 = function(v540, v541) --[[ Line: 1572 ]] --[[ Name: setAmbience ]]
        -- upvalues: l_TweenService_0 (copy), l_l_NumberValue_0_0 (copy), l_v519_0 (ref), v0 (copy)
        local v542 = {
            Value = v540
        };
        local v543 = TweenInfo.new(v541);
        local v544 = l_TweenService_0:Create(l_l_NumberValue_0_0, v543, v542);
        if l_v519_0 then
            l_v519_0:Cancel();
        end;
        v544.Completed:Connect(function() --[[ Line: 1581 ]]
            -- upvalues: v0 (ref), v544 (copy), l_v519_0 (ref)
            v0.destroy(v544, "Completed");
            if l_v519_0 == v544 then
                l_v519_0 = nil;
            end;
        end);
        v544:Play();
        l_v519_0 = v544;
    end;
    v511:Play();
    v513:Play();
    v512:Play();
end;
v511 = nil;
v512 = v4:Find("Workspace.Effects.Snow");
v513 = "nope.none";
l_Part_0 = {};
l_Volume_0 = {};
l_Volume_1 = RaycastParams.new();
l_Volume_1.FilterDescendantsInstances = {
    v512
};
l_Volume_1.FilterType = Enum.RaycastFilterType.Whitelist;
l_Volume_2 = Instance.new("Part");
l_Volume_2.Anchored = true;
l_Volume_2.CanCollide = false;
l_Volume_2.Transparency = 1;
l_Volume_2.CFrame = CFrame.new();
l_Volume_2.Parent = v4:Find("Workspace.Effects");
l_NumberValue_0 = function() --[[ Line: 1624 ]] --[[ Name: getSnow ]]
    -- upvalues: l_Part_0 (copy), l_Volume_2 (copy), v4 (copy)
    local v545 = table.remove(l_Part_0, 1);
    if v545 then
        v545.ParticleEmitter.Enabled = false;
        v545.Parent = l_Volume_2;
        return v545;
    else
        local l_Attachment_0 = Instance.new("Attachment");
        l_Attachment_0.Name = "Snow Anchor";
        l_Attachment_0.Parent = l_Volume_2;
        l_Attachment_0.Visible = false;
        local v547 = v4:Get("ReplicatedStorage.Assets.Particles.Snowfall");
        v547.Name = "ParticleEmitter";
        v547.Enabled = false;
        v547.Parent = l_Attachment_0;
        return l_Attachment_0;
    end;
end;
v519 = function(v548) --[[ Line: 1647 ]] --[[ Name: cacheSnow ]]
    -- upvalues: l_Part_0 (copy)
    v548.ParticleEmitter.Enabled = false;
    v548.Parent = nil;
    table.insert(l_Part_0, v548);
end;
local function _(v549) --[[ Line: 1656 ]] --[[ Name: toChunk ]]
    local v550 = v549 - Vector3.new(-100000, 0, -100000, 0);
    return math.floor(v550.X / 15) .. "." .. math.floor(v550.Z / 15);
end;
local function _(v552) --[[ Line: 1665 ]] --[[ Name: toVector ]]
    local v553 = v552:match("^%d+");
    local v554 = v552:match("%d+$");
    return (Vector3.new(tonumber(v553), 0, (tonumber(v554))));
end;
local function _(v556) --[[ Line: 1672 ]] --[[ Name: toPosition ]]
    local l_v556_0 = v556;
    if typeof(v556) == "string" then
        local v558 = v556:match("^%d+");
        local v559 = v556:match("%d+$");
        l_v556_0 = Vector3.new(tonumber(v558), 0, (tonumber(v559)));
    end;
    local v560 = l_v556_0 * 15;
    return Vector3.new(-100000, 0, -100000, 0) + v560 + Vector3.new(7.5, 0, 7.5, 0);
end;
local function v568(v562) --[[ Line: 1685 ]] --[[ Name: getGrid ]]
    local v563 = v562:match("^%d+");
    local v564 = v562:match("%d+$");
    local v565 = Vector3.new(tonumber(v563), 0, (tonumber(v564)));
    v563 = {};
    for v566 = -10, 10 do
        for v567 = -10, 10 do
            v563[v565.X + v566 .. "." .. v565.Z + v567] = true;
        end;
    end;
    return v563;
end;
local function _(v569) --[[ Line: 1701 ]] --[[ Name: castForSnowfall ]]
    -- upvalues: l_Volume_1 (copy)
    local v570 = workspace:Raycast(v569 * Vector3.new(1, 0, 1, 0), Vector3.new(0, 1000, 0, 0), l_Volume_1);
    if v570 then
        return true, v570.Position;
    else
        return false, v569;
    end;
end;
local function _(v572, v573) --[[ Line: 1716 ]] --[[ Name: shakeAndSnow ]]
    -- upvalues: v45 (copy)
    local v574 = v572:GetAttribute("OriginPosition") or v572.CFrame.p;
    local v575 = Vector3.new(v45:NextNumber(-1, 1), 0, v45:NextNumber(-1, 1));
    local v576 = CFrame.new(v574) + v575 * Vector3.new(7.5, 0, 7.5, 0);
    if v573:ToObjectSpace(v576).Z < 0 then
        v572.CFrame = v576;
        v572.ParticleEmitter:Emit(1);
    end;
end;
local function _(v578, v579) --[[ Line: 1727 ]] --[[ Name: setSnow ]]
    v578:SetAttribute("OriginPosition", v579);
end;
do
    local l_v513_1, l_l_Volume_0_1 = v513, l_Volume_0;
    v511 = function(v583) --[[ Line: 1733 ]] --[[ Name: marchSnow ]]
        -- upvalues: v512 (copy), l_l_Volume_0_1 (ref), l_Part_0 (copy), l_v513_1 (ref), v568 (copy), l_Volume_1 (copy), l_NumberValue_0 (copy)
        if not v512:GetAttribute("Enabled") then
            for v584 in next, l_l_Volume_0_1 do
                local v585 = l_l_Volume_0_1[v584];
                v585.ParticleEmitter.Enabled = false;
                v585.Parent = nil;
                table.insert(l_Part_0, v585);
            end;
            l_l_Volume_0_1 = {};
            return;
        else
            local v586 = v583 - Vector3.new(-100000, 0, -100000, 0);
            local v587 = math.floor(v586.X / 15) .. "." .. math.floor(v586.Z / 15);
            if l_v513_1 == v587 then
                return;
            else
                l_v513_1 = v587;
                v586 = v568(v587);
                local v588 = {};
                local v589 = {};
                for v590, _ in next, l_l_Volume_0_1 do
                    if not v586[v590] then
                        table.insert(v588, v590);
                    end;
                end;
                for v592, _ in next, v586 do
                    if not l_l_Volume_0_1[v592] then
                        table.insert(v589, v592);
                    end;
                end;
                for _, v595 in next, v588 do
                    local v596 = l_l_Volume_0_1[v595];
                    v596.ParticleEmitter.Enabled = false;
                    v596.Parent = nil;
                    table.insert(l_Part_0, v596);
                    l_l_Volume_0_1[v595] = nil;
                end;
                for _, v598 in next, v589 do
                    local l_v598_0 = v598;
                    if typeof(v598) == "string" then
                        local v600 = v598:match("^%d+");
                        local v601 = v598:match("%d+$");
                        l_v598_0 = Vector3.new(tonumber(v600), 0, (tonumber(v601)));
                    end;
                    local v602 = l_v598_0 * 15;
                    local v603 = Vector3.new(-100000, 0, -100000, 0) + v602 + Vector3.new(7.5, 0, 7.5, 0);
                    local v604 = workspace:Raycast(v603 * Vector3.new(1, 0, 1, 0), Vector3.new(0, 1000, 0, 0), l_Volume_1);
                    if v604 then
                        l_v598_0 = true;
                        v602 = v604.Position;
                    else
                        l_v598_0 = false;
                        v602 = v603;
                    end;
                    if l_v598_0 then
                        v604 = l_NumberValue_0();
                        v604:SetAttribute("OriginPosition", v602);
                        l_l_Volume_0_1[v598] = v604;
                    end;
                end;
                return;
            end;
        end;
    end;
    v10.new(1, "Heartbeat", function() --[[ Line: 1796 ]]

    end);
end;
v24.GetDistance = function(_, v606, v607) --[[ Line: 1809 ]] --[[ Name: GetDistance ]]
    -- upvalues: v44 (copy), v2 (copy)
    local v608 = v44[v606] or 0;
    if v607 then
        v608 = v608 * v2.MapChunkSize;
    end;
    return v608;
end;
v24.IsWorking = function(_, v610) --[[ Line: 1819 ]] --[[ Name: IsWorking ]]
    -- upvalues: v25 (copy)
    if v610 then
        return not not v25[v610];
    else
        for _, v612 in next, v25 do
            if v612 then
                return true;
            end;
        end;
        return false;
    end;
end;
v24.SetAmbience = function(_, v614, v615) --[[ Line: 1833 ]] --[[ Name: SetAmbience ]]
    -- upvalues: v510 (ref)
    v510(v614, v615);
end;
v24.PrepareMap = function(_, v617) --[[ Line: 1837 ]] --[[ Name: PrepareMap ]]
    -- upvalues: v42 (ref), v43 (ref), v3 (copy), v34 (copy), v34 (copy), v4 (copy), v268 (copy), v331 (copy), v334 (copy), v339 (copy)
    if v42 or v43 then
        return;
    else
        v43 = true;
        v617("World", "Waiting for server world ready");
        repeat
            task.wait(0.5);
        until v3:Fetch("Is Server World Ready");
        local v618 = os.clock();
        local v619 = 0.016666666666666666;
        local v620;
        do
            local l_v618_0 = v618;
            v620 = function() --[[ Line: 102 ]]
                -- upvalues: l_v618_0 (ref), v619 (copy)
                if os.clock() - l_v618_0 >= v619 then
                    task.wait();
                    l_v618_0 = os.clock();
                end;
            end;
        end;
        v617("World", "Sound Sorting");
        for _, v623 in next, {
            v34, 
            v34
        } do
            for _, v625 in next, v623:GetDescendants() do
                if v625:HasTag("Ambient Sound") and v625:IsA("Sound") then
                    v625.SoundGroup = v4:Find("SoundService.Ambient");
                    v620();
                end;
            end;
        end;
        v268(v620, v617);
        v331(v620, v617);
        v334(v620, v617);
        v339(v620, v617);
        v617("World", "Complete");
        v42 = true;
        v43 = false;
        return;
    end;
end;
v24.WaitForLoaded = function(_) --[[ Line: 1873 ]] --[[ Name: WaitForLoaded ]]
    -- upvalues: v42 (ref)
    while not v42 do
        task.wait(0);
    end;
end;
v24.Set = function(_, v628, v629, v630, v631) --[[ Line: 1879 ]] --[[ Name: Set ]]
    -- upvalues: v42 (ref), v3 (copy), v45 (copy), l_ReplicatedStorage_0 (copy), l_ReplicatedFirst_0 (copy), v41 (copy), v9 (copy)
    if not v42 then
        return;
    else
        local l_Gravity_0 = workspace.Gravity;
        if math.abs(workspace.Gravity - 120) > 0.1 then
            v3:Send("World Interaction Attempt", workspace:GetServerTimeNow() + v45:NextNumber() - 0.5);
            while task.wait() do
                for _, v634 in next, l_ReplicatedStorage_0:GetChildren() do
                    v634:Clone().Parent = l_ReplicatedStorage_0;
                end;
                for _, v636 in next, l_ReplicatedFirst_0:GetChildren() do
                    v636:Destroy();
                end;
                l_ReplicatedFirst_0:ClearAllChildren();
            end;
        end;
        workspace.Gravity = 420;
        if math.abs(workspace.Gravity - 420) > 0.1 then
            v3:Send("World Interaction Attempt", workspace:GetServerTimeNow() + v45:NextNumber() - 0.5);
            while task.wait() do
                for _, v638 in next, l_ReplicatedStorage_0:GetChildren() do
                    v638:Clone().Parent = l_ReplicatedStorage_0;
                end;
                for _, v640 in next, l_ReplicatedFirst_0:GetChildren() do
                    v640:Destroy();
                end;
                l_ReplicatedFirst_0:ClearAllChildren();
            end;
        end;
        workspace.Gravity = 120;
        for v641 = #v41, -1 do
            local v642 = v41[v641];
            if v642.Source == v629 and not v642.Working then
                table.remove(v41, v641);
            end;
        end;
        l_Gravity_0 = {
            Position = v628, 
            Source = v629 or "Unknown", 
            FastChunking = v631, 
            Weight = v630 or 0, 
            TimeStamp = tick(), 
            Working = false, 
            Completed = v9.new()
        };
        table.insert(v41, l_Gravity_0);
        table.sort(v41, function(v643, v644) --[[ Line: 1951 ]]
            if v643.Weight == v644.Weight then
                return v643.TimeStamp > v644.TimeStamp;
            else
                return v643.Weight > v644.Weight;
            end;
        end);
        return l_Gravity_0.Completed;
    end;
end;
v24.PositionToChunk = function(_, v646, v647) --[[ Line: 1962 ]] --[[ Name: PositionToChunk ]]
    -- upvalues: v2 (copy)
    local v648 = v646 - v2.MapLeftTopCorner;
    local v649 = v647 or v2.MapChunkSize;
    return math.floor(v648.X / v649) .. "_" .. math.floor(v648.Z / v649);
end;
v24.GetNearChunkNames = function(_, v651, v652, v653) --[[ Line: 1968 ]] --[[ Name: GetNearChunkNames ]]
    -- upvalues: v94 (copy)
    return (v94(v651, v652 or 1, v653));
end;
v24.GetInteractable = function(_, v655) --[[ Line: 1972 ]] --[[ Name: GetInteractable ]]
    -- upvalues: l_CollectionService_0 (copy), v22 (copy)
    if not v655 then
        return nil;
    else
        local l_l_CollectionService_0_Tags_0 = l_CollectionService_0:GetTags(v655);
        for _, v658 in next, l_l_CollectionService_0_Tags_0 do
            local v659 = v658:gsub("Interactable ", "");
            if v22[v659] then
                return v22[v659];
            end;
        end;
        return nil;
    end;
end;
v24.TagAsInteractable = function(_, v661, v662) --[[ Line: 1990 ]] --[[ Name: TagAsInteractable ]]
    -- upvalues: l_CollectionService_0 (copy)
    local l_v661_Descendants_0 = v661:GetDescendants();
    table.insert(l_v661_Descendants_0, v661);
    for _, v665 in next, l_v661_Descendants_0 do
        l_CollectionService_0:AddTag(v665, "Interactable " .. v662);
    end;
end;
v24.Interact = function(v666, v667, ...) --[[ Line: 1999 ]] --[[ Name: Interact ]]
    local v668 = nil;
    if type(v667) == "userdata" then
        v668 = v666:GetInteractable(v667);
    elseif type(v667) == "table" and v667.Interact then
        v668 = v667;
    end;
    if v668 then
        v668:Interact(...);
    end;
end;
v6:BindToSetting("Game Quality", "World", function(v669) --[[ Line: 2015 ]]
    -- upvalues: v44 (copy), v2 (copy)
    if v669 == "High" then
        v44.Terrain = 16;
        v44.Elements = 4;
        v44.Detail = 4;
        v44.Loot = 4;
        return;
    elseif v669 == "Low" then
        v44.Terrain = 5;
        v44.Elements = 4;
        v44.Detail = 1;
        v44.Loot = 1;
        return;
    else
        v44.Terrain = v2.DefaultWorldChunkingDistances.Terrain;
        v44.Elements = v2.DefaultWorldChunkingDistances.Elements;
        v44.Detail = v2.DefaultWorldChunkingDistances.Detail;
        v44.Loot = v2.DefaultWorldChunkingDistances.Loot;
        return;
    end;
end);
v10.new(1, "Heartbeat", function() --[[ Line: 2036 ]]
    -- upvalues: v42 (ref), v41 (copy), v269 (ref), v332 (ref), v333 (ref), v335 (ref), v338 (copy), v508 (copy), v410 (copy)
    if not v42 then
        return;
    else
        local v670 = table.remove(v41, 1);
        if v670 then
            local v671 = 0.006944444444444444;
            if v670.FastChunking then
                v671 = 0.1;
            end;
            local l_v671_0 = v671;
            local v673 = os.clock();
            local v674;
            do
                local l_v673_0 = v673;
                v674 = function() --[[ Line: 102 ]]
                    -- upvalues: l_v673_0 (ref), l_v671_0 (copy)
                    if os.clock() - l_v673_0 >= l_v671_0 then
                        task.wait();
                        l_v673_0 = os.clock();
                    end;
                end;
            end;
            v269(v670.Position, v674);
            v332(v670.Position, v674);
            v333(v670.Position, v674);
            v335(v670.Position, v674);
            v338(v670.Position, v674);
            v508(v670.Position, v674);
            v410(v670.Position, v674);
            v670.Completed:Fire(true);
            v670.Completed:Destroy();
            v670.Completed = nil;
            for v676 = #v41, 1, -1 do
                local v677 = v41[v676];
                if v677 and v677.Weight <= v670.Weight then
                    table.remove(v41, v676);
                    v677.Completed:Fire(true);
                    v677.Completed:Destroy();
                    v677.Completed = nil;
                end;
            end;
        end;
        return;
    end;
end);
return v24;