local v0 = require(game:GetService("ReplicatedFirst").Framework);
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("SoundService");
local v3 = 10;
if v0.require("Configs", "Globals").QuickRespawn then
    v3 = 1;
end;
local function v14(v4, v5) --[[ Line: 14 ]] --[[ Name: step ]]
    -- upvalues: v3 (ref), v0 (copy)
    local v6 = (os.clock() - v4.StartTime) / v3;
    if v6 >= 1 then
        v4:Disable();
        task.defer(function() --[[ Line: 21 ]]
            -- upvalues: v0 (ref)
            v0.Libraries.Interface:Get("DeathScreen"):Start();
        end);
        v4.Instance.CFrame = CFrame.new(0, 10000, 0);
        return;
    else
        if v6 >= 0.75 and not v4.Fading then
            v4.Fading = true;
            v0.Libraries.Interface:Get("Fade"):Fade(0, 2.5);
        end;
        if v4.Corpse then
            local v7 = math.clamp(v6, 0, 1);
            v7 = if v6 > 0.5 then -2 * (v6 - 1) ^ 2 + 1 else 2 * v6 ^ 2;
            local l_UpperTorso_0 = v4.Corpse:FindFirstChild("UpperTorso");
            if l_UpperTorso_0 then
                local l_CFrame_0 = l_UpperTorso_0.CFrame;
                local v10 = CFrame.new(v4.BaseCF.p, l_CFrame_0.p);
                local v11 = CFrame.new(Vector3.new(0, 0, 0, 0), v10.LookVector * Vector3.new(1, 0, 1, 0)) * CFrame.Angles(-1.2217304763960306, 0, 0) * CFrame.new(0, 0, 15) + l_CFrame_0.p;
                local v12 = v4.BaseCF:lerp(v11, v7);
                local v13 = v4.BaseFov + (60 - v4.BaseFov) * v7;
                v4.Instance.FieldOfView = v13;
                v4.Instance.CFrame = v12;
                v4.RunTime = v4.RunTime + v5;
            end;
        end;
        return;
    end;
end;
return function(_) --[[ Line: 71 ]]
    -- upvalues: v14 (copy), l_UserInputService_0 (copy)
    local v16 = {
        Name = "Corpse", 
        Type = "Camera", 
        Instance = Instance.new("Camera")
    };
    v16.Instance.Name = v16.Name;
    v16.Instance.CameraType = Enum.CameraType.Custom;
    v16.BaseCF = CFrame.new();
    v16.Corpse = nil;
    v16.StartTime = 0;
    v16.Enabled = false;
    v16.ParallelRun = false;
    v16.Step = v14;
    v16.StepOrder = 10;
    v16.Disable = function(v17) --[[ Line: 92 ]] --[[ Name: Disable ]]
        v17.Enabled = false;
        v17.Corpse = nil;
    end;
    v16.Enable = function(v18) --[[ Line: 97 ]] --[[ Name: Enable ]]
        -- upvalues: l_UserInputService_0 (ref)
        l_UserInputService_0.MouseBehavior = Enum.MouseBehavior.Default;
        v18.Enabled = true;
        v18.StartTime = os.clock();
    end;
    v16.Connect = function(v19, v20) --[[ Line: 104 ]] --[[ Name: Connect ]]
        v19.BaseCF = workspace.CurrentCamera.CFrame;
        v19.BaseFov = workspace.CurrentCamera.FieldOfView;
        v19.Corpse = v20;
        v19.RunTime = 0;
    end;
    return v16;
end;