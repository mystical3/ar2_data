local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local _ = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Steppers");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Stats_0 = game:GetService("Stats");
local v6 = {
    Gui = v1:GetGui("NetworkDebug")
};
local l_Inbound_0 = v6.Gui:WaitForChild("ScrollingFrame"):WaitForChild("Inbound");
local l_Outbound_0 = v6.Gui:WaitForChild("ScrollingFrame"):WaitForChild("Outbound");
local l_InboundTemplate_0 = v1:GetStorage("NetworkDebug"):WaitForChild("InboundTemplate");
local l_OutboundTemplate_0 = v1:GetStorage("NetworkDebug"):WaitForChild("OutboundTemplate");
local v11 = {
    In = l_Inbound_0, 
    Out = l_Outbound_0
};
local v12 = {
    In = l_InboundTemplate_0, 
    Out = l_OutboundTemplate_0
};
local v13 = {
    In = {}, 
    Out = {}
};
local function v23() --[[ Line: 43 ]] --[[ Name: scoreData ]]
    -- upvalues: v13 (copy)
    local v14 = {};
    for _, v16 in next, v13 do
        for v17 = #v16, 1, -1 do
            local v18 = v16[v17];
            if v18 and tick() - v18.Time > 10 then
                table.remove(v16, v17);
            end;
        end;
    end;
    for v19, v20 in next, v13 do
        v14[v19] = {};
        for _, v22 in next, v20 do
            if not v14[v19][v22.Name] then
                v14[v19][v22.Name] = {
                    Score = 0, 
                    Oldest = 1e999
                };
            end;
            v14[v19][v22.Name].Score = v14[v19][v22.Name].Score + 1;
            v14[v19][v22.Name].Oldest = math.min(v22.Time, v14[v19][v22.Name].Oldest);
        end;
    end;
    return v14;
end;
local function v32(v24) --[[ Line: 76 ]] --[[ Name: getOrder ]]
    local v25 = {};
    for v26, v27 in next, v24 do
        v25[v26] = {};
        for v28, _ in next, v27 do
            table.insert(v25[v26], v28);
        end;
        table.sort(v25[v26], function(v30, v31) --[[ Line: 86 ]]
            -- upvalues: v27 (copy)
            return v27[v30].Score > v27[v31].Score;
        end);
    end;
    return v25;
end;
local function v44(v33, v34) --[[ Line: 94 ]] --[[ Name: instanceLabels ]]
    -- upvalues: v11 (copy), v12 (copy)
    for v35, v36 in next, v34 do
        local v37 = v11[v35];
        local v38 = {};
        for _, v40 in next, v37:GetChildren() do
            if v40:IsA("GuiBase") then
                if not v33[v35][v40.Name] then
                    v40:Destroy();
                else
                    v38[v40.Name] = true;
                end;
            end;
        end;
        for _, v42 in next, v36 do
            if not v38[v42] then
                local v43 = v12[v35]:Clone();
                v43.Name = v42;
                v43.Parent = v37;
            end;
        end;
    end;
end;
local function v53(v45, v46) --[[ Line: 121 ]] --[[ Name: drawLabels ]]
    -- upvalues: v11 (copy), v6 (copy), l_Stats_0 (copy)
    for v47, v48 in next, v11 do
        for _, v50 in next, v48:GetChildren() do
            if v50:IsA("GuiBase") then
                local v51 = v45[v47][v50.Name].Score / 10;
                local v52 = table.find(v46[v47], v50.Name);
                v50.Size = UDim2.new(0, v51 * 10, 0, 16);
                v50.TextLabel.Text = string.format("%s: %.2f/sec", v50.Name, v51);
                v50.LayoutOrder = v52;
            end;
        end;
    end;
    v6.Gui.OutText.Text = string.format("%.2f Kbps :Outbound", l_Stats_0.DataSendKbps);
    v6.Gui.InText.Text = string.format("Inbound: %.2f Kbps", l_Stats_0.DataReceiveKbps);
end;
l_UserInputService_0.InputBegan:Connect(function(v54, v55) --[[ Line: 142 ]]
    -- upvalues: l_UserInputService_0 (copy), v6 (copy)
    if v54.UserInputType == Enum.UserInputType.Keyboard and not v55 then
        local v56 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.RightControl);
        local v57 = l_UserInputService_0:IsKeyDown(Enum.KeyCode.N);
        if v56 and v57 then
            v6.Gui.Visible = not v6.Gui.Visible;
        end;
    end;
end);
v3.new(1, "Heartbeat", function() --[[ Line: 161 ]]
    -- upvalues: v6 (copy), v23 (copy), v32 (copy), v44 (copy), v53 (copy)
    if v6.Gui.Visible then
        local v58 = v23();
        local v59 = v32(v58);
        v44(v58, v59);
        v53(v58, v59);
    end;
end);
return v6;