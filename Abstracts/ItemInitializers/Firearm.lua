local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Libraries", "Resources");
local v4 = v0.require("Libraries", "GunBuilder");
local v5 = v0.require("Libraries", "Cameras");
local v6 = v0.require("Libraries", "Bullets");
local v7 = v0.require("Classes", "Maids");
local v8 = v0.require("Classes", "Signals");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("UserInputService");
local function _(v11) --[[ Line: 19 ]] --[[ Name: displayError ]]
    -- upvalues: v0 (copy)
    v0.Libraries.Interface:Get("DeathActions"):Log("Server", v11);
end;
local function _(v13, v14) --[[ Line: 26 ]] --[[ Name: isShotReady ]]
    return v14 <= workspace:GetServerTimeNow() - v13.LastShot;
end;
local function _(v16, v17) --[[ Line: 30 ]] --[[ Name: getEquipModel ]]
    if v16.Instance then
        local l_Equipped_0 = v16.Instance:FindFirstChild("Equipped");
        if l_Equipped_0 then
            return l_Equipped_0:FindFirstChild(v17.Name);
        end;
    end;
    return nil;
end;
local function v30(v20, v21, v22, v23, v24) --[[ Line: 42 ]] --[[ Name: fireBullet ]]
    -- upvalues: v0 (copy), v5 (copy), v6 (copy)
    if v20.FireConfig and v20.FireConfig.InternalMag and v20.WorkingAmount and v20.WorkingAmount >= 1 then
        v20.WorkingAmount = v20.WorkingAmount - 1;
    elseif v20.Attachments and v20.Attachments.Ammo and v20.Attachments.Ammo.WorkingAmount >= 1 then
        v20.Attachments.Ammo.WorkingAmount = v20.Attachments.Ammo.WorkingAmount - 1;
    else
        return false;
    end;
    local v25 = v0.Libraries.Interface:Get("Reticle");
    local l_v5_Camera_0 = v5:GetCamera("Character");
    local l_v25_FirearmTargetInfo_0, v28 = v25:GetFirearmTargetInfo(v21, l_v5_Camera_0, v22);
    local v29 = v6:Fire(v21, l_v5_Camera_0, v20, l_v25_FirearmTargetInfo_0, v28, v23);
    v20.LastShot = v29;
    v20.NextShotValid = v29 + v24;
    if v20.KickbackWalk then
        table.insert(v21.MoveImpulses, {
            Direction = (-v28 * Vector3.new(1, 0, 1, 0)).Unit * v20.KickbackWalk.Speed, 
            Durration = v20.KickbackWalk.Duration
        });
    end;
    return true;
end;
local v31 = nil;
local v32 = nil;
local v33 = {};
local l_v33_0 = v33 --[[ copy: 17 -> 22 ]];
v32 = function(v35) --[[ Line: 74 ]] --[[ Name: cancelReload ]]
    -- upvalues: l_v33_0 (copy)
    if l_v33_0[v35] then
        l_v33_0[v35]();
    end;
