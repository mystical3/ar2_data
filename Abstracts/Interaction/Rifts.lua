local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Classes", "Signals");
local v2 = v0.require("Classes", "Steppers");
local v3 = v0.require("Classes", "Maids");
local v4 = v0.require("Libraries", "Network");
local v5 = v0.require("Libraries", "Resources");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("UserInputService");
local v8 = {};
v8.__index = v8;
local function _(v9, v10) --[[ Line: 20 ]] --[[ Name: round ]]
    local v11 = 10 ^ (v10 or 0);
    return math.floor(v9 * v11 + 0.5) / v11;
end;
local function _(v13, v14, v15) --[[ Line: 25 ]] --[[ Name: connectToAttribute ]]
    local v16 = v13:GetAttributeChangedSignal(v14):Connect(function() --[[ Line: 26 ]]
        -- upvalues: v15 (copy), v13 (copy), v14 (copy)
        v15(v13:GetAttribute(v14));
    end);
    v15(v13:GetAttribute(v14));
    return v16;
end;
local function v23(v18) --[[ Line: 35 ]] --[[ Name: getParticles ]]
    local l_1_0 = v18:WaitForChild("1");
    local v20 = {};
    for _, v22 in next, l_1_0:GetDescendants() do
        if v22:IsA("ParticleEmitter") then
            table.insert(v20, v22);
        end;
    end;
    return v20;
end;
local function v35(v24) --[[ Line: 48 ]] --[[ Name: getKeyframes ]]
    local v25 = {};
    for _, v27 in next, v24:GetChildren() do
        table.insert(v25, {
            Name = v27.Name, 
            Pose = v27.PrimaryPart.CFrame, 
            Time = nil, 
            Length = nil, 
            Speed = v27:GetAttribute("MoveSpeed") or 1, 
            Delay = v27:GetAttribute("Delay") or 0, 
            Direction = v27:GetAttribute("Direction") or "In", 
            Style = v27:GetAttribute("Style") or "Linear"
        });
    end;
    table.sort(v25, function(v28, v29) --[[ Line: 70 ]]
        return v28.Name < v29.Name;
    end);
    for v30 = #v25, 1, -1 do
        local v31 = v25[v30];
        if v31.Delay > 0 then
            table.insert(v25, v30, {
                Name = v31.Name .. " Delay", 
                Pose = v31.Pose, 
                Time = nil, 
                Length = v31.Delay, 
                Delay = 0, 
                Direction = "In", 
                Style = "Linear"
            });
        end;
    end;
    local v32 = 0;
    for v33 = 1, #v25 do
        local v34 = v25[v33];
        v34.NextFrame = v25[v33 + 1] or v25[1];
        v34.PreviousFrame = v25[v33 - 1] or v25[#v25];
        v34.Style = Enum.EasingStyle[v34.Style];
        v34.Direction = Enum.EasingDirection[v34.Direction];
        if not v34.Time then
            v34.Time = v32;
        end;
        if not v34.Length then
            v34.Length = math.floor(v34.Pose:ToObjectSpace(v34.NextFrame.Pose).Position.Magnitude / v34.Speed * 10 + 0.5) / 10;
        end;
        v32 = v32 + v34.Length;
    end;
    return v25, v32;
end;
local function v46(v36) --[[ Line: 122 ]] --[[ Name: cleanModelForAnimation ]]
    local l_1_1 = v36:FindFirstChild("1");
    l_1_1:WaitForChild("LootNode").Transparency = 1;
    if not l_1_1 then
        warn("Could not find \"1\" platform:", v36:GetFullName());
        return nil;
    else
        for _, v39 in next, v36:GetChildren() do
            if v39 ~= l_1_1 then
                v39:Destroy();
            end;
        end;
        local l_PrimaryPart_0 = l_1_1.PrimaryPart;
        for _, v42 in next, l_1_1:GetDescendants() do
            if v42:IsA("BasePart") and v42 ~= l_PrimaryPart_0 then
                local l_Weld_0 = Instance.new("Weld");
                l_Weld_0.C0 = l_PrimaryPart_0.CFrame:ToObjectSpace(v42.CFrame);
                l_Weld_0.Part0 = l_PrimaryPart_0;
                l_Weld_0.Part1 = v42;
                l_Weld_0.Parent = v42;
                v42.Anchored = false;
            end;
        end;
        local l_BodyPosition_0 = Instance.new("BodyPosition");
        l_BodyPosition_0.MaxForce = Vector3.new(1e999, 1e999, 1e999, 0);
        l_BodyPosition_0.D = 300;
        l_BodyPosition_0.P = 10000;
        l_BodyPosition_0.Position = l_PrimaryPart_0.CFrame.p;
        l_BodyPosition_0.Parent = l_PrimaryPart_0;
        local l_BodyGyro_0 = Instance.new("BodyGyro");
        l_BodyGyro_0.MaxTorque = Vector3.new(1e999, 1e999, 1e999, 0);
        l_BodyGyro_0.D = 300;
        l_BodyGyro_0.P = 10000;
        l_BodyGyro_0.CFrame = l_PrimaryPart_0.CFrame;
        l_BodyGyro_0.Parent = l_PrimaryPart_0;
        return l_1_1, {
            Position = l_BodyPosition_0, 
            Rotation = l_BodyGyro_0
        };
    end;
end;
local function v63(v47) --[[ Line: 169 ]] --[[ Name: animate ]]
    -- upvalues: l_TweenService_0 (copy)
    local v48 = (workspace:GetServerTimeNow() + v47.AnimationOffset) % v47.AnimationLength;
    local v49 = nil;
    for v50 = #v47.Keyframes, 1, -1 do
        local v51 = v47.Keyframes[v50];
        if v51.Time <= v48 then
            v49 = v51;
            break;
        end;
    end;
    if v49 and v49.NextFrame then
        local v52 = math.clamp((v48 - v49.Time) / v49.Length, 0, 1);
        local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v52, v49.Style, v49.Direction);
        local v54 = v49.Pose:lerp(v49.NextFrame.Pose, l_l_TweenService_0_Value_0);
        v47.AnimationObjects.Position.Position = v54.Position;
        v47.AnimationObjects.Rotation.CFrame = v54;
    end;
    if v47.LootModel and v47.LootModel.PrimaryPart then
        local l_BaseWeld_0 = v47.LootModel.PrimaryPart:FindFirstChild("BaseWeld");
        if l_BaseWeld_0 then
            local v56 = workspace:GetServerTimeNow() * 3.141592653589793 * 2;
            local v57 = math.sin(v56 / 4) * 1;
            local v58 = math.sin(v56 / 8) * 0.5;
            local v59 = math.sin(v56 / 8) * 0.5;
            local v60 = v56 / 7 % 6.283185307179586;
            l_BaseWeld_0.C0 = CFrame.Angles(0, v60, 0) + Vector3.new(v58, v57, v59);
        end;
    end;
    for _, v62 in next, v47.Particles do
        v62.Enabled = v47.LootModel ~= nil;
    end;
