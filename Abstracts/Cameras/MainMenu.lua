local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local v2 = v0.require("Classes", "SteppedSprings");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("SoundService");
local l_Effects_0 = workspace:WaitForChild("Effects");
local v6 = {
    Pitch = v2.new(0, 7, 1), 
    Yaw = v2.new(1.5707963267948966, 7, 1), 
    Distance = v2.new(12, 7, 1)
};
local v7 = {
    Pitch = {
        0, 
        0.7853981633974483
    }, 
    Yaw = {
        -1e999, 
        1e999
    }, 
    Distance = {
        6, 
        15
    }
};
local function v12() --[[ Line: 31 ]] --[[ Name: clampCameraSprings ]]
    -- upvalues: v6 (copy), v7 (copy)
    for v8, v9 in next, v6 do
        local v10, v11 = unpack(v7[v8]);
        if v11 < v9:GetGoal() then
            v9:SetGoal(v11);
        elseif v9:GetGoal() < v10 then
            v9:SetGoal(v10);
        end;
    end;
end;
local function v22(v13, v14) --[[ Line: 43 ]] --[[ Name: step ]]
    -- upvalues: v6 (copy)
    v13.Instance.CameraType = Enum.CameraType.Scriptable;
    if not v13.Visible then
        local v15 = v6.Yaw:GetPosition() + v14 * 3.141592653589793 * 2 * 0.1;
        v6.Yaw:SetGoal(v15);
    end;
    if v13.SubjectModel then
        local l_Position_0 = v13.SubjectModel.Instance.PrimaryPart.Position;
        local v17 = l_Position_0 + Vector3.new(0, 1.2000000476837158, 0, 0);
        local v18 = (CFrame.Angles(0, v6.Yaw:GetPosition(), 0) * CFrame.Angles(v6.Pitch:GetPosition(), 0, 0)).LookVector * v6.Distance:GetPosition();
        v13.Instance.FieldOfView = 50;
        v13.Instance.CFrame = CFrame.new(v17 + v18, v17);
        v13.Instance.Focus = CFrame.new(v17);
        local v19 = l_Position_0 - Vector3.new(0, 2.8499999046325684, 0, 0) - v13.Instance.CFrame.p;
        local v20 = v19.unit * (v19.Magnitude + 0);
        local v21 = v20.magnitude / v19.magnitude;
        v13.SubjectModel.Instance.Shadow.Size = Vector3.new(6, 1, 6, 0) * v21;
        v13.SubjectModel.Instance.Shadow.CFrame = CFrame.new(v13.Instance.CFrame.p + v20);
        v13.SubjectModel:SetState("LookDirection", -v13.Instance.CFrame.lookVector);
    end;
