local _ = game:GetService("Lighting");
local v1 = require(game:GetService("ReplicatedFirst").Framework);
local v2 = v1.require("Configs", "Globals");
local _ = v1.require("Libraries", "Network");
local v4 = v1.require("Libraries", "Keybinds");
local v5 = v1.require("Libraries", "Raycasting");
local v6 = v1.require("Libraries", "UserSettings");
local v7 = v1.require("Libraries", "Interface");
local v8 = v1.require("Classes", "SteppedSprings");
local v9 = v1.require("Classes", "Springs");
local _ = v1.require("Classes", "Steppers");
local _ = v1.require("Classes", "Signals");
local v12 = v1.require("Classes", "Maids");
local _ = game:GetService("RunService");
local _ = game:GetService("SocialService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local _ = game:GetService("SoundService");
local v18 = {
    Pitch = 0, 
    Yaw = 0
};
local v19 = Vector3.new();
local v20 = 0;
local v21 = 70;
local v22 = 10;
local v23 = v8.new(70, 6.25, 1);
local v24 = v8.new(v19, 5.25, 1);
local v25 = v8.new(Vector3.new(), 1, 0.8);
local v26 = v9.new(Vector3.new(), 4.2, 0.8);
local v27 = 15;
if v2.HardcoreMode then
    v27 = 1.05;
    v22 = 0;
end;
local v28 = {
    Vector2.new(0.5, 0.5), 
    Vector2.new(0, 0), 
    Vector2.new(1, 0), 
    Vector2.new(1, 1), 
    Vector2.new(0, 1)
};
local v29 = {
    Climbing = true, 
    Vaulting = true
};
local v30 = {
    Running = 5, 
    Walking = 0, 
    Crouching = 0, 
    Climbing = 0, 
    Sitting = 0, 
    Vaulting = 0, 
    Swimming = 0, 
    SprintSwimming = 5
};
local _ = Random.new();
local function _(v32, v33, v34, v35, v36) --[[ Line: 80 ]] --[[ Name: remapClamped ]]
    return v35 + (v36 - v35) * math.clamp((v32 - v33) / (v34 - v33), 0, 1);
end;
local function _(v38) --[[ Line: 84 ]] --[[ Name: orient ]]
    -- upvalues: v18 (copy)
    local l_lookVector_0 = v38.lookVector;
    local v40 = math.atan2(-l_lookVector_0.X, -l_lookVector_0.Z);
    v18.Pitch = math.asin(l_lookVector_0.Y);
    v18.Yaw = v40;
end;
local function _() --[[ Line: 93 ]] --[[ Name: getInversionValues ]]
    -- upvalues: v6 (copy)
    local l_v6_Setting_0 = v6:GetSetting("Accessibility", "Camera Inversion");
    local v43 = 1;
    local v44 = 1;
    if l_v6_Setting_0 == "X" then
        return v43, -1;
    elseif l_v6_Setting_0 == "Y" then
        return -1, v44;
    else
        if l_v6_Setting_0 == "XY" then
            v43 = -1;
            v44 = -1;
        end;
        return v43, v44;
    end;
end;
local _ = function(v46) --[[ Line: 108 ]] --[[ Name: canPanCamera ]]
    -- upvalues: l_GuiService_0 (copy)
    if l_GuiService_0.MenuIsOpen then
        return false;
    else
        for _, v48 in next, v46.CameraBlockedCases do
            if not v48() then
                return false;
            end;
        end;
        return true;
    end;
end;
local function v72(v50, v51) --[[ Line: 122 ]] --[[ Name: bindUserInput ]]
    -- upvalues: l_UserInputService_0 (copy), l_GuiService_0 (copy), v2 (copy), v4 (copy), v6 (copy), v18 (copy), v27 (ref), v22 (ref)
    v51:Give(l_UserInputService_0.InputBegan:Connect(function(v52, v53) --[[ Line: 123 ]]
        -- upvalues: l_GuiService_0 (ref), v50 (copy), v2 (ref)
        if not v53 and not l_GuiService_0.MenuIsOpen and v50.Enabled and v52.UserInputType == Enum.UserInputType.MouseButton2 and not v2.HardcoreMode then
            v50.Panning = true;
        end;
    end));
    v51:Give(l_UserInputService_0.InputEnded:Connect(function(v54, _) --[[ Line: 134 ]]
        -- upvalues: v50 (copy)
        if v54.UserInputType == Enum.UserInputType.MouseButton2 then
            v50.Panning = false;
        end;
    end));
    v51:Give(l_UserInputService_0.InputChanged:Connect(function(v56, v57) --[[ Line: 140 ]]
        -- upvalues: v50 (copy), l_UserInputService_0 (ref), l_GuiService_0 (ref), v4 (ref), v6 (ref), v18 (ref), v2 (ref), v27 (ref), v22 (ref)
        local v58 = false;
        if not v57 and v50.Enabled then
            if v56.UserInputType == Enum.UserInputType.MouseMovement and l_UserInputService_0.MouseBehavior ~= Enum.MouseBehavior.Default then
                local l_v50_0 = v50;
                local v60;
                if l_GuiService_0.MenuIsOpen then
                    v60 = false;
                else
                    for _, v62 in next, l_v50_0.CameraBlockedCases do
                        if not v62() then
                            v60 = false;
                            v58 = true;
                        end;
                        if v58 then
                            break;
                        end;
                    end;
                    if not v58 then
                        v60 = true;
                    end;
                end;
                v58 = false;
                if v60 then
                    v60 = math.clamp(math.tan((math.rad(v50.Instance.FieldOfView))) / 2.7474774194546216, 0, 1);
                    l_v50_0 = 1;
                    if v50.Character.Zooming or v50.Character.BinocularsEnabled ~= "" then
                        local v63 = v4:GetBind("Aim Down Sights")["First Person Aim Speed"];
                        if v63 and v63.Value then
                            l_v50_0 = v63.Value / 100;
                        end;
                    else
                        v60 = 1;
                    end;
                    local v64 = v56.Delta * 0.003490658503988659 * v60 * l_v50_0;
                    local l_v6_Setting_1 = v6:GetSetting("Accessibility", "Camera Inversion");
                    local v66 = 1;
                    local v67 = 1;
                    if l_v6_Setting_1 == "X" then
                        v67 = -1;
                    elseif l_v6_Setting_1 == "Y" then
                        v66 = -1;
                    elseif l_v6_Setting_1 == "XY" then
                        v66 = -1;
                        v67 = -1;
                    end;
                    local l_v66_0 = v66;
                    v18.Yaw = v18.Yaw - v64.X * v67;
                    v18.Pitch = v18.Pitch - v64.Y * l_v66_0;
                    return;
                end;
            end;
            if v56.UserInputType == Enum.UserInputType.MouseWheel then
                local l_Z_0 = v56.Position.Z;
                l_Z_0 = l_Z_0 < 0 and -1 or l_Z_0 > 0 and 1 or 0;
                local v70 = false;
                local v71 = 10;
                if v50.Character.EquippedItem and not v2.HardcoreMode then
                    if not v50.Character.AtEaseInput then
                        v70 = v50.Character.EquippedItem.CanCameraSuperZoom;
                    end;
                    if v50.Character.EquippedItem.CameraOffsets then
                        v71 = v50.Character.EquippedItem.CameraOffsets.Distance;
                    end;
                end;
                if v70 or v2.HardcoreMode then
                    if l_Z_0 > 0 then
                        v50.FirstPerson = true;
                        return;
                    else
                        v50.FirstPerson = false;
                        v50.FirstPersonReturn = nil;
                        if v2.HardcoreMode then
                            v71 = v27;
                        end;
                        v22 = v71;
                        return;
                    end;
                else
                    v22 = math.clamp(v22 - l_Z_0 * 1.4, 0, v27);
                    if v22 < 1 then
                        v50.FirstPerson = true;
                        return;
                    else
                        v50.FirstPerson = false;
                        v50.FirstPersonReturn = nil;
                    end;
                end;
            end;
        end;
    end));
end;
local function v91(v73, v74, v75) --[[ Line: 220 ]] --[[ Name: collideCamera ]]
    -- upvalues: v28 (copy), v5 (copy)
    local _ = v73.Instance.ViewportSize;
    local v77 = v74.lookVector * 0.5;
    local _ = (v74.p - v75.p).magnitude;
    local v79 = 0;
    local v80 = {};
    if v73.VehicleBase and v73.VehicleBase.Parent then
        table.insert(v80, v73.VehicleBase.Parent);
    end;
    debug.profilebegin("screen corner casting");
    for v81, v82 in next, v28 do
        debug.profilebegin("cast " .. v81);
        local v83 = v73.Instance.ViewportSize * v82;
        local v84 = v73.Instance:ViewportPointToRay(v83.X, v83.Y, 0.5);
        local v85 = v75.p + (v84.Origin - (v74.p + v77));
        local v86 = Ray.new(v85, v84.Origin - v85);
        local _, v88 = v5:CameraCast(v86, v80);
        local l_magnitude_1 = (v88 - v84.Origin).magnitude;
        if v79 < l_magnitude_1 then
            v79 = l_magnitude_1;
        end;
        debug.profileend();
    end;
    debug.profileend();
    local v90 = v74 - (v74.p - v75.p).unit * v79;
    v73.Instance.CFrame = v90;
    v73.Instance.Focus = v75;
    return v90, v75;
end;
local function _(v92) --[[ Line: 265 ]] --[[ Name: tuneCameraForTool ]]
    -- upvalues: v23 (copy)
    if v92.Handling then
        local v93, v94 = unpack(v92.Handling.CameraZoom);
        v93 = v92:GetModifiedStat("CameraZoom", v93);
        v23:Retune(v93, v94);
    end;
end;
local function v102(v96, _) --[[ Line: 275 ]] --[[ Name: setMouseLock ]]
    -- upvalues: v2 (copy), v1 (copy), v7 (copy), l_UserInputService_0 (copy)
    local l_EquippedItem_0 = v96.Character.EquippedItem;
    local l_FirstPerson_0 = v96.FirstPerson;
    local v100 = false;
    local v101 = false;
    if v96.Character.Vehicle and not v2.HardcoreMode then
        l_FirstPerson_0 = false;
    end;
    if not v96.ToolDescription then
        l_EquippedItem_0 = nil;
    end;
    if v1.Libraries.Interface and v1.Libraries.Interface:IsVisible("GameMenu", "MainMenu") then
        v100 = true;
    end;
    if v96.Character and v96.Character.BinocularsEnabled ~= "" and v7:Get("Binoculars").BinocularsReady == v96.Character.BinocularsEnabled then
        v101 = true;
    end;
    if v100 then
        l_UserInputService_0.MouseBehavior = Enum.MouseBehavior.Default;
        return;
    elseif l_EquippedItem_0 and l_EquippedItem_0.CanLockMouse or v101 then
        l_UserInputService_0.MouseBehavior = Enum.MouseBehavior.LockCenter;
        return;
    elseif l_FirstPerson_0 then
        l_UserInputService_0.MouseBehavior = Enum.MouseBehavior.LockCenter;
        return;
    elseif v96.Panning and not v100 then
        l_UserInputService_0.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
        return;
    else
        l_UserInputService_0.MouseBehavior = Enum.MouseBehavior.Default;
        return;
    end;
end;
local function v103(v104, v105) --[[ Line: 323 ]] --[[ Name: setCameraOffsets ]]
    -- upvalues: v22 (ref), v6 (copy), v7 (copy), v2 (copy), v29 (copy), v103 (copy), v19 (ref), v24 (copy)
    local v106 = 0;
    local v107 = 100;
    local v108 = 0;
    local v109 = 0;
    debug.profilebegin("tool fetching");
    if not v104.FirstPerson and v104.ToolDescription then
        if v104.Character.EquippedItem.CameraOffsets then
            local l_CameraOffsets_0 = v104.Character.EquippedItem.CameraOffsets;
            v109 = l_CameraOffsets_0.Shift;
            v108 = l_CameraOffsets_0.Height;
            v22 = l_CameraOffsets_0.Distance;
            if v104.Character.ShoulderSwapped and l_CameraOffsets_0.OppositeShift then
                v109 = l_CameraOffsets_0.OppositeShift;
            end;
            if v104.Character.Zooming and l_CameraOffsets_0.ZoomedDistance then
                v22 = l_CameraOffsets_0.ZoomedDistance;
            end;
            if v22 == 0 then
                v109 = 0;
                v108 = 0;
                if v6:GetSetting("Accessibility", "Aim View Changing") == "New" then
                    v104.ReturnToThirdPerson = true;
                end;
                v104.FirstPerson = true;
            end;
        end;
    elseif v104.FirstPerson then
        v22 = 0;
    end;
    if v104.Character and v104.Character.BinocularsEnabled ~= "" and v7:Get("Binoculars").BinocularsReady == v104.Character.BinocularsEnabled then
        v109 = 0;
        v108 = 0;
        v107 = 0;
    end;
    if v104.ReturnToThirdPerson and not v104.Character.Zooming and v104.Character.EquippedItem and v104.Character.EquippedItem.CameraOffsets then
        local l_CameraOffsets_1 = v104.Character.EquippedItem.CameraOffsets;
        v109 = l_CameraOffsets_1.Shift;
        v108 = l_CameraOffsets_1.Height;
        v22 = l_CameraOffsets_1.Distance;
        v104.ReturnToThirdPerson = false;
    end;
    debug.profileend();
    debug.profilebegin("action auto zoom");
    if v6:GetSetting("Accessibility", "Action Auto Zooming") == "On" and not v2.HardcoreMode and v104.Character and v104.Character.Animator then
        local v112 = v104.Character.Animator:IsAnimationPlaying("Actions.Fall Impact", "Boxing.Box Stagger");
        local v113 = v29[v104.Character.MoveState] == true;
        if v112 or v113 then
            if v104.FirstPerson then
                v104.FirstPersonReturn = true;
                v104.FirstPersonReturnStack = 0.15;
            end;
            v106 = 6;
            v104.FirstPerson = false;
        elseif v104.FirstPersonReturn then
            v104.FirstPersonReturnStack = v104.FirstPersonReturnStack - v105;
            if v104.FirstPersonReturnStack <= 0 then
                v104.FirstPerson = true;
                v104.FirstPersonReturn = nil;
                debug.profileend();
                return v103(v104, v105);
            end;
        end;
    end;
    debug.profileend();
    debug.profilebegin("state tweaks");
    if v104.VehicleBase then
        v106 = 3;
    end;
    v108 = if v104.Character.MoveState == "Crouching" then v108 + 1.2 else v108 + 2.15;
    v22 = math.max(v22, v106);
    if v104.VehicleBase then
        v19 = Vector3.new(0, 0, v22 + 10);
    else
        v19 = Vector3.new(v109, v108, (math.min(v22, v107)));
    end;
    if v104.FirstPerson and v22 > 1 and not v2.HardcoreMode then
        v104.FirstPerson = false;
    end;
    if not v7:IsVisible("GameMenu") then
        v24:SetGoal(v19);
    end;
    debug.profileend();
end;
local function v120(v114) --[[ Line: 453 ]] --[[ Name: setFieldOfView ]]
    -- upvalues: v6 (copy), v20 (ref), v30 (copy), v21 (ref), v7 (copy), v2 (copy)
    local v115 = v6:GetSetting("Accessibility", "Camera FOV") or 70;
    local v116 = v114.Character.Zooming and not v114.Character.AtEaseInput;
    local v117 = v114.Character.EquippedItem ~= nil and not v114.Character.EquippedItem.Reloading;
    local v118 = v20 or 0;
    if v30[v114.Character.MoveState] then
        v118 = v30[v114.Character.MoveState];
        v20 = v118;
    end;
    v21 = v115 + v118;
    if v116 and v117 then
        v118 = v114.Character.EquippedItem;
        if v118.Attachments and v118.Attachments.Sight then
            v21 = v118.Attachments.Sight.FieldOfView;
        elseif v118.AimFieldOfView then
            v21 = v118.AimFieldOfView;
        end;
    elseif v114.VehicleBase then
        v21 = v115;
    end;
    if v114.Character and v114.Character.BinocularsEnabled ~= "" and v7:Get("Binoculars").BinocularsReady == v114.Character.BinocularsEnabled then
        local v119;
        v118, v119 = v114.Character:HasPerk("Binoculars", true);
        if v119 and v119.AimFieldOfView then
            v21 = v119.AimFieldOfView;
        end;
    end;
    if v2.HardcoreMode and not v114.FirstPerson then
        v21 = 40;
    end;
    v21 = math.clamp(v21, 1, 120);
end;
local function v135(v121) --[[ Line: 509 ]] --[[ Name: firearmRecoilProcess ]]
    -- upvalues: v18 (copy)
    local l_EquippedItem_1 = v121.Character.EquippedItem;
    local v123 = CFrame.new();
    if l_EquippedItem_1 and l_EquippedItem_1.Type == "Firearm" then
        local l_RecoilData_0 = l_EquippedItem_1.RecoilData;
        if l_EquippedItem_1.RecoilDataCrouched and v121.Character.MoveState == "Crouching" then
            l_RecoilData_0 = l_EquippedItem_1.RecoilDataCrouched;
        end;
        local v125 = v121.Character.Animator.Springs.RaiseSpring:GetPosition() * l_RecoilData_0.RaiseInfluence;
        local v126 = v121.Character.Animator.Springs.ShiftSpring:GetPosition() * l_RecoilData_0.ShiftCameraInfluence;
        local v127 = 1;
        if not v121.FirstPerson then
            v125 = v125 * 0.5;
            v126 = v126 * 0.4;
        end;
        if v121.Character.EquippedItem.AttachmentStatMods then
            local l_CameraInfluence_0 = v121.Character.EquippedItem.AttachmentStatMods.CameraInfluence;
            if l_CameraInfluence_0 then
                v127 = l_CameraInfluence_0.Multiplier or v127;
            end;
        end;
        v125 = v125 * v127;
        v126 = v126 * v127;
        local l_KickUpCameraInfluence_0 = l_EquippedItem_1.RecoilData.KickUpCameraInfluence;
        local l_ProcessQueue_0 = v121.Character.Animator.Springs.KickVelocity.ProcessQueue;
        local v131 = 0;
        for v132 = #l_ProcessQueue_0, 1, -1 do
            v131 = v131 + table.remove(l_ProcessQueue_0, v132);
        end;
        if v121.Character.MoveState == "Crouching" and l_EquippedItem_1.RecoilDataCrouched then
            l_KickUpCameraInfluence_0 = l_EquippedItem_1.RecoilDataCrouched.KickUpCameraInfluence;
        end;
        local v133 = l_KickUpCameraInfluence_0 * (v131 * 0.010471975511965976);
        if l_EquippedItem_1.Attachments and l_EquippedItem_1.Attachments.Underbarrel then
            local l_Underbarrel_0 = l_EquippedItem_1.Attachments.Underbarrel;
            if l_Underbarrel_0.StatModifiers then
                v133 = v133 * l_Underbarrel_0.StatModifiers.Kick.Velocity;
            end;
        end;
        v18.Pitch = v18.Pitch + v133;
        v123 = CFrame.Angles(v125 + v126.Y, v126.X, 0);
    end;
    return v123;
end;
local function v158(v136, v137) --[[ Line: 576 ]] --[[ Name: step ]]
    -- upvalues: v103 (copy), v102 (copy), v120 (copy), v135 (copy), l_UserInputService_0 (copy), v18 (copy), v7 (copy), v24 (copy), v25 (copy), v27 (ref), v26 (copy), v23 (copy), v21 (ref), v91 (copy), v1 (copy)
    if not v136.Character then
        return;
    elseif not v136.Character.RootPart then
        return;
    else
        if v136.Character.EquippedItem and not v136.Character.AtEaseInput then
            v136.ToolDescription = v136.Character.EquippedItem.Type;
        else
            v136.ToolDescription = nil;
        end;
        debug.profilebegin("camera offsets");
        v103(v136, v137);
        debug.profileend();
        debug.profilebegin("mouse lock");
        v102(v136);
        debug.profileend();
        debug.profilebegin("field of view");
        v120(v136);
        debug.profileend();
        debug.profilebegin("root cf building");
        local l_CFrame_0 = v136.Character.RootPart.CFrame;
        local v139 = v135(v136);
        if v136.VehicleBase then
            local l_CameraPoint_0 = v136.VehicleBase:FindFirstChild("CameraPoint");
            l_CFrame_0 = if l_CameraPoint_0 then l_CameraPoint_0.WorldCFrame else v136.VehicleBase.CFrame + Vector3.new(0, 5, 0, 0);
        end;
        debug.profileend();
        debug.profilebegin("keybord input");
        local v141 = ((l_UserInputService_0:IsKeyDown(Enum.KeyCode.Left) and 1 or 0) - (l_UserInputService_0:IsKeyDown(Enum.KeyCode.Right) and 1 or 0)) * 3.141592653589793 * v137;
        v18.Yaw = v18.Yaw + v141;
        if v7:Get("Binoculars").CameraSnapRequested then
            if v136.Character.BinocularAngleSnap then
                local l_lookVector_1 = v136.Character.BinocularAngleSnap.lookVector;
                v141 = math.atan2(-l_lookVector_1.X, -l_lookVector_1.Z);
                v18.Pitch = math.asin(l_lookVector_1.Y);
                v18.Yaw = v141;
                v136.Character.BinocularAngleSnap = nil;
            end;
            if v7:Get("Binoculars").BinocularsReady == "" and v136.Character.BinocularsReturnCFrame then
                local l_lookVector_2 = v136.Character.BinocularsReturnCFrame.lookVector;
                v141 = math.atan2(-l_lookVector_2.X, -l_lookVector_2.Z);
                v18.Pitch = math.asin(l_lookVector_2.Y);
                v18.Yaw = v141;
                v136.Character.BinocularsReturnCFrame = nil;
            end;
        end;
        v18.Pitch = math.clamp(v18.Pitch, -1.3962634015954636, 1.3962634015954636);
        v18.Yaw = v18.Yaw % 6.283185307179586;
        debug.profileend();
        debug.profilebegin("staging");
        if v7:Get("Binoculars").CameraSnapRequested then
            v24:SnapTo();
        end;
        local l_v24_Position_0 = v24:GetPosition();
        local l_v25_Position_0 = v25:GetPosition();
        v141 = CFrame.fromEulerAnglesYXZ(l_v25_Position_0.X, l_v25_Position_0.Y, l_v25_Position_0.Z);
        local v146 = CFrame.fromEulerAnglesYXZ(v18.Pitch, v18.Yaw, 0) * v141;
        local v147 = CFrame.new(l_v24_Position_0 * Vector3.new(1, 0, 1, 0));
        local v148 = CFrame.new(l_v24_Position_0 * Vector3.new(0, 1, 0, 0));
        local v149 = 1 + -0.8 * math.clamp((l_v24_Position_0.Z / v27 - 0) / 1, 0, 1);
        local v150 = v26:Update(v137) * v149;
        local v151 = v146:VectorToObjectSpace(v150);
        local v152 = CFrame.fromEulerAnglesYXZ(v151.Z * -0.5, v151.X * 0.05, v151.X * 0.25);
        local v153 = Vector3.new(0, 0, 0, 0);
        if v136.FirstPerson then
            v153 = CFrame.Angles(0, v18.Yaw, 0).LookVector * -0.75;
        end;
        local v154 = v150 * 0.3;
        local v155 = v146 * v152 * v139 * v147 + (l_CFrame_0 * v148).p + v154 + v153;
        local v156 = l_CFrame_0 * v148;
        v136.Instance.CFrame = v155;
        v136.Instance.Focus = v156;
        local v157 = (v155.p - v156.p).magnitude < 2;
        if (v136.FirstPerson and v157 or not v136.FirstPerson) and not v7:IsVisible("GameMenu") then
            v23:SetGoal(v21);
        end;
        if v7:Get("Binoculars").CameraSnapRequested then
            v23:SnapTo();
        end;
        v136.Instance.FieldOfView = v23:GetPosition();
        debug.profileend();
        debug.profilebegin("collision");
        v91(v136, v155, v156);
        debug.profileend();
        debug.profilebegin("world set");
        if os.clock() - v136.LastWorldSet > 5 then
            v136.LastWorldSet = os.clock();
            v1.Libraries.World:Set(v136.Instance.CFrame.p, "Camera", 1);
        end;
        debug.profileend();
        if v7:Get("Binoculars").CameraSnapRequested then
            v7:Get("Binoculars").CameraSnapRequested = false;
        end;
        return;
    end;
end;
return function(_) --[[ Line: 735 ]]
    -- upvalues: v158 (copy), v2 (copy), v23 (copy), v12 (copy), v18 (copy), v26 (copy), v25 (copy), v22 (ref), v72 (copy), v1 (copy)
    local v160 = {
        Name = "Character", 
        Type = "Camera", 
        Instance = Instance.new("Camera")
    };
    v160.Instance.Name = v160.Name;
    v160.Instance.CameraType = Enum.CameraType.Scriptable;
    v160.Enabled = false;
    v160.ParallelRun = false;
    v160.Step = v158;
    v160.StepOrder = 10;
    v160.LastWorldSet = 0;
    v160.Character = nil;
    v160.FirstPerson = v2.HardcoreMode;
    v160.CameraBlockedCases = {};
    v160.FovSpring = v23;
    v160.LastFlinch = os.clock();
    local v161 = v12.new();
    local v162 = v12.new();
    if v2.HardcoreMode then
        v160.FirstPerson = true;
    end;
    v160.onTransition = function(v163, v164) --[[ Line: 766 ]]
        -- upvalues: v18 (ref)
        if v163 then
            local l_lookVector_3 = v164.Instance.CFrame.lookVector;
            local v166 = math.atan2(-l_lookVector_3.X, -l_lookVector_3.Z);
            v18.Pitch = math.asin(l_lookVector_3.Y);
            v18.Yaw = v166;
        end;
    end;
    v160.Flinch = function(v167, v168, v169, v170) --[[ Line: 774 ]] --[[ Name: Flinch ]]
        -- upvalues: v2 (ref), v26 (ref)
        local v171 = v167.Instance.Focus.Position - v168;
        if v171.magnitude > 0 then
            v171 = v171.Unit;
        end;
        local l_GlobalFlinchMod_0 = v2.GlobalFlinchMod;
        local v173 = v171 * v169 * l_GlobalFlinchMod_0;
        if v167.Character and v167.Character.Zooming then
            v173 = v173 * 0.75;
        end;
        if os.clock() - v167.LastFlinch <= 30 then
            v173 = v173 * 0.3;
        end;
        if not v170 then
            v173 = v173 * 0.2;
        end;
        v167.LastFlinch = os.clock();
        v26.v = v26.v + v173;
    end;
    v160.Disconnect = function(v174) --[[ Line: 802 ]] --[[ Name: Disconnect ]]
        -- upvalues: v161 (copy)
        v174:DisconnectVehicle();
        v174.Character = nil;
        v161:Clean();
    end;
    v160.Connect = function(v175, v176) --[[ Line: 809 ]] --[[ Name: Connect ]]
        -- upvalues: v2 (ref), v161 (copy), v25 (ref), v23 (ref), v22 (ref)
        v175:DisconnectVehicle();
        v175.Character = v176;
        if not v2.HardcoreMode then
            v175.FirstPerson = false;
        end;
        v161:Clean();
        local v177 = 0;
        v161:Give(v176.MoveStateChanged:Connect(function(v178, v179) --[[ Line: 822 ]]
            -- upvalues: v25 (ref), v177 (ref)
            if v178 == "Vaulting" then
                v25:Accelerate((Vector3.new(-0.699999988079071, 0, 0.30000001192092896, 0)));
            elseif v178 == "Falling" then
                v177 = os.clock();
            end;
            if v179 == "Falling" then
                v25:Accelerate((Vector3.new(-math.min(3, os.clock() - v177), 0, 0)));
            end;
        end));
        v161:Give(v176.Jumped:Connect(function() --[[ Line: 834 ]]
            -- upvalues: v25 (ref)
            v25:Accelerate((Vector3.new(0.30000001192092896, 0, 0, 0)));
        end));
        v161:Give(v176.EquipmentChanged:Connect(function() --[[ Line: 838 ]]
            -- upvalues: v161 (ref), v176 (copy), v23 (ref)
            v161:CleanIndex("ToolChanged");
            if v176.EquippedItem then
                v161:Give(v176.EquippedItem.Changed:Connect(function(v180) --[[ Line: 842 ]]
                    -- upvalues: v176 (ref), v23 (ref)
                    if v180 == "AttachmentStatMods" then
                        local l_EquippedItem_2 = v176.EquippedItem;
                        if l_EquippedItem_2.Handling then
                            local v182, v183 = unpack(l_EquippedItem_2.Handling.CameraZoom);
                            v182 = l_EquippedItem_2:GetModifiedStat("CameraZoom", v182);
                            v23:Retune(v182, v183);
                        end;
                    end;
                end), "ToolChanged");
                local l_EquippedItem_3 = v176.EquippedItem;
                if l_EquippedItem_3.Handling then
                    local v185, v186 = unpack(l_EquippedItem_3.Handling.CameraZoom);
                    v185 = l_EquippedItem_3:GetModifiedStat("CameraZoom", v185);
                    v23:Retune(v185, v186);
                end;
            end;
        end));
        v22 = 10;
    end;
    v160.GetAnimationSpringValue = function(_) --[[ Line: 856 ]] --[[ Name: GetAnimationSpringValue ]]
        -- upvalues: v25 (ref)
        return v25:GetPosition();
    end;
    v160.ConnectVehicle = function(v188, v189) --[[ Line: 860 ]] --[[ Name: ConnectVehicle ]]
        -- upvalues: v18 (ref)
        local l_PrimaryPart_0 = v189.PrimaryPart;
        if l_PrimaryPart_0 then
            local l_LookVector_0 = l_PrimaryPart_0.CFrame.LookVector;
            local v192 = math.atan2(-l_LookVector_0.X, -l_LookVector_0.Z);
            local l_lookVector_4 = CFrame.Angles(0, v192, 0):ToObjectSpace(v188.Instance.CFrame).lookVector;
            local v194 = math.atan2(-l_lookVector_4.X, -l_lookVector_4.Z);
            v18.Pitch = math.asin(l_lookVector_4.Y);
            v18.Yaw = v194;
        end;
    end;
    v160.DisconnectVehicle = function(v195) --[[ Line: 876 ]] --[[ Name: DisconnectVehicle ]]
        -- upvalues: v18 (ref)
        if v195.VehicleBase then
            local l_lookVector_5 = v195.Instance.CFrame.lookVector;
            local v197 = math.atan2(-l_lookVector_5.X, -l_lookVector_5.Z);
            v18.Pitch = math.asin(l_lookVector_5.Y);
            v18.Yaw = v197;
            v195.VehicleBase = nil;
        end;
    end;
    v160.Enable = function(v198) --[[ Line: 884 ]] --[[ Name: Enable ]]
        -- upvalues: v72 (ref), v162 (copy), v1 (ref)
        v198.Enabled = true;
        v72(v198, v162);
        v1.Libraries.World:SetAmbience(1, 10);
    end;
    v160.Disable = function(v199) --[[ Line: 892 ]] --[[ Name: Disable ]]
        -- upvalues: v162 (copy), v1 (ref)
        v199.Enabled = false;
        v162:Clean();
        v1.Libraries.World:SetAmbience(0, 10);
    end;
    v160.AddPanningBlockCase = function(v200, v201, v202) --[[ Line: 901 ]] --[[ Name: AddPanningBlockCase ]]
        if not v202 then
            v202 = #v200.CameraBlockedCases + 1;
        end;
        v200.CameraBlockedCases[v202] = v201;
    end;
    v160.RemovePanningBlockCase = function(v203, v204) --[[ Line: 909 ]] --[[ Name: RemovePanningBlockCase ]]
        v203.CameraBlockedCases[v204] = nil;
    end;
    return v160;
end;