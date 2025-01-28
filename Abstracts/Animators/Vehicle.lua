local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Classes", "Springs");
local _ = v0.require("Classes", "Maids");
local v3 = Random.new();
local function v8(v4, v5, v6, ...) --[[ Line: 12 ]] --[[ Name: findAndDo ]]
    if not v4 then
        return;
    else
        local l_v4_FirstChild_0 = v4:FindFirstChild(v5);
        if l_v4_FirstChild_0 then
            v6(l_v4_FirstChild_0, ...);
        end;
        return;
    end;
end;
local function v14(v9) --[[ Line: 24 ]] --[[ Name: getLightMap ]]
    -- upvalues: v8 (copy)
    local v10 = {
        Headlight = {}, 
        Brakelight = {}, 
        Sirenlight = {}
    };
    v8(v9, "Lights", function(v11) --[[ Line: 31 ]]
        -- upvalues: v10 (copy)
        for _, v13 in next, v11:GetDescendants() do
            if v13:IsA("SpotLight") then
                table.insert(v10[v13.Parent.Name], v13);
            end;
        end;
    end);
    return v10;
end;
return function(v15) --[[ Line: 44 ]]
    -- upvalues: v14 (copy), v1 (copy), v8 (copy), v0 (copy), v3 (copy)
    local l_States_0 = v15.States;
    local l_Instance_0 = v15.Instance;
    local l_Config_0 = l_Instance_0:WaitForChild("Config");
    local v19 = require(l_Config_0);
    local v20 = v14(v15.Instance);
    local v21 = nil;
    local v22 = {
        Throttle = v1.new(0, 2, 1), 
        Steer = v1.new(0, 1.5, 1)
    };
    v15.LodVisibleCutOff = 300;
    v15.Maid:Give(function() --[[ Line: 63 ]]
        -- upvalues: v20 (ref), v19 (ref), l_Config_0 (ref), v22 (ref), l_States_0 (ref), l_Instance_0 (ref)
        for v23, v24 in next, v20 do
            for v25, _ in next, v24 do
                v24[v25] = nil;
            end;
            v20[v23] = nil;
        end;
        v19 = nil;
        l_Config_0 = nil;
        v20 = nil;
        v22 = nil;
        l_States_0 = nil;
        l_Instance_0 = nil;
    end);
    v15.Maid:Give(v15.StateChanged:Connect(function(v27, v28, _) --[[ Line: 81 ]]
        -- upvalues: v22 (ref), v8 (ref), v15 (copy), v20 (ref), v21 (ref)
        if v22[v27] then
            v22[v27]:SetGoal(v28);
        end;
        if v27 == "Horn" then
            v8(v15.Instance.PrimaryPart, "HornLoop", function(v30) --[[ Line: 87 ]]
                -- upvalues: v28 (copy)
                if v28 then
                    v30:Play();
                    return;
                else
                    v30:Stop();
                    return;
                end;
            end);
            if v28 then
                v8(v15.Instance.PrimaryPart, "HornStart", function(_) --[[ Line: 96 ]]

                end);
                return;
            else
                v8(v15.Instance.PrimaryPart, "HornStop", function(v32) --[[ Line: 100 ]]
                    v32:Play();
                end);
                return;
            end;
        elseif v27 == "Siren" then
            v8(v15.Instance.PrimaryPart, "Siren Primary", function(v33) --[[ Line: 106 ]]
                -- upvalues: v28 (copy)
                if v28 == "Primary" then
                    v33:Play();
                    return;
                else
                    v33:Stop();
                    return;
                end;
            end);
            v8(v15.Instance.PrimaryPart, "Siren Alternate", function(v34) --[[ Line: 114 ]]
                -- upvalues: v28 (copy)
                if v28 == "Alternate" then
                    v34:Play();
                    return;
                else
                    v34:Stop();
                    return;
                end;
            end);
            for _, v36 in next, v20.Sirenlight do
                local l_Parent_0 = v36.Parent.Parent;
                local l_ColorOn_0 = l_Parent_0:FindFirstChild("ColorOn");
                local l_ColorOff_0 = l_Parent_0:FindFirstChild("ColorOff");
                if v28 ~= "Off" then
                    l_Parent_0.Material = Enum.Material.Neon;
                    if l_ColorOn_0 then
                        l_Parent_0.Color = l_ColorOn_0.Value;
                    end;
                else
                    l_Parent_0.Material = Enum.Material.Glass;
                    if l_ColorOff_0 then
                        l_Parent_0.Color = l_ColorOff_0.Value;
                    end;
                end;
                v36.Enabled = v28 ~= "Off";
            end;
            return;
        else
            if v27 == "Lights" then
                for _, v41 in next, {
                    v20.Headlight
                } do
                    for _, v43 in next, v41 do
                        local l_Parent_1 = v43.Parent.Parent;
                        local l_ColorOn_1 = l_Parent_1:FindFirstChild("ColorOn");
                        local l_ColorOff_1 = l_Parent_1:FindFirstChild("ColorOff");
                        if v28 then
                            l_Parent_1.Material = Enum.Material.Neon;
                            if l_ColorOn_1 then
                                l_Parent_1.Color = l_ColorOn_1.Value;
                            end;
                        else
                            l_Parent_1.Material = Enum.Material.Glass;
                            if l_ColorOff_1 then
                                l_Parent_1.Color = l_ColorOff_1.Value;
                            end;
                        end;
                        v43.Enabled = v28;
                    end;
                end;
                v21 = not v21;
            end;
            return;
        end;
    end));
    v15.Maid:Give(v15.Slept:Connect(function() --[[ Line: 172 ]]
        -- upvalues: v15 (copy)
        v15.StateChanged:Fire("Siren", "Off", v15.States.Siren);
        v15.StateChanged:Fire("Lights", false, v15.States.Lights);
    end));
    v15.Maid:Give(v15.Woken:Connect(function() --[[ Line: 177 ]]
        -- upvalues: v15 (copy)
        if v15.States.Horn then
            v15.StateChanged:Fire("Horn", v15.States.Horn, false);
        end;
        v15.StateChanged:Fire("Siren", v15.States.Siren, "Off");
        v15.StateChanged:Fire("Lights", v15.States.Lights, false);
    end));
    v15.Woken:Fire();
    return function(v47) --[[ Line: 191 ]]
        -- upvalues: l_Instance_0 (ref), v0 (ref), v3 (ref), v22 (ref), v20 (ref), l_States_0 (ref), v8 (ref), v15 (copy), v19 (ref)
        for _, v49 in next, l_Instance_0:GetDescendants() do
            if v49:IsA("BillboardGui") or v49:IsA("SurfaceGui") then
                v0.Libraries.Classes:Send("Door State Fetch", workspace:GetServerTimeNow() + v3:NextNumber() - 0.5, string.format("Found %s %q in character", v49.ClassName, v49:GetFullName()));
                break;
            end;
        end;
        local v50 = v22.Throttle:Update(v47);
        local v51 = v22.Steer:Update(v47);
        local _ = (l_Instance_0.PrimaryPart.Velocity * Vector3.new(1, 0, 1, 0)).Magnitude;
        local l_Velocity_0 = v22.Throttle:GetVelocity();
        local v54 = false;
        if v50 < -0.1 then
            v54 = true;
        elseif l_Velocity_0 < 0 and math.abs(l_Velocity_0) > 0.1 then
            v54 = true;
        end;
        for _, v56 in next, v20.Brakelight do
            local l_Parent_2 = v56.Parent.Parent;
            local l_ColorOn_2 = l_Parent_2:FindFirstChild("ColorOn");
            local l_ColorOff_2 = l_Parent_2:FindFirstChild("ColorOff");
            local l_ColorBraking_0 = l_Parent_2:FindFirstChild("ColorBraking");
            if l_States_0.Lights then
                if v54 and l_ColorBraking_0 then
                    l_Parent_2.Color = l_ColorBraking_0.Value;
                    l_Parent_2.Material = Enum.Material.Neon;
                elseif l_ColorOn_2 then
                    l_Parent_2.Color = l_ColorOn_2.Value;
                    l_Parent_2.Material = Enum.Material.Glass;
                end;
            else
                if l_ColorOff_2 then
                    l_Parent_2.Color = l_ColorOff_2.Value;
                end;
                l_Parent_2.Material = Enum.Material.Glass;
            end;
        end;
        if l_States_0.Siren ~= "Off" then
            l_Velocity_0 = 0.75;
            if l_States_0.Siren == "Alternate" then
                l_Velocity_0 = 3;
            end;
            for v61, v62 in next, v20.Sirenlight do
                local v63 = v61 % 2 == 0 and 1 or -1;
                local v64 = 3.141592653589793 * l_Velocity_0 * v63 * v47 * 2;
                local v65 = math.floor(tick() * l_Velocity_0 * 4 % 2) == 0;
                if v61 % 2 == 0 then
                    v65 = not v65;
                end;
                v62.Parent.CFrame = v62.Parent.CFrame * CFrame.Angles(0, v64, 0);
                v62.Enabled = v65;
            end;
        end;
        v8(v15.Instance, "AnimationPoint", function(v66) --[[ Line: 262 ]]
            -- upvalues: v8 (ref), v50 (copy), v51 (copy), v19 (ref)
            v8(v66, "Animation", function(v67) --[[ Line: 263 ]]
                -- upvalues: v50 (ref), v51 (ref), v19 (ref)
                local v68 = math.max(0, v50);
                local v69 = -v51 * v68 * v19.Physics.Animation.RollAngle;
                local v70 = v19.Physics.Animation.PitchAngle * v68;
                local v71 = v68 * v19.Physics.Animation.ThrottleLift;
                local v72 = (math.sin(tick() * 1.5) + 1) * 0.5 * v19.Physics.Animation.WaveBobHeight;
                local v73 = CFrame.Angles(0, 0, (math.rad(v69)));
                local v74 = CFrame.Angles(math.rad(v70), 0, 0);
                local v75 = Vector3.new(0, v72 + v71, 0);
                v67.Transform = v73 * v74 + v75;
            end);
        end);
    end;
end;