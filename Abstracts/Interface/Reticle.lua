local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Raycasting");
local v4 = v0.require("Libraries", "Cameras");
local v5 = v0.require("Libraries", "UserSettings");
local _ = v0.require("Classes", "Signals");
local v7 = v0.require("Classes", "SteppedSprings");
local v8 = v0.require("Classes", "Players");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local v12 = v2:GetStorage("Reticle"):WaitForChild("Sight Pictures");
local v13 = CFrame.new();
local v14 = {
    White = Color3.fromRGB(255, 255, 255), 
    Black = Color3.fromRGB(0, 0, 0), 
    Magenta = Color3.fromRGB(255, 0, 255), 
    Green = Color3.fromRGB(0, 255, 0), 
    Red = Color3.fromRGB(255, 0, 0), 
    Cyan = Color3.fromRGB(0, 255, 255), 
    Yellow = Color3.fromRGB(255, 255, 0)
};
local v15 = {
    Gui = v2:GetGui("Reticle")
};
v15.World = v15.Gui:WaitForChild("World");
v15.Crosshair = v15.Gui:WaitForChild("Crosshair");
v15.Stabalize = v15.Gui:WaitForChild("Stabalize");
v15.SightGlass = v15.Gui:WaitForChild("SightGlass");
local v16 = v7.new(50, 15, 1);
local v17 = v7.new(Vector2.new(), 10, 0.9);
local v18 = v7.new(1, 7.5, 1);
local v19 = false;
local v20 = nil;
local function _(v21, v22) --[[ Line: 56 ]] --[[ Name: getEquipModel ]]
    if v21.Instance and v22 then
        local l_Equipped_0 = v21.Instance:FindFirstChild("Equipped");
        if l_Equipped_0 then
            return l_Equipped_0:FindFirstChild(v22.Name);
        end;
    end;
    return nil;
end;
local function v36(v25, v26, v27, _) --[[ Line: 68 ]] --[[ Name: scaleScreenReticle ]]
    -- upvalues: v5 (copy), v2 (copy), v0 (copy), v16 (copy), v15 (copy)
    local l_v5_Setting_0 = v5:GetSetting("User Interface", "Crosshair Behavior");
    local v30 = 0;
    local l_Size_0 = v27.CrosshairConfig.Size;
    local v32 = false;
    if v25.Zooming and v27.HidesCrosshairOnZoom then
        v32 = true;
    elseif v25.LockLookDirection or v25.AtEaseInput then
        v32 = true;
    elseif v2:IsVisible("GameMenu") then
        v32 = true;
    elseif v25.BinocularsEnabled ~= "" then
        v32 = true;
    end;
    if l_v5_Setting_0 == "Dynamic" and v27.Type == "Firearm" then
        local v33 = math.deg((v0.Libraries.Bullets:GetSpreadAngle(v25, v26))) * 2 / v26.Instance.FieldOfView;
        l_Size_0 = v2:GetScreenSize().Y * v33;
    end;
    if v32 then
        l_Size_0 = l_Size_0 + 10000;
    end;
    if l_v5_Setting_0 == "Dynamic" then
        if v25.MoveState == "Running" then
            l_Size_0 = l_Size_0 + 300;
        end;
        if not v32 and v27 then
            v30 = v25.Animator.Springs.SlideSpring:GetPosition() * 700;
        end;
    end;
    if l_v5_Setting_0 == "Hidden" then
        l_Size_0 = 10000;
    end;
    v16:SetGoal(l_Size_0);
    v30 = v30 * v27.CrosshairConfig.DynamicScale;
    local v34 = math.floor(v16:GetPosition() + v30);
    local v35 = v34 + v34 % 2;
    v15.Crosshair.Crosshair.Size = UDim2.fromOffset(v35, v35);
    v15.Crosshair.Crosshair.Top.Visible = not not v27.CrosshairConfig.TopLine;
    v15.Crosshair.Crosshair.Bottom.Visible = not not v27.CrosshairConfig.BottomLine;
    v15.Crosshair.Crosshair.Left.Visible = not not v27.CrosshairConfig.LeftLine;
    v15.Crosshair.Crosshair.Right.Visible = not not v27.CrosshairConfig.RightLine;
