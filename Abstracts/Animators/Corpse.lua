local _ = require(game:GetService("ReplicatedFirst").Framework).require("Libraries", "Resources");
return function(v1) --[[ Line: 7 ]]
    local v2 = v1.Instance:WaitForChild("FallAnimation").Value or "Death.Standing Forwards";
    v1:PlayAnimation(v2);
    local v3 = v1.Animations[v2];
    if v3 then
        v1.Maid:Give(v3:GetMarkerReachedSignal("Freeze"):Connect(function() --[[ Line: 20 ]]
            -- upvalues: v1 (copy), v2 (ref)
            v1:SetAnimationSpeed(v2, 0);
        end));
    end;
    return function(_) --[[ Line: 25 ]]

    end;
end;