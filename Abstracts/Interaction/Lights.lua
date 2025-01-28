local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Maids");
local _ = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v7 = {};
v7.__index = v7;
local function v15(v8) --[[ Line: 19 ]] --[[ Name: getLights ]]
    -- upvalues: l_CollectionService_0 (copy)
    local v9 = {};
    local v10 = {};
    for _, v12 in next, v8:GetDescendants() do
        if v12:IsA("Light") then
            table.insert(v9, v12);
        end;
    end;
    for _, v14 in next, v8:GetDescendants() do
        if v14:IsA("BasePart") and v14:FindFirstChild("ColorOn") then
            l_CollectionService_0:AddTag(v14, "Interact Ignores");
            table.insert(v10, v14);
        end;
    end;
    return v9, v10;
end;
local function v21(v16) --[[ Line: 39 ]] --[[ Name: getRegionStateFolder ]]
    -- upvalues: v1 (copy)
    local v17 = v1:Find("Workspace.Map.Shared.Powered.Regions");
    local l_Attribute_0 = v16.States:GetAttribute("Region");
    for _, v20 in next, v17:GetChildren() do
        if v20.Name == l_Attribute_0 then
            return v20;
        end;
    end;
    return v1:Find("Workspace.Map.Shared.Powered.Regions.Wilderness");
end;
local function v28(v22) --[[ Line: 52 ]] --[[ Name: weldSwitch ]]
    local l_PrimaryPart_0 = v22.PrimaryPart;
    local l_Pivot_0 = v22.Pivot;
    for _, v26 in next, v22:GetDescendants() do
        if v26:IsA("BasePart") and v26 ~= l_PrimaryPart_0 and v26 ~= l_Pivot_0 then
            local l_Weld_0 = Instance.new("Weld");
            l_Weld_0.C0 = l_Pivot_0.CFrame:ToObjectSpace(v26.CFrame);
            l_Weld_0.Part0 = l_Pivot_0;
            l_Weld_0.Part1 = v26;
            l_Weld_0.Parent = v26;
            v26.Anchored = false;
        end;
    end;
end;
local function v39(v29, v30) --[[ Line: 69 ]] --[[ Name: getSwitches ]]
    -- upvalues: v28 (copy)
    local v31 = {};
    for _, v33 in next, v29.Instance:GetChildren() do
        if v33:IsA("Model") then
            local l_v33_FirstChild_0 = v33:FindFirstChild("Interact Point");
            local l_Position_0 = v33.PrimaryPart.Position;
            local v36 = nil;
            for _, v38 in next, v30.Switches:GetChildren() do
                if (v38:GetAttribute("Position") - l_Position_0).Magnitude < 1 then
                    v36 = v38;
                end;
            end;
            if v36 then
                table.insert(v31, {
                    Position = l_Position_0, 
                    InteractPart = l_v33_FirstChild_0, 
                    Instance = v33, 
                    States = v36, 
                    PivotOriginCF = v33.Pivot.CFrame, 
                    Animating = false, 
                    AnimationQueue = {}
                });
                v28(v33);
            end;
        end;
    end;
    return v31;
end;
local function v43(v40) --[[ Line: 108 ]] --[[ Name: prepModel ]]
    for _, v42 in next, v40.Instance:GetChildren() do
        if v42:IsA("Model") then
            v42.Pivot.Transparency = 1;
            v42.Pivot.CanCollide = false;
        end;
    end;
end;
local function v54(v44, v45, v46) --[[ Line: 117 ]] --[[ Name: setLights ]]
    local v47 = v46 == "On";
    if not v45 then
        v47 = false;
    end;
    for _, v49 in next, v44.Lights do
        v49.Enabled = v47;
    end;
    for _, v51 in next, v44.Parts do
        local v52 = "ColorOff";
        if v47 then
            v52 = "ColorOn";
        end;
        local l_v51_FirstChild_0 = v51:FindFirstChild(v52);
        if l_v51_FirstChild_0 then
            v51.Color = l_v51_FirstChild_0.Value;
        end;
        if v47 then
            v51.Material = Enum.Material.Neon;
        else
            v51.Material = Enum.Material.Glass;
        end;
    end;
