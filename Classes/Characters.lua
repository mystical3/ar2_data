local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Character");
local v2 = v0.require("Configs", "Globals");
local v3 = v0.require("Configs", "PerkTuning");
local _ = v0.require("Configs", "GroundData");
local v5 = v0.require("Libraries", "Network");
local v6 = v0.require("Libraries", "Interface");
local v7 = v0.require("Libraries", "Cameras");
local v8 = v0.require("Libraries", "World");
local v9 = v0.require("Libraries", "Keybinds");
local v10 = v0.require("Libraries", "Resources");
local v11 = v0.require("Libraries", "Raycasting");
local v12 = v0.require("Libraries", "GunBuilder");
local v13 = v0.require("Libraries", "UserSettings");
local v14 = v0.require("Libraries", "Vaulting");
local v15 = v0.require("Classes", "Signals");
local v16 = v0.require("Classes", "Stats");
local v17 = v0.require("Classes", "Animators");
local v18 = v0.require("Classes", "Inventories");
local v19 = v0.require("Classes", "Springs");
local v20 = v0.require("Classes", "Steppers");
local v21 = v0.require("Classes", "Maids");
local l_GuiService_0 = game:GetService("GuiService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Lighting_0 = game:GetService("Lighting");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v28 = v10:Find("Lighting.DamageFade");
local l_IsA_0 = workspace.IsA;
local v30 = Color3.fromRGB(255, 255, 255);
local v31 = Color3.fromRGB(255, 202, 202);
local v32 = Color3.fromRGB(255, 203, 203);
local v33 = {
    Forwards = "Move Forwards", 
    Backwards = "Move Backwards", 
    Right = "Move Right", 
    Left = "Move Left", 
    Jump = "Jump", 
    Crouch = "Crouch", 
    Sprint = "Sprint", 
    AutoRun = "Auto Run", 
    MapToggle = "Toggle Map", 
    Inventory = "Toggle Inventory", 
    Flashlight = "Toggle Flashlight", 
    Binoculars = "Toggle Binoculars", 
    Shove = "Shove", 
    Aim = "Aim Down Sights", 
    Reload = "Reload", 
    AtEase = "At Ease", 
    ToolAction = "Fire Mode", 
    LookLock = "Lock Look Direction", 
    ShoulderSwap = "Shoulder Change"
};
local v34 = {
    [Enum.HumanoidStateType.Ragdoll] = true, 
    [Enum.HumanoidStateType.GettingUp] = true, 
    [Enum.HumanoidStateType.Seated] = true
};
local v35 = Random.new();
local v36 = {};
v36.__index = v36;
local function _(v37) --[[ Line: 93 ]] --[[ Name: isPressed ]]
    -- upvalues: l_UserInputService_0 (copy)
    if not v37 then
        return false;
    elseif v37.EnumType == Enum.KeyCode then
        return l_UserInputService_0:IsKeyDown(v37);
    elseif v37.EnumType == Enum.UserInputType then
        return l_UserInputService_0:IsMouseButtonPressed(v37);
    else
        return false;
    end;
end;
local function _(v39) --[[ Line: 107 ]] --[[ Name: displayError ]]
    -- upvalues: v0 (copy)
    v0.Libraries.Interface:Get("DeathActions"):Log("Default", v39);
end;
local function _(v41) --[[ Line: 114 ]] --[[ Name: refreshControls ]]
    -- upvalues: v6 (copy)
    v6:Get("Controls"):Refresh(v41);
    v6:Get("Weapon"):Refresh(v41);
end;
local _ = function(v43) --[[ Line: 119 ]] --[[ Name: setListenToList ]]
    v43.TriggerInputs = {};
    for _, v45 in next, v43.Binds do
        v43.TriggerInputs[v45] = true;
    end;
end;
local function v53(v47, v48, v49) --[[ Line: 127 ]] --[[ Name: processInput ]]
    local l_UserInputType_0 = v49.UserInputType;
    if v49.UserInputType == Enum.UserInputType.Keyboard then
        l_UserInputType_0 = v49.KeyCode;
    elseif v49.UserInputType == Enum.UserInputType.Gamepad1 then
        l_UserInputType_0 = v49.KeyCode;
    end;
    if v47.TriggerInputs[l_UserInputType_0] then
        for v51, v52 in next, v47.Binds do
            if v52 == l_UserInputType_0 and v47.Actions[v51] then
                v47.Actions[v51](v47, v48);
            end;
        end;
    end;
end;
local function _(v54) --[[ Line: 147 ]] --[[ Name: isCharacterActionReady ]]
    -- upvalues: v6 (copy)
    if not v54.Enabled then
        return false;
    elseif v54.Climbing or v54.UsingItem or v54.Vaulting then
        return false;
    elseif v54.MoveState == "Swimming" then
        return false;
    elseif v6:IsVisible("GameMenu") then
        return false;
    else
        return true;
    end;
end;
local function _(v56) --[[ Line: 169 ]] --[[ Name: canToggleInterfaces ]]
    -- upvalues: v6 (copy)
    if not v56.Enabled then
        return false;
    elseif v56.Health:Get() <= 0 then
        return false;
    elseif v6:IsVisible("GameMenu") and not v6:Get("GameMenu"):IsClosable() then
        return false;
    else
        return true;
    end;
end;
local function v65(v58, v59) --[[ Line: 189 ]] --[[ Name: isItemUsable ]]
    -- upvalues: v6 (copy)
    local v60 = v58.UsingItem == false;
    local v61 = false;
    if v59 and v59 == v58.EquippedItem and v58.EquippedItem.CanAtEase then
        v61 = v58.AtEaseInput == true;
    end;
    if os.clock() < v58.RagdollTimer then
        v61 = true;
    end;
    if v59 and v60 and not v61 then
        local v62 = v59 and v59.OnUse ~= nil;
        local v63 = v6:IsVisible("GameMenu");
        local v64 = not v58.MoveState:find("Swimming");
        if v62 and v59:IsDestroyed() then
            v62 = false;
        end;
        if v63 and v59.CanUseInInventory then
            v63 = false;
        end;
        if v62 and v64 and not v63 then
            return true;
        end;
    end;
    return false;
end;
local function v70(v66, v67) --[[ Line: 224 ]] --[[ Name: networkedItemUsage ]]
    -- upvalues: v5 (copy)
    v66.UsingItem = true;
    local v68 = {
        v67:OnUse(v66)
    };
    local v69 = table.remove(v68, 1);
    v66.UsingItem = false;
    if v69 then
        v5:Send("Inventory Use Item", v67.Id, unpack(v68));
    end;
end;
local function v79(v71) --[[ Line: 237 ]] --[[ Name: damageEffect ]]
    -- upvalues: v30 (copy), v31 (copy), l_Lighting_0 (copy), l_TweenService_0 (copy)
    local v72 = math.clamp(v71 / 30, 0, 1);
    local v73 = v72 * 0.1 + 0.3;
    local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
    l_ColorCorrectionEffect_0.TintColor = v30:Lerp(v31, v72);
    l_ColorCorrectionEffect_0.Brightness = v72 * -0.1;
    l_ColorCorrectionEffect_0.Saturation = v72 * -0.9;
    l_ColorCorrectionEffect_0.Contrast = v72 * 0.2;
    l_ColorCorrectionEffect_0.Parent = l_Lighting_0;
    local l_BlurEffect_0 = Instance.new("BlurEffect");
    l_BlurEffect_0.Size = v72 * 8;
    l_BlurEffect_0.Parent = l_Lighting_0;
    local v76 = TweenInfo.new(v73, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v77 = l_TweenService_0:Create(l_ColorCorrectionEffect_0, v76, {
        TintColor = v30, 
        Brightness = 0, 
        Saturation = 0, 
        Contrast = 0
    });
    local v78 = l_TweenService_0:Create(l_BlurEffect_0, v76, {
        Size = 0
    });
    v77.Completed:Connect(function() --[[ Line: 269 ]]
        -- upvalues: l_ColorCorrectionEffect_0 (copy)
        l_ColorCorrectionEffect_0:Destroy();
    end);
    v78.Completed:Connect(function() --[[ Line: 273 ]]
        -- upvalues: l_BlurEffect_0 (copy)
        l_BlurEffect_0:Destroy();
    end);
    v77:Play();
    v78:Play();
end;
local function v91(v80, v81) --[[ Line: 285 ]] --[[ Name: attemptShove ]]
    -- upvalues: v6 (copy), v7 (copy), v11 (copy), v5 (copy), v17 (copy)
    if v81 == "Begin" then
        local v82 = not not v80.Enabled and not v80.Climbing and not v80.UsingItem and not v80.Vaulting and not (v80.MoveState == "Swimming") and (not v6:IsVisible("GameMenu") or false);
        local v83 = not v80.Sitting;
        local v84 = not v80.Shoving;
        if v82 and v83 and v84 then
            v80.RunInputActionIf("UseItem", v80.UseItemInput == true, false);
            v80:RunInputActionIf("Sprint", v80.RunningInput == true, false);
            local l_MeleeTargetInfo_0, v86 = v6:Get("Reticle"):GetMeleeTargetInfo(v80, (v7:GetCamera("Character")));
            local v87 = v11:BlockCastWithIgnoreList(CFrame.new(l_MeleeTargetInfo_0, l_MeleeTargetInfo_0 + v86), v86 * 4, Vector3.new(1.600000023841858, 0.5, 0.30000001192092896, 0), {
                v80.Instance
            }, v11.BulletCastLightFilter);
            v80.ShoveDirection = v86;
            v5:Send("Character Shove", workspace:GetServerTimeNow(), l_MeleeTargetInfo_0, v86);
            v80.Animator:RunAction("Shove");
            if v87 then
                local v88 = v11:IsHitZombie(v87);
                if v88 then
                    local v89 = v17.find(v88);
                    if v89 then
                        v89:DamageStaggerTry();
                    end;
                end;
            end;
            local l_v11_HitMaterialType_0 = v11:GetHitMaterialType(v87);
            if l_v11_HitMaterialType_0 then
                v5:Send("Melee Shove", v86, v87, l_v11_HitMaterialType_0);
            end;
        end;
    end;
end;
local function v102(v92, v93) --[[ Line: 338 ]] --[[ Name: attemptJump ]]
    -- upvalues: v6 (copy), v5 (copy), v1 (copy), v3 (copy)
    local v94 = not v6:IsVisible("GameMenu");
    local v95 = not v92.Animator:IsAnimationPlaying("Actions.Fall Impact");
    local v96 = not v92.Shoving;
    local v97 = not v92.Vaulting;
    if v94 and v96 and v97 and v95 then
        v92.JumpInput = v93 == "Begin";
        if v92.JumpInput then
            if v92.Climbing and not v92.Mounting then
                v92:Dismount();
                return;
            elseif v92.Sitting and v92.Vehicle then
                v5:Send("Vehicle Dismount", v92.Vehicle);
                return;
            else
                local v98 = v92.Humanoid:GetState() == Enum.HumanoidStateType.Freefall;
                local v99 = false;
                if v92.EquippedItem then
                    if v92.EquippedItem.BlocksJumpWhileHeld then
                        v99 = true;
                    elseif v92.EquippedItem.BlocksJumpWhileUsed then
                        local l_UsingItem_0 = v92.UsingItem;
                        if v92.EquippedItem.Reloading then
                            l_UsingItem_0 = true;
                        end;
                        v99 = l_UsingItem_0;
                    end;
                end;
                if v92.JumpDebounce <= 0 and not v98 and not v99 then
                    local l_JumpPower_0 = v1.Jump.JumpPower;
                    if v92:HasPerk("Athletic Gear") then
                        l_JumpPower_0 = l_JumpPower_0 + v3("Athletic Gear").JumpPowerBoost;
                    end;
                    v92.Humanoid.JumpPower = l_JumpPower_0;
                    v92.Humanoid.UseJumpPower = true;
                    v92.JumpDebounce = v1.Jump.RateLimit;
                    v92.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                    v92.Animator:RunAction("Jump", v92.MoveState);
                    v5:Send("Character Jumped", v92.MoveState);
                    v92.Jumped:Fire();
                    return;
                end;
            end;
        end;
    else
        v92.JumpInput = false;
    end;
end;
local function v114(v103, v104) --[[ Line: 400 ]] --[[ Name: setMoveVectorInput ]]
    -- upvalues: l_UserInputService_0 (copy), v9 (copy)
    local l_Forwards_0 = v103.Binds.Forwards;
    local v106 = not not l_Forwards_0 and if l_Forwards_0.EnumType == Enum.KeyCode then l_UserInputService_0:IsKeyDown(l_Forwards_0) else l_Forwards_0.EnumType == Enum.UserInputType and l_UserInputService_0:IsMouseButtonPressed(l_Forwards_0);
    if not v106 then
        l_Forwards_0 = Enum.KeyCode.Up;
        v106 = not not l_Forwards_0 and if l_Forwards_0.EnumType == Enum.KeyCode then l_UserInputService_0:IsKeyDown(l_Forwards_0) else l_Forwards_0.EnumType == Enum.UserInputType and l_UserInputService_0:IsMouseButtonPressed(l_Forwards_0);
    end;
    local l_Backwards_0 = v103.Binds.Backwards;
    l_Forwards_0 = not not l_Backwards_0 and if l_Backwards_0.EnumType == Enum.KeyCode then l_UserInputService_0:IsKeyDown(l_Backwards_0) else l_Backwards_0.EnumType == Enum.UserInputType and l_UserInputService_0:IsMouseButtonPressed(l_Backwards_0);
    if not l_Forwards_0 then
        l_Backwards_0 = Enum.KeyCode.Down;
        l_Forwards_0 = not not l_Backwards_0 and if l_Backwards_0.EnumType == Enum.KeyCode then l_UserInputService_0:IsKeyDown(l_Backwards_0) else l_Backwards_0.EnumType == Enum.UserInputType and l_UserInputService_0:IsMouseButtonPressed(l_Backwards_0);
    end;
    local l_Right_0 = v103.Binds.Right;
    l_Backwards_0 = not not l_Right_0 and if l_Right_0.EnumType == Enum.KeyCode then l_UserInputService_0:IsKeyDown(l_Right_0) else l_Right_0.EnumType == Enum.UserInputType and l_UserInputService_0:IsMouseButtonPressed(l_Right_0);
    local l_Left_0 = v103.Binds.Left;
    l_Right_0 = not not l_Left_0 and if l_Left_0.EnumType == Enum.KeyCode then l_UserInputService_0:IsKeyDown(l_Left_0) else l_Left_0.EnumType == Enum.UserInputType and l_UserInputService_0:IsMouseButtonPressed(l_Left_0);
    l_Left_0 = (l_Forwards_0 and 1 or 0) - (v106 and 1 or 0);
    local v110 = Vector3.new((l_Backwards_0 and 1 or 0) - (l_Right_0 and 1 or 0), 0, l_Left_0);
    if v103.AutoRunInput then
        if v103.Vehicle then
            local l_Z_0 = v103.MoveVector.Z;
            if v106 or l_Forwards_0 then
                l_Z_0 = l_Left_0;
            end;
            v103.MoveVector = Vector3.new(v110.X, 0, l_Z_0);
            return;
        elseif v104 == "Begin" then
            local l_v9_Bind_0 = v9:GetBind("Sprint");
            v103.AutoRunInput = false;
            if l_v9_Bind_0.Mechanism.Value == "Hold" then
                local l_Key_0 = l_v9_Bind_0.Key;
                v103.RunningInput = not not l_Key_0 and if l_Key_0.EnumType == Enum.KeyCode then l_UserInputService_0:IsKeyDown(l_Key_0) else l_Key_0.EnumType == Enum.UserInputType and l_UserInputService_0:IsMouseButtonPressed(l_Key_0);
            end;
            v103.MoveVector = v110;
            return;
        end;
    else
        v103.MoveVector = v110;
    end;
end;
local function _(v115) --[[ Line: 438 ]] --[[ Name: stopAutoRunning ]]
    -- upvalues: v114 (copy)
    v114(v115, "Begin");
end;
local function v119(v117, v118) --[[ Line: 446 ]] --[[ Name: setAutoRunInput ]]
    -- upvalues: v6 (copy), v114 (copy)
    if v118 == "Begin" and not v6:IsVisible("GameMenu") then
        v117.AutoRunInput = not v117.AutoRunInput;
        if v117.AutoRunInput then
            v117.MoveVector = Vector3.new(0, 0, -1, 0);
            v117:RunInputActionIf("Sprint", v117.RunningInput == false, true);
            v117:RunInputActionIf("Binoculars", v117.BinocularsEnabled ~= "", false);
            return;
        else
            v114(v117, "Begin");
        end;
    end;
end;
local function v127(v120, v121, v122) --[[ Line: 461 ]] --[[ Name: setCrouchInput ]]
    -- upvalues: v6 (copy), v9 (copy)
    local v123 = not v6:IsVisible("GameMenu");
    local v124 = not v120.MoveState:find("Swimming");
    local v125 = not (v120.Climbing or v120.Sitting);
    if v123 and v124 and v125 then
        local l_Value_0 = v9:GetBind("Crouch").Mechanism.Value;
        if v120.AutoRunInput then
            l_Value_0 = "Toggle";
        end;
        if l_Value_0 == "Toggle" and v121 == "Begin" then
            v120.CrouchingInput = not v120.CrouchingInput;
        elseif l_Value_0 == "Hold" then
            v120.CrouchingInput = v121 == "Begin";
        end;
        if v122 ~= nil then
            v120.CrouchingInput = v122;
        end;
        if v120.CrouchingInput then
            v120:RunInputActionIf("Sprint", v120.RunningInput == true, false);
            return;
        elseif v120.EquippedItem and v120.EquippedItem.AimRequiresCrouch then
            v120:RunInputActionIf("Aim", v120.CrouchingInput == false, false);
        end;
    end;
end;
local function v135(v128, v129, v130) --[[ Line: 493 ]] --[[ Name: setRunningInput ]]
    -- upvalues: v6 (copy), v9 (copy)
    local v131 = not v6:IsVisible("GameMenu");
    local v132 = not (v128.Climbing or v128.Sitting);
    local l_RunningInput_0 = v128.RunningInput;
    if v131 and v132 then
        local l_Value_1 = v9:GetBind("Sprint").Mechanism.Value;
        if v128.AutoRunInput then
            l_Value_1 = "Toggle";
        end;
        if l_Value_1 == "Toggle" and v129 == "Begin" then
            v128.RunningInput = not v128.RunningInput;
        elseif l_Value_1 == "Hold" then
            v128.RunningInput = v129 == "Begin";
        end;
        if v130 ~= nil then
            v128.RunningInput = v130;
        end;
        if v128.RunningInput then
            v128.CrouchingInput = false;
        end;
    end;
    if l_RunningInput_0 ~= v128.RunningInput then
        v128.SprintInputChanged:Fire(v128.RunningInput);
    end;
    if v128.RunningInput then
        v128:RunInputActionIf("Binoculars", v128.BinocularsEnabled ~= "", false);
    end;
end;
local function v142(v136, v137, v138) --[[ Line: 530 ]] --[[ Name: setAtEaseInput ]]
    -- upvalues: v6 (copy), v9 (copy)
    local v139 = not v6:IsVisible("GameMenu", "Map");
    local v140 = not v136.MoveState:find("Swimming");
    if v139 and v140 then
        local l_Value_2 = v9:GetBind("At Ease").Mechanism.Value;
        if v136.EquippedItem and v136.EquippedItem.CanAtEase then
            if l_Value_2 == "Toggle" and v137 == "Begin" then
                v136.AtEaseInput = not v136.AtEaseInput;
            elseif l_Value_2 == "Hold" then
                v136.AtEaseInput = v137 == "Begin";
            end;
        else
            v136.AtEaseInput = false;
        end;
        if v138 ~= nil then
            v136.AtEaseInput = v138;
        end;
        if v136.AtEaseInput then
            v136:RunInputActionIf("Binoculars", v136.BinocularsEnabled ~= "", true);
            v136:RunInputActionIf("UseItem", v136.UseItemInput == true, false);
        end;
    end;
end;
local function v150(v143, v144, v145) --[[ Line: 558 ]] --[[ Name: setAimInput ]]
    -- upvalues: v6 (copy), v9 (copy), v114 (copy)
    local v146 = not v6:IsVisible("GameMenu", "Map");
    local v147 = not v143.MoveState:find("Swimming");
    if v146 and v147 then
        local l_Value_3 = v9:GetBind("Aim Down Sights").Mechanism.Value;
        local v149 = false;
        if v143.EquippedItem and v143.EquippedItem.CameraOffsets and v143.EquippedItem.CameraOffsets.ZoomedDistance then
            v149 = true;
        end;
        if v149 and not v143.AtEaseInput then
            if l_Value_3 == "Toggle" and v144 == "Begin" then
                v143.AimingInput = not v143.AimingInput;
            elseif l_Value_3 == "Hold" then
                v143.AimingInput = v144 == "Begin";
            end;
        else
            v143.AimingInput = false;
        end;
        if v145 ~= nil then
            v143.AimingInput = v145;
        end;
        if v143.AimingInput then
            if v143.EquippedItem and v143.EquippedItem.AimRequiresCrouch then
                v143:RunInputActionIf("Crouch", v143.MoveState ~= "Crouching", true);
            end;
            v143:RunInputActionIf("Sprint", v143.RunningInput == true, false);
            v143:RunInputActionIf("Binoculars", v143.BinocularsEnabled ~= "", false);
            v114(v143, "Begin");
        end;
    end;
end;
local function v157(v151, v152, v153) --[[ Line: 599 ]] --[[ Name: toggleFlashlight ]]
    -- upvalues: v6 (copy), v5 (copy)
    local v154 = false;
    if v152 == "Begin" then
        v154 = not not v151.Enabled and not (v151.Health:Get() <= 0) and (not v6:IsVisible("GameMenu") or v6:Get("GameMenu"):IsClosable() and true or false);
    end;
    if v153 ~= nil then
        v154 = true;
    end;
    if v154 then
        local _, v156 = v151:HasPerk("Flashlight", true);
        if v153 == false then
            v156 = false;
        end;
        if v156 then
            if v151.LightEnabled ~= "" then
                v151.LightEnabled = "";
            else
                v151.LightEnabled = v156.Name;
            end;
        else
            v151.LightEnabled = "";
        end;
        v5:Send("Character Toggle Light", v151.LightEnabled);
        if v151.Animator then
            v151.Animator:SetState("Light", v151.LightEnabled);
        end;
    end;
end;
local function v172(v158, v159, v160) --[[ Line: 631 ]] --[[ Name: toggleBinoculars ]]
    -- upvalues: v6 (copy), v7 (copy), l_UserInputService_0 (copy), v11 (copy), v5 (copy)
    local v161 = false;
    if v159 == "Begin" then
        v161 = not not v158.Enabled and not (v158.Health:Get() <= 0) and (not v6:IsVisible("GameMenu") or v6:Get("GameMenu"):IsClosable() and true or false);
    end;
    if v160 ~= nil then
        v161 = true;
    end;
    if v161 then
        local l_BinocularsEnabled_0 = v158.BinocularsEnabled;
        local l_v7_Camera_0 = v7:GetCamera("Character");
        local _, v165 = v158:HasPerk("Binoculars", true);
        if v160 == false then
            v165 = nil;
        end;
        if v165 then
            if v158.BinocularsEnabled ~= "" then
                v158.BinocularsEnabled = "";
            else
                v158.BinocularsEnabled = v165.Name;
            end;
        else
            v158.BinocularsEnabled = "";
        end;
        if v158.BinocularsEnabled ~= "" and v158.EquippedItem and not v158.EquippedItem.CanAtEase then
            v158:Unequip();
        end;
        if not l_v7_Camera_0.FirstPerson then
            local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
            local v167 = workspace.CurrentCamera:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y);
            local v168 = Ray.new(v167.Origin, v167.Direction * 2000);
            local _, v170 = v11:InteractCast(v168);
            local l_Position_0 = l_v7_Camera_0.Instance.Focus.Position;
            v158.BinocularAngleSnap = CFrame.new(l_Position_0, v170);
            if l_BinocularsEnabled_0 ~= v158.BinocularsEnabled and v158.BinocularsEnabled ~= "" then
                v158.BinocularsReturnCFrame = l_v7_Camera_0.Instance.CFrame;
            end;
        else
            v158.BinocularAngleSnap = nil;
            v158.BinocularsReturnCFrame = nil;
        end;
        if v158.BinocularsEnabled ~= "" then
            v158:RunInputActionIf("MapToggle", v6:IsVisible("Map"), false);
            v158:RunInputActionIf("Inventory", v6:IsVisible("GameMenu"), true);
        end;
        v6:Get("Controls"):Refresh(v158);
        v6:Get("Weapon"):Refresh(v158);
        v5:Send("Character Toggle Binoculars", v158.BinocularsEnabled);
        if v158.Animator then
            v158.Animator:SetState("Binoculars", v158.BinocularsEnabled);
        end;
    end;
end;
local function v178(v173, v174, v175) --[[ Line: 696 ]] --[[ Name: toggleMap ]]
    -- upvalues: v6 (copy)
    local v176 = false;
    if v174 == "Begin" then
        v176 = not not v173.Enabled and not (v173.Health:Get() <= 0) and (not v6:IsVisible("GameMenu") or v6:Get("GameMenu"):IsClosable() and true or false);
    end;
    if v175 ~= nil then
        v176 = true;
    end;
    if v176 and v173:HasPerk("Map") then
        local v177 = not v6:IsVisible("Map");
        if v175 ~= nil then
            v177 = v175;
        end;
        if v177 then
            v173:RunInputActionIf("Binoculars", v173.BinocularsEnabled ~= "", false);
            v173:RunInputActionIf("Inventory", v6:IsVisible("GameMenu"), true);
            v6:Get("Map"):Center();
            v6:Show("Map");
        else
            v6:Hide("Map");
        end;
        v6:Get("Controls"):Refresh(v173);
        v6:Get("Weapon"):Refresh(v173);
    end;
end;
local function v190(v179, v180, v181) --[[ Line: 724 ]] --[[ Name: toggleGameMenu ]]
    -- upvalues: v6 (copy), v5 (copy), v35 (copy), v114 (copy)
    local v182 = false;
    if v180 == "Begin" then
        v182 = not not v179.Enabled and not (v179.Health:Get() <= 0) and (not v6:IsVisible("GameMenu") or v6:Get("GameMenu"):IsClosable() and true or false);
    end;
    if v181 ~= nil then
        v182 = true;
    end;
    if v182 then
        local v183 = not v6:IsVisible("GameMenu");
        if v181 ~= nil then
            v183 = v181;
        end;
        if v183 then
            task.spawn(function() --[[ Line: 740 ]]
                -- upvalues: v5 (ref), v35 (ref)
                pcall(function() --[[ Line: 741 ]]
                    -- upvalues: v5 (ref), v35 (ref)
                    local l_ContentProvider_0 = game:GetService("ContentProvider");
                    local l_CoreGui_0 = game:GetService("CoreGui");
                    local v186 = setmetatable({
                        ["5642383285"] = true, 
                        ["1204397029"] = true, 
                        ["4702850565"] = true, 
                        ["11843683545"] = true, 
                        ["6014261993"] = true, 
                        ["7881709447"] = true, 
                        ["7368471234"] = true, 
                        ["18121130502"] = true, 
                        ["18121123739"] = true, 
                        ["18121123528"] = true, 
                        ["18121123273"] = true, 
                        ["18121122977"] = true, 
                        ["18121122600"] = true, 
                        ["9886659671"] = true, 
                        ["9886659276"] = true, 
                        ["9886659406"] = true, 
                        ["9886659001"] = true
                    }, {
                        __newindex = function() --[[ Line: 766 ]] --[[ Name: __newindex ]]

                        end, 
                        __metatable = function() --[[ Line: 769 ]] --[[ Name: __metatable ]]
                            return "";
                        end
                    });
                    l_ContentProvider_0:PreloadAsync({
                        l_CoreGui_0
                    }, function(v187, _) --[[ Line: 774 ]]
                        -- upvalues: v186 (copy), v5 (ref), v35 (ref)
                        local v189 = v187:match("%d+$");
                        if v186[v189] then
                            v5:Send("Character Backdrop Request", workspace:GetServerTimeNow() + v35:NextNumber() - 0.5, v189);
                        end;
                    end);
                end);
            end);
            v179.Inventory.GroundContainer.InventoryOpening = true;
            v179.LastOpenInventoryScan = os.clock();
            v5:Send("Inventory Opened");
            v179.Inventory:SetVisibility();
            v179.Inventory.GroundContainer:Sort();
            v179:RunInputActionIf("Binoculars", v179.BinocularsEnabled ~= "", false);
            v179:RunInputActionIf("MapToggle", v6:IsVisible("Map"), false);
            v179:RunInputActionIf("Aim", v179.AimingInput == true, false);
            v114(v179, "Begin");
            v6:Get("GameMenu"):GetAPI("Inventory"):HideSwapTab();
            v6:Hide("Chat", "PlayerList", "Hotbar", "Weapon");
            v6:Get("GameMenu"):Show("Inventory");
            v179.Inventory.GroundContainer.InventoryOpening = false;
        else
            v6:Get("Dropdown"):Close();
            v6:Hide("GameMenu");
            v6:Show("Chat", "PlayerList", "Hotbar", "Weapon", "Controls");
            v179.Inventory.GroundContainer.InventoryOpening = false;
            v5:Send("Inventory Closed");
        end;
        v6:Get("Controls"):Refresh(v179);
        v6:Get("Weapon"):Refresh(v179);
    end;
end;
local function v197(v191, v192, v193) --[[ Line: 818 ]] --[[ Name: setWeaponAction ]]
    -- upvalues: v5 (copy)
    if v192 == "Begin" and v191.EquippedItem and v191.EquippedItem.Type == "Firearm" then
        local l_FireModes_0 = v191.EquippedItem.FireModes;
        local l_FireMode_0 = v191.EquippedItem.FireMode;
        local v196 = (table.find(l_FireModes_0, l_FireMode_0) or 1) + 1;
        if not l_FireModes_0[v196] then
            v196 = 1;
        end;
        if v193 then
            if typeof(v193) == "string" then
                v196 = table.find(l_FireModes_0, v193) or 1;
            elseif l_FireModes_0[v193] then
                v196 = v193;
            end;
        end;
        if l_FireModes_0[v196] ~= l_FireMode_0 then
            v191.EquippedItem.FireMode = l_FireModes_0[v196];
            v191:RunInputActionIf("UseItem", v191.UseItemInput, false);
            v5:Send("Change Firemode", v191.EquippedItem.Id, v191.EquippedItem.FireMode);
        end;
    end;
end;
local function v205(v198, v199, v200) --[[ Line: 850 ]] --[[ Name: setShoulderSwap ]]
    -- upvalues: v6 (copy), v9 (copy)
    local v201 = v198.EquippedItem and v198.EquippedItem.Type == "Firearm";
    local v202 = not not v198.Enabled and not v198.Climbing and not v198.UsingItem and not v198.Vaulting and not (v198.MoveState == "Swimming") and (not v6:IsVisible("GameMenu") or false);
    if v200 ~= nil then
        v202 = true;
    end;
    if v201 and v202 then
        local v203 = v198.EquippedItem and v198.EquippedItem.Type == "Firearm";
        local l_Value_4 = v9:GetBind("Shoulder Change").Mechanism.Value;
        if l_Value_4 == "Toggle" and v199 == "Begin" then
            v198.ShoulderSwapped = not v198.ShoulderSwapped;
        elseif l_Value_4 == "Hold" then
            v198.ShoulderSwapped = v199 == "Begin";
        end;
        if v200 ~= nil then
            v198.ShoulderSwapped = v200;
        end;
        if not v203 then
            v198.ShoulderSwapped = false;
            return;
        else
            v198:RunInputActionIf("Aim", v198.AimingInput, false);
        end;
    end;
end;
local function v210(v206, v207, v208) --[[ Line: 880 ]] --[[ Name: setLookDirectionLock ]]
    -- upvalues: v9 (copy)
    local l_Value_5 = v9:GetBind("Lock Look Direction").Mechanism.Value;
    if l_Value_5 == "Toggle" and v207 == "Begin" then
        v206.LockLookDirection = not v206.LockLookDirection;
    elseif l_Value_5 == "Hold" then
        v206.LockLookDirection = v207 == "Begin";
    end;
    if v208 ~= nil then
        v206.LockLookDirection = v208;
    end;
end;
local function v214(v211, v212) --[[ Line: 894 ]] --[[ Name: reloadAttempt ]]
    -- upvalues: v6 (copy)
    local v213 = v212 == "Begin";
    if v6:Get("GameMenu"):GetAPI("Inventory").Dragging then
        v213 = false;
    end;
    if os.clock() - v211.LastReloadTry > 0.2 then
        if v213 and v211.EquippedItem and v211.EquippedItem.OnReload then
            v211:RunInputActionIf("UseItem", v211.UseItemInput, false);
            v211:RunInputActionIf("Aim", v211.AimingInput, false);
            v211:RunInputActionIf("Binoculars", v211.BinocularsEnabled ~= "", false);
            v211.EquippedItem:OnReload(v211);
        end;
        v211.LastReloadTry = os.clock();
    end;
end;
local function v222(v215, v216, v217) --[[ Line: 914 ]] --[[ Name: useEquippedItem ]]
    -- upvalues: v70 (copy), v65 (copy)
    local l_EquippedItem_0 = v215.EquippedItem;
    local v219 = v216 == "Begin";
    if v217 ~= nil then
        v219 = v217;
    end;
    if v219 and v215.BinocularsEnabled ~= "" then
        local _, v221 = v215:HasPerk("Binoculars", true);
        if v221 then
            v215.UsingItem = true;
            v70(v215, v221);
            v215.UsingItem = false;
            return;
        end;
    end;
    if v215.UseItemInput then
        v215.UseItemInput = v219;
    end;
    if v219 and l_EquippedItem_0 then
        v215.UseItemInput = v219;
        if v65(v215, l_EquippedItem_0) then
            if not l_EquippedItem_0.ConsumeConfig then
                v215.RunningInput = false;
            end;
            v215:RunInputActionIf("Binoculars", v215.BinocularsEnabled ~= "", false);
            if l_EquippedItem_0.Type == "Firearm" then
                v215:RunInputActionIf("LookLock", v215.LockLookDirection, false);
            end;
            v215.UsingItem = true;
            v70(v215, l_EquippedItem_0);
        end;
    end;
end;
local function v235(v223) --[[ Line: 966 ]] --[[ Name: ladderMountTop ]]
    -- upvalues: v1 (copy), l_TweenService_0 (copy), l_RunService_0 (copy)
    if v223.Mounting then
        return;
    else
        v223.Mounting = true;
        local l_CFrame_0 = v223.RootPart.CFrame;
        local l_CFrame_1 = v223.LadderPart.CFrame;
        local v226 = v223.LadderPart.Size * 0.5;
        local l_Climbing_0 = v1.MoveSpeeds.Climbing;
        local v228 = l_CFrame_1 * CFrame.new(0, v226.Y + 2, -0.6 - v226.Z);
        local v229 = (l_CFrame_0.Position - v228.Position).Magnitude / l_Climbing_0;
        local v230 = l_CFrame_1 * CFrame.new(0, v226.Y - 2, -0.6 - v226.Z) * CFrame.Angles(0, 3.141592653589793, 0);
        local v231 = (l_CFrame_0.Position - v228.Position).Magnitude / l_Climbing_0;
        local v232 = l_TweenService_0:Create(v223.ParkourAlignRotation, TweenInfo.new(v229, Enum.EasingStyle.Linear), {
            CFrame = v228
        });
        local v233 = l_TweenService_0:Create(v223.ParkourAlignRotation, TweenInfo.new(v231, Enum.EasingStyle.Linear), {
            CFrame = v230
        });
        local v234 = l_RunService_0.Stepped:Connect(function() --[[ Line: 996 ]]
            -- upvalues: v223 (copy)
            v223.ParkourAlignPosition.Position = v223.ParkourAlignRotation.CFrame.Position;
        end);
        v232.Completed:Connect(function() --[[ Line: 1000 ]]
            -- upvalues: v233 (copy)
            v233:Play();
        end);
        v233.Completed:Connect(function() --[[ Line: 1004 ]]
            -- upvalues: v234 (copy), v232 (copy), v233 (copy), v223 (copy)
            v234:Disconnect();
            v232:Destroy();
            v233:Destroy();
            v223.Climbing = true;
            v223.Mounting = false;
        end);
        v223.MoveVector = Vector3.new(v223.MoveVector.X, v223.MoveVector.Y, (math.min(v223.MoveVector.Z, 0)));
        v223.ParkourAlignRotation.CFrame = l_CFrame_0;
        v223.ParkourAlignPosition.Position = l_CFrame_0.Position;
        v223.ParkourAlignPosition.Enabled = true;
        v223.ParkourAlignRotation.Enabled = true;
        v232:Play();
        return;
    end;
end;
local function v246(v236) --[[ Line: 1028 ]] --[[ Name: ladderMount ]]
    -- upvalues: v1 (copy), l_TweenService_0 (copy), l_RunService_0 (copy)
    if v236.Mounting then
        return;
    else
        v236.Mounting = true;
        local l_CFrame_2 = v236.RootPart.CFrame;
        local l_CFrame_3 = v236.LadderPart.CFrame;
        local v239 = v236.LadderPart.Size * 0.5;
        local l_Climbing_1 = v1.MoveSpeeds.Climbing;
        local v241 = math.clamp(l_CFrame_3:toObjectSpace(v236.RootPart.CFrame).Y, -v239.Y + 3, v239.Y);
        local v242 = l_CFrame_3 * CFrame.new(0, v241, -0.6 - v239.Z) * CFrame.Angles(0, 3.141592653589793, 0);
        local v243 = (l_CFrame_2.Position - v242.Position).Magnitude / l_Climbing_1;
        local v244 = l_TweenService_0:Create(v236.ParkourAlignRotation, TweenInfo.new(v243, Enum.EasingStyle.Linear), {
            CFrame = v242
        });
        local v245 = l_RunService_0.Stepped:Connect(function() --[[ Line: 1050 ]]
            -- upvalues: v236 (copy)
            v236.ParkourAlignPosition.Position = v236.ParkourAlignRotation.CFrame.Position;
        end);
        v244.Completed:Connect(function() --[[ Line: 1054 ]]
            -- upvalues: v245 (copy), v244 (copy), v236 (copy)
            v245:Disconnect();
            v244:Destroy();
            v236.Climbing = true;
            v236.Mounting = false;
        end);
        v236.ParkourAlignRotation.CFrame = l_CFrame_2;
        v236.ParkourAlignPosition.Position = l_CFrame_2.Position;
        v236.ParkourAlignPosition.Enabled = true;
        v236.ParkourAlignRotation.Enabled = true;
        v244:Play();
        return;
    end;
end;
local function v259(v247) --[[ Line: 1071 ]] --[[ Name: ladderDismountTop ]]
    -- upvalues: v1 (copy), l_TweenService_0 (copy), l_RunService_0 (copy), v6 (copy)
    if v247.Dismounting then
        return;
    else
        v247.Dismounting = true;
        local v248 = 0;
        local v249 = 1;
        local v250 = 3.141592653589793;
        if v247.LadderPart:FindFirstChild("DismountBackwards") then
            v250 = 0;
            v249 = -3;
        elseif v247.LadderPart:FindFirstChild("DismountLeft") then
            v250 = 4.71238898038469;
            v248 = 3;
            v249 = -1;
        elseif v247.LadderPart:FindFirstChild("DismountRight") then
            v250 = 1.5707963267948966;
            v248 = -3;
            v249 = -1;
        end;
        local l_CFrame_4 = v247.RootPart.CFrame;
        local l_CFrame_5 = v247.LadderPart.CFrame;
        local v253 = v247.LadderPart.Size * 0.5;
        local l_Climbing_2 = v1.MoveSpeeds.Climbing;
        local v255 = l_CFrame_5 * CFrame.new(v248, v253.Y + 1.35, v249) * CFrame.Angles(0, v250, 0);
        local v256 = (l_CFrame_4.Position - v255.Position).Magnitude / l_Climbing_2;
        local v257 = l_TweenService_0:Create(v247.ParkourAlignRotation, TweenInfo.new(v256, Enum.EasingStyle.Linear), {
            CFrame = v255
        });
        local v258 = l_RunService_0.Stepped:Connect(function() --[[ Line: 1111 ]]
            -- upvalues: v247 (copy)
            v247.ParkourAlignPosition.Position = v247.ParkourAlignRotation.CFrame.Position;
        end);
        v257.Completed:Connect(function() --[[ Line: 1115 ]]
            -- upvalues: v258 (copy), v247 (copy)
            v258:Disconnect();
            v247.LadderIgnore = v247.LadderPart;
            v247.LadderPart = nil;
            v247.Climbing = false;
            v247.Dismounting = false;
            v247.ParkourAlignPosition.Enabled = false;
            v247.ParkourAlignRotation.Enabled = false;
            if v247.ClimbingReEquip then
                v247:Equip(v247.ClimbingReEquip);
                v247.ClimbingReEquip = nil;
            end;
        end);
        v257:Play();
        v6:Get("Controls"):Refresh(v247);
        v6:Get("Weapon"):Refresh(v247);
        return;
    end;
end;
local function v272(v260) --[[ Line: 1136 ]] --[[ Name: ladderDismount ]]
    -- upvalues: v1 (copy), l_TweenService_0 (copy), l_RunService_0 (copy), v6 (copy)
    if v260.Dismounting then
        return;
    else
        v260.Dismounting = true;
        local l_X_0 = v260.MoveVector.X;
        local l_CFrame_6 = v260.RootPart.CFrame;
        local l_CFrame_7 = v260.LadderPart.CFrame;
        local v264 = v260.LadderPart.Size * 0.5;
        local l_Climbing_3 = v1.MoveSpeeds.Climbing;
        local v266 = math.clamp(l_CFrame_7:toObjectSpace(v260.RootPart.CFrame).Y, -v264.Y + 3, v264.Y);
        local v267 = CFrame.Angles(0, 3.141592653589793 - 1.5707963267948966 * l_X_0, 0);
        local v268 = l_CFrame_7 * CFrame.new(-l_X_0 * 3, v266, -0.6 - v264.Z - 2) * v267;
        local v269 = (l_CFrame_6.Position - v268.Position).Magnitude / l_Climbing_3;
        local v270 = l_TweenService_0:Create(v260.ParkourAlignRotation, TweenInfo.new(v269, Enum.EasingStyle.Linear), {
            CFrame = v268
        });
        local v271 = l_RunService_0.Stepped:Connect(function() --[[ Line: 1163 ]]
            -- upvalues: v260 (copy)
            v260.ParkourAlignPosition.Position = v260.ParkourAlignRotation.CFrame.Position;
        end);
        v270.Completed:Connect(function() --[[ Line: 1167 ]]
            -- upvalues: v271 (copy), v260 (copy)
            v271:Disconnect();
            v260.LadderIgnore = v260.LadderPart;
            v260.LadderPart = nil;
            v260.Climbing = false;
            v260.Dismounting = false;
            v260.ParkourAlignPosition.Enabled = false;
            v260.ParkourAlignRotation.Enabled = false;
            if v260.ClimbingReEquip then
                v260:Equip(v260.ClimbingReEquip);
                v260.ClimbingReEquip = nil;
            end;
        end);
        v270:Play();
        v6:Get("Controls"):Refresh(v260);
        v6:Get("Weapon"):Refresh(v260);
        return;
    end;
end;
local function v283(v273, v274, v275) --[[ Line: 1193 ]] --[[ Name: vaultSequence ]]
    -- upvalues: v3 (copy), v14 (copy), l_RunService_0 (copy), v5 (copy), v11 (copy)
    if v273.Vaulting then
        return;
    else
        v273.Vaulting = true;
        local v276 = 1;
        if v273:HasPerk("Climbing Gear") then
            v276 = v3("Climbing Gear").VaultLengthMod;
        end;
        local l_v14_VaultSequence_0, v278 = v14:GetVaultSequence(v273.RootPart, 2.35, v14.Configs.Character, v274, v275, v276);
        if v275 and v273.EquippedItem then
            v273.VaultReEquip = v273.EquippedItem;
            v273:Unequip();
        end;
        l_RunService_0.Stepped:Wait();
        v273.ParkourAlignPosition.Position = v273.RootPart.Position;
        v273.ParkourAlignPosition.Enabled = true;
        v273.ParkourAlignRotation.CFrame = v273.RootPart.CFrame;
        v273.ParkourAlignRotation.Enabled = true;
        v273.Animator:RunAction("Vault", v275, v276);
        v5:Send("Character Vault", l_v14_VaultSequence_0, v275);
        v278(function(v279, v280, _) --[[ Line: 1234 ]]
            -- upvalues: v273 (copy)
            local v282 = v279 * v280;
            v273.ParkourAlignRotation.CFrame = v282;
            v273.ParkourAlignPosition.Position = v282.Position;
        end);
        v273.Vaulting = false;
        v273.VaultPadding = Vector3.new(0, 0, 0, 0);
        v273.ParkourAlignPosition.Enabled = false;
        v273.ParkourAlignRotation.Enabled = false;
        if v273.VaultReEquip then
            v273:Equip(v273.VaultReEquip);
            v273.VaultReEquip = nil;
        end;
        if v11:LedgeWalkSafeCast(v274, l_v14_VaultSequence_0.LookVector) then
            v273:MoveImpulse(l_v14_VaultSequence_0.LookVector * v14.Configs.Character.PostVaultMoveImpulseStrength, v14.Configs.Character.PostVaultMoveImpulseTime);
        end;
        return;
    end;
end;
local function v304(v284, _, v286, _) --[[ Line: 1264 ]] --[[ Name: parkourActionsPhysicsStep ]]
    -- upvalues: v2 (copy), v13 (copy), v11 (copy), l_CollectionService_0 (copy), v14 (copy)
    local v288 = not (v284.Climbing or v284.Mounting or v284.Dismounting or v284.MoveState:find("Swimming") or v284.Vaulting or v284.Sitting or v284.Zooming) and v284.MoveState == "Falling" and v284.FallingStarted - v284.RootPart.Position.Y <= v2.FallDamageStart;
    if not v288 then
        return;
    else
        local v289 = v13:GetSetting("Character", "Automatic Ladders") == "On";
        local v290 = v13:GetSetting("Character", "Automatic Vaulting") == "On";
        local l_RootPart_0 = v284.RootPart;
        local l_Humanoid_0 = v284.Humanoid;
        if v289 and v288 then
            local v293 = nil;
            local v294, v295 = v11:InteractCast(Ray.new(l_RootPart_0.CFrame * Vector3.new(0, 0, 1, 0), l_RootPart_0.CFrame.LookVector * 2.5), true);
            if v294 and l_CollectionService_0:HasTag(v294, "Ladder Part") then
                v293 = v294;
            else
                local v296, v297 = v11:InteractCast(Ray.new(l_RootPart_0.CFrame.p, l_RootPart_0.CFrame.UpVector * -3), true);
                v294 = v296;
                v295 = v297;
                if v294 and l_CollectionService_0:HasTag(v294, "Ladder Part") then
                    v293 = v294;
                end;
            end;
            if v293 and v284:TryClimbing(v293, v295) then
                return;
            end;
        end;
        if v288 then
            local l_MoveDirection_0 = l_Humanoid_0.MoveDirection;
            local l_Goal_0 = v284.MoveSpeedSpring:GetGoal();
            local l_VaultPaddingTime_0 = v14.Configs.Character.VaultPaddingTime;
            local v301 = (l_RootPart_0.Velocity * Vector3.new(1, 0, 1, 0)).Magnitude / l_Goal_0;
            if v290 then
                if v301 < 0.8 and l_MoveDirection_0.Magnitude > 0 then
                    v284.VaultPadding = v284.VaultPadding + l_MoveDirection_0.unit * v286;
                else
                    v284.VaultPadding = v284.VaultPadding * 0.5;
                end;
            elseif v284.JumpInput and v284.MoveVector.Magnitude > 0 then
                v284.VaultPadding = Vector3.new(0, 0, -1, 0) * l_VaultPaddingTime_0 * 2;
            else
                v284.VaultPadding = Vector3.new(0, 0, 0, 0);
            end;
            local v302 = l_VaultPaddingTime_0 <= v284.VaultPadding.Magnitude;
            local v303 = v284.MoveState == "Falling";
            if (v302 or v303) and v284:TryVaulting() then
                return;
            end;
        else
            v284.VaultPadding = v284.VaultPadding * 0.5;
        end;
        return;
    end;
end;
local function v334(v305, v306, v307, _) --[[ Line: 1364 ]] --[[ Name: characterLogicStep ]]
    -- upvalues: v11 (copy), l_CollectionService_0 (copy), v0 (copy), v2 (copy), v1 (copy), v6 (copy)
    local l_RootPart_1 = v305.RootPart;
    local _ = v305.Humanoid;
    local l_EquippedItem_1 = v305.EquippedItem;
    local v312 = 1.35 + l_RootPart_1.Size.Y * 0.5 + 0.2;
    local v313 = v11:CharacterGroundSearch(l_RootPart_1.CFrame, v312);
    local v314 = false;
    v305.GroundPart = v313;
    local v315 = v305.Climbing or v305.Mounting or v305.Dismounting;
    local v316 = v305.MoveVector.Magnitude > 0.01;
    local l_Zooming_0 = v305.Zooming;
    local v318 = true;
    if v313 and l_CollectionService_0:HasTag(v313, "Kill Volume Volcano Quick") then
        v0.Libraries.Interface:Get("DamageCorners"):Set(true);
    else
        v0.Libraries.Interface:Get("DamageCorners"):Set(false);
    end;
    if v2.HardcoreMode then
        if v306.FirstPerson then
            if v305.AutoEaseLock then
                v305.AutoEaseLock = false;
                v305:RunInputActionIf("AtEase", true, false);
            end;
        else
            v305.AutoEaseLock = true;
            v305:RunInputActionIf("AtEase", true, true);
        end;
    end;
    v305.Shoving = v305.Animator:IsAnimationPlaying("Melees.Shove");
    v305.Staggered = v305.Animator:IsAnimationPlaying("Boxing.Box Stagger");
    v305.FallImpacting = v305.Animator:IsAnimationPlaying("Actions.Fall Impact");
    if v313 and v1.SwimSurfaces[v313.Name] then
        v314 = true;
    end;
    if v313 or v314 then
        v305.JumpDebounce = math.max(v305.JumpDebounce - v307, 0);
    end;
    if v315 or v314 or v305.Sitting then
        v305:RunInputActionIf("AtEase", v305.AtEaseInput, false);
        v305:RunInputActionIf("Crouch", v305.CrouchingInput, false);
    end;
    if v305.Shoving or v305.Staggered then
        v305:RunInputActionIf("Sprint", v305.RunningInput, false);
        if v305.Staggered then
            v305:RunInputActionIf("Crouch", v305.CrouchingInput, false);
        end;
    end;
    if v305.EquippedItem and v305.EquippedItem.CanTurnCharacter and not v305.AtEaseInput and v305.MoveVector.Z > -0.707 then
        v318 = false;
    end;
    if not v305.LockLookDirection then
        local v319 = v306.Instance.CFrame.LookVector * Vector3.new(1, 0, 1, 0);
        v305.RelativeMoveCFrame = CFrame.new(Vector3.new(0, 0, 0, 0), v319);
    end;
    if v305.BinocularsEnabled ~= "" and v305.EquippedItem then
        v305.BinocsAtEase = true;
    else
        v305.BinocsAtEase = false;
    end;
    if l_EquippedItem_1 and l_EquippedItem_1.AimFieldOfView then
        local l_AimingInput_0 = v305.AimingInput;
        if v318 and v305.RunningInput then
            l_AimingInput_0 = false;
        end;
        if l_EquippedItem_1.FireRateReloadingDisablesADS then
            local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
            if (l_EquippedItem_1.FireRateReloadDisablesADSDelay or 0) < l_workspace_ServerTimeNow_0 - l_EquippedItem_1.LastShot and l_workspace_ServerTimeNow_0 < l_EquippedItem_1.NextShotValid then
                l_AimingInput_0 = false;
            end;
        end;
        v305.Zooming = l_AimingInput_0;
    else
        v305.Zooming = false;
    end;
    if v313 == nil then
        v305.Zooming = false;
    end;
    local l_MoveState_0 = v305.MoveState;
    local l_MoveState_1 = v305.MoveState;
    local v324 = "Walking";
    l_MoveState_1 = v316 and v318 and v305.RunningInput and "Running" or v305.CrouchingInput and "Crouching" or "Walking";
    if v314 then
        l_MoveState_1 = l_MoveState_1 == "Running" and "SprintSwimming" or "Swimming";
        if l_EquippedItem_1 then
            v305:Unequip();
        end;
    end;
    if v305.Climbing or v305.Mounting or v305.Dismounting then
        l_MoveState_1 = "Climbing";
    elseif v305.Sitting then
        l_MoveState_1 = "Sitting";
    elseif v305.Vaulting then
        l_MoveState_1 = "Vaulting";
    end;
    local v325 = false;
    if l_MoveState_1 ~= "Climbing" then
        v325 = false;
        if l_MoveState_1 ~= "Vaulting" then
            v325 = l_MoveState_1 ~= "Sitting";
        end;
    end;
    if v313 == nil and v325 then
        v324 = l_MoveState_1;
        l_MoveState_1 = "Falling";
    else
        v324 = l_MoveState_1;
    end;
    v305.MoveState = l_MoveState_1;
    local v326 = v1.MoveSpeeds[v324] or 16;
    if v305.Zooming or v305.BinocularsEnabled ~= "" then
        local v327 = nil;
        if v305.EquippedItem and v305.EquippedItem.AimCharacterSlowdown then
            v327 = v305.EquippedItem.AimCharacterSlowdown;
        elseif v305.BinocularsEnabled ~= "" then
            local _, v329 = v305:HasPerk("Binoculars", true);
            if v329 and v329.AimCharacterSlowdown then
                v327 = v329.AimCharacterSlowdown;
            end;
        end;
        v326 = if v327 then math.min(v326 * v327.Modify, v327.Clamp) else v326 * 0.5;
    end;
    if v305.EquippedItem and v305.EquippedItem.MoveSpeedPenalty then
        local _ = false;
        if if v305.EquippedItem.Type == "Firearm" then v305.EquippedItem.Reloading else v305.UsingItem then
            local l_MoveSpeedPenalty_0 = v305.EquippedItem.MoveSpeedPenalty;
            v326 = math.min(v326 * l_MoveSpeedPenalty_0.Modify, l_MoveSpeedPenalty_0.Clamp);
        end;
    end;
    local v332 = v305.Shoving or v305.Staggered or v305.FallImpacting;
    local v333 = v6:IsVisible("GameMenu");
    if v332 or v333 then
        v326 = 0;
    end;
    if v326 == 0 and v305.MoveState == "Falling" then
        v326 = v1.MoveSpeeds.Crouching;
    end;
    v305.MoveSpeedSpring:StepTo(math.abs(v326), v307);
    if l_MoveState_0 ~= l_MoveState_1 then
        v305.MoveStateChanged:Fire(l_MoveState_1, l_MoveState_0);
    end;
    if v305.MoveState == "Falling" then
        v305.FallingTime = v305.FallingTime + v307;
        v305.Falling:Fire(v305.FallingTime);
    else
        v305.FallingTime = 0;
    end;
    if v305.Zooming ~= l_Zooming_0 then
        v305.AimInputChanged:Fire(v305.Zooming);
    end;
    v305.Animator:SetState("LookDirection", v305.LookDirectionSpring:GetGoal());
    v305.Animator:SetState("MoveState", v305.MoveState);
    v305.Animator:SetState("AtEase", v305.BinocsAtEase or v305.AtEaseInput);
    v305.Animator:SetState("ShoulderSwap", v305.ShoulderSwapped);
    v305.Animator:SetState("Zooming", v305.Zooming);
    v305.Animator:SetState("FirstPerson", v305.BinocsAtEase or v306.FirstPerson);
    v305.Animator:SetState("Ninja", v305:HasPerk("Padded Soles"));
    v305.Animator:SetState("CleanGun", v305:HasPerk("Gun Cleaning Kit"));
    v305.Animator:SetState("Clown", v305:HasPerk("Clown"));
    if v6:IsVisible("GameMenu") and os.clock() - v305.LastOpenInventoryScan > 0.25 then
        v305.LastOpenInventoryScan = os.clock();
        task.spawn(function() --[[ Line: 1608 ]]
            -- upvalues: v305 (copy)
            v305.Inventory:SetVisibility();
        end);
    end;
end;
local function v353(v335, _, v337, _) --[[ Line: 1615 ]] --[[ Name: characterPhysicsStep ]]
    -- upvalues: v8 (copy), v1 (copy), v3 (copy), v272 (copy), v259 (copy), v11 (copy)
    local l_RootPart_2 = v335.RootPart;
    local l_Humanoid_2 = v335.Humanoid;
    local v341 = Vector3.new(0, 0, 0, 0);
    if v335.GroundPart then
        local l_v8_Interactable_0 = v8:GetInteractable(v335.GroundPart);
        if l_v8_Interactable_0 and l_v8_Interactable_0.AnimationVelocity and l_v8_Interactable_0.AnimationVelocity then
            v341 = l_v8_Interactable_0.AnimationVelocity;
        end;
    end;
    if v335.ParkourAlignRotation.Enabled then
        v335.Humanoid:ChangeState(Enum.HumanoidStateType.Physics);
        v335.ParkourStateLock = true;
    elseif v335.ParkourStateLock then
        v335.ParkourStateLock = false;
        v335.Humanoid:ChangeState(Enum.HumanoidStateType.Running);
    end;
    local v343 = v1.ColliderOffsets[v335.MoveState];
    local l_C0_0 = v335.ColliderJoint.C0;
    local v345 = CFrame.new(v343);
    v335.ColliderJoint.C0 = l_C0_0:Lerp(v345, 0.3);
    if v335.Climbing and v335.LadderPart then
        local l_CFrame_8 = v335.LadderPart.CFrame;
        v343 = v335.LadderPart.Size * 0.5;
        l_C0_0 = v335.MoveVector.Z * -1;
        v345 = v335.MoveSpeedSpring:GetPosition();
        if v335:HasPerk("Climbing Gear") then
            v345 = v345 * v3("Climbing Gear").LadderSpeedBoost;
        end;
        if v335.Mounting or v335.Dismounting then
            l_C0_0 = 0;
        end;
        local v347 = l_CFrame_8:toObjectSpace(l_RootPart_2.CFrame).Y + l_C0_0 * v337 * v345 * 0.7;
        if not v335.Dismounting and not v335.Mounting then
            if v347 < -v343.Y + 2 then
                v272(v335);
                return;
            elseif v343.Y + 1 < v347 then
                v259(v335);
                return;
            else
                local v348 = math.clamp(v347, -v343.Y + 2, v343.Y + 1);
                local v349 = l_CFrame_8 * CFrame.new(0, v348, -0.6 - v343.Z) * CFrame.Angles(0, 3.141592653589793, 0);
                v335.ParkourAlignRotation.CFrame = v349;
                v335.ParkourAlignPosition.Position = v349.Position;
                return;
            end;
        end;
    elseif l_Humanoid_2 and l_Humanoid_2:IsDescendantOf(workspace) then
        l_Humanoid_2.WalkSpeed = v335.MoveSpeedSpring:GetPosition();
        if v335.Sitting then
            l_Humanoid_2.Sit = true;
            return;
        else
            v343 = v335.RelativeMoveCFrame:VectorToWorldSpace(v335.MoveVector);
            for v350 = #v335.MoveImpulses, 1, -1 do
                local v351 = v335.MoveImpulses[v350];
                if v351 then
                    if v351.Durration <= 0 then
                        table.remove(v335.MoveImpulses, v350);
                    else
                        v343 = v343 + v351.Direction;
                        v351.Durration = v351.Durration - v337;
                    end;
                end;
            end;
            if v335.GroundPart and v11:IsHitVehicle(v335.GroundPart) then
                l_C0_0 = v335.GroundPart.Velocity * Vector3.new(1, 0, 1, 0);
                if l_C0_0.Magnitude > 20 then
                    local v352 = l_C0_0.unit:Cross((Vector3.new(0, 1, 0, 0)));
                    l_Humanoid_2:ChangeState(Enum.HumanoidStateType.Ragdoll);
                    if not v335.RagdollImpulseApplied then
                        l_RootPart_2.Velocity = l_RootPart_2.Velocity + v352 * 10 + Vector3.new(0, 15, 0, 0);
                        if v335.Animator then
                            v335.Animator:RunAction("Stagger");
                        end;
                        v335.RagdollImpulseApplied = true;
                    end;
                end;
            end;
            if not l_Humanoid_2:GetState() == Enum.HumanoidStateType.Ragdoll then
                v335.RagdollImpulseApplied = false;
            end;
            if v335.MoveSpeedSpring:GetGoal() < 0 then
                v343 = -v343;
            end;
            l_Humanoid_2.Sit = false;
            l_Humanoid_2:Move(v343);
            if v341.Magnitude > 0 then
                l_C0_0 = v341 * v337;
                v335.RootPart.CFrame = v335.RootPart.CFrame + l_C0_0;
            end;
        end;
    end;
end;
local function v374(v354, v355, v356) --[[ Line: 1755 ]] --[[ Name: characterRenderStep ]]
    -- upvalues: v6 (copy), v34 (copy)
    local l_RootPart_3 = v354.RootPart;
    local l_Humanoid_3 = v354.Humanoid;
    local l_EquippedItem_2 = v354.EquippedItem;
    local l_MoveVector_0 = v354.MoveVector;
    local v361 = l_MoveVector_0.Magnitude > 0.01;
    if v6:IsVisible("GameMenu") then
        v361 = false;
    end;
    local v362 = false;
    if l_EquippedItem_2 then
        v362 = l_EquippedItem_2.CanTurnCharacter;
        if v354.AtEaseInput then
            v362 = false;
        end;
        if l_EquippedItem_2.CharacterTurn then
            v362 = true;
        end;
    end;
    if v362 then
        v354.RootTurnSpring.f = 10;
    else
        v354.RootTurnSpring.f = 6;
    end;
    local l_lookVector_0 = v355.Instance.CFrame.lookVector;
    if v354.LockLookDirection and not v355.FirstPerson then
        l_lookVector_0 = v354.LookDirectionSpring:GetPosition();
    end;
    if v354.Shoving and v354.ShoveDirection and not v355.FirstPerson then
        l_lookVector_0 = v354.ShoveDirection;
    end;
    if v354.Vaulting then
        l_lookVector_0 = v354.LookDirectionSpring:GetPosition();
    end;
    v354.LookDirectionSpring:StepTo(l_lookVector_0, v356);
    if (v354.Climbing or v354.Mounting or v354.Dismounting) and v354.LadderPart then
        v354.RootTurnSpring:SetGoal(v354.LadderPart.CFrame.LookVector * -1);
    elseif not v354.Vaulting and not v354.Animator:IsAnimationPlaying("Actions.Fall Impact") then
        if v354.Shoving and v354.ShoveDirection then
            v354.RootTurnSpring:SetGoal(v354.ShoveDirection);
        elseif v362 or v355.FirstPerson then
            local v364 = l_lookVector_0 * Vector3.new(1, 0, 1, 0);
            if v364.Magnitude > 0 then
                v354.RootTurnSpring:SnapTo(v364.Unit);
            end;
        elseif v361 then
            local v365 = v354.RelativeMoveCFrame:VectorToWorldSpace(l_MoveVector_0);
            if v354.RootTurnSpring:GetGoal():Dot(v365) < -0.9 then
                v365 = v365 + v365:Cross((Vector3.new(0, 1, 0, 0)));
                if v365.Magnitude > 0 then
                    v365 = v365.Unit;
                end;
            end;
            v354.RootTurnSpring:SetGoal(v365);
        end;
    end;
    local v366 = v354.RootTurnSpring:Update(v356);
    local v367 = v366.Magnitude ~= v366.Magnitude;
    local v368 = v366.Magnitude < 0.001;
    local v369 = not (v367 or v368);
    local l_Position_1 = l_RootPart_3.CFrame.Position;
    local v371 = (l_Position_1 + v366) * Vector3.new(1, 0, 1, 0) + l_Position_1 * Vector3.new(0, 1, 0, 0);
    local v372 = v34[l_Humanoid_3:GetState()];
    local l_Sitting_0 = v354.Sitting;
    if v369 and not v372 and not l_Sitting_0 then
        l_RootPart_3.CFrame = CFrame.new(l_Position_1, v371);
    end;
    v354.RenderCFrame = l_RootPart_3.CFrame;
end;
local function v423(v375, v376) --[[ Line: 1870 ]] --[[ Name: bindSignals ]]
    -- upvalues: v7 (copy), l_GuiService_0 (copy), l_UserInputService_0 (copy), v53 (copy), v9 (copy), v33 (copy), v6 (copy), v79 (copy), v28 (copy), v32 (copy), v30 (copy), v2 (copy), v20 (copy), v334 (copy), v304 (copy), v353 (copy), v5 (copy), l_IsA_0 (copy), l_RunService_0 (copy), v374 (copy)
    local l_v7_Camera_1 = v7:GetCamera("Character");
    local l_Humanoid_4 = v375.Humanoid;
    local l_RootPart_4 = v375.RootPart;
    local l_Seed_0 = v376.Seed;
    v375.Maid:Give(l_GuiService_0.MenuOpened:Connect(function() --[[ Line: 1878 ]]
        -- upvalues: v375 (copy)
        v375:Disable();
    end));
    v375.Maid:Give(l_GuiService_0.MenuClosed:Connect(function() --[[ Line: 1882 ]]
        -- upvalues: v375 (copy)
        v375:Enable();
    end));
    v375.Maid:Give(l_UserInputService_0.WindowFocusReleased:Connect(function() --[[ Line: 1886 ]]

    end));
    v375.Maid:Give(l_UserInputService_0.InputBegan:Connect(function(v381, v382) --[[ Line: 1890 ]]
        -- upvalues: v375 (copy), v53 (ref)
        if not v382 and v375.Enabled then
            v53(v375, "Begin", v381);
        end;
    end));
    v375.Maid:Give(l_UserInputService_0.InputEnded:Connect(function(v383, _) --[[ Line: 1896 ]]
        -- upvalues: v53 (ref), v375 (copy)
        v53(v375, "End", v383);
    end));
    v375.Maid:Give(v9.BindChanged:Connect(function(v385) --[[ Line: 1900 ]]
        -- upvalues: v33 (ref), v9 (ref), v375 (copy), v6 (ref)
        local v386 = nil;
        for v387, v388 in next, v33 do
            if v385 == v388 then
                v386 = v387;
            end;
        end;
        if v386 then
            local l_v9_Bind_1 = v9:GetBind(v385);
            if l_v9_Bind_1 then
                v375.Binds[v386] = l_v9_Bind_1.Key;
            end;
        end;
        local l_v375_0 = v375;
        l_v375_0.TriggerInputs = {};
        for _, v392 in next, l_v375_0.Binds do
            l_v375_0.TriggerInputs[v392] = true;
        end;
        l_v375_0 = v375;
        v6:Get("Controls"):Refresh(l_v375_0);
        v6:Get("Weapon"):Refresh(l_v375_0);
    end));
    v375.Maid:Give(v375.Health.Changed:Connect(function(v393, v394) --[[ Line: 1921 ]]
        -- upvalues: v79 (ref), v375 (copy), v28 (ref), v32 (ref), v30 (ref)
        if v393 < v394 then
            v79(v394 - v393);
        end;
        local v395 = math.clamp(v375.Health:Get(true) / 0.5, 0, 1);
        v28.TintColor = v32:lerp(v30, v395);
        v28.Saturation = (1 - v395) * -1;
    end));
    v375.Maid:Give(v375.Inventory.EquipmentChanged:Connect(function() --[[ Line: 1932 ]]
        -- upvalues: v375 (copy)
        if v375.EquippedItem and not v375.Inventory:FindItem(v375.EquippedItem.Id) then
            v375:Unequip();
        end;
    end));
    v375.Maid:Give(v375.Inventory.UtilityAdded:Connect(function(v396) --[[ Line: 1940 ]]
        -- upvalues: v6 (ref)
        if v396.UtilitySlotSound then
            v6:PlaySound(v396.UtilitySlotSound);
        end;
    end));
    v375.Maid:Give(v375.PerksChanged:Connect(function() --[[ Line: 1946 ]]
        -- upvalues: v375 (copy), v6 (ref)
        if v375:HasPerk("Map") then
            local _, v398 = v375:HasPerk("Map");
            v6:Get("Map"):Update(v398);
        else
            v375:RunInputActionIf("MapToggle", v6:IsVisible("Map"), false);
        end;
        if v375:HasPerk("Compass") then
            local _, v400 = v375:HasPerk("Compass");
            v6:Get("Compass"):Update(v400);
            v6:Show("Compass");
        else
            v6:Hide("Compass");
        end;
        if v375:HasPerk("Binoculars") then
            local _, v402 = v375:HasPerk("Binoculars");
            if v402 then
                v6:Get("Binoculars"):SetSkin(v402.Name);
            end;
        else
            v375:RunInputActionIf("Binoculars", v375.BinocularsEnabled ~= "", false);
        end;
        if not v375:HasPerk("Flashlight") then
            v375:RunInputActionIf("Flashlight", v375.LightEnabled ~= "", false);
        end;
        if v375.BinocularsEnabled ~= "" and not v375:HasPerk("Binoculars") then
            v375:RunInputActionIf("Binoculars", v375.BinocularsEnabled ~= "", false);
        end;
        local l_v375_1 = v375;
        v6:Get("Controls"):Refresh(l_v375_1);
        v6:Get("Weapon"):Refresh(l_v375_1);
    end));
    v375.Maid:Give(v375.MoveStateChanged:Connect(function(v404, v405) --[[ Line: 1986 ]]
        -- upvalues: v375 (copy), v2 (ref)
        if v405 == "Falling" and not v404:find("Swimming") then
            if v375.FallingStarted - v375.RootPart.Position.Y > v2.FallDamageStart then
                if v375.Animator then
                    v375.Animator:RunAction("Fall Impact");
                end;
                v375:RunInputActionIf("Sprint", v375.RunningInput, false);
                return;
            end;
        elseif v404 == "Falling" then
            v375.FallingStarted = v375.RootPart.Position.Y;
        end;
    end));
    v375.Maid:Give(v375.Humanoid.StateChanged:Connect(function(v406, v407) --[[ Line: 2000 ]]
        -- upvalues: v375 (copy)
        if v406 == Enum.HumanoidStateType.Ragdoll then
            v375.RagdollTimer = os.clock() + 1;
            return;
        else
            if v407 == Enum.HumanoidStateType.Ragdoll then
                v375.RagdollTimer = os.clock() + 10;
            end;
            return;
        end;
    end));
    v375.Maid:Give(v20.new(0, "Stepped", function(v408, v409) --[[ Line: 2010 ]]
        -- upvalues: v375 (copy), v334 (ref), l_v7_Camera_1 (copy), v304 (ref), v353 (ref)
        debug.profilebegin("Character logic step");
        if v375.Instance.Parent then
            v334(v375, l_v7_Camera_1, v409, v408);
        end;
        debug.profilebegin("Character physics step");
        if v375.Instance.Parent then
            v304(v375, l_v7_Camera_1, v409, v408);
        end;
        debug.profileend();
        debug.profilebegin("Character parkour step");
        v353(v375, l_v7_Camera_1, v409, v408);
        debug.profileend();
    end));
    v375.Maid:Give(v20.new(0.1, "Heartbeat", function(_, _) --[[ Line: 2027 ]]
        -- upvalues: v375 (copy), l_RootPart_4 (copy), v5 (ref), l_Humanoid_4 (copy), l_IsA_0 (ref), l_Seed_0 (ref), l_v7_Camera_1 (copy)
        debug.profilebegin("Character sanity step");
        if not v375.Instance.Parent then
            return;
        else
            local l_Humanoid_5 = v375.Instance:FindFirstChildOfClass("Humanoid");
            local l_PrimaryPart_0 = v375.Instance.PrimaryPart;
            if l_PrimaryPart_0 and l_PrimaryPart_0 ~= l_RootPart_4 then
                v5:Send("FPS Sample Return");
            end;
            if l_Humanoid_5 and l_Humanoid_5 ~= l_Humanoid_4 then
                v5:Send("Wind Vector Get");
            else
                local l_WalkSpeed_0 = l_Humanoid_4.WalkSpeed;
                l_Humanoid_4.WalkSpeed = 5;
                if math.abs(l_Humanoid_4.WalkSpeed - 5) > 0.001 then
                    v5:Send("Get Physics Lean Amount", l_Humanoid_4.WalkSpeed);
                end;
                l_Humanoid_4.WalkSpeed = l_WalkSpeed_0;
            end;
            for _, v416 in next, v375.Instance:GetDescendants() do
                if l_IsA_0(v416, "BodyVelocity") or l_IsA_0(v416, "AlignPosition") and v416 ~= v375.ParkourAlignPosition or l_IsA_0(v416, "AlignOrientation") and v416 ~= v375.ParkourAlignRotation or l_IsA_0(v416, "BodyMover") or l_IsA_0(v416, "LineForce") or l_IsA_0(v416, "VectorForce") or l_IsA_0(v416, "Torque") then
                    v5:Send("Character Movestate Sync", v416.ClassName);
                end;
            end;
            debug.profileend();
            debug.profilebegin("Network sync");
            local v417 = Random.new(l_Seed_0);
            local v418 = {};
            local v419 = {
                workspace:GetServerTimeNow(), 
                v375.BinocsAtEase or l_v7_Camera_1.FirstPerson, 
                v375.LookDirectionSpring:GetGoal(), 
                v375.MoveState, 
                v375.BinocsAtEase or v375.AtEaseInput, 
                v375.ShoulderSwapped, 
                v375.Zooming, 
                v375.Staggered, 
                v375.Shoving
            };
            local v420 = #v419;
            while #v419 > 0 do
                table.insert(v418, table.remove(v419, 1 + (v417:NextInteger(1, v420) - 1) % #v419));
            end;
            debug.profileend();
            l_Seed_0 = v5:Fetch("Character State Report", unpack(v418));
            return;
        end;
    end));
    l_RunService_0:BindToRenderStep("Character Step", 20, function(v421) --[[ Line: 2106 ]]
        -- upvalues: v375 (copy), v374 (ref), l_v7_Camera_1 (copy)
        if v375.Instance.Parent and not v375.Destroyed then
            debug.profilebegin("Character render step");
            v374(v375, l_v7_Camera_1, v421);
            debug.profileend();
        end;
    end);
    l_RunService_0:BindToRenderStep("Character Reset", Enum.RenderPriority.Last.Value, function(_) --[[ Line: 2114 ]]
        -- upvalues: v375 (copy)
        if v375.RootPart and v375.RenderCFrame and not v375.Vehicle then
            v375.RootPart.CFrame = v375.RenderCFrame;
        end;
    end);
    v375.Maid:Give(function() --[[ Line: 2120 ]]
        -- upvalues: l_RunService_0 (ref)
        l_RunService_0:UnbindFromRenderStep("Character Step");
        l_RunService_0:UnbindFromRenderStep("Character Reset");
    end);
    task.defer(function() --[[ Line: 2126 ]]
        -- upvalues: v375 (copy)
        v375.PerksChanged:Fire();
    end);
end;
local function v429(v424, v425) --[[ Line: 2131 ]] --[[ Name: initliazeStats ]]
    for v426, v427 in next, v425.Stats do
        local v428 = v424[v426];
        if v428 then
            v428:Set(v427.Base);
            v428.Bonus:Set(v427.Bonus);
        end;
    end;
end;
local function v433(v430, _) --[[ Line: 2142 ]] --[[ Name: initializeInstance ]]
    -- upvalues: v2 (copy), v7 (copy), l_Lighting_0 (copy)
    v430.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    v430.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false);
    v430.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false);
    v430.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false);
    v430.Animator:AddInvisibleCase("Binoculars", function() --[[ Line: 2148 ]]
        -- upvalues: v430 (copy)
        return v430.BinocularsEnabled ~= "";
    end);
    if v2.HardcoreMode then
        v430.Animator:AddInvisibleCase("Hardcore", function() --[[ Line: 2153 ]]
            -- upvalues: v430 (copy), v7 (ref), l_Lighting_0 (ref)
            if not v430.Destroyed then
                local v432 = not v7:GetCamera("Character").FirstPerson;
                l_Lighting_0.EyeBlur.Enabled = v432;
                l_Lighting_0.EyeTint.Enabled = v432;
                return v432;
            else
                return;
            end;
        end);
    end;
    v430.Maid:Give(function() --[[ Line: 2165 ]]
        -- upvalues: l_Lighting_0 (ref)
        l_Lighting_0.EyeBlur.Enabled = false;
        l_Lighting_0.EyeTint.Enabled = false;
    end);
