local v0 = game:GetService("RunService"):IsServer();
local v1 = nil;
v1 = if v0 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local v2 = v1.require("Libraries", "Resources");
local v3 = v1.require("Configs", "FirearmSkinsData");
local v4 = v1.require("Configs", "ItemData");
local v5 = {};
local v6 = {
    Ammo = true, 
    Sight = true, 
    Underbarrel = true, 
    Barrel = true
};
local function v11(v7, ...) --[[ Line: 35 ]] --[[ Name: clean ]]
    for _, v9 in next, {
        ...
    } do
        local l_v7_FirstChild_0 = v7:FindFirstChild(v9);
        if l_v7_FirstChild_0 then
            l_v7_FirstChild_0:Destroy();
        end;
    end;
end;
local function _(v12, v13) --[[ Line: 45 ]] --[[ Name: setTransparency ]]
    local l_Texture_0 = v12:FindFirstChildOfClass("Texture");
    if l_Texture_0 then
        l_Texture_0.Transparency = v13;
    end;
    v12.Transparency = v13;
end;
local function v22(v16, v17, v18, v19, v20) --[[ Line: 55 ]] --[[ Name: weld ]]
    local l_Weld_0 = Instance.new("Weld");
    l_Weld_0.Part0 = v16;
    l_Weld_0.Part1 = v17;
    l_Weld_0.C0 = v18 or CFrame.new();
    l_Weld_0.C1 = v19 or CFrame.new();
    l_Weld_0.Parent = v20 or v16;
    return l_Weld_0;
end;
local function _(v23, v24, v25) --[[ Line: 66 ]] --[[ Name: autoJoin ]]
    return v23(v24, v25, v24.CFrame:toObjectSpace(v25.CFrame));
end;
local function v32(v27, v28) --[[ Line: 70 ]] --[[ Name: weldModel ]]
    -- upvalues: v22 (copy)
    for _, v30 in next, v27:GetDescendants() do
        if v30 ~= v28 and v30:IsA("BasePart") and not v30:FindFirstChild("NoWeld") then
            local _ = v22(v28, v30, v28.CFrame:toObjectSpace(v30.CFrame));
        end;
    end;
end;
local function v36(v33) --[[ Line: 80 ]] --[[ Name: unanchorModel ]]
    for _, v35 in next, v33:GetDescendants() do
        if v35:IsA("BasePart") and not v35:FindFirstChild("KeepAnchored") then
            v35.Anchored = false;
        end;
    end;
end;
local function v42(v37, v38) --[[ Line: 90 ]] --[[ Name: findParts ]]
    local v39 = {};
    for _, v41 in next, v37:GetDescendants() do
        if v41.Name == v38 then
            table.insert(v39, v41);
        end;
    end;
    return v39;
end;
local function v54(v43, v44, v45) --[[ Line: 102 ]] --[[ Name: setAdapters ]]
    -- upvalues: v42 (copy)
    for _, v47 in next, v42(v43, "Yes" .. v44) do
        local v48 = v45 and 0 or 1;
        local l_Texture_1 = v47:FindFirstChildOfClass("Texture");
        if l_Texture_1 then
            l_Texture_1.Transparency = v48;
        end;
        v47.Transparency = v48;
    end;
    for _, v51 in next, v42(v43, "No" .. v44) do
        local v52 = v45 and 1 or 0;
        local l_Texture_2 = v51:FindFirstChildOfClass("Texture");
        if l_Texture_2 then
            l_Texture_2.Transparency = v52;
        end;
        v51.Transparency = v52;
    end;