end;
local function v58(v55, v56) --[[ Line: 149 ]] --[[ Name: playSound ]]
    -- upvalues: v1 (copy), v0 (copy)
    if v56 ~= "" then
        local v57 = v1:Get("ReplicatedStorage.Assets.Sounds." .. v56);
        v57.Parent = v55.Instance.PrimaryPart;
        v57.Ended:Connect(function() --[[ Line: 154 ]]
            -- upvalues: v0 (ref), v57 (copy)
            v0.destroy(v57, "Ended");
        end);
        v57:Play();
    end;
end;
local function _(v59) --[[ Line: 162 ]] --[[ Name: initSwitchPosition ]]
    if not v59.Instance.Animation.ReturnsNeutral.Value then
        local l_Attribute_1 = v59.States:GetAttribute("State");
        local v61 = v59.Instance.Pivot[l_Attribute_1];
        v59.Instance.Pivot.CFrame = v59.PivotOriginCF * v61.CFrame;
    end;
end;
local function v63(v64, v65) --[[ Line: 174 ]] --[[ Name: processAnimationQueue ]]
    -- upvalues: l_TweenService_0 (copy), v63 (copy), v0 (copy)
    local v66 = v64.Animating == false;
    if v65 then
        v66 = true;
    end;
    if v64.Destroyed then
        v66 = false;
    end;
    if v66 then
        local v67 = table.remove(v64.AnimationQueue, 1);
        if v67 then
            local v68 = TweenInfo.new(v67.Length, Enum.EasingStyle.Linear);
            local v69 = l_TweenService_0:Create(v64.Instance.Pivot, v68, v67.Goal);
            v69.Completed:Connect(function() --[[ Line: 192 ]]
                -- upvalues: v67 (copy), v63 (ref), v64 (copy), v0 (ref), v69 (copy)
                if v67.OnEnd then
                    v67.OnEnd();
                end;
                v63(v64, true);
                v0.destroy(v69, "Completed");
            end);
            if v67.OnStart then
                v67.OnStart();
            end;
            v69:Play();
            v64.Animating = true;
            return;
        else
            v64.Animating = false;
        end;
    end;
end;
local function v75(v70) --[[ Line: 214 ]] --[[ Name: animateSwitchState ]]
    -- upvalues: v58 (copy), v63 (copy)
    local l_Animation_0 = v70.Instance.Animation;
    local l_Value_0 = l_Animation_0.ReturnsNeutral.Value;
    local l_Attribute_2 = v70.States:GetAttribute("State");
    local v74 = v70.Instance.Pivot[l_Attribute_2];
    table.insert(v70.AnimationQueue, {
        Goal = {
            CFrame = v70.PivotOriginCF * v74.CFrame
        }, 
        Length = l_Animation_0.Durration.Value, 
        OnStart = function() --[[ Line: 225 ]] --[[ Name: OnStart ]]
            -- upvalues: v58 (ref), v70 (copy), l_Animation_0 (copy)
            v58(v70, l_Animation_0.StartSound.Value);
        end, 
        OnEnd = function() --[[ Line: 229 ]] --[[ Name: OnEnd ]]
            -- upvalues: l_Value_0 (copy), v58 (ref), v70 (copy), l_Animation_0 (copy)
            if not l_Value_0 then
                v58(v70, l_Animation_0.EndSound.Value);
            end;
        end
    });
    if l_Value_0 then
        if l_Animation_0.ReturnDelay.Value > 0 then
            table.insert(v70.AnimationQueue, {
                Goal = {
                    CFrame = v70.PivotOriginCF * v74.CFrame
                }, 
                Length = l_Animation_0.ReturnDelay.Value
            });
        end;
        table.insert(v70.AnimationQueue, {
            Goal = {
                CFrame = v70.PivotOriginCF * v70.Instance.Pivot.Neutral.CFrame
            }, 
            Length = l_Animation_0.Durration.Value, 
            OnStart = function() --[[ Line: 248 ]] --[[ Name: OnStart ]]
                -- upvalues: v58 (ref), v70 (copy), l_Animation_0 (copy)
                v58(v70, l_Animation_0.ReturnStartSound.Value);
            end, 
            OnEnd = function() --[[ Line: 252 ]] --[[ Name: OnEnd ]]
                -- upvalues: v58 (ref), v70 (copy), l_Animation_0 (copy)
                v58(v70, l_Animation_0.EndSound.Value);
            end
        });
    end;
    v63(v70);
