local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "Globals");
local v2 = v0.require("Configs", "Animators");
local v3 = v0.require("Libraries", "Network");
local v4 = v0.require("Libraries", "Resources");
local v5 = v0.require("Libraries", "UserSettings");
local v6 = v0.require("Classes", "Steppers");
local v7 = v0.require("Classes", "Signals");
local v8 = v0.require("Classes", "Maids");
local _ = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local v12 = v4:Find("ReplicatedStorage.Client.Abstracts.Animators");
local v13 = 60;
local v14 = 150;
local v15 = 0.0020833333333333333;
local v16 = 0.1;
local l_AutoBindConfig_0 = v2.AutoBindConfig;
local l_NIL_0 = v2.NIL;
local v19 = {};
v19.__index = v19;
local v20 = {};
local v21 = {};
local v22 = CFrame.new();
local v23 = {};
local v24 = {
    Wait = function() --[[ Line: 42 ]] --[[ Name: Wait ]]
        return true;
    end, 
    Connect = function() --[[ Line: 46 ]] --[[ Name: Connect ]]
        return {
            Disconnect = function() --[[ Line: 48 ]] --[[ Name: Disconnect ]]

            end
        };
    end
};
local function v29() --[[ Line: 57 ]] --[[ Name: preloadAnimations ]]
    -- upvalues: v4 (copy), l_ContentProvider_0 (copy)
    local v25 = v4:Find("ReplicatedStorage.Assets.Animations");
    local v26 = {};
    for _, v28 in next, v25:GetDescendants() do
        if v28:IsA("Animation") then
            table.insert(v26, v28);
        end;
    end;
    l_ContentProvider_0:PreloadAsync(v26);
end;
local v30 = nil;
local v31 = 0;
do
    local l_v31_0 = v31;
    v30 = function(v33) --[[ Line: 74 ]] --[[ Name: getRenderId ]]
        -- upvalues: l_v31_0 (ref)
        l_v31_0 = l_v31_0 + 1;
        return v33.Instance.Name .. " Render Step " .. l_v31_0;
    end;
end;
v31 = function(v34, v35, v36, v37, v38) --[[ Line: 81 ]] --[[ Name: remap ]]
    return v37 + (v38 - v37) * ((v34 - v35) / (v36 - v35));
end;
local function v39(v40) --[[ Line: 85 ]] --[[ Name: copyTable ]]
    -- upvalues: v39 (copy)
    local v41 = {};
    for v42, v43 in next, v40 do
        if typeof(v43) == "table" then
            v43 = v39(v43);
        end;
        v41[v42] = v43;
    end;
    return v41;
end;
local function v48(v44, v45) --[[ Line: 99 ]] --[[ Name: findAnimator ]]
    -- upvalues: l_AutoBindConfig_0 (copy)
    local v46 = v44:WaitForChild(l_AutoBindConfig_0[v45].AnimationControllerType or "", 5);
    if not v44.Parent:IsA("WorldModel") and v46 and not v46:IsDescendantOf(workspace) then
        repeat
            v46.AncestryChanged:Wait();
        until v46:IsDescendantOf(workspace);
    end;
    if v46 then
        local l_Animator_0 = v46:FindFirstChild("Animator");
        if l_Animator_0 then
            l_Animator_0:Destroy();
        end;
        l_Animator_0 = Instance.new("Animator");
        l_Animator_0.Parent = v46;
        return l_Animator_0;
    else
        return nil;
    end;
end;
local function v49(v50) --[[ Line: 127 ]] --[[ Name: nilCorrection ]]
    -- upvalues: v49 (copy), l_NIL_0 (copy)
    local v51 = {};
    for v52, v53 in next, v50 do
        if typeof(v53) == "table" then
            v49(v53);
        elseif v53 == l_NIL_0 then
            table.insert(v51, v52);
        end;
    end;
    for _, v55 in next, v51 do
        v50[v55] = nil;
    end;
    return v50;
end;
local _ = function(v56, _) --[[ Line: 145 ]] --[[ Name: buildStatesList ]]
    -- upvalues: v2 (copy), v49 (copy), v39 (copy)
    local v58 = v2.ConfigTemplates[v56.Type];
    return (v49((v39(v58))));