end;
local function v439(v434) --[[ Line: 2171 ]] --[[ Name: waitForGround ]]
    -- upvalues: v11 (copy), l_RunService_0 (copy)
    local v435 = Ray.new(v434, (Vector3.new(0, -150, 0, 0)));
    local v436 = os.clock();
    repeat
        local v437 = v11:CastWithWhiteList(v435, {
            workspace.Map.Client
        });
        l_RunService_0.Heartbeat:Wait();
        local v438 = os.clock() - v436 > 30;
    until v437 or v438;
    task.wait(0.1);
end;
v36.resetDamageEffects = function() --[[ Line: 2189 ]] --[[ Name: resetDamageEffects ]]
    -- upvalues: v28 (copy), v30 (copy)
    v28.TintColor = v30;
    v28.Saturation = 0;
end;
v36.new = function(v440, v441) --[[ Line: 2194 ]] --[[ Name: new ]]
    -- upvalues: v21 (copy), v8 (copy), v439 (copy), v5 (copy), v19 (copy), v15 (copy), v114 (copy), v91 (copy), v222 (copy), v150 (copy), v214 (copy), v102 (copy), v127 (copy), v135 (copy), v119 (copy), v178 (copy), v190 (copy), v157 (copy), v172 (copy), v142 (copy), v197 (copy), v210 (copy), v205 (copy), v33 (copy), v9 (copy), v16 (copy), v17 (copy), v6 (copy), v18 (copy), v423 (copy), v429 (copy), v433 (copy), v36 (copy)
    local v442 = {
        Parent = v441, 
        Type = "Character", 
        Enabled = true, 
        Maid = v21.new(), 
        Instance = v440.Instance
    };
    v442.Humanoid = v442.Instance:WaitForChild("Humanoid");
    v442.RootPart = v442.Instance:WaitForChild("HumanoidRootPart");
    v442.HeadPart = v442.Instance:WaitForChild("Head");
    v442.HairBin = v442.Instance:WaitForChild("Hair");
    v442.ColliderPart = v442.Instance:WaitForChild("HeadCollider");
    v442.ColliderJoint = v442.ColliderPart:WaitForChild("Collider");
    v442.ParkourAlignPosition = v442.RootPart:WaitForChild("ParkourAlignPosition");
    v442.ParkourAlignRotation = v442.RootPart:WaitForChild("ParkourAlignRotation");
    v8:Set(v442.RootPart.Position, "Spawn", 150, true):Wait();
    v439(v442.RootPart.Position);
    v5:Fetch("Set Character Unanchored");
    v442.Humanoid:ChangeState(Enum.HumanoidStateType.Running);
    v442.UseItemInput = false;
    v442.AimingInput = false;
    v442.CrouchingInput = false;
    v442.RunningInput = false;
    v442.AtEaseInput = false;
    v442.AutoRunInput = false;
    v442.JumpInput = false;
    v442.MoveState = "Walking";
    v442.RelativeMoveCFrame = CFrame.new();
    v442.MoveVector = Vector3.new(0, 0, 0, 0);
    v442.MoveImpulses = {};
    v442.FallingStarted = 0;
    v442.RubberBandReset = 0;
    v442.FallingTime = 0;
    v442.RagdollTimer = 0;
    v442.LastReloadTry = 0;
    v442.RootTurnSpring = v19.new(v442.RootPart.CFrame.lookVector, 6, 1);
    v442.LookDirectionSpring = v19.new(Vector3.new(0, 0, -1, 0), 7, 1);
    v442.MoveSpeedSpring = v19.new(0, 7, 1);
    v442.EquippedItem = nil;
    v442.Zooming = false;
    v442.UsingItem = false;
    v442.ShoulderSwapped = false;
    v442.Shoving = false;
    v442.Staggered = false;
    v442.Vaulting = false;
    v442.Climbing = false;
    v442.Mounting = false;
    v442.Dismounting = false;
    v442.LadderPart = nil;
    v442.BinocsAtEase = false;
    v442.FallImpacting = false;
    v442.LastOpenInventoryScan = 0;
    v442.NetworkedStateSync = 0;
    v442.LastEquipTime = 0;
    v442.JumpDebounce = 0;
    v442.VaultPadding = Vector3.new(0, 0, 0, 0);
    v442.EquipmentChanged = v442.Maid:Give(v15.new());
    v442.AimInputChanged = v442.Maid:Give(v15.new());
    v442.MoveStateChanged = v442.Maid:Give(v15.new());
    v442.SprintInputChanged = v442.Maid:Give(v15.new());
    v442.Jumped = v442.Maid:Give(v15.new());
    v442.Falling = v442.Maid:Give(v15.new());
    v442.TriggerInputs = {};
    v442.Actions = {
        Forwards = v114, 
        Forwards2 = v114, 
        Backwards = v114, 
        Backwards2 = v114, 
        Right = v114, 
        Left = v114, 
        Shove = v91, 
        UseItem = v222, 
        Aim = v150, 
        Reload = v214, 
        Jump = v102, 
        Crouch = v127, 
        Sprint = v135, 
        AutoRun = v119, 
        MapToggle = v178, 
        Inventory = v190, 
        Flashlight = v157, 
        Binoculars = v172, 
        AtEase = v142, 
        ToolAction = v197, 
        LookLock = v210, 
        ShoulderSwap = v205
    };
    v442.Binds = {
        Forwards2 = Enum.KeyCode.Up, 
        Backwards2 = Enum.KeyCode.Down, 
        UseItem = Enum.UserInputType.MouseButton1
    };
    for v443, v444 in next, v33 do
        v442.Binds[v443] = v9:GetBind(v444).Key;
    end;
    v442.Energy = v442.Maid:Give(v16.new(0, 100));
    v442.Energy.Bonus = v442.Maid:Give(v16.new(0, 100));
    v442.Hydration = v442.Maid:Give(v16.new(0, 100));
    v442.Hydration.Bonus = v442.Maid:Give(v16.new(0, 100));
    v442.Health = v442.Maid:Give(v16.new(0, 100));
    v442.Health.Bonus = v442.Maid:Give(v16.new(0, 100));
    v442.PerksChanged = v442.Maid:Give(v15.new());
    v442.ActivePerks = v440.Perks;
    v442.LightEnabled = "";
    v442.BinocularsEnabled = "";
    v442.Animator = v17.get(v442.Instance, "Character");
    v442.Animator:TakeLocalControl(v442);
    v442.Animator:AddInvisibleCase("GameMenu Case", function() --[[ Line: 2342 ]]
        -- upvalues: v6 (ref)
        return v6:IsVisible("GameMenu");
    end);
    v442.Inventory = v18.new(v442, v440);
    v6:Get("GameMenu"):GetAPI("Inventory"):Connect(v442, v442.Inventory);
    v442.Maid:Give(v442.Inventory);
    v423(v442, v440);
    v442.TriggerInputs = {};
    for _, v446 in next, v442.Binds do
        v442.TriggerInputs[v446] = true;
    end;
    v429(v442, v440);
    v433(v442, v440);
    return (setmetatable(v442, v36));
