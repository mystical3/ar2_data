local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedFirst_0 = game:GetService("ReplicatedFirst");
local v2 = {};
local v3 = Random.new();
v2.AudibleRangeFallOffRate = 200;
v2.LadderMountDistance = 3;
v2.ValidMoveStates = {
    Running = true, 
    Walking = true, 
    Crouching = true, 
    Climbing = true, zz
    Falling = true, 
    Sitting = true, 
    Vaulting = true, 
    Swimming = true, 
    SprintSwimming = true, 
    Default = true
};
v2.MoveSpeeds = {
    Running = 24, 
    Walking = 16, 
    Crouching = 12, 
    Climbing = 16, 
    Sitting = 0, 
    Vaulting = 16, 
    Swimming = 16, 
    SprintSwimming = 24
};
v2.StateCosts = {
    Running = 1.45, 
    Walking = 1, 
    Crouching = 1, 
    Climbing = 1, 
    Falling = 1, 
    Sitting = 0.5, 
    Vaulting = 1, 
    Swimming = 1, 
    SprintSwimming = 1.45
};
v2.AudibleDistances = {
    Running = 40, 
    Walking = 15, 
    Crouching = 0, 
    Climbing = 15, 
    Falling = 15, 
    Sitting = 0, 
    Vaulting = 10, 
    Swimming = 30, 
    SprintSwimming = 40
};
v2.ColliderOffsets = {
    Running = Vector3.new(0, 1.5499999523162842, -0.4000000059604645, 0), 
    Walking = Vector3.new(0, 1.9500000476837158, -0.20000000298023224, 0), 
    Crouching = Vector3.new(0, 0.949999988079071, -0.5, 0), 
    Climbing = Vector3.new(0, 1.75, 0, 0), 
    Falling = Vector3.new(0, 1.75, 0, 0), 
    Sitting = Vector3.new(0, 1.75, 0, 0), 
    Vaulting = Vector3.new(0, 1.25, -0.20000000298023224, 0), 
    Swimming = Vector3.new(0, 1.75, 0, 0), 
    SprintSwimming = Vector3.new(0, 1.75, 0, 0), 
    Default = Vector3.new(0, 1.75, 0, 0)
};
v2.Jump = {
    RateLimit = 0.3, 
    JumpPower = 32, 
    StaminaCost = 10
};
v2.SwimSurfaces = {
    ["Sea Floor"] = true, 
    ["Lake Floor"] = true
};
v2.FloorDamageTags = {
    ["Kill Volume Instant"] = {
        Damage = 300, 
        Message = nil
    }, 
    ["Kill Volume Quick"] = {
        Damage = 20, 
        Message = nil
    }, 
    ["Kill Volume Volcano Quick"] = {
        Damage = 20, 
        Message = nil
    }, 
    ["Kill Volume Slow"] = {
        Damage = 1
    }, 
    ["Kill Electricity 5"] = {
        Damage = 5, 
        Message = "was killed by electricity"
    }, 
    ["Kill BarbedWire 5"] = {
        Damage = 5, 
        Message = "was killed by barbed wire"
    }, 
    ["Kill Volume Instant Portal"] = {
        Damage = 1000, 
        Message = "was banished to the void"
    }, 
    ["Kill Volume Quick Goop"] = {
        Damage = 20, 
        Message = "was absorbed by the goop"
    }
};
local function v4(v5) --[[ Line: 131 ]] --[[ Name: proxy ]]
    -- upvalues: l_RunService_0 (copy), l_ReplicatedFirst_0 (copy), v3 (copy), v4 (copy)
    local v10 = {
        __index = function(_, v7) --[[ Line: 133 ]] --[[ Name: __index ]]
            -- upvalues: v5 (copy)
            return (rawget(v5, v7));
        end, 
        __newindex = function(v8, v9) --[[ Line: 137 ]] --[[ Name: __newindex ]]
            -- upvalues: l_RunService_0 (ref), l_ReplicatedFirst_0 (ref), v3 (ref)
            rawset(v8, v9, nil);
            if l_RunService_0:IsClient() then
                require(l_ReplicatedFirst_0.Framework).Libraries.Network:Send("Player State Sync", workspace:GetServerTimeNow() + v3:NextNumber() - 0.5);
            end;
        end
    };
    for v11, v12 in next, v5 do
        if typeof(v12) == "table" then
            v5[v11] = v4(v12);
        end;
    end;
    return table.freeze((setmetatable(v5, v10)));
end;
return v4(v2);