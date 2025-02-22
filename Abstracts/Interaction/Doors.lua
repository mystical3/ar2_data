local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Maids");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local v6 = v1:Find("ReplicatedStorage.Chunking.Door Animation");
local v7 = v1:Find("ReplicatedStorage.Assets.Sounds.Interaction");
local v8 = {};
v8.__index = v8;
local v9 = {};
local function _(v10, v11, v12) --[[ Line: 25 ]] --[[ Name: findValue ]]
    local l_v10_FirstChild_0 = v10:FindFirstChild(v11);
    if l_v10_FirstChild_0 then
        return l_v10_FirstChild_0.Value;
    else
        return v12;
    end;
end;
local function v23(_, v16) --[[ Line: 35 ]] --[[ Name: getAnimationPoses ]]
    -- upvalues: v6 (copy)
    local l_Animation_0 = v16.Door.Animation;
    local l_Value_0 = l_Animation_0.AnimationName.Value;
    local l_Value_1 = l_Animation_0.AnimationLength.Value;
    local l_v6_FirstChild_0 = v6:FindFirstChild(l_Value_0);
    local v21 = {};
    local l_DoorHeight_0 = l_Animation_0:FindFirstChild("DoorHeight");
    v21.Height = if l_DoorHeight_0 then l_DoorHeight_0.Value else 6.6;
    l_DoorHeight_0 = l_Animation_0:FindFirstChild("DoorThickness");
    v21.Thickness = if l_DoorHeight_0 then l_DoorHeight_0.Value else 0.2;
    l_DoorHeight_0 = l_Animation_0:FindFirstChild("DoorWidth");
    v21.Width = if l_DoorHeight_0 then l_DoorHeight_0.Value else 0.2;
    l_DoorHeight_0 = l_Animation_0:FindFirstChild("SoundGroup");
    v21.Material = if l_DoorHeight_0 then l_DoorHeight_0.Value else "Wood";
    if l_v6_FirstChild_0 then
        l_Animation_0:Destroy();
        return require(l_v6_FirstChild_0)(l_Value_1, v21);
    else
        warn("Could not find door animation data for", l_Value_0);
        return {};
    end;
end;
local function _(v24) --[[ Line: 59 ]] --[[ Name: prepModel ]]
    local l_DecalPart_0 = v24.DecalPart;
    l_DecalPart_0.Transparency = 1;
    l_DecalPart_0.CanCollide = false;
    l_DecalPart_0.TopSurface = Enum.SurfaceType.Smooth;
    l_DecalPart_0.BottomSurface = Enum.SurfaceType.Smooth;
    l_DecalPart_0.Parent = v24.DoorModel;
    if v24.Decal then
        v24.Decal.Transparency = 1;
    end;
    v24.HingePart.Transparency = 1;
    v24.HingePart.CanCollide = false;
    v24.DoorModel.WorldPivot = v24.HingePart.CFrame;
end;
local function v45(v27) --[[ Line: 77 ]] --[[ Name: update ]]
    -- upvalues: v9 (copy), v7 (copy), v1 (copy), l_TweenService_0 (copy)
    if v9[v27.Id] and v27.TweenCleanUp then
        v27.TweenCleanUp();
    end;
    local l_CFrame_0 = v27.HingePart.CFrame;
    local v29 = v27.AnimationData.Timeline[v27.State];
    local v30, v31 = unpack(v29.AnimationStyle);
    local v32 = Enum.EasingStyle[v30];
    local v33 = Enum.EasingDirection[v31];
    local v34 = v29.AnimationStartDelay + v29.AnimationLength;
    local v35 = 0;
    local v36 = v7:WaitForChild(v29.SoundName):Clone();
    v36.SoundGroup = v1:Find("SoundService.Effects");
    v36.Parent = v27.HingePart;
    local v37 = false;
    local v38 = 0;
    local v39 = 0;
    if v29.SoundPlaysAt == "Start" then
        v38 = v29.SoundTimeSlip;
        v35 = v38 + v29.AnimationStartDelay;
    elseif v29.SoundPlaysAt == "Finish" then
        v38 = v29.AnimationLength - v29.SoundTimeSlip;
        v35 = v29.AnimationStartDelay;
        v34 = v34 + v36.TimeLength;
    end;
    v27.TweenCleanUp = function() --[[ Line: 116 ]]
        -- upvalues: v27 (copy), v9 (ref), v36 (copy)
        v27.TweenCleanUp = nil;
        v9[v27.Id] = nil;
        v36:Destroy();
    end;
    v9[v27.Id] = function(v40) --[[ Line: 123 ]]
        -- upvalues: v27 (copy), v39 (ref), v35 (ref), v29 (copy), l_TweenService_0 (ref), v32 (copy), v33 (copy), l_CFrame_0 (copy), v38 (ref), v37 (ref), v36 (copy), v34 (ref)
        v40 = v40 * v27.SpeedMod;
        v39 = v39 + v40;
        if not v27.DoorModel.PrimaryPart then
            if v27.TweenCleanUp then
                v27.TweenCleanUp();
            end;
            return true;
        else
            if v35 <= v39 then
                local v41 = math.clamp((v39 - v35) / v29.AnimationLength, 0, 1);
                local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v41, v32, v33);
                local v43 = v27.AnimationData.Offsets[v27.State][v27.Direction];
                local v44 = v27.HomeCFrame * v43;
                v27.DoorModel:PivotTo(l_CFrame_0:Lerp(v44, l_l_TweenService_0_Value_0));
            end;
            if v38 <= v39 and not v37 then
                v37 = true;
                v36:Play();
            end;
            if v34 <= v39 then
                v27.TweenCleanUp();
                return true;
            else
                return false;
            end;
        end;
    end;