end;
local function v74(v64, v65, v66) --[[ Line: 216 ]] --[[ Name: spawnLoot ]]
    -- upvalues: v5 (copy), v0 (copy)
    local v67 = v5:Get("ReplicatedStorage.Assets.LootModels." .. v66);
    v67.PrimaryPart.Transparency = 1;
    for _, v69 in next, v67:GetDescendants() do
        if v69:IsA("BasePart") then
            local l_Weld_1 = Instance.new("Weld");
            l_Weld_1.C0 = v67.PrimaryPart.CFrame:ToObjectSpace(v69.CFrame);
            l_Weld_1.Part0 = v67.PrimaryPart;
            l_Weld_1.Part1 = v69;
            l_Weld_1.Parent = v69;
        end;
    end;
    local l_Weld_2 = Instance.new("Weld");
    l_Weld_2.Part0 = v65.LootNode;
    l_Weld_2.Part1 = v67.PrimaryPart;
    l_Weld_2.Parent = v67.PrimaryPart;
    l_Weld_2.Name = "BaseWeld";
    for _, v73 in next, v67:GetDescendants() do
        if v73:IsA("BasePart") then
            v73.Anchored = false;
        end;
    end;
    v67.Parent = v65;
    v0.Libraries.World:TagAsInteractable(v67, v64.Id);
    return v67;
