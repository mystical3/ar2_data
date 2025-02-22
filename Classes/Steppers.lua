local l_RunService_0 = game:GetService("RunService");
local v1 = {};
v1.__index = v1;
local function v9(v2) --[[ Line: 8 ]] --[[ Name: stepperLogic ]]
    if v2.Working then
        return;
    else
        local v3 = os.clock();
        local v4 = v3 - v2.LastStep;
        local v5 = v2.Rate <= v4;
        local v6 = "";
        if v2.FireNextStepInstantly then
            v2.FireNextStepInstantly = false;
            v5 = true;
        end;
        if v5 then
            v2.Working = true;
            local v7, v8 = xpcall(v2.Action, debug.traceback, v3, v4);
            if not v7 then
                if v6 ~= v8 then
                    warn("Stepper error:");
                    print(v8);
                    v6 = v8;
                else
                    print(" ^- stepper is spamming");
                end;
                if v2.ErrorsDisconnect and v2.Connection then
                    v2.Connection:Disconnect();
                end;
                if v2.CustomErrorFunction then
                    v2.CustomErrorFunction(v8);
                end;
            else
                v2.LastStep = v3;
            end;
            v2.Working = false;
        end;
        return;
    end;
end;
v1.new = function(v10, v11, v12) --[[ Line: 61 ]] --[[ Name: new ]]
    -- upvalues: l_RunService_0 (copy), v9 (copy), v1 (copy)
    local v13 = {
        Enabled = true, 
        Rate = v10 or 0
    };
    v13.LastStep = os.clock() - v13.Rate;
    v13.Action = v12;
    v13.Working = false;
    v13.FireNextStepInstantly = false;
    v13.ErrorsDisconnect = false;
    v13.Connection = l_RunService_0[v11]:Connect(function() --[[ Line: 72 ]]
        -- upvalues: v9 (ref), v13 (copy)
        v9(v13);
    end);
    return (setmetatable(v13, v1));
end;
v1.Destroy = function(v14) --[[ Line: 81 ]] --[[ Name: Destroy ]]
    if v14.Destroyed then
        return;
    else
        v14.Destroyed = true;
        v14.Connection:Disconnect();
        setmetatable(v14, nil);
        table.clear(v14);
        v14.Destroyed = true;
        return;
    end;
end;
v1.Enable = function(v15) --[[ Line: 96 ]] --[[ Name: Enable ]]
    v15.Enabled = true;
    return v15;
end;
v1.Disable = function(v16) --[[ Line: 102 ]] --[[ Name: Disable ]]
    v16.Enabled = false;
    return v16;
end;
v1.ForceStep = function(v17) --[[ Line: 108 ]] --[[ Name: ForceStep ]]
    v17.FireNextStepInstantly = true;
    return v17;
end;
v1.SetRate = function(v18, v19) --[[ Line: 114 ]] --[[ Name: SetRate ]]
    v18.Rate = v19;
    return v18;
end;
v1.DisconnectsOnError = function(v20, v21) --[[ Line: 120 ]] --[[ Name: DisconnectsOnError ]]
    v20.ErrorsDisconnect = v21;
    return v20;
end;
v1.IsWorking = function(v22) --[[ Line: 126 ]] --[[ Name: IsWorking ]]
    return v22.Working;
end;
return v1;