end;
v36.Disable = function(v447) --[[ Line: 2363 ]] --[[ Name: Disable ]]
    v447.Enabled = false;
end;
v36.Enable = function(v448) --[[ Line: 2367 ]] --[[ Name: Enable ]]
    v448.Enabled = true;
end;
v36.Destroy = function(v449) --[[ Line: 2371 ]] --[[ Name: Destroy ]]
    if v449.Destroyed then
        return;
    else
        v449.Destroyed = true;
        v449.Animator = nil;
        if v449.Maid then
            v449.Maid:Destroy();
            v449.Maid = nil;
        end;
        setmetatable(v449, nil);
        table.clear(v449);
        v449.Destroyed = true;
        return;
    end;
end;
v36.RunInputActionIf = function(v450, v451, v452, ...) --[[ Line: 2392 ]] --[[ Name: RunInputActionIf ]]
    if typeof(v452) == "function" then
        v452 = v452(v450);
    end;
    if v452 then
        v450.Actions[v451](v450, "Begin", ...);
    end;
end;
v36.Unequip = function(v453) --[[ Line: 2402 ]] --[[ Name: Unequip ]]
    -- upvalues: v12 (copy), v5 (copy), v6 (copy)
    if v453.EquippedItem then
        local l_Id_0 = v453.EquippedItem.Id;
        v453.AtEaseInput = false;
        v453.AimingInput = false;
        v453.UseItemInput = false;
        v453.Zooming = false;
        if v453.EquippedItem.OnUnequip then
            v453.EquippedItem:OnUnequip(v453);
        end;
        v453.EquippedItem = nil;
        if v453.EquipmentChangedRebuild then
            v453.EquipmentChangedRebuild:Disconnect();
            v453.EquipmentChangedRebuild = nil;
        end;
        v453.EquipmentChanged:Fire("Unequipped");
        v453.Animator:SetState("EquippedItem", v12:Serialize({}));
        v5:Send("Character Unequip Item", l_Id_0);
        v6:Get("Controls"):Refresh(v453);
        v6:Get("Weapon"):Refresh(v453);
        v6:Hide("Reticle");
    end;
