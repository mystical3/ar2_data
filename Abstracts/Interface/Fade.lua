local v0 = require(game:GetService("ReplicatedFirst").Framework).require("Libraries", "Interface");
local l_RunService_0 = game:GetService("RunService");
local v2 = {
    Gui = v0:GetGui("Fade")
};
local l_BindableEvent_0 = Instance.new("BindableEvent");
local v4 = nil;
local v5 = 0;
local v6 = 0;
local v7 = 0;
v2.Fade = function(_, v9, v10) --[[ Line: 23 ]] --[[ Name: Fade ]]
    -- upvalues: l_BindableEvent_0 (copy), v2 (copy), v6 (ref), v7 (ref), v4 (ref), v5 (ref)
    if v10 == 0 then
        l_BindableEvent_0:Fire();
        v2.Gui.BackgroundTransparency = v9;
        v6 = 0;
        v7 = 0;
        return;
    else
        local v11 = 0;
        if v4 then
            v11 = (1 - (tick() - v7) / v6) * v6;
            l_BindableEvent_0:Fire();
        end;
        v6 = v10;
        v7 = tick() - v11;
        v5 = v2.Gui.BackgroundTransparency;
        v4 = v9;
        v2.Gui.Visible = true;
        return l_BindableEvent_0.Event;
    end;
end;
v2.SetText = function(_, v13, ...) --[[ Line: 54 ]] --[[ Name: SetText ]]
    -- upvalues: v2 (copy)
    v2.Gui.TextLabel.Text = v13:format(...):upper();
end;
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 60 ]]
    -- upvalues: v4 (ref), v7 (ref), v6 (ref), v2 (copy), l_BindableEvent_0 (copy), v5 (ref)
    if not v4 then
        return;
    else
        debug.profilebegin("Fade UI Step");
        local v14 = math.clamp((tick() - v7) / v6, 0, 1);
        if v14 >= 1 then
            v2.Gui.BackgroundTransparency = v4;
            v4 = nil;
            l_BindableEvent_0:Fire();
        else
            v2.Gui.BackgroundTransparency = v5 + (v4 - v5) * v14;
        end;
        v2.Gui.TextLabel.TextTransparency = v2.Gui.BackgroundTransparency;
        debug.profileend();
        return;
    end;
end);
v2.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 83 ]]
    -- upvalues: v2 (copy)
    v2.Gui.Visible = true;
end);
return v2;