end;
v2:Add("Firearm Reload Cancel", v32);
v31 = function(v36, v37, v38, v39) --[[ Line: 82 ]] --[[ Name: animatedReload ]]
    -- upvalues: v7 (copy), l_v33_0 (copy), v0 (copy)
    local v40 = v7.new();
    local l_Id_0 = v36.Id;
    local function _(v42) --[[ Line: 86 ]] --[[ Name: abortReload ]]
        -- upvalues: v37 (copy)
        v37.Animator:RunAction("Stop Firearm Reload", v42 or "Manual");
    end;
    v40:Give(v37.MoveStateChanged:Connect(function(v44, _) --[[ Line: 91 ]]
        -- upvalues: v37 (copy)
        if v44:find("Swimming") then
            v37.Animator:RunAction("Stop Firearm Reload", "Manual");
        end;
    end));
    v40:Give(v37.Falling:Connect(function(v46) --[[ Line: 97 ]]
        -- upvalues: v37 (copy)
        if v46 > 0.7 then
            v37.Animator:RunAction("Stop Firearm Reload", "Manual");
        end;
    end));
    v40:Give(v37.AimInputChanged:Connect(function(v47) --[[ Line: 103 ]]
        -- upvalues: v37 (copy)
        if v47 then
            v37.Animator:RunAction("Stop Firearm Reload", "Manual");
        end;
    end));
    v40:Give(v37.SprintInputChanged:Connect(function(_) --[[ Line: 109 ]]

    end));
    v40:Give(v37.EquipmentChanged:Connect(function() --[[ Line: 115 ]]
        -- upvalues: v37 (copy), v36 (copy)
        if v37.EquippedItem == nil or v37.EquippedItem.Id ~= v36.Id then
            v37.Animator:RunAction("Stop Firearm Reload", "Manual");
        end;
    end));
    l_v33_0[l_Id_0] = function() --[[ Line: 121 ]]
        -- upvalues: v37 (copy), l_v33_0 (ref), l_Id_0 (copy)
        v37.Animator:RunAction("Stop Firearm Reload", "Manual");
        l_v33_0[l_Id_0] = nil;
    end;
    v0.Libraries.Interface:Get("Mouse"):ResetSpinner();
    v0.Libraries.Interface:Get("Mouse"):SetIconVisible("Spinner", true);
    v37.Animator:RunAction("Play Firearm Reload", v36.Name, v38, function(v49, v50) --[[ Line: 130 ]]
        -- upvalues: v40 (copy), l_v33_0 (ref), l_Id_0 (copy), v0 (ref), v39 (copy)
        if v49 == "Stopped" then
            v40:Destroy();
            l_v33_0[l_Id_0] = nil;
            v0.Libraries.Interface:Get("Mouse"):SetIconVisible("Spinner", false);
        end;
        v39(v49, v50);
    end);
    return true;
end;
v33 = function(v51) --[[ Line: 144 ]] --[[ Name: wrapAmmoCorrector ]]
    if v51.Amount then
        local l_Amount_0 = v51.Amount;
        do
            local l_l_Amount_0_0 = l_Amount_0;
            v51.Maid:Give(v51.Changed:Connect(function(_) --[[ Line: 148 ]]
                -- upvalues: l_l_Amount_0_0 (ref), v51 (copy)
                local l_l_l_Amount_0_0_0 = l_l_Amount_0_0;
                local l_Amount_1 = v51.Amount;
                l_l_Amount_0_0 = l_Amount_1;
                if l_l_l_Amount_0_0_0 < l_Amount_1 then
                    v51.WorkingAmount = l_Amount_1;
                end;
            end));
            v51.WorkingAmount = v51.Amount;
        end;
    end;
end;
local function v61(v57, v58, v59, v60) --[[ Line: 165 ]] --[[ Name: canCharacterShoot ]]
    if not v57.UseItemInput and not v60 then
        return false;
    elseif v57.Reloading then
        return false;
    elseif v57.Animator and v57.Animator:IsAnimationPlaying("Actions.Fall Impact") then
        return false;
    elseif v57.EquippedItem == nil then
        return false;
    elseif v57.EquippedItem.Id ~= v58.Id then
        return false;
    elseif v59 and not v59:FindFirstChild("Muzzle") then
        return false;
    else
        return true;
    end;
end;
local function _(v62) --[[ Line: 199 ]] --[[ Name: hasAmmoToShoot ]]
    if v62.Attachments.Ammo and v62.Attachments.Ammo.WorkingAmount > 0 then
        return true, v62.Attachments.Ammo.Amount;
    elseif v62.FireConfig.InternalMag and v62.WorkingAmount > 0 then
        return true, v62.Amount;
    else
        return false, 0;
    end;