end;
local function v63(v55, v56, v57) --[[ Line: 112 ]] --[[ Name: attach ]]
    -- upvalues: v2 (copy), v32 (copy), v36 (copy), v11 (copy), v54 (copy)
    local l_v55_FirstChild_0 = v55:FindFirstChild(v56 .. "Mount", true);
    if l_v55_FirstChild_0 then
        local v59 = v2:Get("ReplicatedStorage.Assets.Items." .. v57);
        v59:SetPrimaryPartCFrame(l_v55_FirstChild_0.CFrame);
        v59.Name = v56;
        local v60 = Instance.new("StringValue", v59);
        v60.Name = "RealName";
        v60.Value = v57;
        local l_PrimaryPart_0 = v59.PrimaryPart;
        local l_Weld_1 = Instance.new("Weld");
        l_Weld_1.Part0 = l_v55_FirstChild_0;
        l_Weld_1.Part1 = l_PrimaryPart_0;
        l_Weld_1.C0 = CFrame.new();
        l_Weld_1.C1 = CFrame.new();
        l_Weld_1.Parent = l_v55_FirstChild_0;
        v32(v59, v59.PrimaryPart);
        v36(v59);
        v11(v55, v56);
        v54(v55, v56, true);
        v59.Parent = v55;
    end;
end;
local function v77(v64, v65, v66) --[[ Line: 134 ]] --[[ Name: setMagazines ]]
    local l_Magazine_0 = v64:FindFirstChild("Magazine");
    local l_MagazineConstant_0 = v64:FindFirstChild("MagazineConstant");
    local l_AmmoAnimation_0 = v64:FindFirstChild("AmmoAnimation");
    if v65 and not l_Magazine_0 then
        l_Magazine_0 = v64:FindFirstChild(v65);
    end;
    for _, v71 in next, v64:GetDescendants() do
        local v72 = v71:IsA("BasePart");
        if l_AmmoAnimation_0 and v71:IsDescendantOf(l_AmmoAnimation_0) then
            v72 = false;
        end;
        if v72 and v71.Name:find("Magazine") then
            local l_Texture_3 = v71:FindFirstChildOfClass("Texture");
            if l_Texture_3 then
                l_Texture_3.Transparency = 1;
            end;
            v71.Transparency = 1;
        end;
    end;
    if l_Magazine_0 then
        local l_l_Magazine_0_0 = l_Magazine_0;
        local l_Texture_4 = l_l_Magazine_0_0:FindFirstChildOfClass("Texture");
        if l_Texture_4 then
            l_Texture_4.Transparency = v66;
        end;
        l_l_Magazine_0_0.Transparency = v66;
    end;
    if l_MagazineConstant_0 then
        local l_Texture_5 = l_MagazineConstant_0:FindFirstChildOfClass("Texture");
        if l_Texture_5 then
            l_Texture_5.Transparency = v66;
        end;
        l_MagazineConstant_0.Transparency = v66;
    end;
end;
local function v81(v78) --[[ Line: 166 ]] --[[ Name: wipeSightGuis ]]
    for _, v80 in next, v78:GetDescendants() do
        if v80:IsA("SurfaceGui") then
            v80.Enabled = false;
        end;
    end;
end;
local _ = function(v82, v83) --[[ Line: 174 ]] --[[ Name: findGunPart ]]
    for _, v85 in next, v82:GetDescendants() do
        if v85:IsA("BasePart") and v85.Name == v83 then
            return v85;
        end;
    end;
    return nil;
end;
local function v92(v87) --[[ Line: 184 ]] --[[ Name: cleanFirearmSkin ]]
    for _, v89 in next, v87:GetDescendants() do
        if v89:IsA("Texture") and v89.Name == "Skin Texture" then
            v89:Destroy();
        elseif v89:IsA("SpecialMesh") then
            local l_v89_Attribute_0 = v89:GetAttribute("OriginalVertexColor");
            local l_v89_Attribute_1 = v89:GetAttribute("OriginalTextureId");
            if l_v89_Attribute_0 then
                v89.VertexColor = l_v89_Attribute_0;
            end;
            if l_v89_Attribute_1 then
                v89.TextureId = l_v89_Attribute_1;
            end;
        end;
    end;
