local v0 = game:GetService("RunService"):IsServer();
local v1 = nil;
v1 = if v0 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local v2 = v1.require("Configs", "ItemData");
local v3 = v1.require("Configs", "CreatorData");
local v4 = v1.require("Libraries", "Resources");
local v5 = {};
local v6 = Color3.fromRGB(245, 205, 48);
local v7 = {
    [2499282434] = 11880242173
};
local v8 = {
    "LowerTorso", 
    "UpperTorso", 
    "RightUpperArm", 
    "RightLowerArm", 
    "RightHand", 
    "LeftUpperArm", 
    "LeftLowerArm", 
    "LeftHand"
};
local v9 = {
    "RightUpperLeg", 
    "RightLowerLeg", 
    "RightFoot", 
    "LeftUpperLeg", 
    "LeftLowerLeg", 
    "LeftFoot"
};
local v10 = {
    "Head", 
    "LowerTorso", 
    "UpperTorso", 
    "RightUpperArm", 
    "RightLowerArm", 
    "RightHand", 
    "LeftUpperArm", 
    "LeftLowerArm", 
    "LeftHand", 
    "RightUpperLeg", 
    "RightLowerLeg", 
    "RightFoot", 
    "LeftUpperLeg", 
    "LeftLowerLeg", 
    "LeftFoot"
};
local v11 = {
    "Accessory", 
    "Belt", 
    "Hat", 
    "Vest", 
    "Backpack"
};
local function v12(...) --[[ Line: 87 ]] --[[ Name: traceWarn ]]
    warn(...);
    print(debug.traceback());
end;
local function _(v13, v14) --[[ Line: 92 ]] --[[ Name: findAndDestroy ]]
    local l_v13_FirstChild_0 = v13:FindFirstChild(v14);
    if l_v13_FirstChild_0 then
        l_v13_FirstChild_0:Destroy();
    end;
end;
local function _(v17) --[[ Line: 100 ]] --[[ Name: getItemData ]]
    -- upvalues: v2 (copy)
    if typeof(v17) == "table" then
        return v17;
    else
        return v2[v17];
    end;
end;
local function v28(v19, v20, v21) --[[ Line: 108 ]] --[[ Name: setClothingParts ]]
    -- upvalues: v4 (copy), v0 (copy), v12 (copy)
    local v22 = v4:Search("ServerStorage.ClothingTextures." .. v21);
    if not v22 then
        if v0 then
            v12("Couldn't find ClothingTexture", v21, "for", v19);
            return;
        else
            v12("Cannot dress non-humanoids on the client");
            return;
        end;
    else
        for _, v24 in next, v20 do
            local l_v19_FirstChild_0 = v19:FindFirstChild(v24);
            if l_v19_FirstChild_0 and l_v19_FirstChild_0:IsA("MeshPart") then
                local l_ClothingTexture_0 = l_v19_FirstChild_0:FindFirstChild("ClothingTexture");
                local v27 = v22:Clone();
                if l_ClothingTexture_0 then
                    l_ClothingTexture_0:Destroy();
                end;
                v27.Name = "ClothingTexture";
                v27.Parent = l_v19_FirstChild_0;
            end;
        end;
        return;
    end;
end;
local function v41(v29) --[[ Line: 136 ]] --[[ Name: resolveLimbHiding ]]
    -- upvalues: v10 (copy)
    local l_Equipment_0 = v29:FindFirstChild("Equipment");
    if l_Equipment_0 then
        local v31 = {};
        for _, v33 in next, v10 do
            v31[v33] = 0;
        end;
        for _, v35 in next, l_Equipment_0:GetChildren() do
            if v35:IsA("Model") then
                if v35.Name:find("3D Clothing") then
                    for _, v37 in next, v35:GetChildren() do
                        if v37:GetAttribute("HidesLimb") then
                            v31[v37.PrimaryPart.Name] = 1;
                        end;
                    end;
                elseif v35:GetAttribute("HidesLimb") then
                    v31[v35.PrimaryPart.Name] = 1;
                end;
            end;
        end;
        for v38, v39 in next, v31 do
            local l_v29_FirstChild_0 = v29:FindFirstChild(v38);
            if l_v29_FirstChild_0 then
                l_v29_FirstChild_0.Transparency = math.min(v39, 0.999);
            end;
        end;
    end;
