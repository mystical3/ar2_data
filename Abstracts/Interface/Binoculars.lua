local l_TweenService_0 = game:GetService("TweenService");
local v1 = require(game:GetService("ReplicatedFirst").Framework);
local v2 = v1.require("Configs", "Globals");
local v3 = v1.require("Libraries", "Interface");
local v4 = v1.require("Libraries", "Raycasting");
local v5 = v1.require("Libraries", "Resources");
local _ = v1.require("Classes", "Springs");
local v7 = v1.require("Classes", "Steppers");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("UserInputService");
local v10 = v5:Find("Workspace.Effects");
local v11 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v12 = {
    BackgroundTransparency = 0
};
local v13 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local v14 = {
    BackgroundTransparency = 1
};
local v15 = Random.new();
local v16 = {
    "a", 
    "b", 
    "c", 
    "d", 
    "e", 
    "f", 
    "g", 
    "h", 
    "i", 
    "j", 
    "k", 
    "l", 
    "m", 
    "n", 
    "o", 
    "p", 
    "q", 
    "r", 
    "s", 
    "t", 
    "u", 
    "v", 
    "w", 
    "x", 
    "y", 
    "z", 
    "1", 
    "2", 
    "3", 
    "4", 
    "5", 
    "6", 
    "7", 
    "8", 
    "9", 
    "0", 
    "-", 
    "=", 
    "!", 
    "@", 
    "#", 
    "$", 
    "%", 
    "^", 
    "&", 
    "*", 
    "(", 
    ")", 
    "_", 
    "?", 
    ">", 
    "<", 
    "/", 
    "\\"
};
local v17 = {
    Gui = v3:GetGui("Binoculars")
};
local v18 = false;
local v19 = false;
local v20 = "Binoculars";
local v21 = {};
local v22 = {};
local function _() --[[ Line: 55 ]] --[[ Name: getBinocularsSkin ]]
    -- upvalues: v1 (copy)
    local l_Players_0 = v1.Classes.Players;
    if l_Players_0 then
        local v24 = l_Players_0.get();
        if v24 and v24.Character and not v24.Character.Dead then
            local l_Character_0 = v24.Character;
            if l_Character_0.BinocularsEnabled ~= "" then
                return l_Character_0.BinocularsEnabled;
            end;
        end;
    end;
    return nil;
end;
local function v32(v27, v28, v29) --[[ Line: 73 ]] --[[ Name: playSound ]]
    -- upvalues: v5 (copy), v1 (copy)
    local v30 = "ReplicatedStorage.Assets.Sounds." .. v28;
    local v31 = v5:Get(v30, v27);
    v31.Ended:Connect(function() --[[ Line: 77 ]]
        -- upvalues: v1 (ref), v31 (copy)
        v1.destroy(v31, "Ended");
    end);
    if v29 then
        v29(v31);
    end;
    v31:Play();
    return v31;
end;
local _ = function(v33) --[[ Line: 90 ]] --[[ Name: setSkin ]]
    -- upvalues: v17 (copy)
    if not v33 then
        v33 = "__off";
    end;
    for _, v35 in next, v17.Gui.Scopes:GetChildren() do
        v35.Visible = v35.Name == v33;
    end;
