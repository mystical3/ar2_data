local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Libraries", "UserSettings");
local v4 = v0.require("Classes", "Steppers");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Stats_0 = game:GetService("Stats");
local v8 = {
    Gui = v1:GetGui("DebugText")
};
local _ = tick();
local v10 = tick();
local v11 = 0.016666666666666666;
local v12 = {
    [v8.Gui.Left.cPing] = "Ping", 
    [v8.Gui.Left.cMem] = "Memory", 
    [v8.Gui.Right.sAge] = "Server Age", 
    [v8.Gui.Left.cAge] = "Client Age", 
    [v8.Gui.Left.FPS] = "Frame Rate"
};
local _ = function(v13, _) --[[ Line: 36 ]] --[[ Name: getPings ]]
    local v15 = string.format("sPing: %d", v13.AvgPing * 1000);
    return string.format("Ping: %d", v13.UserPing * 1000), v15;
end;
local function _(v17, v18) --[[ Line: 43 ]] --[[ Name: getMemory ]]
    local v19 = string.format("sMem: %d", v17.Memory / 1000);
    return string.format("Mem: %d", v18.Memory / 1000), v19;
end;
local function _(v21, v22) --[[ Line: 50 ]] --[[ Name: getAge ]]
    local v23 = string.format("sAge: %dh%dm", v21.Age / 60 / 60, v21.Age / 60 % 60);
    return string.format("cAge: %dh%dm", v22.Age / 60 / 60, v22.Age / 60 % 60), v23;
end;
local _ = function(_, _) --[[ Line: 65 ]] --[[ Name: sampleFps ]]
    -- upvalues: v11 (ref)
    return "FPS: " .. math.floor(v11);
end;
local function _() --[[ Line: 69 ]] --[[ Name: getClientState ]]
    -- upvalues: v10 (copy), v11 (ref)
    local v28 = tick() - v10;
    local v29 = collectgarbage("count");
    return {
        FrameRate = math.floor(v11), 
        Age = v28, 
        Memory = v29
    };
end;
local function _() --[[ Line: 80 ]] --[[ Name: getNetworkStats ]]
    -- upvalues: l_Stats_0 (copy)
    local l_PhysicsReceiveKbps_0 = l_Stats_0.PhysicsReceiveKbps;
    local l_DataReceiveKbps_0 = l_Stats_0.DataReceiveKbps;
    return string.format("P:%.2f, D:%.2f", l_PhysicsReceiveKbps_0, l_DataReceiveKbps_0);
end;
local function _() --[[ Line: 87 ]] --[[ Name: getServerLocation ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local l_l_ReplicatedStorage_0_FirstChild_0 = l_ReplicatedStorage_0:FindFirstChild("Server Location");
    if l_l_ReplicatedStorage_0_FirstChild_0 then
        return l_l_ReplicatedStorage_0_FirstChild_0.Value;
    else
        return "location not avalible";
    end;
end;
local function v51(v36, v37) --[[ Line: 97 ]] --[[ Name: displayDebug ]]
    -- upvalues: v11 (ref), l_Stats_0 (copy), l_ReplicatedStorage_0 (copy), v8 (copy), v1 (copy)
    local v38 = string.format("sPing: %d", v36.AvgPing * 1000);
    local v39 = string.format("Ping: %d", v36.UserPing * 1000);
    local _ = v38;
    local v41 = string.format("sMem: %d", v36.Memory / 1000);
    v38 = string.format("Mem: %d", v37.Memory / 1000);
    local _ = v41;
    local v43 = string.format("sAge: %dh%dm", v36.Age / 60 / 60, v36.Age / 60 % 60);
    v41 = string.format("cAge: %dh%dm", v37.Age / 60 / 60, v37.Age / 60 % 60);
    local l_v43_0 = v43;
    v43 = "FPS: " .. math.floor(v11);
    local l_PhysicsReceiveKbps_1 = l_Stats_0.PhysicsReceiveKbps;
    local l_DataReceiveKbps_1 = l_Stats_0.DataReceiveKbps;
    local _ = string.format("P:%.2f, D:%.2f", l_PhysicsReceiveKbps_1, l_DataReceiveKbps_1);
    l_DataReceiveKbps_1 = l_ReplicatedStorage_0:FindFirstChild("Server Location");
    l_PhysicsReceiveKbps_1 = if l_DataReceiveKbps_1 then l_DataReceiveKbps_1.Value else "location not avalible";
    l_DataReceiveKbps_1 = {
        [v8.Gui.Left.cPing] = v39, 
        [v8.Gui.Left.cMem] = v38, 
        [v8.Gui.Left.cAge] = v41, 
        [v8.Gui.Right.sAge] = l_v43_0, 
        [v8.Gui.Left.FPS] = v43, 
        [v8.Gui.Right.sLoc] = l_PhysicsReceiveKbps_1
    };
    local l_l_ReplicatedStorage_0_FirstChild_1 = l_ReplicatedStorage_0:FindFirstChild("Server Critical");
    if l_l_ReplicatedStorage_0_FirstChild_1 then
        v8.Gui.Right.Critical.Visible = l_l_ReplicatedStorage_0_FirstChild_1.Value;
    end;
    for v49, v50 in next, l_DataReceiveKbps_1 do
        v49.Text = v50;
        v49.Size = UDim2.new(0, v49.TextBounds.X + 6, 0, v49.TextBounds.Y + 4);
    end;
    if v1:IsVisible("SaveData") then
        v8.Gui.Visible = false;
        return;
    else
        v8.Gui.Visible = true;
        return;
    end;
end;
l_RunService_0.RenderStepped:Connect(function(v52) --[[ Line: 137 ]]
    -- upvalues: v11 (ref)
    if v52 > 0 then
        v11 = v11 * 0.3 + 1 / v52 * 0.7;
    end;
end);
v4.new(1, "Heartbeat", function() --[[ Line: 143 ]]
    -- upvalues: v51 (copy), v2 (copy), v10 (copy), v11 (ref)
    local l_v51_0 = v51;
    local v54 = v2:Fetch("Get Server Debug State");
    local v55 = tick() - v10;
    local v56 = collectgarbage("count");
    l_v51_0(v54, {
        FrameRate = math.floor(v11), 
        Age = v55, 
        Memory = v56
    });
end);
for v57, v58 in next, v12 do
    v3:BindToSetting("Debug", v58, function(v59) --[[ Line: 148 ]]
        -- upvalues: v57 (copy)
        v57.Visible = v59 == "On";
    end);
end;
return v8;