end;
local function v50(v42, v43) --[[ Line: 171 ]] --[[ Name: attachModelToLimb ]]
    -- upvalues: v12 (copy)
    local l_PrimaryPart_0 = v42.PrimaryPart;
    if not l_PrimaryPart_0 then
        v12("Failed to attach clothing to limb, no base part", v42, v43);
        return;
    else
        for _, v46 in next, v42:GetDescendants() do
            if v46:IsA("BasePart") and v46 ~= l_PrimaryPart_0 then
                local l_Weld_0 = Instance.new("Weld");
                l_Weld_0.C0 = l_PrimaryPart_0.CFrame:ToObjectSpace(v46.CFrame);
                l_Weld_0.Part0 = l_PrimaryPart_0;
                l_Weld_0.Part1 = v46;
                l_Weld_0.Parent = v46;
                v46.CanCollide = false;
                v46.Anchored = false;
                v46.Massless = true;
            end;
        end;
        local l_Weld_1 = Instance.new("Weld");
        l_Weld_1.Part0 = v43;
        l_Weld_1.Part1 = l_PrimaryPart_0;
        l_Weld_1.Parent = l_PrimaryPart_0;
        l_PrimaryPart_0.CanCollide = false;
        l_PrimaryPart_0.Anchored = false;
        l_PrimaryPart_0.Massless = true;
        l_PrimaryPart_0.Transparency = 1;
        local l_Decal_0 = l_PrimaryPart_0:FindFirstChildOfClass("Decal");
        if l_Decal_0 then
            l_Decal_0:Destroy();
        end;
        return;
    end;
end;
local function v61(v51, v52, v53) --[[ Line: 210 ]] --[[ Name: dress3DClothing ]]
    -- upvalues: v4 (copy), v50 (copy), v41 (copy)
    local v54 = v52.RealName or v52.DisplayName;
    local v55 = v4:Search("ReplicatedStorage.Assets.Items." .. v54) or v4:Search("ServerStorage.ItemsServerOnly." .. v54);
    local l_Equipment_1 = v51:FindFirstChild("Equipment");
    if not v55 then
        warn("Failed to dress", v51, v54, "Couldn't find Items model");
        return;
    elseif not l_Equipment_1 then
        warn("Failed to dress", v51, v54, "Failed to find Equipment folder");
        return;
    else
        if v55 and l_Equipment_1 then
            local v57 = v55:Clone();
            for _, v59 in next, v57:GetChildren() do
                local l_v51_FirstChild_0 = v51:FindFirstChild(v59.PrimaryPart.Name);
                if l_v51_FirstChild_0 then
                    v50(v59, l_v51_FirstChild_0);
                else
                    v59:Destroy();
                    warn("Failed to dress 3D Clothing", v51, v54, v59.Name);
                end;
            end;
            v57:SetAttribute("ItemName", v54);
            v57:SetAttribute("EquipSlot", v53 or v52.EquipSlot or "???");
            v57:SetAttribute("Is3DClothing", true);
            v57.Name = v54 .. " 3D Clothing";
            v57.Parent = l_Equipment_1;
            v41(v51);
        end;
        return;
    end;
end;
local function v70(v62, v63, v64) --[[ Line: 253 ]] --[[ Name: dressAccessoryModel ]]
    -- upvalues: v4 (copy), v50 (copy), v41 (copy)
    local v65 = v63.RealName or v63.DisplayName;
    local v66 = v4:Search("ReplicatedStorage.Assets.Items." .. v65) or v4:Search("ServerStorage.ItemsServerOnly." .. v65);
    local l_Equipment_2 = v62:FindFirstChild("Equipment");
    if not v66 then
        warn("Failed to dress", v62, v65, "Couldn't find Items model");
        return;
    elseif not l_Equipment_2 then
        warn("Failed to dress", v62, v65, "Failed to find Equipment folder");
        return;
    else
        if v66 and l_Equipment_2 then
            local v68 = v66:Clone();
            local l_v62_FirstChild_0 = v62:FindFirstChild(v68.PrimaryPart.Name);
            if l_v62_FirstChild_0 then
                v50(v68, l_v62_FirstChild_0);
                v68:SetAttribute("ItemName", v65);
                v68:SetAttribute("EquipSlot", v64 or v63.EquipSlot or "???");
                v68:SetAttribute("Is3DClothing", false);
                v68.Name = v65;
                v68.Parent = l_Equipment_2;
            else
                v68:Destroy();
                warn("Failed to dress model", v62, v65, v68.Name);
            end;
            v41(v62);
        end;
        return;
    end;
