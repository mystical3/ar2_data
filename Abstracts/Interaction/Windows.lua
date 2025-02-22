local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Maids");
local l_CollectionService_0 = game:GetService("CollectionService");
local v5 = v1:Find("ReplicatedStorage.Assets.Sounds.Impact.Glass 1");
local v6 = v1:Find("ReplicatedStorage.Assets.Sounds.Impact.Generic 1");
local v7 = v1:Find("ReplicatedStorage.Assets.Particles.Glass");
local v8 = v1:Find("ReplicatedStorage.Assets.Particles.Sticks");
local v9 = {};
v9.__index = v9;
local function v21(v10) --[[ Line: 22 ]] --[[ Name: prepModel ]]
    -- upvalues: l_CollectionService_0 (copy)
    local l_DecalPart_0 = v10.DecalPart;
    l_DecalPart_0.Transparency = 1;
    l_DecalPart_0.CanCollide = false;
    l_DecalPart_0.TopSurface = Enum.SurfaceType.Smooth;
    l_DecalPart_0.BottomSurface = Enum.SurfaceType.Smooth;
    local l_Frame_0 = v10.Instance:FindFirstChild("Frame");
    if l_Frame_0 then
        for _, v14 in next, l_Frame_0:GetDescendants() do
            if v14:IsA("BasePart") then
                v14.CanCollide = false;
            end;
        end;
    end;
    local l_FirstChild_0 = v10.Instance:FindFirstChild("Break Glass");
    local l_FirstChild_1 = v10.Instance:FindFirstChild("Break Frame");
    if l_FirstChild_0 then
        for _, v18 in next, l_FirstChild_0:GetDescendants() do
            l_CollectionService_0:AddTag(v18, "Window Part");
        end;
    end;
    if l_FirstChild_1 then
        for _, v20 in next, l_FirstChild_1:GetDescendants() do
            l_CollectionService_0:AddTag(v20, "Window Part");
        end;
    end;
    if v10.Decal then
        v10.Decal.Transparency = 1;
    end;
end;
local function v41(v22, v23) --[[ Line: 59 ]] --[[ Name: breakWindow ]]
    -- upvalues: v5 (copy), v1 (copy), v7 (copy), v6 (copy), v8 (copy)
    local v24 = false;
    local v25 = false;
    local v26 = 0;
    local v27 = Vector3.new();
    if v22.BrokenWindow then
        local l_FirstChild_2 = v22.Instance:FindFirstChild("Break Glass");
        if v22.Decal then
            v22.Decal:Destroy();
            v22.Decal = nil;
        end;
        if l_FirstChild_2 then
            l_FirstChild_2:Destroy();
            v24 = true;
        end;
    end;
    if v22.BrokenFrame then
        local l_FirstChild_3 = v22.Instance:FindFirstChild("Break Frame");
        if l_FirstChild_3 then
            for _, v31 in next, l_FirstChild_3:GetDescendants() do
                if v31:IsA("BasePart") then
                    v27 = v27 + Vector3.new(v31.Color.R, v31.Color.G, v31.Color.B);
                    v26 = v26 + 1;
                end;
            end;
            l_FirstChild_3:Destroy();
            v25 = true;
        end;
    end;
    if v23 then
        if v24 then
            local v32 = v5:Clone();
            v32.SoundGroup = v1:Find("SoundService.Effects");
            v32.Parent = v22.DecalPart;
            local v33 = v7:Clone();
            v33.Parent = v22.DecalPart;
            local l_Size_0 = v22.DecalPart.Size;
            v33:Emit(l_Size_0.Y * l_Size_0.X / 3.46);
            v32:Play();
            local l_v33_0 = v33 --[[ copy: 7 -> 12 ]];
            local l_v32_0 = v32 --[[ copy: 6 -> 13 ]];
            delay(3, function() --[[ Line: 111 ]]
                -- upvalues: l_v33_0 (copy), l_v32_0 (copy)
                l_v33_0:Destroy();
                l_v32_0:Destroy();
            end);
        end;
        if v25 and v26 > 0 then
            local v37 = v6:Clone();
            v37.SoundGroup = v1:Find("SoundService.Effects");
            v37.Parent = v22.DecalPart;
            local v38 = v27 / v26;
            local v39 = Color3.new(v38.X, v38.Y, v38.Z);
            local v40 = v8:Clone();
            v40.Color = ColorSequence.new(v39);
            v40.Parent = v22.DecalPart;
            v40:Emit(v26);
            v37:Play();
            delay(3, function() --[[ Line: 132 ]]
                -- upvalues: v40 (copy), v37 (copy)
                v40:Destroy();
                v37:Destroy();
            end);
        end;
    end;
