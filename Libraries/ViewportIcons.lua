local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v2 = l_RunService_0:IsServer();
local v3 = nil;
v3 = if v2 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local v4 = v3.require("Configs", "ItemData");
local v5 = v3.require("Libraries", "Resources");
local v6 = v3.require("Libraries", "Wardrobe");
local v7 = v3.require("Libraries", "GunBuilder");
local v8 = v3.require("Libraries", "Welds");
local v9 = v3.require("Classes", "Steppers");
local v10 = {};
local v11 = {};
local v12 = {
    Loot = v5:Find("ReplicatedStorage.Assets.LootModels"), 
    Items = v5:Find("ReplicatedStorage.Assets.Items")
};
local _ = {
    Bottom = "Pants", 
    Top = "Shirt"
};
local _ = {
    Pants = "PantsTemplate", 
    Shirt = "ShirtTemplate"
};
local function v19(v15, v16, v17, ...) --[[ Line: 46 ]] --[[ Name: findAndDo ]]
    local l_v15_FirstChild_0 = v15:FindFirstChild(v16);
    if l_v15_FirstChild_0 then
        v17(l_v15_FirstChild_0, ...);
    end;
end;
local function v46(v20, v21, v22, v23, v24) --[[ Line: 54 ]] --[[ Name: setViewportToIconConfig ]]
    -- upvalues: v7 (copy), v19 (copy), v10 (copy), v5 (copy), v6 (copy), v12 (copy), l_CollectionService_0 (copy), v8 (copy)
    local l_ModelSource_0 = v23.ModelSource;
    if v24 == "Creator" then
        l_ModelSource_0 = "Items";
    end;
    local v26 = v21 .. " " .. v24;
    local v27 = v23.Stages[v24];
    local v28 = false;
    if v22.Maid and v22.Changed then
        local l_v7_BuildKey_0 = v7:GetBuildKey(v22);
        if l_v7_BuildKey_0 ~= "" then
            v26 = v26 .. " " .. l_v7_BuildKey_0;
            v28 = true;
        end;
    end;
    local v30 = nil;
    local v31 = false;
    v19(v20, "WorldModel", function(v32) --[[ Line: 80 ]]
        -- upvalues: v19 (ref), v26 (ref), v31 (ref), v10 (ref), v20 (copy)
        v19(v32, "View Model", function(v33) --[[ Line: 81 ]]
            -- upvalues: v26 (ref), v31 (ref), v10 (ref), v20 (ref)
            if v33:GetAttribute("IconKey") == v26 then
                v31 = true;
                return;
            else
                v10:ClearViewportIcon(v20);
                return;
            end;
        end);
    end);
    if v31 then
        return;
    else
        if l_ModelSource_0 == "Items" and v24 == "Creator" then
            v30 = v5:Get("ReplicatedStorage.Assets.Mannequin");
            v30:WaitForChild("Head"):WaitForChild("Face"):Destroy();
            if v22.Type == "Hair" then
                v6:SetHair(v30, v21, "White");
            elseif v22.EquipSlot == "Top" then
                v6:DressShirt(v30, v21);
            elseif v22.EquipSlot == "Bottom" then
                v6:DressPants(v30, v21);
            else
                v6:DressAccessory(v30, v21);
            end;
        else
            v30 = v12[l_ModelSource_0]:WaitForChild(v21):Clone();
            if v30.PrimaryPart then
                l_CollectionService_0:AddTag(v30.PrimaryPart, "ViewportInvisible");
            end;
            for _, v35 in next, v30:GetDescendants() do
                if l_CollectionService_0:HasTag(v35, "ViewportInvisible") then
                    v35:Destroy();
                end;
            end;
            v30.WorldPivot = v30:GetBoundingBox();
        end;
        v20.Ambient = v27.Ambient;
        v20.LightColor = v27.LightColor;
        v20.LightDirection = v27.LightDirection;
        v20.ImageColor3 = v27.ImageColor3;
        v20.BackgroundColor3 = v27.BackgroundColor3;
        if not v20.CurrentCamera then
            local l_Camera_0 = Instance.new("Camera");
            l_Camera_0.CFrame = CFrame.new();
            l_Camera_0.Parent = v20;
            v20.CurrentCamera = l_Camera_0;
        end;
        v20.CurrentCamera.FieldOfView = v27.FieldOfView;
        if not v20:FindFirstChild("WorldModel") then
            Instance.new("WorldModel", v20);
        end;
        local v37 = CFrame.new(v27.ModelCFrame.X, v27.ModelCFrame.Y, v27.ModelCFrame.Z);
        local v38 = CFrame.fromOrientation(v27.ModelCFrame.Pitch, v27.ModelCFrame.Yaw, v27.ModelCFrame.Roll);
        if v28 then
            if v24 == "Grid" and v22.Attachments and v22.AttachmentIconAdjustments then
                local l_AttachmentIconAdjustments_0 = v22.AttachmentIconAdjustments;
                local v40 = 0;
                local v41 = 0;
                local v42 = 0;
                for _, v44 in next, v22.Attachments do
                    local v45 = nil;
                    if l_AttachmentIconAdjustments_0[v44.Name] then
                        v45 = l_AttachmentIconAdjustments_0[v44.Name];
                    elseif l_AttachmentIconAdjustments_0[v44.Slot] then
                        v45 = l_AttachmentIconAdjustments_0[v44.Slot];
                    elseif v44.Type == "Ammo" then
                        v45 = l_AttachmentIconAdjustments_0.Ammo;
                    end;
                    if v45 then
                        v42 = math.max(v42, v45.ZoomOut);
                        v40 = v40 + v45.LeftRight;
                        v41 = v41 + v45.UpDown;
                    end;
                end;
                v37 = v37 + Vector3.new(v40, v41, -v42);
            end;
            if not v30:GetAttribute("GunFormatted") then
                v30:SetAttribute("GunFormatted", true);
                if v22.Type == "Firearm" then
                    v8.formatFirearmAsWelded(v30);
                end;
            end;
            v7:Build(v30, v22);
        end;
        v30.Name = "View Model";
        v30:SetAttribute("IconKey", v26);
        v30:PivotTo(v37 * v38);
        v30.Parent = v20.WorldModel;
        return;
    end;