end;
local function v76(v71, v72) --[[ Line: 293 ]] --[[ Name: wipeEquipmentBySlot ]]
    -- upvalues: v41 (copy)
    local l_Equipment_3 = v71:FindFirstChild("Equipment");
    if l_Equipment_3 then
        for _, v75 in next, l_Equipment_3:GetChildren() do
            if v75:GetAttribute("EquipSlot") == v72 then
                v75:Destroy();
            end;
        end;
        v41(v71);
    end;
end;
local function v97(v77) --[[ Line: 307 ]] --[[ Name: resolveAttributes ]]
    -- upvalues: v2 (copy)
    local l_Equipment_4 = v77:FindFirstChild("Equipment");
    local l_Hair_0 = v77:FindFirstChild("Hair");
    if l_Equipment_4 and l_Hair_0 then
        local l_l_Hair_0_Attribute_0 = l_Hair_0:GetAttribute("VisibleUnderHats");
        local v81 = {};
        local v82 = 0;
        local v83 = false;
        local v84 = false;
        for _, v86 in next, l_Equipment_4:GetChildren() do
            local v87 = v2[v86:GetAttribute("ItemName") or v86.Name];
            if v86:GetAttribute("EquipSlot") == "Hat" then
                v83 = true;
            end;
            if v87 then
                if v87.IKMods then
                    for v88, v89 in next, v87.IKMods do
                        for v90, v91 in next, v89 do
                            local v92 = v88 .. v90;
                            v81[v92] = math.min(v81[v92] or v91, v91);
                        end;
                    end;
                end;
                if v87.HidesHair then
                    v84 = true;
                end;
            end;
        end;
        for v93, v94 in next, v81 do
            l_Equipment_4:SetAttribute(v93, v94);
        end;
        v82 = (not not v83 or v84) and 1 or 0;
        if l_l_Hair_0_Attribute_0 and v83 then
            v82 = v84 and 1 or 0;
        end;
        for _, v96 in next, l_Hair_0:GetDescendants() do
            if v96:IsA("BasePart") then
                v96.Transparency = v82;
            end;
        end;
    end;
end;
v5.UndressItem = function(v98, v99, v100) --[[ Line: 374 ]] --[[ Name: UndressItem ]]
    -- upvalues: v2 (copy), v41 (copy), v97 (copy)
    local v101 = if typeof(v100) == "table" then v100 else v2[v100];
    if v101 then
        if v101.EquipSlot == "Top" then
            v98:DressShirt(v99, "Default");
        elseif v101.EquipSlot == "Bottom" then
            v98:DressPants(v99, "Default");
        end;
        local l_Equipment_5 = v99:FindFirstChild("Equipment");
        if l_Equipment_5 then
            local l_l_Equipment_5_FirstChild_0 = l_Equipment_5:FindFirstChild(v101.RealName);
            if l_l_Equipment_5_FirstChild_0 then
                l_l_Equipment_5_FirstChild_0:Destroy();
            end;
            if v101.Is3DClothing then
                local l_l_Equipment_5_FirstChild_1 = l_Equipment_5:FindFirstChild(v101.RealName .. " 3D Clothing");
                if l_l_Equipment_5_FirstChild_1 then
                    l_l_Equipment_5_FirstChild_1:Destroy();
                end;
            end;
            v41(v99);
        end;
        v97(v99);
    end;
end;
v5.UndressSlot = function(v105, v106, v107) --[[ Line: 411 ]] --[[ Name: UndressSlot ]]
    -- upvalues: v76 (copy), v97 (copy)
    if v107 == "Top" then
        v105:DressShirt(v106, "Default");
    elseif v107 == "Bottom" then
        v105:DressPants(v106, "Default");
    end;
    v76(v106, v107);
    v97(v106);