end;
v8.new = function(v75, v76, v77) --[[ Line: 251 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), v23 (copy), v35 (copy), v46 (copy), v2 (copy), v63 (copy), v74 (copy), v8 (copy)
    local v78 = {
        Type = "Rift", 
        Id = v75, 
        Maid = v3.new(), 
        Instance = v76, 
        HomeCFrame = v76.PrimaryPart.CFrame, 
        Particles = v23(v76)
    };
    local v79, v80 = v35(v76);
    v78.Keyframes = v79;
    v78.AnimationLength = v80;
    v79, v80 = v46(v76);
    v78.Platform = v79;
    v78.AnimationObjects = v80;
    v78.AnimationOffset = 0;
    v78.Enabled = false;
    v78.LootModel = nil;
    v78.LootItem = "";
    v78.AnimationStepper = v78.Maid:Give(v2.new(0, "Heartbeat", function() --[[ Line: 270 ]]
        -- upvalues: v63 (ref), v78 (copy)
        v63(v78);
    end));
    v79 = v78.Maid;
    local function v82(v81) --[[ Line: 274 ]]
        -- upvalues: v78 (copy), v63 (ref)
        v78.AnimationOffset = v81;
        v63(v78);
        v78.Platform:SetPrimaryPartCFrame(v78.AnimationObjects.Rotation.CFrame);
    end;
    local l_v77_AttributeChangedSignal_0 = v77:GetAttributeChangedSignal("AnimationOffset");
    local v84 = "AnimationOffset";
    local l_v82_0 = v82 --[[ copy: 7 -> 12 ]];
    local l_v84_0 = v84 --[[ copy: 11 -> 13 ]];
    l_v77_AttributeChangedSignal_0 = l_v77_AttributeChangedSignal_0:Connect(function() --[[ Line: 26 ]]
        -- upvalues: l_v82_0 (copy), v77 (copy), l_v84_0 (copy)
        l_v82_0(v77:GetAttribute(l_v84_0));
    end);
    v82(v77:GetAttribute("AnimationOffset"));
    v79:Give(l_v77_AttributeChangedSignal_0);
    v79 = v78.Maid;
    v82 = function(v87) --[[ Line: 282 ]]
        -- upvalues: v78 (copy), v74 (ref)
        v78.LootItem = v87;
        if v78.LootModel then
            v78.LootModel:Destroy();
            v78.LootModel = nil;
        end;
        if v87 ~= "" then
            v78.LootModel = v74(v78, v78.Platform, v87);
        end;
    end;
    l_v77_AttributeChangedSignal_0 = v77:GetAttributeChangedSignal("Loot");
    v84 = "Loot";
    local l_v82_1 = v82 --[[ copy: 7 -> 14 ]];
    local l_v84_1 = v84 --[[ copy: 11 -> 15 ]];
    l_v77_AttributeChangedSignal_0 = l_v77_AttributeChangedSignal_0:Connect(function() --[[ Line: 26 ]]
        -- upvalues: l_v82_1 (copy), v77 (copy), l_v84_1 (copy)
        l_v82_1(v77:GetAttribute(l_v84_1));
    end);
    v82(v77:GetAttribute("Loot"));
    v79:Give(l_v77_AttributeChangedSignal_0);
    v79 = v78.Maid;
    v82 = function(v90) --[[ Line: 295 ]]
        -- upvalues: v78 (copy)
        v78.Enabled = v90;
        if v90 then
            v78.Platform.Parent = v78.Instance;
            return;
        else
            v78.Platform.Parent = nil;
            return;
        end;
    end;
    l_v77_AttributeChangedSignal_0 = v77:GetAttributeChangedSignal("Enabled");
    v84 = "Enabled";
    l_v77_AttributeChangedSignal_0 = l_v77_AttributeChangedSignal_0:Connect(function() --[[ Line: 26 ]]
        -- upvalues: v82 (copy), v77 (copy), v84 (copy)
        v82(v77:GetAttribute(v84));
    end);
    v82(v77:GetAttribute("Enabled"));
    v79:Give(l_v77_AttributeChangedSignal_0);
    v78.Platform.PrimaryPart.Anchored = false;
    return (setmetatable(v78, v8));
end;
v8.Destroy = function(v91) --[[ Line: 316 ]] --[[ Name: Destroy ]]
    if v91.Destroyed then
        return;
    else
        v91.Destroyed = true;
        if v91.LootModel then
            v91.LootModel:Destroy();
            v91.LootModel = nil;
        end;
        if v91.Platform then
            v91.Platform:Destroy();
            v91.Platform = nil;
        end;
        if v91.Maid then
            v91.Maid:Destroy();
            v91.Maid = nil;
        end;
        setmetatable(v91, nil);
        table.clear(v91);
        v91.Destroyed = true;
        return;
    end;
end;
v8.GetInteractionPosition = function(v92, _, _) --[[ Line: 344 ]] --[[ Name: GetInteractionPosition ]]
    if v92.Enabled and v92.LootModel then
        return v92.LootModel.PrimaryPart.CFrame.p;
    else
        return nil;
    end;
end;
v8.Interact = function(v95) --[[ Line: 352 ]] --[[ Name: Interact ]]
    -- upvalues: v4 (copy)
    if v95.Enabled and v95.LootModel then
        v4:Send("World Interact", v95.Id);
    end;
end;
v8.SetDetailed = function(_, _) --[[ Line: 358 ]] --[[ Name: SetDetailed ]]

end;
return v8;