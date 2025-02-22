local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local v2 = v0.require("Classes", "Steppers");
local v3 = v0.require("Classes", "Springs");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Elastic_0 = Enum.EasingStyle.Elastic;
local l_Quad_0 = Enum.EasingStyle.Quad;
local l_Out_0 = Enum.EasingDirection.Out;
local v9 = {};
v9.__index = v9;
local function v15() --[[ Line: 30 ]] --[[ Name: isMuffled ]]
    local l_Position_0 = workspace.CurrentCamera.Focus.Position;
    local l_HeartbeatVolume_0 = workspace.Effects.HeartbeatVolume;
    local v12 = l_HeartbeatVolume_0.CFrame:PointToObjectSpace(l_Position_0);
    local v13 = l_HeartbeatVolume_0.Size * 0.5;
    local v14 = false;
    if math.abs(v12.X) <= v13.X then
        v14 = false;
        if math.abs(v12.Y) <= v13.Y then
            v14 = math.abs(v12.Z) <= v13.Z;
        end;
    end;
    return not v14;
end;
local function v20(v16, v17) --[[ Line: 44 ]] --[[ Name: shakeCamera ]]
    -- upvalues: v0 (copy)
    local l_Camera_0 = v0.Libraries.Cameras:GetCamera("Character");
    if l_Camera_0 then
        local v19 = (1 - math.clamp((v16.Parts.Heart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude / 65, 0, 1)) * 30 * v17;
        l_Camera_0:Flinch(v16.Parts.Heart.Position, v19, true);
    end;
end;
local function v30(v21, v22, v23, v24, v25, v26) --[[ Line: 58 ]] --[[ Name: tween ]]
    -- upvalues: l_TweenService_0 (copy)
    local v27 = nil;
    if v21.Parts and v21.Parts[v22] then
        v27 = v21.Parts[v22];
    end;
    if v27 then
        local v28 = l_TweenService_0:Create(v27, TweenInfo.new(v23, v24, v25), v26);
        v28:Play();
        return v28.Completed;
    else
        return {
            Wait = function() --[[ Line: 77 ]] --[[ Name: Wait ]]

            end, 
            Connect = function(v29) --[[ Line: 81 ]] --[[ Name: Connect ]]
                v29();
            end
        };
    end;
end;
local function _(v31) --[[ Line: 88 ]] --[[ Name: yield ]]
    if typeof(v31) == "number" then
        return task.wait(v31);
    elseif typeof(v31) == "RBXScriptSignal" then
        return v31:Wait();
    else
        return coroutine.yield();
    end;
end;
local function v36(v33) --[[ Line: 100 ]] --[[ Name: prepModel ]]
    v33.Parts = {
        Heart = v33.Instance:WaitForChild("Heart"), 
        Orientation = v33.Instance:WaitForChild("Orientation"), 
        LeftArtery = v33.Instance:WaitForChild("Left Artery"), 
        RightArtery = v33.Instance:WaitForChild("Right Artery"), 
        Stem1 = v33.Instance:WaitForChild("Stem 1"), 
        Stem2 = v33.Instance:WaitForChild("Stem 2"), 
        Stem3 = v33.Instance:WaitForChild("Stem 3"), 
        Stem1Target = v33.Instance:WaitForChild("Stem 1 Target"), 
        Stem2Target = v33.Instance:WaitForChild("Stem 2 Target"), 
        Stem3Target = v33.Instance:WaitForChild("Stem 3 Target")
    };
    v33.Parts.Orientation.Transparency = 1;
    v33.Parts.Stem1Target.Transparency = 1;
    v33.Parts.Stem2Target.Transparency = 1;
    v33.Parts.Stem3Target.Transparency = 1;
    v33.BasePose = {};
    for v34, v35 in next, v33.Parts do
        v33.BasePose[v34] = {
            CFrame = v35.CFrame, 
            Size = v35.Size
        };
    end;
end;
local function v66(v37) --[[ Line: 131 ]] --[[ Name: heartPump ]]
    -- upvalues: v3 (copy), l_RunService_0 (copy), v15 (copy), v20 (copy)
    local v38 = v3.new(0, 5, 0.8);
    local v39 = v3.new(5, 3, 1);
    local v40 = nil;
    local v41 = 0;
    local v42 = os.clock();
    local _ = function(v43, v44, v45, v46) --[[ Line: 139 ]] --[[ Name: target ]]
        -- upvalues: v41 (ref), v39 (copy), v38 (copy)
        v41 = v43;
        v39:SetGoal(v44);
        v38.d = v45 or v38.d;
        if typeof(v46) == "number" then
            local _ = task.wait(v46);
            return;
        elseif typeof(v46) == "RBXScriptSignal" then
            local _ = v46:Wait();
            return;
        else
            local _ = coroutine.yield();
            return;
        end;
    end;
    local function _() --[[ Line: 148 ]] --[[ Name: wasteTime ]]
        -- upvalues: v42 (copy)
        local v51 = os.clock() - v42;
        if v51 < 2.848 then
            task.wait(2.848 - v51);
        end;
    end;
    v40 = l_RunService_0.Heartbeat:Connect(function(v53) --[[ Line: 156 ]]
        -- upvalues: v37 (copy), v39 (copy), v38 (copy), v41 (ref)
        if not v37.Enabled then
            return;
        else
            v38.f = v39:Update(v53) or v38.f;
            local v54 = v38:StepTo(v41, v53);
            for v55, v56 in next, v37.PumpInGoal do
                local v57 = v37.PumpOutGoal[v55];
                v37.Parts.Heart[v55] = v56:Lerp(v57, v54);
            end;
            local v58 = v37.Parts.Heart.Size / v37.BasePose.Heart.Size;
            for v59, v60 in next, v37.StemOffsets do
                local v61 = v37.Parts[v59];
                local v62 = v37.Parts.Heart.CFrame * (v60.FromHeart * v58);
                local v63 = CFrame.new(v62, v60.Target) * v60.Offset;
                v61.Size = v37.BasePose[v59].Size * v58;
                v61.CFrame = v63;
            end;
            return;
        end;
    end);
    local v64 = v15();
    v37.Sound.Muffle.Enabled = v64;
    v37.Sound:Stop();
    v37.Sound:Play();
    local v65 = task.wait(0.05);
    if not v64 then
        v20(v37, 0.6);
    end;
    v41 = 1;
    v39:SetGoal(6);
    v38.d = 0.4;
    v65 = task.wait(0.302);
    if not v64 then
        v20(v37, 1);
    end;
    v41 = -1;
    v39:SetGoal(3);
    v38.d = 0.4;
    v65 = task.wait(0.0704);
    v41 = 0;
    v39:SetGoal(1);
    v38.d = 0.4;
    v65 = task.wait(1.869);
    v65 = os.clock() - v42;
    if v65 < 2.848 then
        task.wait(2.848 - v65);
    end;
    v40:Disconnect();
end;
local function v74(v67) --[[ Line: 216 ]] --[[ Name: arteryShake ]]
    -- upvalues: v30 (copy), l_Elastic_0 (copy), l_Out_0 (copy), l_Quad_0 (copy)
    local v68 = {
        CFrame = v67.BasePose.LeftArtery.CFrame * CFrame.Angles(0, 0.03490658503988659, 0), 
        Size = v67.BasePose.LeftArtery.Size * Vector3.new(0.8500000238418579, 1.100000023841858, 0.8500000238418579, 0)
    };
    local v69 = {
        CFrame = v67.BasePose.LeftArtery.CFrame * CFrame.Angles(0, -0.03490658503988659, 0), 
        Size = v67.BasePose.LeftArtery.Size * Vector3.new(1.600000023841858, 1, 1.600000023841858, 0)
    };
    local v70 = {
        CFrame = v67.BasePose.LeftArtery.CFrame, 
        Size = v67.BasePose.LeftArtery.Size
    };
    local v71 = {
        CFrame = v67.BasePose.RightArtery.CFrame * CFrame.Angles(0, -0.03490658503988659, 0), 
        Size = v67.BasePose.RightArtery.Size * Vector3.new(0.8500000238418579, 1.100000023841858, 0.8500000238418579, 0)
    };
    local v72 = {
        CFrame = v67.BasePose.RightArtery.CFrame * CFrame.Angles(0, 0.03490658503988659, 0), 
        Size = v67.BasePose.RightArtery.Size * Vector3.new(1.600000023841858, 1, 1.600000023841858, 0)
    };
    local v73 = {
        CFrame = v67.BasePose.RightArtery.CFrame, 
        Size = v67.BasePose.RightArtery.Size
    };
    v30(v67, "LeftArtery", 0.40199999999999997, l_Elastic_0, l_Out_0, v68):Connect(function() --[[ Line: 247 ]]
        -- upvalues: v30 (ref), v67 (copy), l_Elastic_0 (ref), l_Out_0 (ref), v69 (copy), l_Quad_0 (ref), v70 (copy)
        v30(v67, "LeftArtery", 0.327, l_Elastic_0, l_Out_0, v69):Connect(function() --[[ Line: 248 ]]
            -- upvalues: v30 (ref), v67 (ref), l_Quad_0 (ref), l_Out_0 (ref), v70 (ref)
            v30(v67, "LeftArtery", 1.869, l_Quad_0, l_Out_0, v70);
        end);
    end);
    v30(v67, "RightArtery", 0.40199999999999997, l_Elastic_0, l_Out_0, v71):Connect(function() --[[ Line: 253 ]]
        -- upvalues: v30 (ref), v67 (copy), l_Elastic_0 (ref), l_Out_0 (ref), v72 (copy), l_Quad_0 (ref), v73 (copy)
        v30(v67, "RightArtery", 0.327, l_Elastic_0, l_Out_0, v72):Connect(function() --[[ Line: 254 ]]
            -- upvalues: v30 (ref), v67 (ref), l_Quad_0 (ref), l_Out_0 (ref), v73 (ref)
            v30(v67, "RightArtery", 1.869, l_Quad_0, l_Out_0, v73);
        end);
    end);
end;
v9.new = function(v75, v76, _) --[[ Line: 262 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy), v36 (copy), v2 (copy), v66 (copy), v74 (copy), v9 (copy)
    local v78 = {
        Type = "Heart Animation", 
        Id = v75, 
        Instance = v76
    };
    v78.HomeCFrame = v78.Instance.PrimaryPart.CFrame;
    v78.Sound = v1:Get("ReplicatedStorage.Assets.Sounds.Ambient.Heart Pump");
    v78.Sound.Parent = v78.Instance:WaitForChild("Heart");
    v78.Enabled = false;
    v36(v78);
    v78.PumpOutGoal = {
        CFrame = v78.BasePose.Heart.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(-0.08726646259971647, 0.08726646259971647, 0.08726646259971647), 
        Size = v78.BasePose.Heart.Size * 1.05
    };
    v78.PumpInGoal = {
        CFrame = v78.BasePose.Heart.CFrame * CFrame.new(0, 0.2, 0) * CFrame.Angles(0, -0.08726646259971647, 0), 
        Size = v78.BasePose.Heart.Size * 0.95
    };
    v78.StemOffsets = {};
    for _, v80 in next, {
        "Stem1", 
        "Stem2", 
        "Stem3"
    } do
        local l_Position_1 = v78.BasePose[v80 .. "Target"].CFrame.Position;
        local v82 = v78.Parts[v80];
        local l_Position_2 = v82.Pivot.WorldCFrame.Position;
        local v84 = CFrame.new(l_Position_2, l_Position_1);
        v78.StemOffsets[v80] = {
            FromHeart = v78.Parts.Heart.CFrame:PointToObjectSpace(l_Position_2), 
            Offset = v84:ToObjectSpace(v82.CFrame), 
            Target = l_Position_1
        };
    end;
    v78.Stepper = v2.new(0, "Heartbeat", function() --[[ Line: 306 ]]
        -- upvalues: v66 (ref), v78 (copy), v74 (ref)
        pcall(function() --[[ Line: 307 ]]
            -- upvalues: v66 (ref), v78 (ref), v74 (ref)
            task.spawn(v66, v78);
            task.spawn(v74, v78);
        end);
        local _ = task.wait(2.848);
    end);
    return (setmetatable(v78, v9));
end;
v9.Destroy = function(v86) --[[ Line: 322 ]] --[[ Name: Destroy ]]
    if v86.Destroyed then
        return;
    else
        v86.Destroyed = true;
        v86.Stepper:Destroy();
        v86.Stepper = nil;
        setmetatable(v86, nil);
        table.clear(v86);
        v86.Destroyed = true;
        return;
    end;
end;
v9.GetInteractionPosition = function(_, _, _) --[[ Line: 338 ]] --[[ Name: GetInteractionPosition ]]
    return nil;
end;
v9.Interact = function(_) --[[ Line: 342 ]] --[[ Name: Interact ]]

end;
v9.SetDetailed = function(v91, v92) --[[ Line: 346 ]] --[[ Name: SetDetailed ]]
    v91.Enabled = v92;
end;
return v9;