local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "SplashScreens");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Network");
local v4 = v0.require("Classes", "Steppers");
local _ = game:GetService("TweenService");
local v6 = {
    Gui = v2:GetGui("SplashScreens")
};
local v7 = 0;
local v8 = {};
local v9 = {};
local v10 = nil;
local _ = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local _ = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local function v19() --[[ Line: 28 ]] --[[ Name: getOrder ]]
    -- upvalues: v1 (copy), v10 (ref)
    local v13 = os.time();
    local v14 = {};
    for v15, v16 in next, v1 do
        if v16.DisplayAfter < v13 and v13 < v16.ExpiresAfter and (v10[v15] == nil or v10[v15] ~= v16.ClickedValue) then
            table.insert(v14, v15);
        end;
    end;
    table.sort(v14, function(v17, v18) --[[ Line: 40 ]]
        -- upvalues: v1 (ref)
        return v1[v17].DisplayAfter < v1[v18].DisplayAfter;
    end);
    return v14;
end;
local function v23(v20, v21) --[[ Line: 47 ]] --[[ Name: popScreen ]]
    -- upvalues: v2 (copy), v3 (copy), v10 (ref), v1 (copy)
    v21.Visible = true;
    v2:Show("SplashScreens");
    v2:PlaySound("Interface.Bweep");
    local l_v21_FirstChild_0 = v21:FindFirstChild("CONFIRM", true);
    if l_v21_FirstChild_0 then
        l_v21_FirstChild_0.MouseButton1Click:Wait();
        v2:PlaySound("Interface.Click");
    end;
    v2:Hide("SplashScreens");
    v21.Visible = false;
    v3:Send("Log Splash Screen History", v20);
    v10[v20] = v1[v20].ClickedValue;
    task.wait(0.5);
end;
v6.TrySplash = function(_) --[[ Line: 70 ]] --[[ Name: TrySplash ]]
    -- upvalues: v0 (copy), v10 (ref), v3 (copy), v19 (copy), v7 (ref), v9 (copy)
    if v0.Configs.Globals.QuickPlay then
        return;
    else
        if not v10 then
            v10 = v3:Fetch("Get Splash Screen History");
        end;
        local v25 = v19();
        if v7 == 0 then
            v7 = os.clock() + 1;
        end;
        for v26 = 1, #v25 do
            local v27 = v25[v26];
            if not table.find(v9, v27) then
                table.insert(v9, v27);
            end;
        end;
        return;
    end;
end;
for v28, _ in next, v1 do
    local l_FirstChild_0 = v6.Gui:FindFirstChild(v28);
    if l_FirstChild_0 and l_FirstChild_0:IsA("Frame") then
        l_FirstChild_0.Visible = false;
        v8[v28] = l_FirstChild_0;
    end;
end;
v4.new(0, "Heartbeat", function() --[[ Line: 106 ]]
    -- upvalues: v7 (ref), v9 (copy), v8 (copy), v23 (copy)
    if os.clock() > v7 then
        local v31 = table.remove(v9, 1);
        local v32 = v31 and v8[v31];
        if v31 and v32 then
            v23(v31, v32);
        end;
    end;
end);
v3:Add("Sync Splash Screen History", function(v33) --[[ Line: 117 ]]
    -- upvalues: v10 (ref), v6 (copy)
    v10 = v33;
    v6:TrySplash();
end);
return v6;