end;
local function v66(v64, v65) --[[ Line: 214 ]] --[[ Name: compareBestAmmo ]]
    if v64 and not v65 then
        return v64;
    elseif v65 and not v64 then
        return v65;
    elseif not v64 or not v65 then
        return nil;
    elseif v64.Amount == v65.Amount then
        if v64.GridPosition[2] + v64.GridPosition[1] / 10 < v65.GridPosition[2] + v65.GridPosition[1] / 10 then
            return v64;
        else
            return v65;
        end;
    elseif v64.Amount > v65.Amount then
        return v64;
    else
        return v65;
    end;
end;
local function v80(v67, v68, v69) --[[ Line: 244 ]] --[[ Name: findReloadAmmo ]]
    -- upvalues: v66 (copy)
    if v69 and v69.Caliber == v67.Caliber and v69.Amount > 0 then
        if v69.SubType == "Magazine" and not v67.FireConfig.InternalMag and not table.find(v67.MagazineTypes, v69.Name) then
            return nil;
        else
            return v69;
        end;
    elseif v68.Inventory and not v69 then
        if v67.FireConfig.InternalMag then
            local v70 = nil;
            for _, v72 in next, v68.Inventory.Containers do
                if v72.IsCarried then
                    for _, v74 in next, v72.Occupants do
                        if v74.Type == "Ammo" and v74.SubType ~= "Magazine" and v74.Caliber == v67.Caliber and v74.Amount > 0 then
                            v70 = v66(v70, v74);
                        end;
                    end;
                end;
            end;
            return v70;
        else
            local v75 = nil;
            for _, v77 in next, v68.Inventory.Containers do
                if v77.IsCarried then
                    for _, v79 in next, v77.Occupants do
                        if v79.SubType == "Magazine" and v79.Caliber == v67.Caliber and v79.Amount > 0 and table.find(v67.MagazineTypes, v79.Name) then
                            v75 = v66(v75, v79);
                        end;
                    end;
                end;
            end;
            return v75;
        end;
    else
        return nil;
    end;