end;
local function v69(v60, v61) --[[ Line: 152 ]] --[[ Name: stepAnimator ]]
    -- upvalues: l_AutoBindConfig_0 (copy), v2 (copy), v22 (ref), v13 (ref), v14 (ref), v15 (ref), v16 (ref)
    if l_AutoBindConfig_0[v60.Type].Bin then
        local v62, v63, v64 = v2.canSleep(v60.Type, v60.Instance, v22);
        v60.DistanceToCamera = v63;
        v60.VisibleToCamera = v64;
        if v60.Sleeping ~= v62 then
            v60.Sleeping = v62;
            if v60.Sleeping then
                v60.Slept:Fire();
            else
                v60.Woken:Fire();
            end;
        end;
    end;
    if not v60.Sleeping then
        v60.DeltaStack = v60.DeltaStack + v61;
        local l_DistanceToCamera_0 = v60.DistanceToCamera;
        local l_v13_0 = v13;
        local l_v14_0 = v14;
        local l_v15_0 = v15;
        if math.clamp(l_v15_0 + (v16 - l_v15_0) * ((l_DistanceToCamera_0 - l_v13_0) / (l_v14_0 - l_v13_0)), v15, v16) <= v60.DeltaStack then
            debug.profilebegin(v60.Type .. " Animator Step");
            v60.RawStepFunction(v60.DeltaStack);
            debug.profileend();
            v60.DeltaStack = 0;
            return;
        end;
    else
        v60.DeltaStack = 0;
    end;
end;
v19.new = function(v70, v71, v72) --[[ Line: 214 ]] --[[ Name: new ]]
    -- upvalues: v20 (copy), v21 (copy), v7 (copy), v19 (copy), v48 (copy), v8 (copy), v12 (copy), v2 (copy), v49 (copy), v39 (copy), l_RunService_0 (copy), v69 (copy)
    if v20[v70] then
        return v20[v70];
    elseif v21[v70] then
        return v21[v70]:Wait();
    elseif v70 == nil then
        return;
    else
        v21[v70] = v7.new();
        local v73 = setmetatable({}, v19);
        v73.Parent = v72;
        v73.ClassName = "Animator";
        v73.Type = v71;
        v73.IsNetworked = true;
        v73.Instance = v70;
        v73.Animator = v48(v70, v71);
        v73.Maid = v8.new();
        v73.AnimationPlayed = v73.Maid:Give(v7.new());
        v73.StateChanged = v73.Maid:Give(v7.new());
        v73.Slept = v73.Maid:Give(v7.new());
        v73.Woken = v73.Maid:Give(v7.new());
        v73.LastSleep = 0;
        v73.DeltaStack = 0;
        v73.Sleeping = false;
        v73.SleepingBlockedFor = 10;
        v73.DistanceToCamera = 10;
        v73.VisibleToCamera = true;
        v73.Animations = {};
        v73.AnimationTags = {};
        v73.States = {};
        v73.Actions = {};
        while not v70.PrimaryPart do
            v70:GetPropertyChangedSignal("PrimaryPart"):Wait();
        end;
        v73.BasePart = v70.PrimaryPart;
        local v74 = v12:WaitForChild(v71);
        local v75 = v2.ConfigTemplates[v73.Type];
        v73.States = v49((v39(v75)));
        v73.RawStepFunction = require(v74)(v73);
        v73.Maid["Main Step"] = l_RunService_0.Heartbeat:Connect(function(v76) --[[ Line: 271 ]]
            -- upvalues: v69 (ref), v73 (copy)
            v69(v73, v76);
        end);
        v20[v70] = v73;
        v21[v70]:Fire(v73);
        v21[v70]:Destroy();
        v21[v70] = nil;
        return v73;
    end;
end;
v19.find = function(v77) --[[ Line: 285 ]] --[[ Name: find ]]
    -- upvalues: v20 (copy)
    return v20[v77];
end;
v19.get = function(v78, v79) --[[ Line: 289 ]] --[[ Name: get ]]
    -- upvalues: v19 (copy)
    return v19.find(v78) or v19.new(v78, v79);
end;
v19.Destroy = function(v80) --[[ Line: 295 ]] --[[ Name: Destroy ]]
    -- upvalues: v20 (copy)
    if v80.Destroyed then
        return;
    else
        v80.Destroyed = true;
        if v80.Animations then
            local v81 = {};
            for v82, _ in next, v80.Animations do
                table.insert(v81, v82);
            end;
            for _, v85 in next, v81 do
                v80:StopAnimation(v85, 0);
            end;
        end;
        v20[v80.Instance] = nil;
        if v80.Maid then
            v80.Maid:Destroy();
        end;
        setmetatable(v80, nil);
        table.clear(v80);
        return;
    end;
