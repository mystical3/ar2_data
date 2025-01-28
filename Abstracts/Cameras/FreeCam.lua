local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Libraries", "Network");
local _ = v0.require("Libraries", "Keybinds");
local _ = v0.require("Libraries", "Raycasting");
local v4 = v0.require("Classes", "SteppedSprings");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_LeftAlt_0 = Enum.KeyCode.LeftAlt;
local l_LeftControl_0 = Enum.KeyCode.LeftControl;
local l_LeftShift_0 = Enum.KeyCode.LeftShift;
local v10 = {
    0, 
    1
};
local v11 = {
    0, 
    50
};
local v12 = {
    MoveSpeed = {
        EditKey = Enum.KeyCode.Z, 
        Spring = v4.new(16, 20, 1), 
        SpringEditable = true, 
        Limits = {
            0, 
            1e999
        }, 
        Increment = 0.1
    }, 
    TurnSpeed = {
        EditKey = Enum.KeyCode.X, 
        Spring = v4.new(0.1, 20, 1), 
        SpringEditable = true, 
        Limits = {
            0, 
            0.5
        }, 
        Increment = 0.01
    }, 
    Roll = {
        EditKey = Enum.KeyCode.C, 
        Spring = v4.new(0, 20, 1), 
        SpringEditable = true, 
        Limits = {
            -1e999, 
            1e999
        }, 
        Increment = 0.04363323129985824
    }, 
    Offset = {
        EditKey = Enum.KeyCode.R, 
        Spring = v4.new(0, 20, 1), 
        SpringEditable = true, 
        Limits = {
            -1e999, 
            1e999
        }, 
        Increment = 1
    }, 
    FieldOfView = {
        EditKey = Enum.KeyCode.F, 
        Spring = v4.new(70, 20, 1), 
        SpringEditable = true, 
        Limits = {
            5, 
            70
        }, 
        Increment = 5
    }, 
    Position = {
        EditKey = Enum.KeyCode.T, 
        Spring = v4.new(Vector3.new(7465, 122.5250015258789, -6160, 0), 20, 1)
    }, 
    Rotation = {
        EditKey = Enum.KeyCode.G, 
        Spring = v4.new(Vector3.new(), 20, 1), 
        Sensitivity = 0.2
    }
};
local function _(v13, v14, v15) --[[ Line: 81 ]] --[[ Name: constrain ]]
    return v13 < v14 and v14 or v15 < v13 and v15 or v13;
end;
local function _(v17) --[[ Line: 85 ]] --[[ Name: normalize ]]
    if v17 < 0 then
        return -1;
    elseif v17 > 0 then
        return 1;
    else
        return 0;
    end;
end;
local function _(v19, v20, v21) --[[ Line: 89 ]] --[[ Name: lerp ]]
    return v19 + (v20 - v19) * v21;
end;
local function _(v23) --[[ Line: 93 ]] --[[ Name: unbindBinds ]]
    if v23.InputBound then
        v23.BeganBind:Disconnect();
        v23.EndedBind:Disconnect();
        v23.ChangedBind:Disconnect();
        v23.InputBound = false;
    end;