end;
v7.new = function(v76, v77, v78) --[[ Line: 263 ]] --[[ Name: new ]]
    -- upvalues: v15 (copy), v39 (copy), v21 (copy), v43 (copy), v54 (copy), v3 (copy), v75 (copy), v7 (copy)
    local v79 = {
        Type = "Light", 
        Id = v76, 
        Destroyed = false, 
        States = v78, 
        Instance = v77, 
        LightsFolder = v77:WaitForChild("Light Parts")
    };
    local v80, v81 = v15(v79.LightsFolder);
    v79.Lights = v80;
    v79.Parts = v81;
    v79.Switches = v39(v79, v78);
    v79.RegionState = v21(v79);
    v43(v79);
    v54(v79, v79.RegionState:GetAttribute("Powered"), v78:GetAttribute("State"));
    v79.Maid = v3.new();
    v79.Maid:Give(v78:GetAttributeChangedSignal("State"):Connect(function() --[[ Line: 291 ]]
        -- upvalues: v79 (copy), v78 (copy), v54 (ref)
        local l_Attribute_3 = v79.RegionState:GetAttribute("Powered");
        local l_v78_Attribute_0 = v78:GetAttribute("State");
        v54(v79, l_Attribute_3, l_v78_Attribute_0);
    end));
    v79.Maid:Give(v79.RegionState:GetAttributeChangedSignal("Powered"):Connect(function() --[[ Line: 298 ]]
        -- upvalues: v79 (copy), v78 (copy), v54 (ref)
        local l_Attribute_4 = v79.RegionState:GetAttribute("Powered");
        local l_v78_Attribute_1 = v78:GetAttribute("State");
        v54(v79, l_Attribute_4, l_v78_Attribute_1);
    end));
    for _, v87 in next, v79.Switches do
        v79.Maid:Give(v87.States:GetAttributeChangedSignal("State"):Connect(function() --[[ Line: 306 ]]
            -- upvalues: v75 (ref), v87 (copy)
            v75(v87);
        end));
        if not v87.Instance.Animation.ReturnsNeutral.Value then
            local l_Attribute_5 = v87.States:GetAttribute("State");
            local v89 = v87.Instance.Pivot[l_Attribute_5];
            v87.Instance.Pivot.CFrame = v87.PivotOriginCF * v89.CFrame;
        end;
    end;
    return (setmetatable(v79, v7));
end;
v7.Destroy = function(v90) --[[ Line: 320 ]] --[[ Name: Destroy ]]
    if v90.Destroyed then
        return;
    else
        v90.Destroyed = true;
        if v90.Maid then
            v90.Maid:Destroy();
            v90.Maid = nil;
        end;
        setmetatable(v90, nil);
        table.clear(v90);
        v90.Destroyed = true;
        return;
    end;
end;
v7.GetInteractionPosition = function(v91, v92, _) --[[ Line: 338 ]] --[[ Name: GetInteractionPosition ]]
    for _, v95 in next, v91.Switches do
        if v92:IsDescendantOf(v95.Instance) then
            if v95.InteractPart then
                return v95.InteractPart.Position;
            else
                return v95.Position;
            end;
        end;
    end;
    return nil;
end;
v7.GetSwitchState = function(v96, _, _) --[[ Line: 352 ]] --[[ Name: GetSwitchState ]]
    return v96.States:GetAttribute("State");
end;
v7.Interact = function(v99, v100) --[[ Line: 362 ]] --[[ Name: Interact ]]
    -- upvalues: v2 (copy)
    local v101 = 1e999;
    local v102 = nil;
    for _, v104 in next, v99.Switches do
        local l_Magnitude_0 = (v100 - v104.Position).Magnitude;
        if l_Magnitude_0 < v101 then
            v102 = v104;
            v101 = l_Magnitude_0;
        end;
    end;
    if v102 and not v102.Animating then
        v2:Send("World Interact", v99.Id, v102.States:GetAttribute("Id"));
    end;
end;
v7.SetDetailed = function(_, _) --[[ Line: 380 ]] --[[ Name: SetDetailed ]]

end;
return v7;