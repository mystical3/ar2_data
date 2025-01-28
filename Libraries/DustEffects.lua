local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Lighting");
local v2 = v0.require("Libraries", "Resources");
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local v5 = v2:Find("ReplicatedStorage.Assets.Sounds");
local v6 = v2:Find("Workspace.Effects");
local v7 = {};
local function _(v8, v9, v10, v11, v12) --[[ Line: 27 ]] --[[ Name: remap ]]
    return v11 + (v12 - v11) * ((v8 - v9) / (v10 - v9));
end;
local function _(v14, v15, v16, v17, v18) --[[ Line: 31 ]] --[[ Name: clampedRemap ]]
    local v19 = math.clamp(v14, v15, v16);
    return v17 + (v18 - v17) * ((v19 - v15) / (v16 - v15));
end;
local function v26() --[[ Line: 35 ]] --[[ Name: getStormFade ]]
    -- upvalues: v1 (copy)
    local l_v1_State_0, v22 = v1:GetState();
    if l_v1_State_0 == nil or not v22.StormEnabled then
        return 0;
    else
        local l_Position_0 = workspace.CurrentCamera.CFrame.Position;
        local l_Magnitude_0 = (l_Position_0 - Vector3.new(-201.39999389648438, 101, 962.4459838867188, 0)).Magnitude;
        local l_Magnitude_1 = (l_Position_0 - Vector3.new(-223.25599670410156, 138.6699981689453, 656.5059814453125, 0)).Magnitude;
        if l_Magnitude_1 <= 289 then
            return 0 + 1 * ((math.clamp(l_Magnitude_1, 226, 289) - 226) / 63);
        else
            return 1 + -1 * ((math.clamp(l_Magnitude_0, 500, 750) - 500) / 250);
        end;
    end;
end;
local function v29() --[[ Line: 75 ]] --[[ Name: getWind ]]
    -- upvalues: v26 (copy)
    local v27 = CFrame.Angles(math.sin((os.clock())) * 0.03490658503988659, 0.7853981633974483, 0);
    local v28 = v26() * 400;
    return v27.LookVector, v28;
end;
local v30 = nil;
local l_StaticDust_0 = v6:WaitForChild("StaticDust");
local l_Bigs_0 = l_StaticDust_0:WaitForChild("Bigs");
local l_Smalls_0 = l_StaticDust_0:WaitForChild("Smalls");
local l_Rate_0 = l_Bigs_0.Rate;
local l_Rate_1 = l_Smalls_0.Rate;
local v36 = Vector3.new();
local v37 = os.clock();
local v38 = 0;
local l_l_Bigs_0_0 = l_Bigs_0 --[[ copy: 14 -> 22 ]];
local l_l_Smalls_0_0 = l_Smalls_0 --[[ copy: 15 -> 23 ]];
local l_l_StaticDust_0_0 = l_StaticDust_0 --[[ copy: 13 -> 24 ]];
local l_l_Rate_0_0 = l_Rate_0 --[[ copy: 16 -> 25 ]];
local l_l_Rate_1_0 = l_Rate_1 --[[ copy: 17 -> 26 ]];
do
    local l_v36_0, l_v37_0, l_v38_0 = v36, v37, v38;
    v30 = function(v47) --[[ Line: 99 ]] --[[ Name: setStaticDust ]]
        -- upvalues: l_v37_0 (ref), l_v38_0 (ref), l_l_Bigs_0_0 (copy), l_l_Smalls_0_0 (copy), l_Players_0 (copy), l_v36_0 (ref), l_l_StaticDust_0_0 (copy), v26 (copy), l_l_Rate_0_0 (copy), l_l_Rate_1_0 (copy)
        local v48 = os.clock();
        local v49 = v48 - l_v37_0;
        l_v38_0 = l_v38_0 + v49;
        l_v37_0 = v48;
        if v47 == 0 then
            l_l_Bigs_0_0.Enabled = false;
            l_l_Smalls_0_0.Enabled = false;
            l_v38_0 = 0;
            return;
        else
            l_l_Bigs_0_0.Enabled = true;
            l_l_Smalls_0_0.Enabled = true;
            local l_Position_1 = workspace.CurrentCamera.Focus.Position;
            local l_CFrame_0 = workspace.CurrentCamera.CFrame;
            local v52 = Vector3.new();
            if l_Players_0.LocalPlayer and l_Players_0.LocalPlayer.Character then
                local l_Character_0 = l_Players_0.LocalPlayer.Character;
                if l_Character_0 and l_Character_0.PrimaryPart then
                    local l_Velocity_0 = l_Character_0.PrimaryPart.Velocity;
                    v52 = Vector3.new(1, 0, 1, 0) * l_Velocity_0 * 1.2;
                end;
            end;
            while l_v38_0 >= 0.016666666666666666 do
                l_v38_0 = math.min(0.1, l_v38_0) - 0.016666666666666666;
                l_v36_0 = l_v36_0:Lerp(v52, 0.05);
            end;
            local v55 = l_Position_1 + l_v36_0 - l_CFrame_0.Position;
            if v55.Magnitude > 25 then
                v55 = v55.Unit * 25;
            end;
            local v56 = l_CFrame_0.Position + v55;
            local v57 = Vector3.new(0, l_l_StaticDust_0_0.Size.Y * 0.5 - 5, 0);
            l_l_StaticDust_0_0.CFrame = l_CFrame_0.Rotation + v56 + v57;
            local v58 = CFrame.Angles(math.sin((os.clock())) * 0.03490658503988659, 0.7853981633974483, 0);
            local v59 = v26() * 400;
            local _ = v58.LookVector * v59 - Vector3.new(0, -0.05000000074505806, 0, 0);
            l_l_Bigs_0_0.Rate = l_l_Rate_0_0 * v47;
            l_l_Smalls_0_0.Rate = l_l_Rate_1_0 * v47;
            return;
        end;
    end;