end;
local function v110(v93, v94) --[[ Line: 207 ]] --[[ Name: applyFirearmSkin ]]
    -- upvalues: v3 (copy)
    local l_v3_SkinFromId_0 = v3:GetSkinFromId(v94);
    if l_v3_SkinFromId_0 then
        for _, v97 in next, v93:GetDescendants() do
            local l_v97_Attribute_0 = v97:GetAttribute("SkinPattern");
            if l_v97_Attribute_0 and not l_v3_SkinFromId_0.Patterns[l_v97_Attribute_0] then
                l_v97_Attribute_0 = v97:GetAttribute("BackupPattern");
            end;
            if l_v97_Attribute_0 and l_v3_SkinFromId_0.Patterns[l_v97_Attribute_0] then
                local v99 = l_v3_SkinFromId_0.Patterns[l_v97_Attribute_0];
                local v100 = v99.Channel1[1];
                local v101 = Color3.new(select(2, unpack(v99.Channel1)));
                local v102 = v99.Channel2[1];
                local v103 = Color3.new(select(2, unpack(v99.Channel2)));
                if v97:IsA("MeshPart") then
                    for _, v105 in next, Enum.NormalId:GetEnumItems() do
                        local l_Texture_6 = Instance.new("Texture");
                        l_Texture_6.Name = "Skin Texture";
                        l_Texture_6.Texture = v100;
                        l_Texture_6.Color3 = v101;
                        l_Texture_6.Transparency = v97.Transparency;
                        l_Texture_6.ZIndex = 1;
                        l_Texture_6.Face = v105;
                        l_Texture_6.Parent = v97;
                        local l_Texture_7 = Instance.new("Texture");
                        l_Texture_7.Name = "Skin Texture";
                        l_Texture_7.Texture = v102;
                        l_Texture_7.Color3 = v103;
                        l_Texture_7.Transparency = v97.Transparency;
                        l_Texture_7.ZIndex = 2;
                        l_Texture_7.Face = v105;
                        l_Texture_7.Parent = v97;
                    end;
                else
                    local l_SpecialMesh_0 = v97:FindFirstChildOfClass("SpecialMesh");
                    local l_Texture_8 = v97:FindFirstChildOfClass("Texture");
                    if l_SpecialMesh_0 then
                        if not l_SpecialMesh_0:GetAttribute("OriginalVertexColor") then
                            l_SpecialMesh_0:SetAttribute("OriginalVertexColor", l_SpecialMesh_0.VertexColor);
                        end;
                        if not l_SpecialMesh_0:GetAttribute("OriginalTextureId") then
                            l_SpecialMesh_0:SetAttribute("OriginalTextureId", l_SpecialMesh_0.TextureId);
                        end;
                        if not l_Texture_8 then
                            l_Texture_8 = Instance.new("Texture", v97);
                            l_Texture_8.Name = "Skin Texture";
                        end;
                        l_SpecialMesh_0.VertexColor = Vector3.new(v101.R, v101.G, v101.B);
                        l_SpecialMesh_0.TextureId = v100;
                        l_Texture_8.Texture = v102;
                        l_Texture_8.Color3 = v103;
                        l_Texture_8.Transparency = v97.Transparency;
                    end;
                end;
            end;
        end;
    end;
end;
local function _(v111, v112, v113) --[[ Line: 278 ]] --[[ Name: getValue ]]
    local l_v111_FirstChild_0 = v111:FindFirstChild(v112);
    if not l_v111_FirstChild_0 then
        l_v111_FirstChild_0 = Instance.new(v113);
        l_v111_FirstChild_0.Name = v112;
        l_v111_FirstChild_0.Parent = v111;
    end;
    return l_v111_FirstChild_0;
