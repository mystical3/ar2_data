local v0 = game:GetService("RunService"):IsServer();
local v1 = nil;
v1 = if v0 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local v2 = {};
local function v7(v3, v4) --[[ Line: 20 ]] --[[ Name: unanchorModel ]]
    for _, v6 in next, v3:GetDescendants() do
        if v6:IsA("BasePart") and v6 ~= v4 and not v6:FindFirstChild("KeepAnchored") then
            v6.Anchored = false;
        end;
    end;
    v4.Anchored = false;
end;
local _ = function(v8, v9) --[[ Line: 32 ]] --[[ Name: setCollisions ]]
    for _, v11 in next, v8:GetDescendants() do
        if v11:IsA("BasePart") then
            v11.CanCollide = not not v9;
        end;
    end;
end;
local function v17(v13, v14) --[[ Line: 40 ]] --[[ Name: setMassless ]]
    for _, v16 in next, v13:GetDescendants() do
        if v16:IsA("BasePart") then
            v16.Massless = v14;
        end;
    end;
end;
v2.UnanchorModel = function(v18) --[[ Line: 50 ]]
    -- upvalues: v7 (copy)
    v7(v18, v18.PrimaryPart);
end;
v2.Attach = function(v19, v20, v21, v22) --[[ Line: 54 ]]
    local l_Attachment_0 = Instance.new("Attachment");
    l_Attachment_0.Position = v20 or l_Attachment_0.Position;
    l_Attachment_0.Axis = v21 or l_Attachment_0.Axis;
    l_Attachment_0.SecondaryAxis = v22 or l_Attachment_0.SecondaryAxis;
    l_Attachment_0.Parent = v19;
    return l_Attachment_0;
end;
v2.Weld = function(v24, v25, v26, v27, v28) --[[ Line: 64 ]]
    local l_Weld_0 = Instance.new("Weld");
    l_Weld_0.Part0 = v24;
    l_Weld_0.Part1 = v25;
    l_Weld_0.C0 = v26 or CFrame.new();
    l_Weld_0.C1 = v27 or CFrame.new();
    l_Weld_0.Parent = v28 or v24;
    return l_Weld_0;
end;
v2.Motor = function(v30, v31, v32, v33, v34) --[[ Line: 75 ]]
    local l_Motor6D_0 = Instance.new("Motor6D");
    l_Motor6D_0.Part0 = v30;
    l_Motor6D_0.Part1 = v31;
    l_Motor6D_0.C0 = v32 or CFrame.new();
    l_Motor6D_0.C1 = v33 or CFrame.new();
    l_Motor6D_0.Parent = v34 or v30;
    return l_Motor6D_0;
end;
v2.AutoJoin = function(v36, v37, v38) --[[ Line: 86 ]]
    return v36(v37, v38, v37.CFrame:toObjectSpace(v38.CFrame));
end;
v2.WeldModel = function(v39, v40) --[[ Line: 90 ]]
    -- upvalues: v2 (copy)
    for _, v42 in next, v39:GetDescendants() do
        if v42:IsA("BasePart") and v42 ~= v40 and not v42:FindFirstChild("NoWeld") then
            v2.AutoJoin(v2.Weld, v40, v42);
        end;
    end;
end;
v2.AttachMeleeToCharacter = function(v43, v44) --[[ Line: 100 ]]
    -- upvalues: v2 (copy), v7 (copy), v17 (copy)
    local v45 = v44[v43.PrimaryPart.Name];
    local l_LimbWeldModels_0 = v43:FindFirstChild("LimbWeldModels");
    if l_LimbWeldModels_0 then
        for _, v48 in next, l_LimbWeldModels_0:GetChildren() do
            if v48:IsA("Model") and v48.PrimaryPart then
                local l_v44_FirstChild_0 = v44:FindFirstChild(v48.PrimaryPart.Name);
                if l_v44_FirstChild_0 then
                    v2.WeldModel(v48, v48.PrimaryPart);
                    v48.PrimaryPart.Name = v48.PrimaryPart.Name .. "Grip";
                    local v50 = v2.Motor(l_v44_FirstChild_0, v48.PrimaryPart);
                    v50.Name = "Handle";
                    v50.Parent = v48.PrimaryPart;
                    v50.CurrentAngle = 0.01;
                end;
            end;
        end;
        for _, v52 in next, v43:GetChildren() do
            if v52:IsA("Model") then
                v2.WeldModel(v52, v43.PrimaryPart);
            elseif v52:IsA("BasePart") and not v52:FindFirstChild("NoWeld") then
                v2.AutoJoin(v2.Weld, v43.PrimaryPart, v52);
            end;
        end;
    else
        v2.WeldModel(v43, v43.PrimaryPart);
    end;
    v7(v43, v43.PrimaryPart);
    for _, v54 in next, v43:GetDescendants() do
        if v54:IsA("BasePart") then
            v54.CanCollide = false;
        end;
    end;
    v17(v43, true);
    v43.PrimaryPart.Name = v43.PrimaryPart.Name .. "Grip";
    local v55 = v2.Motor(v45, v43.PrimaryPart);
    v55.Name = "Handle";
    v55.Parent = v43.PrimaryPart;
    v55.CurrentAngle = 0.01;
    v43.PrimaryPart.Transparency = 1;
    v43.Parent = v44.Equipped;
    return v43, v55;
