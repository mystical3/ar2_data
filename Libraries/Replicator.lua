local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Network");
local v2 = v0.require("Classes", "Springs");
local l_RunService_0 = game:GetService("RunService");
local v4 = {};
local v5 = {};
local v6 = Instance.new("NumberValue", workspace);
v6.Name = "Damp";
v6.Value = 0.95;
local v7 = Instance.new("NumberValue", workspace);
v7.Name = "Freq";
v7.Value = 5;
local function v9(v8) --[[ Line: 29 ]] --[[ Name: getJob ]]
    -- upvalues: v4 (copy), v2 (copy)
    if not v4[v8] then
        v4[v8] = {
            Anchored = true, 
            RawCFrame = v8.CFrame, 
            RawVelocity = v8.Velocity, 
            PingSmooth = 0, 
            Ping = 0, 
            Springs = {
                Velocity = v2.new(v8.Velocity, 5, 0.95), 
                Position = v2.new(v8.CFrame.Position, 5, 0.95), 
                LookVector = v2.new(v8.CFrame.LookVector, 5, 0.95), 
                UpVector = v2.new(v8.CFrame.UpVector, 5, 0.95)
            }, 
            LastUpdate = os.clock(), 
            RootPart = v8
        };
    end;
    return v4[v8];
end;
local function _(v10) --[[ Line: 56 ]] --[[ Name: clearJob ]]
    if v10.RootPart:IsDescendantOf(workspace) then
        v10.RootPart.Anchored = false;
    end;
    table.clear(v10.Springs);
    table.clear(v10);
end;
local function _(v12) --[[ Line: 65 ]] --[[ Name: isDeadJob ]]
    if v12.RootPart.Parent == nil or not v12.RootPart:IsDescendantOf(workspace) then
        return true;
    elseif os.clock() - v12.LastUpdate > 3 then
        return true;
    else
        return;
    end;
end;
local function _(v14, v15, v16, v17, v18) --[[ Line: 74 ]] --[[ Name: updateTarget ]]
    -- upvalues: v9 (copy)
    local v19 = v9(v14);
    v19.Ping = v18;
    v19.Anchored = v15;
    v19.RawCFrame = v16;
    v19.RawVelocity = v17;
    v19.LastUpdate = os.clock();
end;
local function v31(v21, v22) --[[ Line: 90 ]] --[[ Name: workJob ]]
    if v21.Anchored then
        v21.PingSmooth = v21.PingSmooth * 0.8 + v21.Ping * 0.2;
        local v23 = os.clock() - v21.LastUpdate;
        local v24 = math.min(v21.PingSmooth * 2, v23);
        local v25 = v21.Springs.Velocity:StepTo(v21.RawVelocity, v22);
        local v26 = v24 * v25;
        local v27 = v21.RawCFrame.Position + v26;
        local v28 = v21.Springs.Position:StepTo(v27, v22);
        local v29 = v21.Springs.LookVector:StepTo(v21.RawCFrame.LookVector, v22);
        local v30 = CFrame.new(v28, v28 + v29);
        v21.RootPart.Anchored = true;
        v21.RootPart.Velocity = v25;
        v21.RootPart.CFrame = v30;
        return;
    else
        v21.RootPart.Anchored = false;
        return;
    end;
end;
v1:Add("Replication Update", function(v32, v33, v34, v35, v36) --[[ Line: 122 ]]
    -- upvalues: v9 (copy)
    local v37 = v9(v32);
    v37.Ping = v36;
    v37.Anchored = v33;
    v37.RawCFrame = v34;
    v37.RawVelocity = v35;
    v37.LastUpdate = os.clock();
end);
l_RunService_0.Heartbeat:Connect(function(v38) --[[ Line: 126 ]]
    -- upvalues: v4 (copy), v31 (copy)
    local v39 = {};
    for v40, v41 in next, v4 do
        if v41.RootPart.Parent == nil or not v41.RootPart:IsDescendantOf(workspace) or os.clock() - v41.LastUpdate > 3 or nil then
            v39[v40] = v41;
        end;
    end;
    for v42, v43 in next, v39 do
        if v43.RootPart:IsDescendantOf(workspace) then
            v43.RootPart.Anchored = false;
        end;
        table.clear(v43.Springs);
        table.clear(v43);
        v4[v42] = nil;
    end;
    for _, v45 in next, v4 do
        v31(v45, v38);
    end;
end);
return v5;