end;
local function v125(v116) --[[ Line: 291 ]] --[[ Name: setOffsetValues ]]
    local l_Sight_0 = v116:FindFirstChild("Sight");
    local l_SightLine_0 = v116:FindFirstChild("SightLine");
    local l_ProjectionPlane_0 = v116:FindFirstChild("ProjectionPlane");
    if l_Sight_0 then
        l_ProjectionPlane_0 = l_Sight_0:FindFirstChild("ProjectionPlane") or l_ProjectionPlane_0;
        l_SightLine_0 = l_Sight_0:FindFirstChild("SightLine") or l_SightLine_0;
    end;
    local l_SightLineOffset_0 = v116:FindFirstChild("SightLineOffset");
    if not l_SightLineOffset_0 then
        l_SightLineOffset_0 = Instance.new("Vector3Value");
        l_SightLineOffset_0.Name = "SightLineOffset";
        l_SightLineOffset_0.Parent = v116;
    end;
    local l_l_SightLineOffset_0_0 = l_SightLineOffset_0;
    local l_SightLineSize_0 = v116:FindFirstChild("SightLineSize");
    if not l_SightLineSize_0 then
        l_SightLineSize_0 = Instance.new("Vector3Value");
        l_SightLineSize_0.Name = "SightLineSize";
        l_SightLineSize_0.Parent = v116;
    end;
    l_SightLineOffset_0 = l_SightLineSize_0;
    local l_ProjectionOffset_0 = v116:FindFirstChild("ProjectionOffset");
    if not l_ProjectionOffset_0 then
        l_ProjectionOffset_0 = Instance.new("Vector3Value");
        l_ProjectionOffset_0.Name = "ProjectionOffset";
        l_ProjectionOffset_0.Parent = v116;
    end;
    l_SightLineSize_0 = l_ProjectionOffset_0;
    local l_ProjectionSize_0 = v116:FindFirstChild("ProjectionSize");
    if not l_ProjectionSize_0 then
        l_ProjectionSize_0 = Instance.new("Vector3Value");
        l_ProjectionSize_0.Name = "ProjectionSize";
        l_ProjectionSize_0.Parent = v116;
    end;
    l_ProjectionOffset_0 = l_ProjectionSize_0;
    if v116.PrimaryPart then
        if l_SightLine_0 then
            l_ProjectionSize_0 = l_SightLine_0.CFrame * (l_SightLine_0.Size * Vector3.new(0, 0, 0.5, 0));
            l_l_SightLineOffset_0_0.Value = -v116.PrimaryPart.CFrame:pointToObjectSpace(l_ProjectionSize_0);
            l_SightLineOffset_0.Value = l_SightLine_0.Size;
        end;
        if l_ProjectionPlane_0 then
            l_SightLineSize_0.Value = v116.PrimaryPart.CFrame:pointToObjectSpace(l_ProjectionPlane_0.Position);
            l_ProjectionOffset_0.Value = l_ProjectionPlane_0.Size;
        end;
    end;
end;
v5.Build = function(_, v127, v128) --[[ Line: 325 ]] --[[ Name: Build ]]
    -- upvalues: v54 (copy), v77 (copy), v6 (copy), v11 (copy), v63 (copy), v81 (copy), v125 (copy), v92 (copy), v110 (copy)
    if v128.Attachments then
        v54(v127, "Sight", false);
        v54(v127, "Barrel", false);
        v54(v127, "Underbarrel", false);
        v77(v127, nil, 1);
        for v129 in next, v6 do
            local v130 = v128.Attachments[v129];
            if v129 ~= "Ammo" then
                v11(v127, v129);
                if v130 then
                    v63(v127, v129, v130.Name);
                end;
            elseif v129 == "Ammo" and v130 then
                v77(v127, v130.Name, 0);
            end;
        end;
        v81(v127);
        v125(v127);
    end;
    v92(v127);
    if v128.SkinId then
        v110(v127, v128.SkinId);
    end;
end;
v5.CleanSkin = function(_, v132) --[[ Line: 357 ]] --[[ Name: CleanSkin ]]
    -- upvalues: v92 (copy)
    v92(v132);
end;
v5.ApplySkin = function(_, v134, v135) --[[ Line: 361 ]] --[[ Name: ApplySkin ]]
    -- upvalues: v110 (copy)
    v110(v134, v135);
end;
v5.SetMagazines = function(_, v137, v138, v139) --[[ Line: 365 ]] --[[ Name: SetMagazines ]]
    -- upvalues: v77 (copy)
    if v138 then
        v77(v137, v139, 0);
        return;
    else
        v77(v137, nil, 1);
        return;
    end;