end;
v5.DressPants = function(_, v109, v110) --[[ Line: 425 ]] --[[ Name: DressPants ]]
    -- upvalues: v2 (copy), v28 (copy), v9 (copy), v76 (copy), v61 (copy)
    local l_Humanoid_0 = v109:FindFirstChild("Humanoid");
    local l_Pants_0 = v109:FindFirstChild("Pants");
    local v113 = if typeof(v110) == "table" then v110 else v2[v110];
    if l_Humanoid_0 and l_Pants_0 then
        local v114 = nil;
        if v113 then
            v114 = "rbxassetid://" .. v113.ClothingId;
        end;
        if v110 == "Default" then
            v114 = "rbxassetid://5486306372";
        end;
        if v114 then
            l_Pants_0.PantsTemplate = v114;
        end;
        if v113 then
            l_Pants_0:SetAttribute("ItemName", v113.RealName);
        else
            l_Pants_0:SetAttribute("ItemName", "Default");
        end;
    elseif not l_Humanoid_0 then
        local v115 = nil;
        if v110 == "Default" then
            v115 = "Pants Default";
        elseif v113 then
            v115 = v113.RealName;
        end;
        if v115 then
            v28(v109, v9, v115);
        end;
    end;
    v76(v109, "Bottom");
    if v113 and v113.Is3DClothing then
        v61(v109, v113);
    end;
end;
v5.DressShirt = function(_, v117, v118) --[[ Line: 476 ]] --[[ Name: DressShirt ]]
    -- upvalues: v2 (copy), v28 (copy), v8 (copy), v76 (copy), v61 (copy)
    local l_Humanoid_1 = v117:FindFirstChild("Humanoid");
    local l_Shirt_0 = v117:FindFirstChild("Shirt");
    local v121 = if typeof(v118) == "table" then v118 else v2[v118];
    if l_Humanoid_1 and l_Shirt_0 then
        local v122 = nil;
        if v121 then
            v122 = "rbxassetid://" .. v121.ClothingId;
        end;
        if v118 == "Default" then
            v122 = "rbxassetid://1549828522";
        end;
        if v122 then
            l_Shirt_0.ShirtTemplate = v122;
        end;
        if v121 then
            l_Shirt_0:SetAttribute("ItemName", v121.RealName);
        else
            l_Shirt_0:SetAttribute("ItemName", "Default");
        end;
    elseif not l_Humanoid_1 then
        local v123 = nil;
        if v118 == "Default" then
            v123 = "Shirt Default";
        elseif v121 then
            v123 = v121.RealName;
        end;
        if v123 then
            v28(v117, v8, v123);
        end;
    end;
    v76(v117, "Top");
    if v121 and v121.Is3DClothing then
        v61(v117, v121);
    end;
end;
v5.DressAccessory = function(_, v125, v126, v127) --[[ Line: 527 ]] --[[ Name: DressAccessory ]]
    -- upvalues: v2 (copy), v11 (copy), v61 (copy), v70 (copy), v97 (copy)
    local v128 = if typeof(v126) == "table" then v126 else v2[v126];
    if v128 and table.find(v11, v128.EquipSlot) then
        if v128.Is3DClothing then
            v61(v125, v128, v127);
        else
            v70(v125, v128, v127);
        end;
    end;
    v97(v125);
end;
v5.SetHair = function(_, v130, v131, v132) --[[ Line: 542 ]] --[[ Name: SetHair ]]
    -- upvalues: v4 (copy), v2 (copy), v50 (copy), v97 (copy)
    local l_Hair_1 = v130:FindFirstChild("Hair");
    if l_Hair_1 and v131 == "Bald" then
        local l_Hair_2 = l_Hair_1:FindFirstChild("Hair");
        if l_Hair_2 then
            l_Hair_2:Destroy();
        end;
    elseif l_Hair_1 and v131 and v132 then
        local v135 = v4:Find("ReplicatedStorage.Assets.Items." .. v131);
        local l_Head_0 = v130:FindFirstChild("Head");
        local v137 = nil;
        if v2[v131] and v2[v131].Colors then
            v137 = v2[v131].Colors[v132];
        end;
        if v135 and l_Head_0 and v137 then
            local l_Hair_3 = l_Hair_1:FindFirstChild("Hair");
            if l_Hair_3 then
                l_Hair_3:Destroy();
            end;
            l_Hair_3 = v135:Clone();
            l_Hair_3:SetAttribute("Style", v131);
            l_Hair_3:SetAttribute("Color", v132);
            l_Hair_3.Hair.TextureID = v137;
            l_Hair_3.Head.Mesh.Scale = Vector3.new(0, 0, 0, 0);
            v50(l_Hair_3, l_Head_0);
            l_Hair_3.Name = "Hair";
            l_Hair_3.Parent = l_Hair_1;
        end;
    end;
    v97(v130);
