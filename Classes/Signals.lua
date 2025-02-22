local v0 = nil;
local function v3(v1, ...) --[[ Line: 34 ]] --[[ Name: acquireRunnerThreadAndCallEventHandler ]]
    -- upvalues: v0 (ref)
    local l_v0_0 = v0;
    v0 = nil;
    v1(...);
    v0 = l_v0_0;
end;
local function v4() --[[ Line: 45 ]] --[[ Name: runEventHandlerInFreeThread ]]
    -- upvalues: v3 (copy)
    while true do
        v3(coroutine.yield());
    end;
end;
local v5 = {};
v5.__index = v5;
v5.new = function(v6, v7) --[[ Line: 60 ]] --[[ Name: new ]]
    -- upvalues: v5 (copy)
    return (setmetatable({
        ClassName = "SignalConnection", 
        _connected = true, 
        _signal = v6, 
        _fn = v7, 
        _next = false
    }, v5));
end;
v5.Disconnect = function(v8) --[[ Line: 71 ]] --[[ Name: Disconnect ]]
    v8._connected = false;
    if v8._signal._handlerListHead == v8 then
        v8._signal._handlerListHead = v8._next;
        return;
    else
        local l__handlerListHead_0 = v8._signal._handlerListHead;
        while l__handlerListHead_0 and l__handlerListHead_0._next ~= v8 do
            l__handlerListHead_0 = l__handlerListHead_0._next;
        end;
        if l__handlerListHead_0 then
            l__handlerListHead_0._next = v8._next;
        end;
        return;
    end;
end;
setmetatable(v5, {
    __index = function(_, v11) --[[ Line: 93 ]] --[[ Name: __index ]]
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(v11))), 2);
    end, 
    __newindex = function(_, v13, _) --[[ Line: 96 ]] --[[ Name: __newindex ]]
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(v13))), 2);
    end
});
local v15 = {};
v15.__index = v15;
v15.new = function() --[[ Line: 105 ]] --[[ Name: new ]]
    -- upvalues: v15 (copy)
    return (setmetatable({
        ClassName = "Signal", 
        _handlerListHead = false, 
        _enabled = true
    }, v15));
end;
v15.Destroy = function(v16) --[[ Line: 114 ]] --[[ Name: Destroy ]]
    v16:DisconnectAll();
    v16:Disable();
    setmetatable(v16, nil);
    table.clear(v16);
end;
v15.Disable = function(v17) --[[ Line: 122 ]] --[[ Name: Disable ]]
    v17._enabled = false;
end;
v15.Enable = function(v18) --[[ Line: 126 ]] --[[ Name: Enable ]]
    v18._enabled = true;
end;
v15.Connect = function(v19, v20) --[[ Line: 130 ]] --[[ Name: Connect ]]
    -- upvalues: v5 (copy)
    local v21 = v5.new(v19, v20);
    if v19._handlerListHead then
        v21._next = v19._handlerListHead;
        v19._handlerListHead = v21;
        return v21;
    else
        v19._handlerListHead = v21;
        return v21;
    end;
end;
v15.DisconnectAll = function(v22) --[[ Line: 143 ]] --[[ Name: DisconnectAll ]]
    v22._handlerListHead = false;
end;
v15.Fire = function(v23, ...) --[[ Line: 151 ]] --[[ Name: Fire ]]
    -- upvalues: v0 (ref), v4 (copy)
    if not v23._enabled then
        return;
    else
        local l__handlerListHead_1 = v23._handlerListHead;
        while l__handlerListHead_1 do
            if l__handlerListHead_1._connected then
                if not v0 then
                    v0 = coroutine.create(v4);
                    coroutine.resume(v0);
                end;
                task.spawn(v0, l__handlerListHead_1._fn, ...);
            end;
            l__handlerListHead_1 = l__handlerListHead_1._next;
        end;
        return;
    end;
end;
v15.Wait = function(v25) --[[ Line: 172 ]] --[[ Name: Wait ]]
    local v26 = coroutine.running();
    local v27 = nil;
    local v28 = nil;
    v27 = v25:Connect(function(...) --[[ Line: 177 ]]
        -- upvalues: v27 (ref), v28 (ref), v26 (copy)
        v27:Disconnect();
        v28 = {
            ...
        };
        task.spawn(v26, ...);
    end);
    coroutine.yield();
    return unpack(v28);
end;
v15.Once = function(v29, v30) --[[ Line: 191 ]] --[[ Name: Once ]]
    local v31 = nil;
    v31 = v29:Connect(function(...) --[[ Line: 193 ]]
        -- upvalues: v31 (ref), v30 (copy)
        if v31._connected then
            v31:Disconnect();
        end;
        v30(...);
    end);
    return v31;
end;
setmetatable(v15, {
    __index = function(_, v33) --[[ Line: 204 ]] --[[ Name: __index ]]
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(v33))), 2);
    end, 
    __newindex = function(_, v35, _) --[[ Line: 207 ]] --[[ Name: __newindex ]]
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(v35))), 2);
    end
});
return v15;