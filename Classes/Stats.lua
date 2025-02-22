local v0 = game:GetService("RunService"):IsServer();
local _ = nil;
local v2 = (if v0 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework)).require("Classes", "Signals");
local v3 = {};
v3.__index = v3;
v3.new = function(v4, v5) --[[ Line: 25 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy), v3 (copy)
    local v6 = {
        Type = "Stat", 
        Max = v5 or 100, 
        Min = v4 or 0
    };
    v6.Value = v6.Max or v6.Min;
    v6.Changed = v2.new();
    v6.Filled = v2.new();
    v6.Emptied = v2.new();
    return (setmetatable(v6, v3));
end;
v3.Destroy = function(v7) --[[ Line: 42 ]] --[[ Name: Destroy ]]
    if v7.Destroyed then
        return;
    else
        v7.Destroyed = true;
        v7.Changed:Destroy();
        v7.Filled:Destroy();
        v7.Emptied:Destroy();
        setmetatable(v7, nil);
        table.clear(v7);
        v7.Destroyed = true;
        return;
    end;
end;
v3.Get = function(v8, v9) --[[ Line: 59 ]] --[[ Name: Get ]]
    if v9 then
        return (v8.Value - v8.Min) / (v8.Max - v8.Min);
    else
        return v8.Value;
    end;
end;
v3.Set = function(v10, v11, v12) --[[ Line: 67 ]] --[[ Name: Set ]]
    local v13 = math.clamp(v11, v10.Min, v10.Max);
    local l_Value_0 = v10.Value;
    if l_Value_0 ~= v13 or v12 then
        v10.Value = v13;
        v10.Changed:Fire(v13, l_Value_0);
        if v13 == v10.Max then
            v10.Filled:Fire();
            return;
        elseif v13 == v10.Min then
            v10.Emptied:Fire();
        end;
    end;
end;
v3.Increment = function(v15, v16) --[[ Line: 84 ]] --[[ Name: Increment ]]
    if v16 ~= 0 then
        v15:Set(v15.Value + v16);
    end;
    return v15:Get();
end;
v3.IsFull = function(v17, v18) --[[ Line: 92 ]] --[[ Name: IsFull ]]
    if v18 then
        return math.abs(v17.Max - v17.Value) < v18;
    else
        return v17.Value == v17.Max;
    end;
end;
v3.IsEmpty = function(v19, v20) --[[ Line: 100 ]] --[[ Name: IsEmpty ]]
    if v20 then
        return math.abs(v19.Value - v19.Min) < v20;
    else
        return v19.Value == v19.Min;
    end;
end;
return v3;