end;
v5.GetBuildKey = function(_, v141) --[[ Line: 373 ]] --[[ Name: GetBuildKey ]]
    local v142 = {};
    if v141.SkinId then
        table.insert(v142, v141.SkinId);
    end;
    if v141.Attachments then
        for _, v144 in next, v141.Attachments do
            table.insert(v142, v144.Name);
        end;
    end;
    table.sort(v142, function(v145, v146) --[[ Line: 386 ]]
        return v145 < v146;
    end);
    return table.concat(v142, " ");
end;
v5.Serialize = function(_, v148) --[[ Line: 393 ]] --[[ Name: Serialize ]]
    -- upvalues: v6 (copy)
    local v149 = {
        ItemName = v148.Name or "", 
        SkinId = v148.SkinId or "", 
        Attachments = {}
    };
    if v148.Attachments then
        for v150, _ in next, v6 do
            if v148.Attachments[v150] then
                v149.Attachments[v150] = v148.Attachments[v150].Name or "";
            else
                v149.Attachments[v150] = "";
            end;
        end;
        return v149;
    else
        for v152, _ in next, v6 do
            v149.Attachments[v152] = "";
        end;
        return v149;
    end;
end;
v5.BuildFromSerialization = function(_, v155, v156) --[[ Line: 416 ]] --[[ Name: BuildFromSerialization ]]
    -- upvalues: v54 (copy), v77 (copy), v4 (copy), v11 (copy), v63 (copy), v81 (copy), v125 (copy), v92 (copy), v110 (copy)
    if v156.Attachments then
        v54(v155, "Sight", false);
        v54(v155, "Barrel", false);
        v54(v155, "Underbarrel", false);
        v77(v155, nil, 1);
        for v157, v158 in next, v156.Attachments do
            local v159 = v4[v158];
            if v157 == "Ammo" and v159 then
                if v159.Capacity then
                    v77(v155, v158, 0);
                end;
            else
                v11(v155, v157);
                if v159 then
                    v63(v155, v157, v158);
                end;
            end;
        end;
        v81(v155);
        v125(v155);
    end;
    v92(v155);
    if v156.SkinId and v156.SkinId ~= "" then
        v110(v155, v156.SkinId);
    end;
end;
v5.GetAttachmentStats = function(_, v161, v162) --[[ Line: 452 ]] --[[ Name: GetAttachmentStats ]]
    -- upvalues: v4 (copy)
    local v163 = v4[v161];
    local v164 = {};
    local v165 = {};
    for _, v167 in next, v162 do
        local v168 = v4[v167];
        if v168 and v168.HandlingMods then
            for v169, v170 in next, v168.HandlingMods do
                local v171 = v164[v169];
                if not v171 then
                    v164[v169] = {};
                    v171 = v164[v169];
                end;
                v171.Multiply = (v171.Multiply or 0) + v170.Multiply;
                v171.Addition = (v171.Addition or 0) + v170.Addition;
                v171.DiminishesBy = math.max(v171.DiminishesBy or 0, v170.DiminishesBy);
                v171.Occurances = (v171.Occurances or 0) + 1;
            end;
        end;
    end;
    for v172, v173 in next, v164 do
        local v174 = 1 - v173.DiminishesBy / v173.Occurances;
        local v175 = (1 + v173.Multiply) * v174;
        local v176 = v173.Addition * v174;
        v165[v172] = {
            Multiplier = v175, 
            Bonus = v176
        };
        if v163 then
            if v163.Handling and v163.Handling[v172] then
                local v177 = v163.Handling[v172];
                local l_v177_0 = v177;
                if typeof(v177) == "table" then
                    l_v177_0 = v177[1];
                end;
                v165[v172].Calculated = l_v177_0 * v175 + v176;
            end;
            if v163.HandlingModEffectivness and v163.HandlingModEffectivness[v172] then
                for v179, v180 in next, v165[v172] do
                    v165[v179] = v180 * v163.HandlingModEffectivness[v172];
                end;
            end;
        end;
    end;
    return v165;
end;
return v5;