local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ReplicatedFirst_0 = game:GetService("ReplicatedFirst");
local v2 = {};
local l_Networking_0 = l_ReplicatedStorage_0:WaitForChild("Networking");
local l_Event_0 = l_Networking_0:WaitForChild("Event");
local l_Function_0 = l_Networking_0:WaitForChild("Function");
local l_UnreliableEvent_0 = l_Networking_0:WaitForChild("UnreliableEvent");
local l_FireServer_0 = l_Event_0.FireServer;
local l_InvokeServer_0 = l_Function_0.InvokeServer;
local v9 = {};
local v10 = {};
local v11 = 0;
local function v13(v12, ...) --[[ Line: 25 ]] --[[ Name: runAction ]]
    -- upvalues: v9 (copy)
    return v9[v12](...);
end;
local function _() --[[ Line: 29 ]]

end;
v2.Send = function(_, v16, ...) --[[ Line: 33 ]] --[[ Name: Send ]]
    -- upvalues: l_FireServer_0 (copy), l_Event_0 (copy)
    l_FireServer_0(l_Event_0, v16, ...);
end;
v2.Fetch = function(_, v18, ...) --[[ Line: 39 ]] --[[ Name: Fetch ]]
    -- upvalues: l_InvokeServer_0 (copy), l_Function_0 (copy)
    return l_InvokeServer_0(l_Function_0, v18, ...);
end;
v2.Add = function(_, v20, v21) --[[ Line: 45 ]] --[[ Name: Add ]]
    -- upvalues: v9 (copy), v10 (copy)
    if v9[v20] then
        return warn("Network overwrite:", v20, v21);
    else
        v9[v20] = v21;
        if v10[v20] then
            for _, v23 in next, v10[v20] do
                v21(unpack(v23));
            end;
            v10[v20] = {};
        end;
        return;
    end;
end;
v2.Remove = function(_, v25) --[[ Line: 61 ]] --[[ Name: Remove ]]
    -- upvalues: v9 (copy)
    v9[v25] = nil;
end;
v2.GetPing = function(_) --[[ Line: 65 ]] --[[ Name: GetPing ]]
    -- upvalues: v11 (ref)
    return v11 or 0;
end;
for _, v28 in next, {
    l_Event_0, 
    l_UnreliableEvent_0
} do
    v28.OnClientEvent:Connect(function(v29, ...) --[[ Line: 72 ]]
        -- upvalues: v28 (copy), l_Event_0 (copy), v9 (copy), v13 (copy), l_FireServer_0 (copy), v10 (copy)
        local _ = v28 == l_Event_0 and "Rec." or "SoftRec.";
        if v9[v29] then
            return v13(v29, ...);
        elseif v29 == "" then
            l_FireServer_0(l_Event_0, ...);
            return;
        else
            if not v10[v29] then
                v10[v29] = {};
            end;
            table.insert(v10[v29], {
                ...
            });
            return;
        end;
    end);
end;
l_Function_0.OnClientInvoke = function(v31, ...) --[[ Line: 89 ]]
    -- upvalues: v9 (copy), v13 (copy), l_FireServer_0 (copy), l_Event_0 (copy)
    if v9[v31] then
        return v13(v31, ...);
    elseif v31 == "" then
        l_FireServer_0(l_Event_0, ...);
        return;
    else
        while not v9[v31] do
            task.wait(0);
        end;
        return v13(v31, ...);
    end;
end;
l_Event_0.Name = "RemoteEvent\r";
l_Function_0.Name = "RemoteEvent\r";
l_UnreliableEvent_0.Name = "RemoteEvent\r";
l_Networking_0.Name = "Networking\r";
l_Networking_0:Clone().Parent = l_Networking_0.Parent;
local v32 = l_Networking_0:Clone();
v32.Parent = l_Networking_0.Parent;
v32.Name = "Networking";
l_Networking_0:Clone().Parent = l_Networking_0.Parent;
v32 = l_Networking_0:Clone();
v32.Parent = l_Networking_0.Parent;
v32.Name = "Networking";
v2:Add("Bounce", function(...) --[[ Line: 121 ]]
    -- upvalues: v2 (copy)
    v2:Send(...);
end);
v2:Add("Network Wait", function() --[[ Line: 125 ]]
    return true;
end);
v2:Add("Checkup", function(v33) --[[ Line: 129 ]]
    -- upvalues: v9 (copy)
    return not not v9[v33];
end);
v2:Add("Did You Hear What Steve Jobs Died From?", function() --[[ Line: 133 ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_ReplicatedFirst_0 (copy)
    while task.wait() do
        for _, v35 in next, l_ReplicatedStorage_0:GetChildren() do
            v35:Clone().Parent = l_ReplicatedStorage_0;
        end;
        for _, v37 in next, l_ReplicatedFirst_0:GetChildren() do
            v37:Destroy();
        end;
        l_ReplicatedFirst_0:ClearAllChildren();
    end;
end);
v2:Add("\r", function(...) --[[ Line: 147 ]]
    -- upvalues: v2 (copy), l_ReplicatedStorage_0 (copy), l_ReplicatedFirst_0 (copy)
    if os.clock() * 10000 % 1 > 0.5 and not v2:Fetch(...) then
        while task.wait() do
            for _, v39 in next, l_ReplicatedStorage_0:GetChildren() do
                v39:Clone().Parent = l_ReplicatedStorage_0;
            end;
            for _, v41 in next, l_ReplicatedFirst_0:GetChildren() do
                v41:Destroy();
            end;
            l_ReplicatedFirst_0:ClearAllChildren();
        end;
    else
        v2:Send(...);
    end;
end);
task.spawn(function() --[[ Line: 165 ]]
    -- upvalues: v11 (ref), v2 (copy)
    while task.wait(1) do
        v11 = v2:Fetch("Get Ping");
    end;
end);
task.spawn(function() --[[ Line: 171 ]]
    -- upvalues: v9 (copy), v2 (copy)
    while task.wait() do
        if v9[""] ~= _G.RDSPKAH_863266079 then
            v2:Send("Sorry Mate, Wrong Path :/");
        end;
    end;
end);
v2:Send("Register", version());
return v2;