local _ = require(game:GetService("ReplicatedFirst").Framework);
local function v3(v1, _) --[[ Line: 5 ]] --[[ Name: step ]]
    v1.Instance.CFrame = CFrame.new();
end;
return function(_) --[[ Line: 11 ]]
    -- upvalues: v3 (copy)
    local v5 = {
        Name = "Default", 
        Type = "Camera", 
        Instance = Instance.new("Camera")
    };
    v5.Instance.Name = v5.Name;
    v5.Enabled = true;
    v5.ParallelRun = false;
    v5.Step = v3;
    v5.StepOrder = 10;
    v5.Disable = function(v6) --[[ Line: 27 ]] --[[ Name: Disable ]]
        v6.Enabled = false;
    end;
    v5.Enable = function(v7) --[[ Line: 31 ]] --[[ Name: Enable ]]
        v7.Enabled = true;
    end;
    return v5;
end;