end;
v19.TakeLocalControl = function(v86, v87) --[[ Line: 324 ]] --[[ Name: TakeLocalControl ]]
    -- upvalues: v30 (ref), l_RunService_0 (copy), v69 (copy)
    local v88 = v30(v86);
    v86.IsNetworked = false;
    v86.Parent = v87;
    v86.Maid:CleanIndex("Main Step");
    v86.Maid:CleanIndex("Render Step");
    v86.Maid["Render Step"] = function() --[[ Line: 335 ]]
        -- upvalues: l_RunService_0 (ref), v88 (copy)
        l_RunService_0:UnbindFromRenderStep(v88);
    end;
    l_RunService_0:BindToRenderStep(v88, 30, function(v89) --[[ Line: 339 ]]
        -- upvalues: v69 (ref), v86 (copy)
        v69(v86, v89);
    end);
end;
v19.BindToState = function(v90, v91, v92) --[[ Line: 344 ]] --[[ Name: BindToState ]]
    return v90.StateChanged:Connect(function(v93, v94, v95) --[[ Line: 345 ]]
        -- upvalues: v91 (copy), v92 (copy)
        if v91 == v93 then
            v92(v94, v95);
        end;
    end);
end;
v19.RefreshState = function(v96, v97) --[[ Line: 352 ]] --[[ Name: RefreshState ]]
    -- upvalues: v2 (copy)
    local v98 = v2.ConfigTemplates[v96.Type][v97];
    local v99 = v96.States[v97];
    v96.StateChanged:Fire(v97, v99, v98);
end;
v19.GetState = function(v100, v101) --[[ Line: 359 ]] --[[ Name: GetState ]]
    return v100.States[v101];
end;
v19.SetState = function(v102, v103, v104, v105) --[[ Line: 363 ]] --[[ Name: SetState ]]
    -- upvalues: l_NIL_0 (copy)
    local v106 = v102.States[v103];
    if v104 == l_NIL_0 then
        v104 = nil;
    end;
    if (v105 or v106 ~= v104) and not v102.Sleeping then
        v102.States[v103] = v104;
        if v102.StateChanged then
            v102.StateChanged:Fire(v103, v104, v106);
        end;
    end;
end;
v19.RunAction = function(v107, v108, ...) --[[ Line: 379 ]] --[[ Name: RunAction ]]
    local v109 = v107.Actions[v108];
    if v109 and not v107.Sleeping then
        return v109(...);
    else
        if v109 == nil then
            warn("Invalid Animator Action:", v108);
        end;
        return nil;
    end;
end;
v19.SetAction = function(v110, v111, v112) --[[ Line: 392 ]] --[[ Name: SetAction ]]
    if v110.Actions[v111] then
        warn("Animator Action Overlap:", v111);
    end;
    v110.Actions[v111] = v112;
end;
v19.GetTrack = function(v113, v114) --[[ Line: 400 ]] --[[ Name: GetTrack ]]
    local v115 = v113.Animations[v114];
    if v115 then
        return v115;
    else
        return nil;
    end;
end;
v19.IsAnimationPlaying = function(v116, ...) --[[ Line: 410 ]] --[[ Name: IsAnimationPlaying ]]
    for _, v118 in next, {
        ...
    } do
        local v119 = v116.Animations[v118];
        if v119 and v119.IsPlaying then
            return true;
        end;
    end;
    return false;
end;
v19.IsAnimationPlayingWithTag = function(v120, ...) --[[ Line: 422 ]] --[[ Name: IsAnimationPlayingWithTag ]]
    for _, v122 in next, {
        ...
    } do
        if v120.AnimationTags[v122] and next(v120.AnimationTags[v122]) then
            return true;
        end;
    end;
    return false;