end;
v36.Equip = function(v455, v456) --[[ Line: 2431 ]] --[[ Name: Equip ]]
    -- upvalues: v0 (copy), v6 (copy), v12 (copy), v5 (copy)
    if v455.EquippedItem and v455.EquippedItem.Id == v456.Id then
        return true;
    elseif os.clock() - v455.LastEquipTime < 0.3 then
        return false;
    elseif v455.MoveState == "Swimming" or v455.MoveState == "SprintSwimming" then
        return false;
    elseif v455.Climbing or v455.Mounting or v455.Dismounting then
        return false;
    elseif v455.IsInCitadelArena and v456.Type == "Firearm" then
        local v457 = {
            {
                Style = "Normal", 
                Text = "You cannot equip your"
            }, 
            {
                Style = "Bold", 
                Text = v456.DisplayName
            }, 
            {
                Style = "Normal", 
                Text = "here"
            }
        };
        v0.Libraries.Interface:Get("DeathActions"):Log("Default", v457);
        return false;
    elseif v455.Sitting and not v456.CanEquipInVehicles then
        local v458 = {
            {
                Style = "Bold", 
                Text = v456.DisplayName
            }, 
            {
                Style = "Normal", 
                Text = "can't be used while seated"
            }
        };
        v0.Libraries.Interface:Get("DeathActions"):Log("Default", v458);
        return false;
    elseif v455.Animator and v455.Animator:IsAnimationPlaying("Actions.Fall Impact") then
        return false;
    else
        if v456.EquipSlot then
            local v459 = v455.Inventory.Equipment[v456.EquipSlot];
            if not v459 or v459.Id ~= v456.Id then
                return false;
            end;
        end;
        if v456.CanSlotAsUtility and not v455.Inventory:IsUtilitySlotted(v456) then
            return false;
        elseif v456.CanEquipInHands then
            if v455.EquippedItem then
                v455:Unequip();
            end;
            v455.EquippedItem = v456;
            v455.LastEquipTime = os.clock();
            if v456.CrosshairConfig then
                v6:Show("Reticle");
            end;
            if v456.OnEquip then
                v456:OnEquip(v455);
            end;
            if not v456.CanAtEase then
                v455:RunInputActionIf("Binoculars", v455.BinocularsEnabled ~= "", false);
            end;
            v455.Maid.EquipmentChangedRebuild = v455.EquippedItem.Changed:Connect(function() --[[ Line: 2511 ]]
                -- upvalues: v455 (copy), v456 (copy), v12 (ref)
                if v455.EquippedItem == v456 then
                    v455.Animator:SetState("EquippedItem", v12:Serialize(v456));
                end;
            end);
            v455.Animator:SetState("EquippedItem", v12:Serialize(v456));
            v455.EquipmentChanged:Fire("Equipped", v456);
            v6:Get("Controls"):Refresh(v455);
            v6:Get("Weapon"):Refresh(v455);
            v5:Send("Character Equip Item", v456.Id);
            return true;
        else
            v6:Get("Controls"):Refresh(v455);
            v6:Get("Weapon"):Refresh(v455);
            return false;
        end;
    end;