end;
local function v41(v37) --[[ Line: 131 ]] --[[ Name: setIcons ]]
    -- upvalues: v15 (copy), v2 (copy)
    local v38 = false;
    local v39 = false;
    if v37.MoveState == "Running" then
        v39 = true;
    end;
    if v37.EquippedItem and v37.EquippedItem.Type == "Firearm" then
        local l_Amount_0 = v37.EquippedItem.Amount;
        if v37.EquippedItem.Attachments and v37.EquippedItem.Attachments.Ammo then
            l_Amount_0 = v37.EquippedItem.Attachments.Ammo.Amount;
        elseif not l_Amount_0 then
            l_Amount_0 = 0;
        end;
        if l_Amount_0 and l_Amount_0 == 0 then
            v38 = true;
        end;
        if v37.EquippedItem.Reloading then
            v38 = false;
        end;
    end;
    v15.Crosshair.NoAmmo.Visible = v38;
    v15.Crosshair.Clickable.Visible = false;
    v15.Crosshair.Clickable.NoLoot.Visible = false;
    if v2:IsVisible("GameMenu") then
        v15.Crosshair.NoAmmo.Visible = false;
        v15.Crosshair.Clickable.Visible = false;
        v15.Crosshair.Clickable.NoLoot.Visible = false;
        return;
    else
        if v39 then
            v15.Crosshair.Clickable.Visible = false;
            v15.Crosshair.NoAmmo.Visible = false;
        end;
        return;
    end;
end;
local function v58(v42, v43, v44, v45) --[[ Line: 177 ]] --[[ Name: castWorldReticle ]]
    -- upvalues: v15 (copy), v3 (copy), v1 (copy), v2 (copy), v18 (copy), v17 (copy), v19 (ref)
    local l_v15_FirearmTargetInfo_0, v47, v48 = v15:GetFirearmTargetInfo(v42, v43, v45);
    local v49 = Ray.new(l_v15_FirearmTargetInfo_0, v47 * 10);
    local v50, v51 = v3:BulletCastLight(v49, true, {
        v42.Instance
    });
    local v52 = v43.Instance:WorldToScreenPoint(v51);
    local v53 = Vector2.new(v52.X, v52.Y) + v1.GuiInset;
    local v54 = v15.Crosshair.Crosshair.AbsoluteSize * 0.5;
    local l_magnitude_0 = (v15.Crosshair.Crosshair.AbsolutePosition + v54 - v53).magnitude;
    if v50 then
        v48 = true;
    end;
    if l_magnitude_0 < 3 then
        v48 = false;
    end;
    if v44 and v44.Reloading then
        v48 = false;
    end;
    if v42.MoveState == "Running" then
        v48 = false;
    end;
    if v43.FirstPerson and v42.Zooming then
        v48 = false;
    end;
    if v2:IsVisible("GameMenu") then
        v48 = false;
    end;
    v18:SetGoal(v48 and 0 or 1);
    if v48 then
        v17:SetGoal(v53);
    end;
    if v48 and v19 == false then
        v17:SnapTo();
    end;
    local l_v17_Position_0 = v17:GetPosition();
    local l_v18_Position_0 = v18:GetPosition();
    v15.World.Position = UDim2.fromOffset(l_v17_Position_0.X, l_v17_Position_0.Y);
    v15.World.Visible = true;
    v15.World.Dot.ImageTransparency = l_v18_Position_0;
    v19 = v48;
end;
local function v68(v59, v60, v61) --[[ Line: 235 ]] --[[ Name: projectOffsetToScreen ]]
    local v62 = v60.X / v60.Y;
    local v63 = -v59.Z * math.tan((math.rad(v61 * 0.5)));
    local v64 = v62 * v63;
    local v65 = v59 - Vector3.new(-v64, v63, v59.Z);
    local v66 = v65.X / (v64 * 2);
    local v67 = -v65.Y / (v63 * 2);
    return Vector2.new(v66 * v60.X, v67 * v60.Y);
