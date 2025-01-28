local v0 = {};
local function v3(v1) --[[ Line: 5 ]] --[[ Name: destroyItem ]]
    local v2 = true;
    if typeof(v1) == "function" then
        v1();
        return v2;
    elseif typeof(v1) == "RBXScriptConnection" then
        v1:Disconnect();
        return v2;
    elseif typeof(v1) == "table" and v1.ClassName == "SignalConnection" then
        v1:Disconnect();
        return v2;
    elseif typeof(v1) == "Instance" then
        v1:Destroy();
        return v2;
    elseif typeof(v1) == "table" and v1.Destroy then
        v1:Destroy();
        return v2;
    else
        return false;
    end;
end;
v0.new = function() --[[ Line: 32 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    return (setmetatable({
        ClassName = "Maid", 
        Destroyed = false, 
        Items = {}
    }, {
        __index = function(v4, v5) --[[ Line: 40 ]] --[[ Name: __index ]]
            -- upvalues: v0 (ref)
            if v4.Items[v5] ~= nil then
                return v4.Items[v5];
            else
                return v0[v5];
            end;
        end, 
        __newindex = function(v6, v7, v8) --[[ Line: 48 ]] --[[ Name: __newindex ]]
            rawset(v6, v7, nil);
            v6:CleanIndex(v7);
            return v6:Give(v8, v7);
        end
    }));
end;
v0.destroyItem = function(v9) --[[ Line: 58 ]] --[[ Name: destroyItem ]]
    -- upvalues: v3 (copy)
    return (v3(v9));
end;
v0.Give = function(v10, v11, v12) --[[ Line: 64 ]] --[[ Name: Give ]]
    -- upvalues: v3 (copy)
    if v10.Destroyed then
        if not v3(v11) then
            warn(("Maid failed to destroy %q"):Format(v12), v11);
        end;
        return v11;
    else
        local v13 = v12 or #v10.Items + 1;
        local l_Items_0 = v10.Items;
        local v15 = l_Items_0[v13];
        if v11 ~= v15 then
            l_Items_0[v13] = v11;
        end;
        if v15 and not v3(v15) then
            warn(("Maid failed to destroy %q"):Format(v13), v15);
        end;
        return v11;
    end;
end;
v0.Remove = function(v16, v17) --[[ Line: 90 ]] --[[ Name: Remove ]]
    for v18, v19 in next, v16.Items do
        if v19 == v17 then
            v16.Items[v18] = nil;
            return v17;
        end;
    end;
    return nil;
end;
v0.CleanIndex = function(v20, v21) --[[ Line: 102 ]] --[[ Name: CleanIndex ]]
    -- upvalues: v3 (copy)
    local v22 = v20.Items[v21];
    v20.Items[v21] = nil;
    if v22 and not v3(v22) then
        warn(("Maid failed to destroy %q"):Format(v21), v22);
    end;
end;
v0.CleanConnections = function(v23) --[[ Line: 114 ]] --[[ Name: CleanConnections ]]
    for _, v25 in next, v23.Items do
        local v26 = typeof(v25) == "RBXScriptConnection";
        local v27 = false;
        if typeof(v25) == "table" then
            v27 = v25.ClassName == "SignalConnection";
        end;
        if v26 or v27 then
            v25:Disconnect();
        end;
    end;
end;
v0.Clean = function(v28) --[[ Line: 125 ]] --[[ Name: Clean ]]
    -- upvalues: v3 (copy)
    v28:CleanConnections();
    repeat
        local v29, v30 = next(v28.Items);
        if v30 ~= nil and not v3(v30) then
            warn(("Maid failed to destroy %q"):format(v29), v30);
        end;
        if v29 then
            v28.Items[v29] = nil;
        end;
    until v30 == nil and v29 == nil;
end;
v0.Destroy = function(v31) --[[ Line: 144 ]] --[[ Name: Destroy ]]
    if v31.Destroyed then
        return;
    else
        v31.Destroyed = true;
        v31:Clean();
        setmetatable(v31, nil);
        table.clear(v31);
        v31.Destroyed = true;
        return;
    end;
end;
return v0;