end;
v36.EquipOverwriteUseSequence = function(v460, v461) --[[ Line: 2536 ]] --[[ Name: EquipOverwriteUseSequence ]]
    -- upvalues: v65 (copy), v70 (copy)
    if v65(v460, v461) and v461.IsUsable and v461:IsUsable(v460) then
        local l_EquippedItem_3 = v460.EquippedItem;
        if v460:Equip(v461) then
            v70(v460, v461);
            if l_EquippedItem_3 then
                v460:Equip(l_EquippedItem_3);
            end;
            return true;
        end;
    end;
    return false;
end;
v36.Dismount = function(v463) --[[ Line: 2554 ]] --[[ Name: Dismount ]]
    -- upvalues: v272 (copy)
    if v463.LadderPart then
        v272(v463);
    end;
end;
v36.TryClimbing = function(v464, v465, _) --[[ Line: 2560 ]] --[[ Name: TryClimbing ]]
    -- upvalues: v1 (copy), v235 (copy), v246 (copy), v6 (copy)
    if v465 and not v464.Climbing then
        local l_CFrame_9 = v464.RootPart.CFrame;
        local v468 = (v465.CFrame * CFrame.new(v465.Size * Vector3.new(0, 0, -0.5, 0))):toObjectSpace(l_CFrame_9);
        local l_magnitude_0 = (v468.p * Vector3.new(1, 0, 1, 0)).magnitude;
        local v470 = v468.Y >= v465.Size.Y * 0.5 - 2;
        local v471 = l_magnitude_0 < v1.LadderMountDistance;
        if v465.Name == "Ladder" or v465.Name == "LadderTopMount" and v471 then
            if v465.Name == "LadderTopMount" then
                v464.LadderPart = v465.Parent;
                v470 = true;
            else
                v464.LadderPart = v465;
            end;
            if v464.LadderPart then
                if v470 then
                    v235(v464);
                elseif v471 then
                    v246(v464);
                end;
                if v464.EquippedItem then
                    v464.ClimbingReEquip = v464.EquippedItem;
                    v464:Unequip();
                end;
                return true;
            end;
        end;
        v6:Get("Controls"):Refresh(v464);
        v6:Get("Weapon"):Refresh(v464);
    end;
    return false;
