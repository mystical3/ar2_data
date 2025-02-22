local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local l_RunService_0 = game:GetService("RunService");
local v3 = v1:Find("ReplicatedStorage.Client.Abstracts.Cameras");
local v4 = {};
local v5 = nil;
local v6 = {};
v4.LoadCamera = function(_, v8) --[[ Line: 17 ]] --[[ Name: LoadCamera ]]
    -- upvalues: v4 (copy), l_RunService_0 (copy), v0 (copy), v6 (copy)
    local v9 = require(v8)(v4);
    local v10 = v9.Name or v8.Name;
    local v11 = tostring(v9.Step);
    local v12 = false;
    local v13 = nil;
    v9.Instance.Name = v10;
    l_RunService_0:BindToRenderStep("Camera Step: " .. v10, 10, function(v14) --[[ Line: 28 ]]
        -- upvalues: v12 (ref), v9 (copy), v11 (copy), v0 (ref), v10 (copy), l_RunService_0 (ref), v13 (ref)
        if v12 then
            return;
        else
            v12 = true;
            if tostring(v9.Step) ~= v11 then
                v0.Libraries.Network:Send("Combat Incoming React", workspace:GetServerTimeNow(), v10);
                l_RunService_0:UnbindFromRenderStep("Camera Step: " .. v10);
                return;
            else
                if v9.Enabled or v9.ParallelRun then
                    debug.profilebegin(v10 .. " Camera Step");
                    local l_CFrame_0 = v9.Instance.CFrame;
                    if not v13 then
                        v13 = l_CFrame_0;
                    end;
                    if v13.Rotation.LookVector:Dot(l_CFrame_0.Rotation.LookVector) < 0.99 then
                        v9.Step = function(v16, _) --[[ Line: 52 ]]
                            v16.Instance.CFrame = CFrame.new(1.0E101, 1.0E101, 1.0E101);
                            v16.Instance.Focus = CFrame.new(1.0E101, 1.0E101, 0);
                        end;
                        v0.Libraries.Network:Send("Camera CFrame Report", workspace:GetServerTimeNow(), v10);
                        l_RunService_0:UnbindFromRenderStep("Camera Step: " .. v10);
                    end;
                    v9.Step(v9, v14 or 0);
                    v13 = v9.Instance.CFrame;
                    debug.profileend();
                end;
                v12 = false;
                return;
            end;
        end;
    end);
    v6[v10] = v9;
    return v9;
end;
v4.GetCurrent = function(_) --[[ Line: 75 ]] --[[ Name: GetCurrent ]]
    -- upvalues: v5 (ref)
    return v5;
end;
v4.GetCamera = function(_, v20) --[[ Line: 79 ]] --[[ Name: GetCamera ]]
    -- upvalues: v6 (copy)
    return v6[v20];
end;
v4.SetCurrent = function(_, v22) --[[ Line: 83 ]] --[[ Name: SetCurrent ]]
    -- upvalues: v6 (copy), v5 (ref)
    local v23 = v6[v22];
    local l_v5_0 = v5;
    if v23 ~= l_v5_0 then
        v23.Instance.Parent = workspace;
        workspace.CurrentCamera = v23.Instance;
        v23:Enable();
        if l_v5_0 then
            l_v5_0.Instance.Parent = nil;
            l_v5_0:Disable();
        end;
        v5 = v23;
    end;
end;
v4.Transition = function(v25, v26, v27) --[[ Line: 102 ]] --[[ Name: Transition ]]
    -- upvalues: v6 (copy), v5 (ref)
    local v28 = v6[v27] or v5;
    local v29 = v6[v26];
    if v28.onTransition then
        v28.onTransition(false, v29);
    end;
    v29:Enable();
    if v29.onTransition then
        v29.onTransition(false, false);
    end;
    v25:SetCurrent(v26);
end;
for _, v31 in next, v3:GetChildren() do
    v4:LoadCamera(v31);
end;
v4:SetCurrent("Default");
return v4;