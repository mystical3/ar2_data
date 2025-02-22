local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Classes", "Springs");
local l_RunService_0 = game:GetService("RunService");
local v3 = {};
v3.__index = v3;
local function _() --[[ Line: 14 ]] --[[ Name: getCharacterPosition ]]
    -- upvalues: v0 (copy)
    if v0.Classes.Players then
        local v4 = v0.Classes.Players.get();
        if v4 and v4.Character and v4.Character.HeadPart then
            return v4.Character.HeadPart.Position;
        end;
    end;
end;
v3.new = function(v6, v7, _) --[[ Line: 26 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy), l_RunService_0 (copy), v0 (copy), v3 (copy)
    local v9 = {
        Type = "Camera Stare", 
        Id = v6, 
        Instance = v7
    };
    v9.HomeCFrame = v9.Instance.PrimaryPart.CFrame;
    v9.OriginPos = v9.HomeCFrame.Position;
    v9.Active = false;
    v9.LookSpring = v1.new(Vector3.new(0, 0, -1, 0), 2, 0.6);
    v9.Connection = l_RunService_0.Heartbeat:Connect(function(v10) --[[ Line: 40 ]]
        -- upvalues: v9 (copy), v0 (ref)
        local v11 = false;
        if not v9.Active then
            return;
        else
            local v12;
            if v0.Classes.Players then
                local v13 = v0.Classes.Players.get();
                if v13 and v13.Character and v13.Character.HeadPart then
                    v12 = v13.Character.HeadPart.Position;
                    v11 = true;
                end;
            end;
            if not v11 then
                v12 = nil;
            end;
            v11 = false;
            if not v12 then
                return;
            else
                local v14 = v12 - v9.HomeCFrame.Position;
                if v14.Magnitude > 0 then
                    v14 = v14.Unit;
                end;
                local v15, v16 = v9.LookSpring:StepTo(v14, v10);
                local v17 = CFrame.new(v9.OriginPos, v9.OriginPos + v15);
                v9.Instance:PivotTo(v17 + v16);
                return;
            end;
        end;
    end);
    return (setmetatable(v9, v3));
end;
v3.Destroy = function(v18) --[[ Line: 70 ]] --[[ Name: Destroy ]]
    if v18.Destroyed then
        return;
    else
        v18.Destroyed = true;
        if v18.Connection then
            v18.Connection:Disconnect();
            v18.Connection = nil;
        end;
        setmetatable(v18, nil);
        table.clear(v18);
        v18.Destroyed = true;
        return;
    end;
end;
v3.GetInteractionPosition = function(_, _, _) --[[ Line: 88 ]] --[[ Name: GetInteractionPosition ]]
    return nil;
end;
v3.Interact = function(_) --[[ Line: 92 ]] --[[ Name: Interact ]]

end;
v3.SetDetailed = function(v23, v24) --[[ Line: 96 ]] --[[ Name: SetDetailed ]]
    v23.Active = not not v24;
end;
return v3;