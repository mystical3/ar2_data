local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Classes", "Signals");
local v2 = v0.require("Classes", "Steppers");
local v3 = v0.require("Classes", "Maids");
local v4 = v0.require("Classes", "Springs");
local v5 = v0.require("Libraries", "Network");
local v6 = v0.require("Libraries", "Resources");
local _ = game:GetService("Players");
local _ = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v10 = {};
v10.__index = v10;
local function _(v11, v12) --[[ Line: 22 ]] --[[ Name: round ]]
    local v13 = 10 ^ (v12 or 0);
    return math.floor(v11 * v13 + 0.5) / v13;
end;
local function _(v15, v16, v17) --[[ Line: 27 ]] --[[ Name: connectToAttribute ]]
    local v18 = v15:GetAttributeChangedSignal(v16):Connect(function() --[[ Line: 28 ]]
        -- upvalues: v17 (copy), v15 (copy), v16 (copy)
        v17(v15:GetAttribute(v16));
    end);
    v17(v15:GetAttribute(v16));
    return v18;
end;
local function v34(v20) --[[ Line: 37 ]] --[[ Name: getKeyframes ]]
    -- upvalues: v6 (copy)
    local v21 = {};
    for _, v23 in next, v20:GetChildren() do
        local v24 = {
            Name = v23.Name, 
            Pose = v23.PrimaryPart.CFrame, 
            Time = nil, 
            Length = nil, 
            LengthRaw = v23:GetAttribute("Length"), 
            Speed = v23:GetAttribute("MoveSpeed") or 1, 
            Delay = v23:GetAttribute("Delay") or 0, 
            Direction = v23:GetAttribute("Direction") or "In", 
            Style = v23:GetAttribute("Style") or "Linear", 
            Sound = v23:GetAttribute("SoundEffect") or "NOPE"
        };
        local v25 = "ReplicatedStorage.Assets.Sounds." .. v24.Sound;
        local v26 = v6:Search(v25);
        if v26 then
            v24.Sound = v26;
        else
            v24.Sound = nil;
        end;
        table.insert(v21, v24);
    end;
    table.sort(v21, function(v27, v28) --[[ Line: 70 ]]
        return tonumber(v27.Name) < tonumber(v28.Name);
    end);
    for v29 = #v21, 1, -1 do
        local v30 = v21[v29];
        if v30.Delay > 0 then
            table.insert(v21, v29, {
                Name = v30.Name .. " Delay", 
                Pose = v30.Pose, 
                Time = nil, 
                Length = v30.Delay, 
                Delay = 0, 
                Direction = "In", 
                Style = "Linear"
            });
        end;
    end;
    local v31 = 0;
    for v32 = 1, #v21 do
        local v33 = v21[v32];
        v33.NextFrame = v21[v32 + 1] or v21[1];
        v33.PreviousFrame = v21[v32 - 1] or v21[#v21];
        v33.Style = Enum.EasingStyle[v33.Style];
        v33.Direction = Enum.EasingDirection[v33.Direction];
        if not v33.Time then
            v33.Time = v31;
        end;
        if not v33.Length then
            v33.Length = v33.LengthRaw;
        end;
        if not v33.Length then
            v33.Length = math.floor(v33.Pose:ToObjectSpace(v33.NextFrame.Pose).Position.Magnitude / v33.Speed * 10 + 0.5) / 10;
        end;
        v31 = v31 + v33.Length;
    end;
    return v21, v31;
end;
local function v40(v35) --[[ Line: 126 ]] --[[ Name: cleanModelForAnimation ]]
    local l_1_0 = v35:FindFirstChild("1");
    if not l_1_0 then
        warn("Could not find \"1\" platform:", v35:GetFullName());
        return nil;
    else
        for _, v38 in next, v35:GetChildren() do
            if v38 ~= l_1_0 then
                v38:Destroy();
            end;
        end;
        local _ = l_1_0.PrimaryPart;
        return l_1_0, {
            Platform = l_1_0
        };
    end;
end;
local function v61(v41, v42) --[[ Line: 188 ]] --[[ Name: animate ]]
    -- upvalues: v5 (copy), l_TweenService_0 (copy)
    local v43 = math.clamp(v5:GetPing(), 0, 0.75) * 1;
    local v44 = v41.PingSpring:StepTo(v43, v42);
    local v45 = (workspace:GetServerTimeNow() + v41.AnimationOffset + v44) % v41.AnimationLength;
    local v46 = nil;
    for v47 = #v41.Keyframes, 1, -1 do
        local v48 = v41.Keyframes[v47];
        if v48.Time <= v45 then
            v46 = v48;
            break;
        end;
    end;
    if v46 and v46.NextFrame then
        local v49 = v45 - v46.Time;
        local v50 = math.clamp(v49 / v46.Length, 0, 1);
        local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v50, v46.Style, v46.Direction);
        local v52 = v46.Pose:lerp(v46.NextFrame.Pose, l_l_TweenService_0_Value_0);
        v41.AnimationObjects.Platform:PivotTo(v52);
        local v53 = v49 - 0.008333333333333333;
        local v54 = math.clamp(v53 / v46.Length, 0, 1);
        local l_l_TweenService_0_Value_1 = l_TweenService_0:GetValue(v54, v46.Style, v46.Direction);
        local v56 = v49 + 0.008333333333333333;
        local v57 = math.clamp(v56 / v46.Length, 0, 1);
        local l_l_TweenService_0_Value_2 = l_TweenService_0:GetValue(v57, v46.Style, v46.Direction);
        local v59 = v46.Pose:lerp(v46.NextFrame.Pose, l_l_TweenService_0_Value_1);
        v41.AnimationVelocity = (v46.Pose:lerp(v46.NextFrame.Pose, l_l_TweenService_0_Value_2).Position - v59.Position) / (v56 - v53);
        if v46 ~= v41.LastKeyframe then
            if v46.Sound and not v41.Muted then
                local v60 = v46.Sound:Clone();
                v60.Parent = v41.Instance.PrimaryPart;
                v60.PlaybackSpeed = v60.TimeLength / v46.Length;
                v60.Ended:Connect(function() --[[ Line: 238 ]]
                    -- upvalues: v60 (copy)
                    v60:Destroy();
                end);
                v60:Play();
            end;
            v41.LastKeyframe = v46;
        end;
    end;