end;
local function v45(v25) --[[ Line: 103 ]] --[[ Name: setBinds ]]
    -- upvalues: l_UserInputService_0 (copy), l_GuiService_0 (copy), v0 (copy), v12 (copy), l_LeftAlt_0 (copy), v10 (copy), l_LeftControl_0 (copy), v11 (copy), l_LeftShift_0 (copy)
    if v25.InputBound then
        return;
    else
        v25.BeganBind = l_UserInputService_0.InputBegan:Connect(function(v26, v27) --[[ Line: 110 ]]
            -- upvalues: l_GuiService_0 (ref), v25 (copy), v0 (ref)
            if not v27 and not l_GuiService_0.MenuIsOpen and v25.Enabled and v26.KeyCode == Enum.KeyCode.B then
                v0.Libraries.Interface:ToggleVisbility();
            end;
        end);
        v25.EndedBind = l_UserInputService_0.InputEnded:Connect(function(_, _) --[[ Line: 118 ]]

        end);
        v25.ChangedBind = l_UserInputService_0.InputChanged:Connect(function(v30, _) --[[ Line: 122 ]]
            -- upvalues: v25 (copy), v12 (ref), l_UserInputService_0 (ref), l_LeftAlt_0 (ref), v10 (ref), l_LeftControl_0 (ref), v11 (ref), l_LeftShift_0 (ref)
            if v25.Enabled then
                if v30.UserInputType == Enum.UserInputType.MouseMovement then
                    local v32 = math.tan((math.rad(v25.Instance.FieldOfView))) / 2.7474774194546216;
                    local l_Position_0 = v12.TurnSpeed.Spring:GetPosition();
                    local v34 = v30.Delta * math.rad(l_Position_0) * v32;
                    local v35 = v12.Rotation.Spring:GetGoal().Y - v34.X;
                    local v36 = v12.Rotation.Spring:GetGoal().X - v34.Y;
                    local l_Z_0 = v12.Rotation.Spring:GetGoal().Z;
                    v12.Rotation.Spring:SetGoal((Vector3.new(v36, v35, l_Z_0)));
                    return;
                elseif v30.UserInputType == Enum.UserInputType.MouseWheel then
                    local l_Z_1 = v30.Position.Z;
                    local v39 = l_Z_1 < 0 and -1 or l_Z_1 > 0 and 1 or 0;
                    for _, v41 in next, v12 do
                        if l_UserInputService_0:IsKeyDown(v41.EditKey) then
                            if l_UserInputService_0:IsKeyDown(l_LeftAlt_0) then
                                local v42 = math.clamp(v41.Spring.Damping - v39 * 0.025, unpack(v10));
                                v41.Spring.Damping = v42;
                            elseif l_UserInputService_0:IsKeyDown(l_LeftControl_0) then
                                local v43 = math.clamp(v41.Spring.Speed + v39 * 0.5, unpack(v11));
                                v41.Spring.Speed = v43;
                            elseif l_UserInputService_0:IsKeyDown(l_LeftShift_0) and v41.Increment then
                                local v44 = math.clamp(v41.Spring:GetGoal() + v39 * v41.Increment, unpack(v41.Limits));
                                v41.Spring:SetGoal(v44);
                            end;
                        end;
                    end;
                end;
            end;
        end);
        v25.InputBound = true;
        return;
    end;
end;
local function v62(v46, v47) --[[ Line: 167 ]] --[[ Name: step ]]
    -- upvalues: l_UserInputService_0 (copy), v12 (copy), v0 (copy)
    if not v46.Enabled then
        return;
    else
        local v48 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.W) and 0 or 1;
        local v49 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.A) and 0 or 1;
        local v50 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.S) and 0 or 1;
        local v51 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.D) and 0 or 1;
        local v52 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.Q) and 0 or 1;
        local v53 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.E) and 0 or 1;
        local v54 = Vector3.new(v49 - v51, v52 - v53, v48 - v50) * v47 * v12.MoveSpeed.Spring:GetPosition();
        local v55 = v46.Instance.CFrame:VectorToWorldSpace(v54);
        v12.Position.Spring:SetGoal(v12.Position.Spring:GetGoal() + v55);
        local v56 = CFrame.Angles(0, v12.Rotation.Spring:GetPosition().Y, 0);
        local v57 = CFrame.Angles(v12.Rotation.Spring:GetPosition().X, 0, 0);
        local v58 = CFrame.Angles(0, 0, v12.Roll.Spring:GetPosition());
        local l_Position_1 = v12.Position.Spring:GetPosition();
        local v60 = CFrame.new(0, 0, v12.Offset.Spring:GetPosition());
        local v61 = v56 * v57 * v58;
        v46.Instance.FieldOfView = v12.FieldOfView.Spring:GetPosition();
        v46.Instance.CFrame = v61 * v60 + l_Position_1;
        v46.Instance.Focus = v61 + l_Position_1;
        l_UserInputService_0.MouseBehavior = Enum.MouseBehavior.LockCenter;
        l_UserInputService_0.MouseIconEnabled = false;
        if tick() - v46.LastWorldSet > 5 then
            v46.LastWorldSet = tick();
            v0.Libraries.World:Set(v46.Instance.CFrame.p, "Camera", 1);
        end;
        return;
    end;
end;
return function(_) --[[ Line: 212 ]]
    -- upvalues: v62 (copy), v45 (copy)
    local v64 = {
        Name = "FreeCam", 
        Type = "Camera", 
        Instance = Instance.new("Camera")
    };
    v64.Instance.Name = v64.Name;
    v64.Instance.CameraType = "Custom";
    v64.Enabled = false;
    v64.ParallelRun = false;
    v64.Step = v62;
    v64.StepOrder = 10;
    v64.LastWorldSet = tick();
    v64.FocusPart = nil;
    v64.Enable = function(v65) --[[ Line: 232 ]] --[[ Name: Enable ]]
        -- upvalues: v45 (ref)
        v65.Enabled = true;
        v45(v65);
    end;
    v64.Disable = function(v66) --[[ Line: 237 ]] --[[ Name: Disable ]]
        v66.Enabled = false;
        if v66.InputBound then
            v66.BeganBind:Disconnect();
            v66.EndedBind:Disconnect();
            v66.ChangedBind:Disconnect();
            v66.InputBound = false;
        end;
    end;
    return v64;
end;