end;
v8.new = function(v46, v47, v48) --[[ Line: 163 ]] --[[ Name: new ]]
    -- upvalues: v23 (copy), v3 (copy), v45 (copy), v8 (copy)
    local v49 = {
        Type = "Door", 
        Id = v46, 
        Instance = v47, 
        DecalPart = v47.PrimaryPart
    };
    v49.Decal = v49.DecalPart:WaitForChild("Decal", 0.1);
    v49.DoorModel = v47:WaitForChild("Door");
    v49.InteractModel = v47:FindFirstChild("Interact Point", true);
    v49.HingePart = v49.DoorModel.PrimaryPart;
    v49.LockedDoor = v49.Instance:GetAttribute("Cosmetic");
    v49.AnimationData = v23(v49, v47);
    v49.HomeCFrame = v49.HingePart.CFrame;
    v49.Maid = v3.new();
    v49.Maid:Give(v48:GetAttributeChangedSignal("State"):Connect(function() --[[ Line: 181 ]]
        -- upvalues: v49 (copy), v48 (copy), v45 (ref)
        v49.State = v48:GetAttribute("State");
        v45(v49);
    end));
    v49.Maid:Give(v48:GetAttributeChangedSignal("Speed"):Connect(function() --[[ Line: 187 ]]
        -- upvalues: v49 (copy), v48 (copy)
        v49.SpeedMod = v48:GetAttribute("Speed");
    end));
    v49.Maid:Give(v48:GetAttributeChangedSignal("Direction"):Connect(function() --[[ Line: 192 ]]
        -- upvalues: v49 (copy), v48 (copy)
        v49.Direction = v48:GetAttribute("Direction");
    end));
    v49.State = v48:GetAttribute("State");
    v49.Direction = v48:GetAttribute("Direction");
    v49.SpeedMod = v48:GetAttribute("Speed");
    local l_DecalPart_1 = v49.DecalPart;
    l_DecalPart_1.Transparency = 1;
    l_DecalPart_1.CanCollide = false;
    l_DecalPart_1.TopSurface = Enum.SurfaceType.Smooth;
    l_DecalPart_1.BottomSurface = Enum.SurfaceType.Smooth;
    l_DecalPart_1.Parent = v49.DoorModel;
    if v49.Decal then
        v49.Decal.Transparency = 1;
    end;
    v49.HingePart.Transparency = 1;
    v49.HingePart.CanCollide = false;
    v49.DoorModel.WorldPivot = v49.HingePart.CFrame;
    l_DecalPart_1 = v49.AnimationData.Offsets[v49.State][v49.Direction];
    local v51 = v49.HomeCFrame * l_DecalPart_1;
    v49.DoorModel:PivotTo(v51);
    return (setmetatable(v49, v8));
end;
v8.Destroy = function(v52) --[[ Line: 212 ]] --[[ Name: Destroy ]]
    if v52.Destroyed then
        return;
    else
        v52.Destroyed = true;
        if v52.TweenCleanUp then
            v52.TweenCleanUp();
        end;
        if v52.Maid then
            v52.Maid:Destroy();
            v52.Maid = nil;
        end;
        setmetatable(v52, nil);
        table.clear(v52);
        v52.Destroyed = true;
        return;
    end;
end;
v8.GetInteractionPosition = function(v53, _, _) --[[ Line: 234 ]] --[[ Name: GetInteractionPosition ]]
    if v53.InteractModel and v53.InteractModel.PrimaryPart then
        local l_CFrame_1 = v53.InteractModel.PrimaryPart.CFrame;
        local v57 = l_CFrame_1:ToObjectSpace(workspace.CurrentCamera.CFrame);
        local v58 = v53.InteractModel.PrimaryPart.Size * Vector3.new(0, 0, 0.5, 0);
        if v57.Z < 0 then
            v58 = -v58;
        end;
        return l_CFrame_1 * v58;
    else
        return v53.DecalPart.CFrame.p;
    end;
end;
v8.Interact = function(v59) --[[ Line: 251 ]] --[[ Name: Interact ]]
    -- upvalues: v2 (copy)
    if not v59.LockedDoor then
        v2:Send("World Interact", v59.Id);
    end;
end;
v8.SetDetailed = function(v60, v61) --[[ Line: 257 ]] --[[ Name: SetDetailed ]]
    for _, v63 in next, v60.Instance:GetDescendants() do
        if v63:IsA("BasePart") then
            v63.LocalTransparencyModifier = v61 and 0 or 1;
        end;
    end;
    if v60.Decal then
        v60.Decal.Transparency = v61 and 1 or 0;
    end;
end;
v8.IsTweening = function(v64) --[[ Line: 269 ]] --[[ Name: IsTweening ]]
    -- upvalues: v9 (copy)
    if v9[v64.Id] then
        return true;
    else
        return false;
    end;
end;
l_RunService_0.Heartbeat:Connect(function(v65) --[[ Line: 279 ]]
    -- upvalues: v9 (copy)
    debug.profilebegin("Door animation tweens");
    for v66, v67 in next, v9 do
        if v67(v65) then
            v9[v66] = nil;
        end;
    end;
    debug.profileend();
end);
return v8;