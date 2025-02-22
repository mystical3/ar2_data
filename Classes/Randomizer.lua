local v0 = {};
v0.__index = v0;
local v1 = Random.new();
local function v5(v2) --[[ Line: 15 ]] --[[ Name: pickFromOne ]]
    local _, v4 = next(v2.List);
    return v4;
end;
local function v7(v6) --[[ Line: 21 ]] --[[ Name: pickFromTwo ]]
    if v6.List[1] == v6.Last then
        return v6.List[2];
    else
        return v6.List[1];
    end;
end;
local function v12(v8) --[[ Line: 29 ]] --[[ Name: pickFromMany ]]
    -- upvalues: v1 (copy)
    for _ = 1, 10 do
        local v10 = v1:NextInteger(1, v8.Length);
        local v11 = v8.List[v10];
        if v11 ~= v8.Last then
            return v11;
        end;
    end;
    return v8.List[v1:NextInteger(1, v8.Length)];
end;
local function _(v13) --[[ Line: 43 ]] --[[ Name: getPickFunction ]]
    -- upvalues: v5 (copy), v7 (copy), v12 (copy)
    if v13 == 0 then
        error("Cannot create randomizer with empty list");
        return;
    elseif v13 == 1 then
        return v5;
    elseif v13 == 2 then
        return v7;
    else
        return v12;
    end;
end;
v0.new = function(v15) --[[ Line: 58 ]] --[[ Name: new ]]
    -- upvalues: v5 (copy), v7 (copy), v12 (copy), v0 (copy)
    local v16 = {
        List = v15, 
        Last = nil, 
        Length = #v15
    };
    local l_Length_0 = v16.Length;
    local v18;
    if l_Length_0 == 0 then
        error("Cannot create randomizer with empty list");
        v18 = nil;
    else
        v18 = if l_Length_0 == 1 then v5 else if l_Length_0 == 2 then v7 else v12;
    end;
    v16.PickFunction = v18;
    return (setmetatable(v16, v0));
end;
v0.Destroy = function(v19) --[[ Line: 71 ]] --[[ Name: Destroy ]]
    if v19.Destroyed then
        return;
    else
        v19.Destroyed = true;
        setmetatable(v19, nil);
        table.clear(v19);
        v19.Destroyed = true;
        return;
    end;
end;
v0.Roll = function(v20) --[[ Line: 84 ]] --[[ Name: Roll ]]
    v20.Last = v20:PickFunction();
    return v20.Last;
end;
v0.NewList = function(v21, v22) --[[ Line: 90 ]] --[[ Name: NewList ]]
    -- upvalues: v5 (copy), v7 (copy), v12 (copy)
    v21.List = v22;
    v21.Last = nil;
    v21.Length = #v22;
    local l_Length_1 = v21.Length;
    local v24;
    if l_Length_1 == 0 then
        error("Cannot create randomizer with empty list");
        v24 = nil;
    else
        v24 = if l_Length_1 == 1 then v5 else if l_Length_1 == 2 then v7 else v12;
    end;
    v21.PickFunction = v24;
end;
return v0;