end;
l_StaticDust_0 = nil;
l_Bigs_0 = v6:WaitForChild("StormDust");
l_Smalls_0 = l_Bigs_0:WaitForChild("Clouds");
l_Rate_0 = v6:WaitForChild("StormDebris");
l_Rate_1 = l_Rate_0:WaitForChild("Debris");
v36 = v2:GetFrom(v5, "Ambient.Winter Snowstorm");
v36.SoundGroup = v2:Find("SoundService.Ambient");
v36.Parent = v6;
v37 = l_Smalls_0.Rate;
v38 = l_Rate_1.Rate;
local l_Volume_0 = v36.Volume;
v36.Volume = 0;
v36:Play();
l_StaticDust_0 = function(v62, v63) --[[ Line: 180 ]] --[[ Name: setStormDust ]]
    -- upvalues: l_Smalls_0 (copy), l_Rate_1 (copy), v36 (copy), v26 (copy), l_Rate_0 (copy), l_Bigs_0 (copy), v37 (copy), v38 (copy), l_Volume_0 (copy)
    if v63 then
        l_Smalls_0.Enabled = false;
        l_Smalls_0:Clear();
        l_Rate_1.Enabled = false;
        l_Rate_1:Clear();
        v36.Volume = 0;
        return;
    elseif v62 == 0 then
        l_Smalls_0.Enabled = false;
        l_Rate_1.Enabled = false;
        v36.Volume = 0;
        return;
    else
        l_Smalls_0.Enabled = true;
        l_Rate_1.Enabled = true;
        local v64 = CFrame.Angles(math.sin((os.clock())) * 0.03490658503988659, 0.7853981633974483, 0);
        local v65 = v26() * 400;
        v64 = v64.LookVector * math.min(300, v65);
        v65 = workspace.CurrentCamera;
        l_Rate_0.Size = Vector3.new(10, 10, 10, 0);
        l_Rate_0.CFrame = CFrame.new(v65.CFrame * Vector3.new(0, 0, -3, 0)) - v64.Unit * 5;
        l_Bigs_0.CFrame = CFrame.new(v64 * 0, -v64) + v65.Focus.Position + Vector3.new(0, l_Bigs_0.Size.Y * 0.5, 0) - v64.Unit * 5;
        l_Smalls_0.Acceleration = v64;
        l_Smalls_0.Rate = v37 * v62;
        l_Rate_1.Acceleration = v64;
        l_Rate_1.Rate = v38 * v62;
        v36.Volume = l_Volume_0 * v62;
        return;
    end;
end;
v7.GetStormFade = function(_) --[[ Line: 223 ]] --[[ Name: GetStormFade ]]
    -- upvalues: v26 (copy)
    return (v26());
end;
v7.WipeStorm = function(_) --[[ Line: 227 ]] --[[ Name: WipeStorm ]]

end;
v7.GetWindVector = function(_) --[[ Line: 231 ]] --[[ Name: GetWindVector ]]
    -- upvalues: v29 (copy)
    return v29();
end;
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 237 ]]

end);
return v7;