end;
local function v86(v69) --[[ Line: 252 ]] --[[ Name: projectReticlePicture ]]
    -- upvalues: v2 (copy), v68 (copy), v15 (copy), v13 (ref), v20 (ref)
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local l_CFrame_0 = l_CurrentCamera_0.CFrame;
    local l_v2_ScreenSize_0 = v2:GetScreenSize();
    local l_FieldOfView_0 = l_CurrentCamera_0.FieldOfView;
    local l_ToolOffset_0 = v69.ToolOffset;
    local v75 = l_ToolOffset_0 * CFrame.new(v69.GlassProjectionOffset);
    local v76 = l_ToolOffset_0 * CFrame.new(-v69.SightlineOffset);
    local v77 = v75.LookVector:Dot((Vector3.new(0, 0, -1, 0))) > 0.9;
    local v78 = v69.GlassProjectionSize * 0.5;
    if v77 then
        local v79 = v75 * (v78 * Vector3.new(-1, 1, 1, 0));
        local v80 = v75 * (v78 * Vector3.new(1, -1, 1, 0));
        local v81 = v68(v79, l_v2_ScreenSize_0, l_FieldOfView_0);
        local v82 = v68(v80, l_v2_ScreenSize_0, l_FieldOfView_0) - v81;
        local v83 = v81 + v82 * 0.5;
        v15.SightGlass.Position = UDim2.fromOffset(v83.X, v83.Y);
        v15.SightGlass.Size = UDim2.fromOffset(v82.X, v82.Y);
        v13 = l_CFrame_0 * v75;
        local v84 = v76 * Vector3.new(0, 0, -v20.Distance.Value);
        local v85 = v68(v84, l_v2_ScreenSize_0, l_FieldOfView_0) - v83 + v82 * 0.5;
        v20.Position = UDim2.fromOffset(v85.X, v85.Y);
        return v77;
    else
        v13 = l_CFrame_0;
        return v77;
    end;
end;
v15.GetWorldCastInfo = function(_, ...) --[[ Line: 298 ]] --[[ Name: GetWorldCastInfo ]]
    -- upvalues: l_Players_0 (copy), v3 (copy)
    local l_CurrentCamera_1 = workspace.CurrentCamera;
    local v89 = Ray.new(l_CurrentCamera_1.CFrame.Position, l_CurrentCamera_1.CFrame.LookVector);
    local v90 = Ray.new(v89.Origin, v89.Direction * 2000);
    local v91 = {
        l_Players_0.LocalPlayer.Character, 
        ...
    };
    return v3:BulletCastLight(v90, false, v91);
end;
v15.GetFirearmTargetInfo = function(_, v93, v94, v95, v96) --[[ Line: 312 ]] --[[ Name: GetFirearmTargetInfo ]]
    -- upvalues: v20 (ref), v13 (ref), v3 (copy), v15 (copy)
    local v97 = v93.HeadPart.CFrame * Vector3.new(0, 0, 0.44999998807907104, 0);
    local l_p_0 = v95.Muzzle.CFrame.p;
    if v96 then
        v97 = v93.HeadPart.CFrame.p;
    end;
    if v94.FirstPerson then
        v97 = v94.Instance.CFrame.p;
    end;
    local l_v97_0 = v97;
    local v100 = nil;
    local v101 = false;
    if v93.Animator and v93.Animator.EquipFading then
        return l_p_0, v95.Muzzle.CFrame.LookVector, v101;
    elseif v94.FirstPerson and v93.Zooming and v20 then
        local v102 = Ray.new(v13.Position, v13.LookVector);
        return v102.Origin - v102.Direction * 0.1, v102.Direction, v101;
    else
        local v103 = {
            v93.Instance
        };
        local l_magnitude_1 = (v97 - l_p_0).magnitude;
        local v105 = Ray.new(v97, l_p_0 - v97);
        local v106, v107, v108 = v3:BulletCastLight(v105, false, v103);
        l_v97_0 = v107;
        if v106 then
            l_v97_0 = l_v97_0 + v108 * 0.1;
        end;
        local l_v15_WorldCastInfo_0, v110 = v15:GetWorldCastInfo();
        v100 = (v110 - l_p_0).unit;
        if (v110 - l_p_0).magnitude < l_magnitude_1 then
            local v111 = {
                l_v15_WorldCastInfo_0
            };
            local v112 = false;
            local v113 = 0;
            repeat
                local l_v15_WorldCastInfo_1, v115 = v15:GetWorldCastInfo(unpack(v111));
                l_v15_WorldCastInfo_0 = l_v15_WorldCastInfo_1;
                v110 = v115;
                v100 = (v110 - l_p_0).unit;
                v113 = v113 + 1;
                if (v110 - l_p_0).magnitude < l_magnitude_1 then
                    table.insert(v111, l_v15_WorldCastInfo_0);
                else
                    v112 = true;
                end;
            until v112 or v113 > 10;
        end;
        return l_v97_0, v100, (l_p_0 - l_v97_0).magnitude > 0.01;
    end;