end;
v2.AttachFirearmToCharacter = function(v56, v57) --[[ Line: 154 ]]
    -- upvalues: v2 (copy), v17 (copy), v7 (copy)
    local l_RightHand_0 = v57.RightHand;
    for _, v60 in next, v56:GetChildren() do
        if v60:IsA("Folder") and v60.Name == "AmmoAnimation" then
            local l_LeftHand_0 = v60.LeftHand;
            for _, v63 in next, v60:GetChildren() do
                if v63 ~= l_LeftHand_0 then
                    v2.WeldModel(v63, v63.PrimaryPart);
                    v2.AutoJoin(v2.Weld, v63.PrimaryPart, l_LeftHand_0);
                end;
            end;
            v2.Motor(l_RightHand_0.Parent.LeftHand, l_LeftHand_0, CFrame.new(0, -l_LeftHand_0.Size.Y * 0.5, -l_LeftHand_0.Size.Z * 0.5), CFrame.new(0, -l_LeftHand_0.Size.Y * 0.5, -l_LeftHand_0.Size.Z * 0.5), l_LeftHand_0).Name = "MagPivot";
            l_LeftHand_0.Name = "MagGrip";
            for _, v65 in next, v60:GetDescendants() do
                if v65:IsA("BasePart") then
                    v65.Transparency = 1;
                end;
            end;
        elseif v60:IsA("Folder") and v60:FindFirstChild("BasePart") and v60:FindFirstChild("PivotPoint") then
            local l_BasePart_0 = v60.BasePart;
            local l_PivotPoint_0 = v60.PivotPoint;
            v2.Motor(v56.PrimaryPart, l_BasePart_0, v56.PrimaryPart.CFrame:toObjectSpace(l_PivotPoint_0.CFrame), l_BasePart_0.CFrame:toObjectSpace(l_PivotPoint_0.CFrame), l_BasePart_0);
            l_BasePart_0.Name = v60.Name;
            l_PivotPoint_0:Destroy();
            v2.WeldModel(v60, l_BasePart_0);
        elseif v60:IsA("BasePart") then
            if v60.Name == "RightGrip" then
                v2.AutoJoin(v2.Motor, v56.PrimaryPart, v60).Name = "RightGrip";
            elseif v60.Name == "LeftGrip" then
                v2.AutoJoin(v2.Motor, v56.PrimaryPart, v56.LeftGrip).Name = "LeftGrip";
            elseif not v60:FindFirstChild("NoWeld") then
                v2.AutoJoin(v2.Weld, v60, v56.PrimaryPart);
            end;
        end;
    end;
    for _, v69 in next, v56:GetDescendants() do
        if v69:IsA("BasePart") then
            v69.CanCollide = false;
        end;
    end;
    v17(v56, true);
    v7(v56, v56.PrimaryPart);
    local v70 = v2.Motor(l_RightHand_0, v56.PrimaryPart);
    v70.Name = "Handle";
    v70.Parent = v56.Base;
    v56.Parent = v57.Equipped;
    return v56, v70;
end;
v2.formatFirearmAsWelded = function(v71) --[[ Line: 233 ]] --[[ Name: formatFirearmAsWelded ]]
    for _, v73 in next, v71:GetChildren() do
        if v73:IsA("Folder") and v73.Name == "AmmoAnimation" then
            v73.LeftHand.Name = "MagGrip";
            for _, v75 in next, v73:GetDescendants() do
                if v75:IsA("BasePart") then
                    v75.Transparency = 1;
                end;
            end;
        elseif v73:IsA("Folder") and v73:FindFirstChild("BasePart") and v73:FindFirstChild("PivotPoint") then
            local l_BasePart_1 = v73.BasePart;
            local l_PivotPoint_1 = v73.PivotPoint;
            l_BasePart_1.Name = v73.Name;
            l_PivotPoint_1:Destroy();
        elseif v73:IsA("BasePart") then

        end;
    end;
end;
return v2;