end;
v19.PlayAnimation = function(v123, v124, v125, v126, v127) --[[ Line: 434 ]] --[[ Name: PlayAnimation ]]
    -- upvalues: v4 (copy), v24 (copy)
    if v123.Destroyed then
        return;
    else
        if v123.Animations[v124] == nil and v123.Animator and v123.Animator.Parent then
            local v128 = v4:Search("ReplicatedStorage.Assets.Animations." .. v124);
            if v128 then
                v123.Animations[v124] = v123.Animator:LoadAnimation(v128);
                for _, v130 in next, v128:GetChildren() do
                    if v123.AnimationTags[v130.Name] == nil then
                        v123.AnimationTags[v130.Name] = {};
                    end;
                    v123.AnimationTags[v130.Name][v124] = true;
                end;
                v123.Animations[v124].Stopped:Connect(function() --[[ Line: 457 ]]
                    -- upvalues: v123 (copy), v124 (copy)
                    v123.Animations[v124]:Destroy();
                    v123.Animations[v124] = nil;
                    for v131, v132 in next, v123.AnimationTags do
                        v132[v124] = nil;
                        if not next(v132) then
                            v123.AnimationTags[v131] = nil;
                        end;
                    end;
                end);
            else
                warn("Animation ", v124, "is not a valid animation");
            end;
        end;
        if v123.Animations[v124] then
            v123.Animations[v124]:Play(v125, v127, v126);
            v123.AnimationPlayed:Fire(v124, v123.Animations[v124]);
            return v123.Animations[v124].Stopped;
        else
            return v24;
        end;
    end;
end;
v19.StopAnimation = function(v133, v134, v135) --[[ Line: 485 ]] --[[ Name: StopAnimation ]]
    if v133.Animations[v134] then
        v133.Animations[v134]:Stop(v135);
    end;
end;
v19.SetAnimationWeight = function(v136, v137, v138, v139) --[[ Line: 491 ]] --[[ Name: SetAnimationWeight ]]
    if v136.Animations[v137] then
        v136.Animations[v137]:AdjustWeight(v138, v139);
    end;
end;
v19.SetAnimationSpeed = function(v140, v141, v142) --[[ Line: 497 ]] --[[ Name: SetAnimationSpeed ]]
    if v140.Animations[v141] then
        v140.Animations[v141]:AdjustSpeed(v142);
    end;
end;
v3:Add("Animator States Update", function(v143, v144) --[[ Line: 505 ]]
    -- upvalues: v19 (copy)
    local v145 = v19.find(v143);
    if v145 then
        for v146, v147 in next, v144 do
            v145:SetState(v146, v147);
        end;
    end;
end);
v3:Add("Animator Action Run", function(v148, v149, ...) --[[ Line: 515 ]]
    -- upvalues: v19 (copy)
    local v150 = v19.find(v148);
    if v150 then
        v150:RunAction(v149, ...);
    end;
end);
v6.new(0.3333333333333333, "Heartbeat", function() --[[ Line: 523 ]]
    -- upvalues: v23 (copy), v22 (ref), v3 (copy)
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local v152 = 0;
    local v153 = #v23;
    v22 = l_CurrentCamera_0.CFrame;
    if v153 > 0 then
        for _, v155 in next, v23 do
            v152 = v152 + v155;
        end;
        v152 = v152 / v153;
    end;
    table.clear(v23);
    v3:Send("Camera Report", v22, l_CurrentCamera_0.Name, v152);
end);
l_RunService_0.RenderStepped:Connect(function(v156) --[[ Line: 542 ]]
    -- upvalues: v23 (copy)
    table.insert(v23, 1 / v156);
end);
v5:BindToSetting("Game Quality", "Animation", function(v157) --[[ Line: 546 ]]
    -- upvalues: v13 (ref), v14 (ref), v15 (ref), v16 (ref)
    if v157 == "High" then
        v13 = 300;
        v14 = 600;
        v15 = 0.0020833333333333333;
        v16 = 0.03333333333333333;
        return;
    elseif v157 == "Low" then
        v13 = 50;
        v14 = 100;
        v15 = 0.016666666666666666;
        v16 = 0.1;
        return;
    else
        v13 = 60;
        v14 = 150;
        v15 = 0.0020833333333333333;
        v16 = 0.1;
        return;
    end;
end);
for v158, v159 in next, l_AutoBindConfig_0 do
    if v159.Bin then
        v159.Bin.ChildAdded:Connect(function(v160) --[[ Line: 572 ]]
            -- upvalues: v19 (copy), v158 (copy)
            v19.new(v160, v158);
        end);
        v159.Bin.ChildRemoved:Connect(function(v161) --[[ Line: 576 ]]
            -- upvalues: v19 (copy)
            local v162 = v19.find(v161);
            if v162 then
                v162:Destroy();
            end;
        end);
        for _, v164 in next, v159.Bin:GetChildren() do
            coroutine.wrap(v19.new)(v164, v158);
        end;
    end;
end;
coroutine.wrap(v29)();
v3:Send("Animator Ready");
return v19;