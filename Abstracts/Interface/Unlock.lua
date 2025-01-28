local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "ItemData");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Discovery");
local _ = v0.require("Libraries", "Resources");
local v5 = v0.require("Libraries", "ViewportIcons");
local l_TextService_0 = game:GetService("TextService");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v9 = {
    Gui = v2:GetGui("Unlock")
};
local v10 = {
    [1] = v9.Gui.Bottom.Hat.NameLine1, 
    [2] = v9.Gui.Bottom.Hat.NameLine2
};
local v11 = {
    [1] = v9.Gui.Bottom.Hat.DescLine1, 
    [2] = v9.Gui.Bottom.Hat.DescLine2
};
local v12 = {};
local v13 = false;
local v14 = UDim2.new(1, -35, 1, -386);
local v15 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
local v16 = UDim2.new(1, 300, 1, -386);
local v17 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
local function v26(v18, v19, v20) --[[ Line: 42 ]] --[[ Name: splitIntoLines ]]
    -- upvalues: l_TextService_0 (copy)
    local v21 = Vector2.new(1000, 1000);
    local v22 = {};
    local v23 = "";
    for v24 in v18:gmatch("%S+") do
        local l_v24_0 = v24;
        if v23 ~= "" then
            l_v24_0 = v23 .. " " .. v24;
        end;
        if v20 < l_TextService_0:GetTextSize(l_v24_0, v19.TextSize, v19.Font, v21).X then
            table.insert(v22, v23);
            v23 = v24;
        else
            v23 = l_v24_0;
        end;
    end;
    table.insert(v22, v23);
    return v22;
end;
local function v38(v27) --[[ Line: 69 ]] --[[ Name: tweenSequence ]]
    -- upvalues: v1 (copy), v26 (copy), v9 (copy), v11 (copy), v10 (copy), v5 (copy), v16 (copy), l_TweenService_0 (copy), v15 (copy), v14 (copy), v17 (copy), v2 (copy)
    local v28 = v1[v27].Description or "";
    local v29 = v1[v27].DisplayName or v27;
    local v30 = v26(v28, v9.Gui.Bottom.Hat.DescLine1, 158);
    local v31 = v26(v29, v9.Gui.Bottom.Hat.NameLine1, 107);
    for v32, v33 in next, v11 do
        v33.Text = v30[v32] or "";
    end;
    for v34, v35 in next, v10 do
        v35.Text = v31[v34] or "";
    end;
    if v1[v27].DisplayedInCreator then
        v5:SetViewportIcon(v9.Gui.Bottom.Hat.Selected.Icon, v27, "Creator");
    else
        v5:ClearViewportIcon(v9.Gui.Bottom.Hat.Selected.Icon);
    end;
    v9.Gui.Bottom.Hat.Label.Text = v1[v27].EquipSlot;
    v9.Gui.Position = v16;
    v9.Gui.Visible = true;
    local v36 = l_TweenService_0:Create(v9.Gui, v15, {
        Position = v14
    });
    local v37 = l_TweenService_0:Create(v9.Gui, v17, {
        Position = v16
    });
    v36.Completed:Connect(function() --[[ Line: 97 ]]
        -- upvalues: v2 (ref), v37 (copy)
        v2:PlaySound("Interface.Bweep");
        task.wait(3);
        v37:Play();
    end);
    v36:Play();
    v37.Completed:Wait();
end;
v9.ClearQueue = function(_) --[[ Line: 109 ]] --[[ Name: ClearQueue ]]
    -- upvalues: v9 (copy), v12 (ref)
    v9.Gui.Visible = false;
    v12 = {};
end;
v3.Discovered:Connect(function(v40) --[[ Line: 116 ]]
    -- upvalues: v12 (ref)
    table.insert(v12, v40);
end);
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 120 ]]
    -- upvalues: v13 (ref), v12 (ref), v1 (copy), v38 (copy)
    if v13 then
        return;
    else
        v13 = true;
        local v41 = table.remove(v12, 1);
        if v41 and v1[v41] then
            v38(v41);
        end;
        v13 = false;
        return;
    end;
end);
return v9;