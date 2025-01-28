local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local v2 = v0.require("Classes", "Steppers");
local v3 = v1:Find("Workspace.Map.Shared.Randoms");
local v4 = {};
v4.__index = v4;
v4.new = function(v5, v6, _) --[[ Line: 16 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy), v3 (copy), v4 (copy)
    local v8 = {
        Type = "Random Event Geometry", 
        Id = v5, 
        Instance = v6
    };
    v8.HomeCFrame = v8.Instance.PrimaryPart.CFrame;
    v8.OriginPos = v8.HomeCFrame.Position;
    v8.ParentBin = v6.Parent;
    v8.EventName = v6:WaitForChild("RandomEvent").Value;
    v8.EventActiveModel = v6:WaitForChild("EventActive");
    v8.EventMissingModel = v6:WaitForChild("EventMissing");
    v8.Stepper = v2.new(1, "Heartbeat", function() --[[ Line: 32 ]]
        -- upvalues: v3 (ref), v8 (copy)
        if v3:FindFirstChild(v8.EventName) then
            if v8.EventActiveModel.Parent ~= v8.ParentBin then
                v8.EventActiveModel.Parent = v8.ParentBin;
                v8.EventMissingModel.Parent = nil;
                return;
            end;
        elseif v8.EventMissingModel.Parent ~= v8.ParentBin then
            v8.EventMissingModel.Parent = v8.ParentBin;
            v8.EventActiveModel.Parent = nil;
        end;
    end):ForceStep();
    return (setmetatable(v8, v4));
end;
v4.Destroy = function(v9) --[[ Line: 55 ]] --[[ Name: Destroy ]]
    if v9.Destroyed then
        return;
    else
        v9.Destroyed = true;
        if v9.Stepper then
            v9.Stepper:Destroy();
            v9.Stepper = nil;
        end;
        setmetatable(v9, nil);
        table.clear(v9);
        v9.Destroyed = true;
        return;
    end;
end;
v4.GetInteractionPosition = function(_, _, _) --[[ Line: 73 ]] --[[ Name: GetInteractionPosition ]]
    return nil;
end;
v4.Interact = function(_) --[[ Line: 77 ]] --[[ Name: Interact ]]

end;
v4.SetDetailed = function(v14, v15) --[[ Line: 81 ]] --[[ Name: SetDetailed ]]
    if v15 then
        v14.Stepper:SetRate(1);
        return;
    else
        v14.Stepper:SetRate(10);
        return;
    end;
end;
return v4;