end;
v10.ClearViewportIcon = function(_, v48) --[[ Line: 210 ]] --[[ Name: ClearViewportIcon ]]
    local l_WorldModel_0 = v48:FindFirstChild("WorldModel");
    local v50 = l_WorldModel_0 and l_WorldModel_0:FindFirstChild("View Model");
    if v50 then
        v50:Destroy();
    end;
end;
v10.SetViewportIcon = function(_, v52, v53, v54) --[[ Line: 219 ]] --[[ Name: SetViewportIcon ]]
    -- upvalues: v4 (copy), v46 (copy)
    local v55 = nil;
    local v56 = nil;
    local v57 = nil;
    if typeof(v53) == "string" then
        v56 = v53;
        v55 = v4[v56];
        v57 = v55.IconData;
    elseif typeof(v53) == "table" then
        v55 = v53;
        v56 = v55.RealName;
        v57 = v55.IconData;
    end;
    if v56 == nil or v57 == nil then
        warn("Couldn't dress viewport:", v52:GetFullName(), " with target:", v53);
        return;
    else
        local l_status_0, l_result_0 = pcall(v46, v52, v56, v55, v57, v54);
        if not l_status_0 then
            warn("Viewport set failed for item:", v56, "stage:", v54);
            print(l_result_0);
        end;
        return;
    end;
end;
v9.new(0, "Heartbeat", function() --[[ Line: 254 ]]
    -- upvalues: v11 (copy)
    local v60 = os.clock();
    repeat
        local v61, v62 = next(v11);
        if v61 then
            if v61.Parent then
                v62();
            end;
            v11[v61] = nil;
        end;
    until v61 == nil or os.clock() - v60 > 0.016666666666666666;
end);
return v10;