end;
v15.GetMeleeTargetInfo = function(v116, v117, v118) --[[ Line: 380 ]] --[[ Name: GetMeleeTargetInfo ]]
    local l_CFrame_1 = v117.RootPart.CFrame;
    local l_LookVector_0 = v118.Instance.CFrame.LookVector;
    local l_p_1 = l_CFrame_1.p;
    local v122 = nil;
    if v117.Instance and v117.EquippedItem then
        local l_Equipped_1 = v117.Instance:FindFirstChild("Equipped");
        if l_Equipped_1 then
            v122 = l_Equipped_1:FindFirstChild(v117.EquippedItem.Name);
        end;
    end;
    if v117.EquippedItem and v117.EquippedItem.Type == "Melee" and v122 and v122.PrimaryPart then
        local l_v116_FirearmTargetInfo_0, v125 = v116:GetFirearmTargetInfo(v117, v118, {
            Muzzle = v122.PrimaryPart
        }, true);
        l_p_1 = l_v116_FirearmTargetInfo_0;
        l_LookVector_0 = v125;
    else
        if l_LookVector_0.Y > 0 then
            l_p_1 = l_p_1 + Vector3.new(0, l_LookVector_0.Y, 0);
        end;
        if l_LookVector_0.Y < 0 then
            l_LookVector_0 = Vector3.new(l_LookVector_0.X, l_LookVector_0.Y * 0, l_LookVector_0.Z).unit;
        end;
    end;
    return l_p_1, l_LookVector_0;
end;
v15.SetStabalizeBarValue = function(_, v127) --[[ Line: 415 ]] --[[ Name: SetStabalizeBarValue ]]
    -- upvalues: v15 (copy)
    local v128 = math.clamp(v127, 0, 1);
    v15.Stabalize.Fill.Size = UDim2.new(v128, 0, 1, 0);
end;
v15.SetStabalizeBarVisible = function(_, v130) --[[ Line: 421 ]] --[[ Name: SetStabalizeBarVisible ]]
    -- upvalues: v15 (copy)
    local v131 = not not v130;
    v15.Stabalize.Visible = v131;
end;
v15.SetStabalizerTimeout = function(_, v133) --[[ Line: 427 ]] --[[ Name: SetStabalizerTimeout ]]
    -- upvalues: v15 (copy)
    local v134 = "Hold \"Sprint\" to stabilize";
    if v133 then
        v134 = "Catching breath...";
    end;
    v15.Stabalize.TextLabel.Text = v134;
    v15.Stabalize.TextLabel.Backdrop.Text = v134;