end;
return function(_) --[[ Line: 85 ]]
    -- upvalues: v22 (copy), v1 (copy), v6 (copy), v12 (copy), l_Effects_0 (copy), l_UserInputService_0 (copy), v0 (copy)
    local v24 = {
        Name = "MainMenu", 
        Type = "Camera", 
        Instance = Instance.new("Camera")
    };
    v24.Instance.Name = v24.Name;
    v24.Enabled = true;
    v24.ParallelRun = false;
    v24.Step = v22;
    v24.StepOrder = 10;
    v24.SubjectModel = nil;
    local l_MannequinPoint_0 = v1:Find("ReplicatedStorage.Interface.MainMenu.SpawnPlate"):WaitForChild("MannequinPoint");
    v24.Instance.CFrame = l_MannequinPoint_0.CFrame;
    v24.Disable = function(v26) --[[ Line: 110 ]] --[[ Name: Disable ]]
        v26.Enabled = false;
        if v26.SubjectBackground then
            v26.SubjectBackground.Parent = nil;
        end;
    end;
    v24.Enable = function(v27) --[[ Line: 118 ]] --[[ Name: Enable ]]
        -- upvalues: v6 (ref), v12 (ref), l_Effects_0 (ref)
        v27.Enabled = true;
        v6.Yaw:SnapTo(-0.475602);
        v6.Pitch:SnapTo(0.069813);
        v6.Distance:SnapTo(10);
        v12();
        if v27.SubjectBackground then
            v27.SubjectBackground.Parent = l_Effects_0;
        end;
    end;
    v24.SetSubject = function(v28, v29) --[[ Line: 132 ]] --[[ Name: SetSubject ]]
        v28.SubjectModel = v29;
    end;
    v24.SetSubjectBackground = function(v30, v31) --[[ Line: 136 ]] --[[ Name: SetSubjectBackground ]]
        v30.SubjectBackground = v31;
    end;
    v24.ShowManniquin = function(v32, _) --[[ Line: 140 ]] --[[ Name: ShowManniquin ]]
        -- upvalues: v6 (ref), v12 (ref)
        v32.CanZoom = true;
        v32.Visible = true;
        v6.Yaw:SnapTo(-0.475602);
        v6.Pitch:SnapTo(0.069813);
        v6.Distance:SnapTo(10);
        v6.Yaw:Retune(7);
        v6.Pitch:Retune(7);
        v6.Distance:Retune(7);
        v12();
        if v32.SubjectModel then
            v32.SubjectModel.Springs.LookDirection.SnapTo();
        end;
    end;
    v24.HideManniquin = function(v34, _) --[[ Line: 159 ]] --[[ Name: HideManniquin ]]
        -- upvalues: v6 (ref)
        v34.CanZoom = false;
        v34.Visible = false;
        v6.Pitch:Retune(0.1);
        v6.Distance:Retune(0.1);
        v6.Pitch:SetGoal(0);
        v6.Distance:SetGoal(15);
    end;
    local v36 = nil;
    local v37 = false;
    l_UserInputService_0.InputBegan:Connect(function(v38, v39) --[[ Line: 176 ]]
        -- upvalues: v24 (copy), v0 (ref), v37 (ref), v36 (ref)
        if not v39 and v24.Enabled then
            local l_Bind_0 = v0.Libraries.Keybinds:GetBind("Crouch");
            local v41 = l_Bind_0 and l_Bind_0.Key or nil;
            if v38.UserInputType == Enum.UserInputType.MouseButton2 then
                v37 = true;
                v36 = nil;
                return;
            elseif v24.SubjectModel and v41 and v38.KeyCode == v41 then
                if l_Bind_0.Mechanism.Value == "Toggle" then
                    if v24.SubjectModel:GetState("MoveState") == "Walking" then
                        v24.SubjectModel:SetState("MoveState", "Crouching");
                        return;
                    else
                        v24.SubjectModel:SetState("MoveState", "Walking");
                        return;
                    end;
                else
                    v24.SubjectModel:SetState("MoveState", "Crouching");
                end;
            end;
        end;
    end);
    l_UserInputService_0.InputEnded:Connect(function(v42, _) --[[ Line: 199 ]]
        -- upvalues: v0 (ref), v37 (ref), v24 (copy)
        local l_Bind_1 = v0.Libraries.Keybinds:GetBind("Crouch");
        local v45 = l_Bind_1 and l_Bind_1.Key or nil;
        if v42.UserInputType == Enum.UserInputType.MouseButton2 then
            v37 = false;
            return;
        else
            if v24.SubjectModel and v45 and v42.KeyCode == v45 and l_Bind_1.Mechanism.Value == "Hold" then
                v24.SubjectModel:SetState("MoveState", "Walking");
            end;
            return;
        end;
    end);
    l_UserInputService_0.InputChanged:Connect(function(v46, v47) --[[ Line: 212 ]]
        -- upvalues: v24 (copy), l_UserInputService_0 (ref), v37 (ref), v36 (ref), v6 (ref), v12 (ref)
        if v24.Enabled then
            local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
            if v46.UserInputType == Enum.UserInputType.MouseMovement then
                if v24.Visible and v37 and v36 then
                    local v49 = 0.004363323129985824 * (l_l_UserInputService_0_MouseLocation_0 - v36);
                    v6.Yaw:SetGoal(v6.Yaw:GetGoal() - v49.X);
                    v6.Pitch:SetGoal(v6.Pitch:GetGoal() + v49.Y);
                    v12();
                end;
                v36 = l_l_UserInputService_0_MouseLocation_0;
                return;
            elseif v47 == false and v24.CanZoom and v46.UserInputType == Enum.UserInputType.MouseWheel then
                local v50 = math.sign(v46.Position.Z);
                v6.Distance:SetGoal(v6.Distance:GetGoal() - v50);
                v12();
            end;
        end;
    end);
    return v24;
end;