end;
v9.new = function(v42, v43, v44) --[[ Line: 142 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), v41 (copy), v21 (copy), v9 (copy)
    local v45 = {
        Type = "Window", 
        Id = v42, 
        Destroyed = false, 
        Instance = v43
    };
    v45.DecalPart = v45.Instance.PrimaryPart;
    v45.Decal = v45.DecalPart:WaitForChild("Decal", 0.1);
    v45.Maid = v3.new();
    v45.Maid:Give(v44:GetAttributeChangedSignal("BrokenWindow"):Connect(function() --[[ Line: 157 ]]
        -- upvalues: v45 (copy), v44 (copy), v41 (ref)
        v45.BrokenWindow = v44:GetAttribute("BrokenWindow");
        v41(v45, true);
        if v45.BrokenWindow and v45.BrokenFrame then
            v45.Destroyed = true;
        end;
    end));
    v45.Maid:Give(v44:GetAttributeChangedSignal("BrokenFrame"):Connect(function(_) --[[ Line: 167 ]]
        -- upvalues: v45 (copy), v44 (copy), v41 (ref)
        v45.BrokenFrame = v44:GetAttribute("BrokenFrame");
        v41(v45, true);
        if v45.BrokenWindow and v45.BrokenFrame then
            v45.Destroyed = true;
        end;
    end));
    v45.BrokenWindow = v44:GetAttribute("BrokenWindow");
    v45.BrokenFrame = v44:GetAttribute("BrokenFrame");
    v45.HomeCFrame = v45.DecalPart.CFrame;
    v21(v45);
    v41(v45, false);
    return (setmetatable(v45, v9));
end;
v9.Destroy = function(v47) --[[ Line: 192 ]] --[[ Name: Destroy ]]
    if v47.Destroyed then
        return;
    else
        v47.Destroyed = true;
        if v47.Maid then
            v47.Maid:Destroy();
            v47.Maid = nil;
        end;
        setmetatable(v47, nil);
        table.clear(v47);
        v47.Destroyed = true;
        return;
    end;
end;
v9.GetInteractionPosition = function(v48, _, _) --[[ Line: 210 ]] --[[ Name: GetInteractionPosition ]]
    return v48.HomeCFrame.p;
end;
v9.CanBreak = function(v51) --[[ Line: 214 ]] --[[ Name: CanBreak ]]
    if v51.BrokenWindow and v51.BrokenFrame then
        return false;
    else
        return true;
    end;
end;
v9.Interact = function(v52) --[[ Line: 222 ]] --[[ Name: Interact ]]
    -- upvalues: v2 (copy)
    v2:Send("World Interact", v52.Id);
end;
v9.SetDetailed = function(v53, v54) --[[ Line: 226 ]] --[[ Name: SetDetailed ]]
    for _, v56 in next, v53.Instance:GetDescendants() do
        if v56:IsA("BasePart") then
            v56.LocalTransparencyModifier = v54 and 0 or 1;
        end;
    end;
    if v53.Decal then
        v53.Decal.Transparency = v54 and 1 or 0;
    end;
end;
return v9;