end;
v10.new = function(v62, v63, v64) --[[ Line: 252 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), v34 (copy), v40 (copy), v4 (copy), v2 (copy), v61 (copy), v10 (copy)
    local v65 = {
        Type = "MovingPlatform", 
        Id = v62, 
        Maid = v3.new(), 
        Instance = v63, 
        HomeCFrame = v63.PrimaryPart.CFrame
    };
    local v66, v67 = v34(v63);
    v65.Keyframes = v66;
    v65.AnimationLength = v67;
    v66, v67 = v40(v63);
    v65.Platform = v66;
    v65.AnimationObjects = v67;
    v65.Muted = false;
    v65.LastKeyframe = nil;
    v65.AnimationOffset = 0;
    v65.AnimationVelocity = Vector3.new();
    v65.PingSpring = v4.new(0, 1, 1);
    v65.AnimationStepper = v65.Maid:Give(v2.new(0, "Stepped", function(_, v69) --[[ Line: 270 ]]
        -- upvalues: v61 (ref), v65 (copy)
        v61(v65, v69);
    end));
    v66 = v65.Maid;
    local function v71(v70) --[[ Line: 274 ]]
        -- upvalues: v65 (copy), v61 (ref)
        v65.AnimationOffset = v70;
        v61(v65, 0);
    end;
    local l_v64_AttributeChangedSignal_0 = v64:GetAttributeChangedSignal("AnimationOffset");
    local v73 = "AnimationOffset";
    local l_v71_0 = v71 --[[ copy: 7 -> 12 ]];
    local l_v73_0 = v73 --[[ copy: 11 -> 13 ]];
    l_v64_AttributeChangedSignal_0 = l_v64_AttributeChangedSignal_0:Connect(function() --[[ Line: 28 ]]
        -- upvalues: l_v71_0 (copy), v64 (copy), l_v73_0 (copy)
        l_v71_0(v64:GetAttribute(l_v73_0));
    end);
    v71(v64:GetAttribute("AnimationOffset"));
    v66:Give(l_v64_AttributeChangedSignal_0);
    v65.Instance:SetAttribute("Muted", false);
    v66 = v65.Maid;
    v71 = function(v76) --[[ Line: 284 ]]
        -- upvalues: v65 (copy)
        v65.Muted = v76;
    end;
    l_v64_AttributeChangedSignal_0 = v64:GetAttributeChangedSignal("Muted");
    v73 = "Muted";
    l_v64_AttributeChangedSignal_0 = l_v64_AttributeChangedSignal_0:Connect(function() --[[ Line: 28 ]]
        -- upvalues: v71 (copy), v64 (copy), v73 (copy)
        v71(v64:GetAttribute(v73));
    end);
    v71(v64:GetAttribute("Muted"));
    v66:Give(l_v64_AttributeChangedSignal_0);
    v61(v65, 0);
    return (setmetatable(v65, v10));
end;
v10.Destroy = function(v77) --[[ Line: 301 ]] --[[ Name: Destroy ]]
    if v77.Destroyed then
        return;
    else
        v77.Destroyed = true;
        if v77.Platform then
            v77.Platform:Destroy();
            v77.Platform = nil;
        end;
        if v77.Maid then
            v77.Maid:Destroy();
            v77.Maid = nil;
        end;
        for _, v79 in next, v77.Keyframes do
            v79.Sound = nil;
        end;
        setmetatable(v77, nil);
        table.clear(v77);
        v77.Destroyed = true;
        return;
    end;
end;
v10.GetInteractionPosition = function(_, _, _) --[[ Line: 328 ]] --[[ Name: GetInteractionPosition ]]
    return nil;
end;
v10.Interact = function(_) --[[ Line: 332 ]] --[[ Name: Interact ]]

end;
v10.SetDetailed = function(_, _) --[[ Line: 336 ]] --[[ Name: SetDetailed ]]

end;
return v10;