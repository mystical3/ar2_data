local l_RunService_0 = game:GetService("RunService");
local v1 = {};
local v2 = {};
local v3 = {};
local function _(v4) --[[ Line: 13 ]] --[[ Name: splitPath ]]
    local v5 = {};
    for v6 in v4:gmatch("[^.,]+") do
        table.insert(v5, v6);
    end;
    return v5;
end;
local function v17(v8, v9, v10) --[[ Line: 23 ]] --[[ Name: getFromPath ]]
    -- upvalues: v2 (copy)
    local v11 = {};
    for v12 in v9:gmatch("[^.,]+") do
        table.insert(v11, v12);
    end;
    local l_v11_0 = v11;
    v11 = v8;
    local v14 = {
        Path = v8:GetFullName() .. "." .. v9, 
        LastChild = v8 == game and "Game" or v8.Name, 
        LastStep = os.clock(), 
        Traceback = debug.traceback(), 
        TimeWarned = false, 
        Completed = false
    };
    table.insert(v2, v14);
    for _, v16 in next, l_v11_0 do
        v14.LastChild = v16;
        if v11 == game then
            v11 = v11:GetService(v16);
            if not v11 then
                error("Resources failed: Cannot get game service " .. v16);
            end;
        elseif v10 then
            v11 = v11:WaitForChild(v16, 100000);
        else
            v11 = v11:FindFirstChild(v16);
        end;
        v14.LastStep = os.clock();
        v14.TimeWarned = false;
        if not v11 then
            break;
        end;
    end;
    v14.Completed = true;
    return v11;
end;
v1.Search = function(_, v19) --[[ Line: 72 ]] --[[ Name: Search ]]
    -- upvalues: v17 (copy)
    return (v17(game, v19, false));
end;
v1.Find = function(_, v21) --[[ Line: 77 ]] --[[ Name: Find ]]
    -- upvalues: v17 (copy)
    return (v17(game, v21, true));
end;
v1.Get = function(_, v23, v24) --[[ Line: 82 ]] --[[ Name: Get ]]
    -- upvalues: v17 (copy)
    local v25 = v17(game, v23, true):Clone();
    v25.Parent = v24;
    return v25;
end;
v1.FindFrom = function(_, v27, v28) --[[ Line: 92 ]] --[[ Name: FindFrom ]]
    -- upvalues: v17 (copy)
    return (v17(v27, v28, true));
end;
v1.SearchFrom = function(_, v30, v31) --[[ Line: 97 ]] --[[ Name: SearchFrom ]]
    -- upvalues: v17 (copy)
    return (v17(v30, v31, false));
end;
v1.GetFrom = function(_, v33, v34, v35) --[[ Line: 102 ]] --[[ Name: GetFrom ]]
    -- upvalues: v3 (copy), v17 (copy)
    if typeof(v33) == "string" then
        v33 = v3[v33];
    end;
    local v36 = v17(v33, v34, true):Clone();
    v36.Parent = v35;
    return v36;
end;
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 119 ]]
    -- upvalues: v2 (copy)
    for v37 = #v2, 1, -1 do
        local v38 = v2[v37];
        if v38 then
            if v38.Completed then
                table.remove(v2, v37);
            elseif not v38.TimeWarned and os.clock() - v38.LastStep > 20 then
                warn("Resources stalled at \"" .. v38.LastChild .. "\" on path: " .. v38.Path);
                print(v38.Traceback);
                v38.TimeWarned = true;
            end;
        end;
    end;
end);
return v1;