end;
return function(v81, v82, v83) --[[ Line: 303 ]]
    -- upvalues: v4 (copy), v8 (copy), v2 (copy), v32 (ref), v0 (copy), v80 (copy), v31 (ref), v61 (copy), v30 (copy), l_RunService_0 (copy), v3 (copy)
    v81.Amount = 0;
    v81.FireMode = v82.DefaultFireMode;
    v81.Attachments = {};
    v81.AttachmentStatMods = {};
    v81.LastShot = 0;
    v81.Reloading = false;
    v81.NextShotValid = 0;
    if v82.FireConfig.InternalMag then
        v81.Amount = 0;
    end;
    if not v83 then
        return;
    else
        v81.Maid:Give(function() --[[ Line: 326 ]]
            -- upvalues: v81 (copy)
            if v81.Attachments then
                for _, v85 in next, v81.Attachments do
                    v85:Destroy();
                end;
                v81.Attachments = nil;
            end;
            v81.AttachmentStatMods = nil;
        end);
        v81.Maid:Give(v81.Changed:Connect(function(v86) --[[ Line: 339 ]]
            -- upvalues: v81 (copy), v4 (ref)
            if v86 == "Attachments" and v81.Attachments then
                local v87 = {};
                for _, v89 in next, v81.Attachments do
                    table.insert(v87, v89.Name);
                end;
                v81.AttachmentStatMods = v4:GetAttachmentStats(v81.Name, v87);
            end;
        end));
        v81.RebuildSignal = v81.Maid:Give(v8.new());
        for _, v91 in next, {
            "Attachments", 
            "SkindId"
        } do
            v81.Maid:Give(v81:GetPropertyChangedSignal(v91):Connect(function() --[[ Line: 355 ]]
                -- upvalues: v81 (copy)
                if v81.RebuildSignal then
                    v81.RebuildSignal:Fire();
                end;
            end));
        end;
        if v81.FireConfig.InternalMag and v81.Amount then
            local l_Amount_2 = v81.Amount;
            do
                local l_l_Amount_2_0 = l_Amount_2;
                v81.Maid:Give(v81.Changed:Connect(function(_) --[[ Line: 148 ]]
                    -- upvalues: l_l_Amount_2_0 (ref), v81 (copy)
                    local l_l_l_Amount_2_0_0 = l_l_Amount_2_0;
                    local l_Amount_3 = v81.Amount;
                    l_l_Amount_2_0 = l_Amount_3;
                    if l_l_l_Amount_2_0_0 < l_Amount_3 then
                        v81.WorkingAmount = l_Amount_3;
                    end;
                end));
                v81.WorkingAmount = v81.Amount;
            end;
        end;
        v81.GetAmmoCountText = function(v97) --[[ Line: 369 ]]
            if v97.FireConfig.InternalMag then
                return string.format("%d/%d", v97.WorkingAmount or v97.Amount, v97.FireConfig.InternalMagSize);
            elseif v97.Attachments and v97.Attachments.Ammo then
                return v97.Attachments.Ammo:GetAmmoCountText();
            else
                return;
            end;
        end;
        v81.GetModifiedStat = function(v98, v99, v100) --[[ Line: 378 ]]
            if v98.AttachmentStatMods and v98.AttachmentStatMods[v99] then
                local v101 = v98.AttachmentStatMods[v99];
                if v101.Calculated then
                    return v101.Calculated;
                else
                    local v102 = v101.Multiplier or 1;
                    local v103 = v101.Bonus or 0;
                    return v100 * v102 + v103;
                end;
            else
                return v100;
            end;
        end;
        v81.CanCraft = function(v104, v105) --[[ Line: 395 ]]
            if v105.Type == "Ammo" then
                if v104.FireConfig.InternalMag and v105.Caliber == v104.Caliber then
                    return true;
                else
                    return table.find(v104.MagazineTypes, v105.Name);
                end;
            elseif v105.Type == "Attachment" then
                return table.find(v104.AttachmentTypes, v105.Name);
            else
                return false;
            end;
        end;
        v81.OnCraft = function(v106, v107, v108) --[[ Line: 410 ]]
            -- upvalues: v2 (ref)
            if v108.Type == "Ammo" then
                return v106:OnReload(v107, v108);
            else
                v2:Send("Inventory Craft Item", v106.Id, v108.Id);
                return true;
            end;
        end;
        v81.OnReload = function(v109, v110, v111) --[[ Line: 420 ]]
            -- upvalues: v32 (ref), v2 (ref), v0 (ref), v80 (ref), v31 (ref)
            if v109.Reloading then
                v32(v109.Id);
                return false;
            elseif v110.Sitting then
                return false;
            else
                if not v110.EquippedItem or v110.EquippedItem.Id ~= v109.Id then
                    local l_Equipment_0 = v110.Inventory.Equipment;
                    local l_DisplayName_0 = v109.DisplayName;
                    local l_Id_1 = v109.Id;
                    local l_EquipSlot_0 = v109.EquipSlot;
                    v2:Fetch("Inventory Equip Item", l_Id_1);
                    local v116 = l_Equipment_0[l_EquipSlot_0];
                    if v116 and v116.Id == l_Id_1 then
                        v109 = v116;
                        if not v110:Equip(v109) then
                            local v117 = {
                                {
                                    Style = "Bold", 
                                    Text = l_DisplayName_0
                                }, 
                                {
                                    Style = "Normal", 
                                    Text = "can't be equipped for reloading"
                                }
                            };
                            v0.Libraries.Interface:Get("DeathActions"):Log("Server", v117);
                            return false;
                        end;
                    else
                        local v118 = {
                            {
                                Style = "Bold", 
                                Text = l_DisplayName_0
                            }, 
                            {
                                Style = "Normal", 
                                Text = "can't be equipped for reloading"
                            }
                        };
                        v0.Libraries.Interface:Get("DeathActions"):Log("Server", v118);
                        return false;
                    end;
                end;
                local v119 = v80(v109, v110, v111);
                if v109.FireConfig.InternalMag and v109.FireConfig.InternalMagSize - v109.Amount == 0 then
                    local v120 = {
                        {
                            Style = "Bold", 
                            Text = v109.DisplayName
                        }, 
                        {
                            Style = "Normal", 
                            Text = "is already fully loaded"
                        }
                    };
                    v0.Libraries.Interface:Get("DeathActions"):Log("Server", v120);
                    return false;
                elseif v119 then
                    v110.UseItemInput = false;
                    local v121 = nil;
                    local v122 = 0;
                    v121 = if v109.Attachments.Ammo then v109.Attachments.Ammo.Name else "None";
                    if v109.FireConfig.InternalMag then
                        v122 = v109.FireConfig.InternalMagSize - v109.Amount;
                    end;
                    local v123 = {
                        ReloadCase = "Default", 
                        Old = v121, 
                        New = v119.Name, 
                        LoopCount = math.max(v122 - 1, 0)
                    };
                    v109.Reloading = true;
                    v2:Send("Character Reload Firearm Initiated", v109.Id, v119.Id, v123);
                    v31(v109, v110, v123, function(v124, v125) --[[ Line: 515 ]]
                        -- upvalues: v2 (ref), v109 (ref), v119 (copy)
                        if v124 == "Stopped" then
                            if v125 ~= "Natrually" then
                                v2:Send("Character Reload Firearm Clear", v109.Id);
                            end;
                            v109.Reloading = false;
                            return;
                        else
                            if v124 == "Commit" then
                                if v125 == "Load" then
                                    v2:Send("Character Reload Firearm Committed", v109.Id, v119.Id);
                                    return;
                                elseif v125 == "End" then
                                    v2:Send("Character Reload Firearm Clear", v109.Id);
                                end;
                            end;
                            return;
                        end;
                    end);
                    return true;
                else
                    local v126 = {
                        {
                            Style = "Bold", 
                            Text = v109.DisplayName
                        }, 
                        {
                            Style = "Normal", 
                            Text = "has no usable ammo to reload with"
                        }
                    };
                    v0.Libraries.Interface:Get("DeathActions"):Log("Server", v126);
                    return false;
                end;
            end;
        end;
        v81.OnUse = function(v127, v128) --[[ Line: 544 ]]
            -- upvalues: v32 (ref), v61 (ref), v30 (ref), l_RunService_0 (ref), v0 (ref), v3 (ref)
            local v129 = false;
            local v130;
            if v128.Instance then
                local l_Equipped_1 = v128.Instance:FindFirstChild("Equipped");
                if l_Equipped_1 then
                    v130 = l_Equipped_1:FindFirstChild(v127.Name);
                    v129 = true;
                end;
            end;
            if not v129 then
                v130 = nil;
            end;
            v129 = false;
            local v132, v133;
            if v127.Attachments.Ammo and v127.Attachments.Ammo.WorkingAmount > 0 then
                v132 = true;
                v133 = v127.Attachments.Ammo.Amount;
            elseif v127.FireConfig.InternalMag and v127.WorkingAmount > 0 then
                v132 = true;
                v133 = v127.Amount;
            else
                v132 = false;
                v133 = 0;
            end;
            local v134 = v132 == false;
            local v135 = 60 / v127.FireConfig.FireRate;
            local v136 = 1;
            if v132 and v127.FireMode == "Burst" then
                v136 = math.min(v133, v127.FireConfig.BurstCount or 1);
            end;
            if v132 then
                if v128.Animator:IsReloadPlaying() then
                    v32(v127.Id);
                end;
                if v127.FireMode == "Automatic" then
                    while v61(v128, v127, v130) do
                        if v135 <= workspace:GetServerTimeNow() - v127.LastShot and not v30(v127, v128, v130, nil, v135) then
                            local v137;
                            if v127.Attachments.Ammo and v127.Attachments.Ammo.WorkingAmount > 0 then
                                v137 = true;
                                local _ = v127.Attachments.Ammo.Amount;
                            elseif v127.FireConfig.InternalMag and v127.WorkingAmount > 0 then
                                v137 = true;
                                local _ = v127.Amount;
                            else
                                v137 = false;
                            end;
                            if not v137 then
                                v134 = true;
                                break;
                            else
                                break;
                            end;
                        else
                            l_RunService_0.RenderStepped:Wait();
                        end;
                    end;
                elseif v135 * v136 <= workspace:GetServerTimeNow() - v127.LastShot then
                    if v127.DisplayFireRateReloadingIcon then
                        v0.Libraries.Interface:Get("Mouse"):ResetSpinner();
                        v0.Libraries.Interface:Get("Mouse"):SetIconVisible("Spinner", true);
                        task.delay(v135, function() --[[ Line: 582 ]]
                            -- upvalues: v127 (copy), v0 (ref)
                            if not v127.Reloading then
                                v0.Libraries.Interface:Get("Mouse"):SetIconVisible("Spinner", false);
                            end;
                        end);
                    end;
                    if v127.FireMode == "Burst" then
                        for v140 = 1, v136 do
                            local v141 = 0;
                            if v61(v128, v127, v130, true) then
                                if not v30(v127, v128, v130, v140, v135 * 0.6) then
                                    local v142;
                                    if v127.Attachments.Ammo and v127.Attachments.Ammo.WorkingAmount > 0 then
                                        v142 = true;
                                        local _ = v127.Attachments.Ammo.Amount;
                                    elseif v127.FireConfig.InternalMag and v127.WorkingAmount > 0 then
                                        v142 = true;
                                        local _ = v127.Amount;
                                    else
                                        v142 = false;
                                    end;
                                    if not v142 then
                                        v134 = true;
                                        break;
                                    else
                                        break;
                                    end;
                                else
                                    while not (v135 * 0.6 <= workspace:GetServerTimeNow() - v127.LastShot) do
                                        v141 = v141 + l_RunService_0.RenderStepped:Wait();
                                    end;
                                end;
                            else
                                break;
                            end;
                        end;
                    elseif v61(v128, v127, v130) then
                        v30(v127, v128, v130, nil, v135);
                    end;
                end;
                if v127.LastBulletActionSound then
                    local v145;
                    if v127.Attachments.Ammo and v127.Attachments.Ammo.WorkingAmount > 0 then
                        local _ = true;
                        v145 = v127.Attachments.Ammo.Amount;
                    elseif v127.FireConfig.InternalMag and v127.WorkingAmount > 0 then
                        local _ = true;
                        v145 = v127.Amount;
                    else
                        local _ = false;
                        v145 = 0;
                    end;
                    if v145 == 0 then
                        local v149 = v3:Find("ReplicatedStorage.Assets.Sounds." .. v127.LastBulletActionSound);
                        if v149 then
                            local v150 = v149:Clone();
                            v150.Parent = v3:Find("Workspace.Sounds");
                            v150.SoundGroup = v3:Find("SoundService.Effects");
                            v150.Ended:Connect(function() --[[ Line: 627 ]]
                                -- upvalues: v150 (copy)
                                v150:Destroy();
                            end);
                            task.delay(v127.LastBulletActionSoundDelay or 0, function() --[[ Line: 631 ]]
                                -- upvalues: v150 (copy)
                                v150:Play();
                            end);
                        end;
                    end;
                end;
            end;
            if v134 then
                local v151 = v3:Get("ReplicatedStorage.Assets.Sounds.Shooting.Empty Mag Click");
                v151.Parent = v3:Find("Workspace.Sounds");
                v151.Ended:Connect(function() --[[ Line: 643 ]]
                    -- upvalues: v0 (ref), v151 (copy)
                    v0.destroy(v151, "Ended");
                end);
                v151:Play();
            end;
            return false;
        end;
        return;
    end;
end;