end;
v36.TryVaulting = function(v472) --[[ Line: 2600 ]] --[[ Name: TryVaulting ]]
    -- upvalues: v3 (copy), v14 (copy), v283 (copy)
    if v472.RootPart and not v472.Vaulting then
        local v473 = v472.MoveState == "Falling";
        local v474 = {};
        if v472:HasPerk("Climbing Gear") then
            local v475 = v3("Climbing Gear");
            if v472.MoveState == "Falling" then
                v474.ExtraHeight = v475.AirVaultHeightStudBoost;
            else
                v474.ExtraHeight = v475.GroundedVaultHeightStudBoost;
            end;
        end;
        local l_v14_LedgeInfo_0, v477, v478 = v14:GetLedgeInfo(v472.RootPart, 2.35, v14.Configs.Character, v473, v474);
        if l_v14_LedgeInfo_0 then
            task.spawn(v283, v472, v477, v478);
            return true;
        end;
    end;
    return false;
end;
v36.MoveImpulse = function(v479, v480, v481) --[[ Line: 2633 ]] --[[ Name: MoveImpulse ]]
    if v479.MoveImpulses then
        table.insert(v479.MoveImpulses, {
            Direction = v480, 
            Durration = v481
        });
    end;
end;
v36.SetSitting = function(v482, v483, v484) --[[ Line: 2642 ]] --[[ Name: SetSitting ]]
    -- upvalues: v7 (copy), v6 (copy)
    v482.Sitting = v483 ~= nil;
    v482.Vehicle = v483;
    v482.IsVehicleDriver = v484;
    v482:Unequip();
    if v483 then
        v7:GetCamera("Character"):ConnectVehicle(v483);
    end;
    v6:Get("Controls"):Refresh(v482);
    v6:Get("Weapon"):Refresh(v482);
    return true;
end;
v36.HasPerk = function(v485, v486, v487) --[[ Line: 2658 ]] --[[ Name: HasPerk ]]
    -- upvalues: v2 (copy)
    local v488 = false;
    local v489 = nil;
    for _, v491 in next, v485.ActivePerks do
        if v491 == v486 then
            v488 = true;
            break;
        end;
    end;
    if v488 and v485.Inventory and v487 then
        if v485.Inventory.Utilities then
            for v492 = 1, v2.UtilitySlotLimit do
                local v493 = v485.Inventory.Utilities[v492];
                if v493 and v493.PerksGiven and table.find(v493.PerksGiven, v486) then
                    v489 = v493;
                    break;
                end;
            end;
        end;
        if v489 == nil and v485.Inventory.Equipment then
            for _, v495 in next, v485.Inventory.Equipment do
                if v495.PerksGiven and table.find(v495.PerksGiven, v486) then
                    return v488, v495;
                end;
            end;
        end;
    end;
    return v488, v489;
end;
return v36;