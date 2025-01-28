local v0 = require(game:GetService("ReplicatedFirst").Framework).require("Libraries", "Resources"):Find("ReplicatedStorage.Client.Abstracts.Animators.Character");
local v1 = require(v0);
return function(v2) --[[ Line: 10 ]]
    -- upvalues: v1 (copy)
    local v3 = v1(v2);
    v2.Muted = true;
    v2.StateChangeSpeed = 0.25;
    v2:SetState("AtEase", true);
    v2:SetState("MoveState", "Walking");
    return function(v4) --[[ Line: 19 ]]
        -- upvalues: v2 (copy), v3 (copy)
        if v2.Instance and v2.Instance.PrimaryPart then
            v2.Instance.PrimaryPart.Velocity = v2.Instance.PrimaryPart.Velocity * 0;
        end;
        v3(v4);
    end;
end;