end;
local function _(v37, v38) --[[ Line: 100 ]] --[[ Name: formatScanText ]]
    -- upvalues: v15 (copy), v16 (copy)
    local v39 = string.len(v37);
    local v40 = (v39 % 2 == 0 and 30 or 29) - v39;
    local v41 = string.rep(" ", (math.floor(v40 / 2))) .. v37 .. string.rep(" ", (math.ceil(v40 / 2)));
    local v42 = "";
    for v43 in string.gmatch(v41, ".") do
        if v15:NextNumber() < math.sqrt(v38) then
            local v44 = v15:NextInteger(1, #v16);
            local l_upper_0 = string.upper;
            if v15:NextNumber() > 0.5 then
                l_upper_0 = string.lower;
            end;
            v43 = l_upper_0(v16[v44]);
        end;
        v42 = v42 .. v43;
    end;
    return v42;
end;
local function v53() --[[ Line: 129 ]] --[[ Name: animate ]]
    -- upvalues: l_TweenService_0 (copy), v17 (copy), v11 (copy), v12 (copy), v13 (copy), v14 (copy), v18 (ref), v20 (ref), v19 (ref), v1 (copy)
    local v47 = l_TweenService_0:Create(v17.Gui.Fade, v11, v12);
    local v48 = l_TweenService_0:Create(v17.Gui.Fade, v13, v14);
    local v49 = nil;
    v47.Completed:Connect(function() --[[ Line: 134 ]]
        -- upvalues: v49 (ref), v18 (ref), v20 (ref), v17 (ref), v48 (copy)
        v49 = v18;
        local v50 = v20 or "__off";
        for _, v52 in next, v17.Gui.Scopes:GetChildren() do
            v52.Visible = v52.Name == v50;
        end;
        v17.Gui.Scopes.Visible = v49;
        v17.BinocularsReady = v49 and v20 or "";
        v17.CameraSnapRequested = true;
        v48:Play();
    end);
    v47:Play();
    v48.Completed:Wait();
    v19 = v49;
    v1.destroy(v47, "Completed");
    v1.destroy(v48, "Completed");
end;
local l_Binoculars_0 = v17.Gui.Scopes.Binoculars;
local l_StatusDisplay_0 = l_Binoculars_0.StatusDisplay;
local l_InfoDisplay_0 = l_Binoculars_0.InfoDisplay;
local v57 = 0;
local v58 = nil;
local v59 = 0;
local v60 = 0;
local v61 = os.clock();
local l_l_Binoculars_0_0 = l_Binoculars_0 --[[ copy: 28 -> 36 ]];
local l_l_StatusDisplay_0_0 = l_StatusDisplay_0 --[[ copy: 29 -> 37 ]];
do
    local l_v57_0, l_v58_0, l_v59_0, l_v60_0, l_v61_0 = v57, v58, v59, v60, v61;
    v21.Binoculars = function(v69) --[[ Line: 172 ]]
        -- upvalues: l_v61_0 (ref), l_l_Binoculars_0_0 (copy), v2 (copy), v4 (copy), l_v60_0 (ref), l_v58_0 (ref), v32 (copy), v10 (copy), l_v59_0 (ref), l_l_StatusDisplay_0_0 (copy), l_v57_0 (ref), l_InfoDisplay_0 (copy)
        local v70 = os.clock() - l_v61_0;
        l_v61_0 = os.clock();
        if v69.ClickId then
            v69.ClickId = nil;
            local v71 = l_l_Binoculars_0_0.Crosshair.AbsolutePosition + l_l_Binoculars_0_0.Crosshair.AbsoluteSize * 0.5 + v2.GuiInset;
            local v72 = workspace.CurrentCamera:ViewportPointToRay(v71.X, v71.Y);
            local v73 = v4:BinocularsCast(v72);
            l_v60_0 = 0;
            l_v58_0 = nil;
            v32(v10, "Interface.Blip");
            if v73 then
                l_v58_0 = v73;
                l_v59_0 = os.clock() + 2;
                l_v60_0 = 7;
                l_l_StatusDisplay_0_0.Text = "Identifying...";
            else
                l_l_StatusDisplay_0_0.Text = "Can't Identify";
            end;
            l_v57_0 = os.clock() + 2;
        end;
        if os.clock() > l_v57_0 then
            l_l_StatusDisplay_0_0.Text = "";
        end;
        if os.clock() > l_v59_0 then
            if l_v58_0 then
                l_v60_0 = l_v60_0 - v70;
                if l_v60_0 <= 0 then
                    l_v58_0 = nil;
                end;
            end;
            if l_InfoDisplay_0.Text == "" and l_v58_0 then
                v32(v10, "Interface.Bweep");
            end;
            if l_v58_0 then
                l_InfoDisplay_0.Text = l_v58_0;
                return;
            else
                l_InfoDisplay_0.Text = "";
                return;
            end;
        else
            l_InfoDisplay_0.Text = "";
            return;
        end;
    end;
end;
l_Binoculars_0 = v17.Gui.Scopes["Military Rangefinder"];
l_StatusDisplay_0 = l_Binoculars_0.InfoDisplay;
v21["Military Rangefinder"] = function(v74, v75) --[[ Line: 233 ]]
    -- upvalues: l_StatusDisplay_0 (copy), l_Binoculars_0 (copy), v2 (copy), v4 (copy), v32 (copy), v10 (copy)
    if not v74.Budget then
        v74.Budget = 0;
        v74.Set = true;
    end;
    if v74.ClickId then
        v74.ClickId = nil;
        v74.Budget = 0.5;
        l_StatusDisplay_0.Text = "Processing...";
        v74.Set = false;
    end;
    if v74.Budget > 0 then
        v74.Budget = v74.Budget - v75;
    end;
    if v74.Budget <= 0 and not v74.Set then
        local v76 = l_Binoculars_0.Crosshair.AbsolutePosition + l_Binoculars_0.Crosshair.AbsoluteSize * 0.5 + v2.GuiInset;
        local v77 = workspace.CurrentCamera:ViewportPointToRay(v76.X, v76.Y);
        l_StatusDisplay_0.Text = v4:RangefinderCast(v77);
        v74.Set = true;
        v32(v10, "Interface.Bweep");
    end;
end;
v17.GetState = function(_) --[[ Line: 266 ]] --[[ Name: GetState ]]
    -- upvalues: v19 (ref)
    return v19;
end;
v17.Set = function(_, v80) --[[ Line: 270 ]] --[[ Name: Set ]]
    -- upvalues: v18 (ref)
    v18 = not not v80;
end;
v17.SetSkin = function(_, v82) --[[ Line: 274 ]] --[[ Name: SetSkin ]]
    -- upvalues: v20 (ref), v17 (copy)
    v20 = v82;
    local v83 = v20 or "__off";
    for _, v85 in next, v17.Gui.Scopes:GetChildren() do
        v85.Visible = v85.Name == v83;
    end;
end;
v17.SetVariable = function(_, v87, v88) --[[ Line: 280 ]] --[[ Name: SetVariable ]]
    -- upvalues: v22 (ref)
    v22[v87] = v88;
end;
v17.GetVariable = function(_, v90) --[[ Line: 284 ]] --[[ Name: GetVariable ]]
    -- upvalues: v22 (ref)
    return v22[v90];
end;
v7.new(0, "Heartbeat", function() --[[ Line: 290 ]]
    -- upvalues: v17 (copy), v18 (ref), v19 (ref), v53 (copy), v22 (ref)
    v17.Gui.Visible = true;
    if v18 ~= v19 then
        v53();
    end;
    if not v19 then
        v22 = {};
    end;
end);
l_RunService_0.Heartbeat:Connect(function(v91) --[[ Line: 302 ]]
    -- upvalues: v1 (copy), v21 (copy), v20 (ref), v17 (copy), v19 (ref), v22 (ref)
    local v92 = false;
    local l_Players_1 = v1.Classes.Players;
    local v94;
    if l_Players_1 then
        local v95 = l_Players_1.get();
        if v95 and v95.Character and not v95.Character.Dead then
            local l_Character_1 = v95.Character;
            if l_Character_1.BinocularsEnabled ~= "" then
                v94 = l_Character_1.BinocularsEnabled;
                v92 = true;
            end;
        end;
    end;
    if not v92 then
        v94 = nil;
    end;
    v92 = false;
    if v94 and v21[v94] then
        if v94 ~= v20 then
            v17:SetSkin(v94);
        end;
        v17:Set(true);
    else
        v17:Set(false);
    end;
    if v19 and v21[v20] then
        v21[v20](v22, v91);
    end;
end);
return v17;