end;
l_RunService_0:BindToRenderStep("Firearm Crosshair Render", 40, function() --[[ Line: 441 ]]
    -- upvalues: v8 (copy), v4 (copy), v20 (ref), v12 (copy), v15 (copy), v86 (copy), v13 (ref)
    local v135 = v8.get();
    local v136 = v135 and v135.Character;
    local l_v4_Camera_0 = v4:GetCamera("Character");
    local v138 = nil;
    local v139 = nil;
    if v136 and l_v4_Camera_0.FirstPerson and v136.Zooming then
        local l_Animator_0 = v136.Animator;
        local l_EquippedItem_0 = v136.EquippedItem;
        if l_EquippedItem_0 and l_EquippedItem_0.Type ~= "Firearm" then
            l_EquippedItem_0 = nil;
        end;
        if l_EquippedItem_0 and l_EquippedItem_0.Reloading then
            l_EquippedItem_0 = nil;
        end;
        if l_EquippedItem_0 and l_Animator_0 and l_Animator_0.FirearmPoseInfo and l_Animator_0.FirearmPoseInfo.Packed then
            local l_Name_0 = l_EquippedItem_0.Name;
            if l_EquippedItem_0.Attachments and l_EquippedItem_0.Attachments.Sight then
                l_Name_0 = l_EquippedItem_0.Attachments.Sight.Name;
            end;
            v138 = l_Name_0;
            v139 = l_Animator_0.FirearmPoseInfo;
        end;
    end;
    local v143 = false;
    if v138 == nil then
        v143 = v20 ~= nil;
    end;
    local v144 = v20 and v20.Name ~= v138;
    if v143 or v144 then
        v20:Destroy();
        v20 = nil;
    end;
    local v145 = false;
    if v138 and v139 then
        if not v20 then
            local l_v12_FirstChild_0 = v12:FindFirstChild(v138);
            if l_v12_FirstChild_0 then
                v20 = l_v12_FirstChild_0:Clone();
                v20.Parent = v15.SightGlass;
                local l_Value_0 = v20.Roundness.Value;
                v15.SightGlass.UICorner.CornerRadius = UDim.new(l_Value_0, 0);
            end;
        end;
        if v20 then
            v145 = true;
        end;
    end;
    if v145 then
        v15.SightGlass.Visible = v86(v139);
        return;
    else
        v13 = workspace.CurrentCamera.CFrame;
        v15.SightGlass.Visible = false;
        return;
    end;
end);
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 517 ]]
    -- upvalues: v15 (copy), v8 (copy), v4 (copy), v58 (copy), v18 (copy), v41 (copy), v36 (copy), v19 (ref)
    local v148 = false;
    debug.profilebegin("Reticle UI Step");
    if v15.Gui.Visible then
        local l_Character_0 = v8.get().Character;
        local l_v4_Camera_1 = v4:GetCamera("Character");
        if l_Character_0 then
            local l_EquippedItem_1 = l_Character_0.EquippedItem;
            local v152;
            if l_Character_0.Instance and l_EquippedItem_1 then
                local l_Equipped_2 = l_Character_0.Instance:FindFirstChild("Equipped");
                if l_Equipped_2 then
                    v152 = l_Equipped_2:FindFirstChild(l_EquippedItem_1.Name);
                    v148 = true;
                end;
            end;
            if not v148 then
                v152 = nil;
            end;
            v148 = false;
            if l_EquippedItem_1 and l_EquippedItem_1.Type == "Firearm" and v152 and not l_Character_0.AtEaseInput then
                v58(l_Character_0, l_v4_Camera_1, l_EquippedItem_1, v152);
            elseif v15.World.Visible then
                v15.World.Visible = false;
                v18:SetGoal(1);
            end;
            v41(l_Character_0);
            v36(l_Character_0, l_v4_Camera_1, l_EquippedItem_1, v152);
        end;
    else
        if v15.World.Visible then
            v15.World.Visible = false;
            v18:SetGoal(1);
        end;
        v19 = false;
    end;
    debug.profileend();
end);
v5:BindToSetting("User Interface", "Crosshair Color", function(v154) --[[ Line: 554 ]]
    -- upvalues: v14 (copy), v15 (copy)
    local v155 = v14[v154];
    if v155 then
        v15.Crosshair.Crosshair.Bottom.ImageColor3 = v155;
        v15.Crosshair.Crosshair.Top.ImageColor3 = v155;
        v15.Crosshair.Crosshair.Left.ImageColor3 = v155;
        v15.Crosshair.Crosshair.Right.ImageColor3 = v155;
        v15.World.Dot.ImageColor3 = v155;
    end;
end);
return v15;