end;
v5.SetSkinColor = function(_, v140, v141) --[[ Line: 577 ]] --[[ Name: SetSkinColor ]]
    -- upvalues: v3 (copy), v10 (copy)
    if typeof(v141) == "number" then
        v141 = v3.Body.Colors[v141];
    end;
    if v141 and typeof(v141) == "Color3" then
        for _, v143 in next, v10 do
            local l_v140_FirstChild_0 = v140:FindFirstChild(v143);
            if l_v140_FirstChild_0 then
                l_v140_FirstChild_0.Color = v141;
            end;
        end;
    end;
end;
v5.SetFace = function(_, v146, v147) --[[ Line: 593 ]] --[[ Name: SetFace ]]
    -- upvalues: v7 (copy)
    if v147 == "Default" then
        v147 = "rbxasset://textures/face.png";
    end;
    local l_Head_1 = v146:FindFirstChild("Head");
    local v149 = tonumber(v147:match("%d+$"));
    if v7[v149] then
        v147 = v147:gsub(v149, v7[v149]);
    end;
    if l_Head_1 then
        local l_Face_0 = l_Head_1:FindFirstChild("Face");
        if l_Face_0 then
            l_Face_0.Texture = v147;
        end;
    end;
end;
v5.SetDefault = function(v151, v152) --[[ Line: 614 ]] --[[ Name: SetDefault ]]
    -- upvalues: v6 (copy), v11 (copy)
    v151:SetHair(v152, "Bald");
    v151:SetSkinColor(v152, v6);
    v151:SetFace(v152, "Default");
    v151:DressShirt(v152, "Default");
    v151:DressPants(v152, "Default");
    for _, v154 in next, v11 do
        v151:UndressSlot(v152, v154);
    end;
end;
v5.ApplyOutfit = function(v155, v156, v157) --[[ Line: 627 ]] --[[ Name: ApplyOutfit ]]
    -- upvalues: v11 (copy)
    if v157.HairStyle ~= nil then
        v155:SetHair(v156, v157.HairStyle, v157.HairColor);
    end;
    if v157.SkinColor then
        v155:SetSkinColor(v156, v157.SkinColor);
    end;
    if v157.FaceTexture then
        v155:SetFace(v156, v157.FaceTexture);
    end;
    if v157.Top then
        v155:DressShirt(v156, v157.Top);
    end;
    if v157.Bottom then
        v155:DressPants(v156, v157.Bottom);
    end;
    for _, v159 in next, v11 do
        if v157[v159] then
            v155:DressAccessory(v156, v157[v159]);
        end;
    end;
end;
v5.DressFromOutfit = function(v160, v161, v162) --[[ Line: 658 ]] --[[ Name: DressFromOutfit ]]
    v160:SetDefault(v161);
    v160:ApplyOutfit(v161, v162);
end;
v5.SetFaceFromUserId = function(v163, v164, v165) --[[ Line: 666 ]] --[[ Name: SetFaceFromUserId ]]
    task.spawn(function() --[[ Line: 667 ]]
        -- upvalues: v165 (copy), v163 (copy), v164 (copy)
        local l_Players_0 = game:GetService("Players");
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 670 ]]
            -- upvalues: l_Players_0 (copy), v165 (ref)
            return l_Players_0:GetCharacterAppearanceAsync(v165);
        end);
        if l_status_0 and l_result_0 then
            local v169 = l_result_0:WaitForChild("face", 1);
            if v169 then
                v163:SetFace(v164, v169.Texture);
            end;
            l_result_0:Destroy();
        end;
    end);
end;
v5.SetHairVisible = function(_, v171, v172) --[[ Line: 686 ]] --[[ Name: SetHairVisible ]]
    -- upvalues: v97 (copy)
    local l_Hair_4 = v171:FindFirstChild("Hair");
    if l_Hair_4 then
        l_Hair_4:SetAttribute("VisibleUnderHats", v172);
        v97(v171);
    end;
end;
return v5;