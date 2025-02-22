local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Maids");
local v4 = {};
v4.__index = v4;
local function _(v5) --[[ Line: 15 ]] --[[ Name: findDesignation ]]
    return v5.Instance:WaitForChild("Power Switch"):WaitForChild("Substation").Value;
end;
local function _(v7, v8, v9) --[[ Line: 22 ]] --[[ Name: bindToAttribute ]]
    local v10 = v7:GetAttributeChangedSignal(v8):Connect(function() --[[ Line: 23 ]]
        -- upvalues: v9 (copy), v7 (copy), v8 (copy)
        v9(v7:GetAttribute(v8));
    end);
    v9(v7:GetAttribute(v8));
    return v10;
end;
local function v16(v12) --[[ Line: 32 ]] --[[ Name: findStateSource ]]
    -- upvalues: v1 (copy)
    local v13 = v1:Find("Workspace.Map.Shared.Powered.Power Station");
    for _, v15 in next, v13:GetChildren() do
        if v15.Name == "Substation" and v15:GetAttribute("Designation") == v12.Designation then
            return v15;
        end;
    end;
    return nil;
end;
local function v26(v17) --[[ Line: 46 ]] --[[ Name: prepModel ]]
    local v18 = v17.Instance:WaitForChild("Route Switch");
    local v19 = v17.Instance:WaitForChild("Power Switch");
    local v20 = v17.Instance:WaitForChild("Request Button");
    v17.Instance.PrimaryPart.Transparency = 1;
    v17.Instance.PrimaryPart.CanCollide = false;
    for _, v22 in next, {
        v18, 
        v19, 
        v20
    } do
        local l_Part_0 = Instance.new("Part");
        l_Part_0.Size = v22:GetModelSize() * 1.1;
        l_Part_0.CFrame = v22:GetModelCFrame();
        l_Part_0.Transparency = 0.99;
        l_Part_0.Anchored = true;
        l_Part_0.CanCollide = false;
        l_Part_0.Name = "Hitbox";
        l_Part_0.Parent = v22;
    end;
    for _, v25 in next, v17.Instance:GetDescendants() do
        if v25.Name == "Pivot" then
            v25.Transparency = 1;
        end;
    end;
end;
local function v34(v27) --[[ Line: 74 ]] --[[ Name: getInteractionPoints ]]
    local v28 = v27.Instance:WaitForChild("Route Switch");
    local v29 = v27.Instance:WaitForChild("Power Switch");
    local v30 = v27.Instance:WaitForChild("Request Button");
    local v31 = {};
    for _, v33 in next, {
        v28, 
        v29, 
        v30
    } do
        v31[v33.Name] = v33:GetModelCFrame().p;
    end;
    return v31;
end;
local function v40(v35, v36) --[[ Line: 88 ]] --[[ Name: setLEDLights ]]
    local v37 = v35:FindFirstChild("Interact Point") or v35:FindFirstChild("Indicator");
    if v37 then
        local v38 = "ColorOff";
        if v36 then
            v38 = "ColorOn";
        end;
        local l_v37_FirstChild_0 = v37:FindFirstChild(v38);
        if l_v37_FirstChild_0 then
            v37.Color = l_v37_FirstChild_0.Value;
        end;
        if v36 then
            v37.Material = Enum.Material.Neon;
            return;
        else
            v37.Material = Enum.Material.Glass;
        end;
    end;
end;
local function v50(v41, v42) --[[ Line: 116 ]] --[[ Name: setPoweredLEDs ]]
    -- upvalues: v40 (copy)
    local l_v41_FirstChild_0 = v41:FindFirstChild("Power Switch");
    local v44 = l_v41_FirstChild_0 and l_v41_FirstChild_0:FindFirstChild("LED On");
    local v45 = l_v41_FirstChild_0 and l_v41_FirstChild_0:FindFirstChild("LED Off");
    local v46 = {};
    local v47 = true;
    if v42 ~= "On" then
        v47 = v42 == "Both";
    end;
    v46[v44] = v47;
    v47 = true;
    if v42 ~= "Off" then
        v47 = v42 == "Both";
    end;
    v46[v45] = v47;
    for v48, v49 in next, v46 do
        v40(v48, v49);
    end;
end;
local function v60(v51, v52) --[[ Line: 131 ]] --[[ Name: setRoutedLEDs ]]
    -- upvalues: v40 (copy)
    local l_v51_FirstChild_0 = v51:FindFirstChild("Route Switch");
    local v54 = l_v51_FirstChild_0 and l_v51_FirstChild_0:FindFirstChild("LED On");
    local v55 = l_v51_FirstChild_0 and l_v51_FirstChild_0:FindFirstChild("LED Off");
    local v56 = {};
    local v57 = true;
    if v52 ~= "On" then
        v57 = v52 == "Both";
    end;
    v56[v54] = v57;
    v57 = true;
    if v52 ~= "Off" then
        v57 = v52 == "Both";
    end;
    v56[v55] = v57;
    for v58, v59 in next, v56 do
        v40(v58, v59);
    end;
end;
local function _(v61, v62) --[[ Line: 146 ]] --[[ Name: setRequestLed ]]
    -- upvalues: v40 (copy)
    local l_v61_FirstChild_0 = v61:FindFirstChild("Request Button");
    local v64 = l_v61_FirstChild_0 and l_v61_FirstChild_0:FindFirstChild("LED");
    if l_v61_FirstChild_0 then
        v40(v64, v62);
    end;
end;
local function v74(v66, v67) --[[ Line: 155 ]] --[[ Name: setIndicatorLights ]]
    -- upvalues: v40 (copy)
    local v68 = v66 and v66:FindFirstChild("LED On");
    local v69 = v66 and v66:FindFirstChild("LED Off");
    local v70 = {};
    local v71 = true;
    if v67 ~= "On" then
        v71 = v67 == "Both";
    end;
    v70[v68] = v71;
    v71 = true;
    if v67 ~= "Off" then
        v71 = v67 == "Both";
    end;
    v70[v69] = v71;
    for v72, v73 in next, v70 do
        v40(v72, v73);
    end;
end;
local function v88(v75) --[[ Line: 169 ]] --[[ Name: linkCircuitDisplays ]]
    -- upvalues: v1 (copy), v74 (copy)
    local v76 = v1:Find("Workspace.Map.Shared.Powered.Power Station");
    local v77 = {};
    for _, v79 in next, v76:GetChildren() do
        if v79.Name == "Circuit" then
            v77[v79:GetAttribute("Designation")] = v79;
        end;
    end;
    for _, v81 in next, v75.Instance:GetChildren() do
        if v81.Name == "Plant Indicator" then
            local v82 = v77[v81.Circuit.Value];
            local l_Maid_0 = v75.Maid;
            local function v85(v84) --[[ Line: 184 ]]
                -- upvalues: v74 (ref), v81 (copy)
                v74(v81, v84);
            end;
            local l_v82_AttributeChangedSignal_0 = v82:GetAttributeChangedSignal("ReadyLED");
            local v87 = "ReadyLED";
            l_v82_AttributeChangedSignal_0 = l_v82_AttributeChangedSignal_0:Connect(function() --[[ Line: 23 ]]
                -- upvalues: v85 (copy), v82 (copy), v87 (copy)
                v85(v82:GetAttribute(v87));
            end);
            v85(v82:GetAttribute("ReadyLED"));
            l_Maid_0:Give(l_v82_AttributeChangedSignal_0);
        end;
    end;
end;
v4.new = function(v89, v90, _) --[[ Line: 193 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), v16 (copy), v34 (copy), v74 (copy), v50 (copy), v60 (copy), v40 (copy), v88 (copy), v26 (copy), v4 (copy)
    local v92 = {
        Type = "Power Controllers", 
        Id = v89, 
        Destroyed = false, 
        HomeCFrame = v90.PrimaryPart.CFrame, 
        Instance = v90, 
        Maid = v3.new()
    };
    v92.Designation = v92.Instance:WaitForChild("Power Switch"):WaitForChild("Substation").Value;
    v92.StateSource = v16(v92);
    v92.InteractionPoints = v34(v92);
    if v92.StateSource then
        local l_Maid_1 = v92.Maid;
        local l_StateSource_0 = v92.StateSource;
        local function v96(v95) --[[ Line: 210 ]]
            -- upvalues: v92 (copy)
            v92.Powered = v95;
        end;
        local l_l_StateSource_0_AttributeChangedSignal_0 = l_StateSource_0:GetAttributeChangedSignal("Powered");
        local v98 = "Powered";
        local l_v96_0 = v96 --[[ copy: 8 -> 13 ]];
        local l_l_StateSource_0_0 = l_StateSource_0 --[[ copy: 7 -> 14 ]];
        local l_v98_0 = v98 --[[ copy: 12 -> 15 ]];
        l_l_StateSource_0_AttributeChangedSignal_0 = l_l_StateSource_0_AttributeChangedSignal_0:Connect(function() --[[ Line: 23 ]]
            -- upvalues: l_v96_0 (copy), l_l_StateSource_0_0 (copy), l_v98_0 (copy)
            l_v96_0(l_l_StateSource_0_0:GetAttribute(l_v98_0));
        end);
        v96(l_StateSource_0:GetAttribute("Powered"));
        l_Maid_1:Give(l_l_StateSource_0_AttributeChangedSignal_0);
        l_Maid_1 = v92.Maid;
        l_StateSource_0 = v92.StateSource;
        v96 = function(v102) --[[ Line: 214 ]]
            -- upvalues: v92 (copy)
            v92.Routed = v102;
        end;
        l_l_StateSource_0_AttributeChangedSignal_0 = l_StateSource_0:GetAttributeChangedSignal("Routed");
        v98 = "Routed";
        local l_v96_1 = v96 --[[ copy: 8 -> 16 ]];
        local l_l_StateSource_0_1 = l_StateSource_0 --[[ copy: 7 -> 17 ]];
        local l_v98_1 = v98 --[[ copy: 12 -> 18 ]];
        l_l_StateSource_0_AttributeChangedSignal_0 = l_l_StateSource_0_AttributeChangedSignal_0:Connect(function() --[[ Line: 23 ]]
            -- upvalues: l_v96_1 (copy), l_l_StateSource_0_1 (copy), l_v98_1 (copy)
            l_v96_1(l_l_StateSource_0_1:GetAttribute(l_v98_1));
        end);
        v96(l_StateSource_0:GetAttribute("Routed"));
        l_Maid_1:Give(l_l_StateSource_0_AttributeChangedSignal_0);
        l_Maid_1 = v92.Maid;
        l_StateSource_0 = v92.StateSource;
        v96 = function(v106) --[[ Line: 218 ]]
            -- upvalues: v92 (copy)
            v92.RouteRequested = v106;
        end;
        l_l_StateSource_0_AttributeChangedSignal_0 = l_StateSource_0:GetAttributeChangedSignal("RouteRequested");
        v98 = "RouteRequested";
        local l_v96_2 = v96 --[[ copy: 8 -> 19 ]];
        local l_l_StateSource_0_2 = l_StateSource_0 --[[ copy: 7 -> 20 ]];
        local l_v98_2 = v98 --[[ copy: 12 -> 21 ]];
        l_l_StateSource_0_AttributeChangedSignal_0 = l_l_StateSource_0_AttributeChangedSignal_0:Connect(function() --[[ Line: 23 ]]
            -- upvalues: l_v96_2 (copy), l_l_StateSource_0_2 (copy), l_v98_2 (copy)
            l_v96_2(l_l_StateSource_0_2:GetAttribute(l_v98_2));
        end);
        v96(l_StateSource_0:GetAttribute("RouteRequested"));
        l_Maid_1:Give(l_l_StateSource_0_AttributeChangedSignal_0);
        l_Maid_1 = v92.Maid;
        l_StateSource_0 = v92.StateSource;
        v96 = function(v110) --[[ Line: 224 ]]
            -- upvalues: v74 (ref), v92 (copy), v50 (ref)
            v74(v92.Instance:FindFirstChild("Power Indicator"), v110);
            v50(v92.Instance, v110);
        end;
        l_l_StateSource_0_AttributeChangedSignal_0 = l_StateSource_0:GetAttributeChangedSignal("PoweredLED");
        v98 = "PoweredLED";
        local l_v96_3 = v96 --[[ copy: 8 -> 22 ]];
        local l_l_StateSource_0_3 = l_StateSource_0 --[[ copy: 7 -> 23 ]];
        local l_v98_3 = v98 --[[ copy: 12 -> 24 ]];
        l_l_StateSource_0_AttributeChangedSignal_0 = l_l_StateSource_0_AttributeChangedSignal_0:Connect(function() --[[ Line: 23 ]]
            -- upvalues: l_v96_3 (copy), l_l_StateSource_0_3 (copy), l_v98_3 (copy)
            l_v96_3(l_l_StateSource_0_3:GetAttribute(l_v98_3));
        end);
        v96(l_StateSource_0:GetAttribute("PoweredLED"));
        l_Maid_1:Give(l_l_StateSource_0_AttributeChangedSignal_0);
        l_Maid_1 = v92.Maid;
        l_StateSource_0 = v92.StateSource;
        v96 = function(v114) --[[ Line: 229 ]]
            -- upvalues: v74 (ref), v92 (copy), v60 (ref)
            v74(v92.Instance:FindFirstChild("Route Indicator"), v114);
            v60(v92.Instance, v114);
        end;
        l_l_StateSource_0_AttributeChangedSignal_0 = l_StateSource_0:GetAttributeChangedSignal("RoutedLED");
        v98 = "RoutedLED";
        local l_v96_4 = v96 --[[ copy: 8 -> 25 ]];
        local l_l_StateSource_0_4 = l_StateSource_0 --[[ copy: 7 -> 26 ]];
        local l_v98_4 = v98 --[[ copy: 12 -> 27 ]];
        l_l_StateSource_0_AttributeChangedSignal_0 = l_l_StateSource_0_AttributeChangedSignal_0:Connect(function() --[[ Line: 23 ]]
            -- upvalues: l_v96_4 (copy), l_l_StateSource_0_4 (copy), l_v98_4 (copy)
            l_v96_4(l_l_StateSource_0_4:GetAttribute(l_v98_4));
        end);
        v96(l_StateSource_0:GetAttribute("RoutedLED"));
        l_Maid_1:Give(l_l_StateSource_0_AttributeChangedSignal_0);
        l_Maid_1 = v92.Maid;
        l_StateSource_0 = v92.StateSource;
        v96 = function(v118) --[[ Line: 234 ]]
            -- upvalues: v92 (copy), v40 (ref)
            local l_FirstChild_0 = v92.Instance:FindFirstChild("Request Indicator");
            local v120 = l_FirstChild_0 and l_FirstChild_0:FindFirstChild("LED");
            v40(v120, v118);
            local l_FirstChild_1 = v92.Instance:FindFirstChild("Request Button");
            local v122 = l_FirstChild_1 and l_FirstChild_1:FindFirstChild("LED");
            if l_FirstChild_1 then
                v40(v122, v118);
            end;
        end;
        l_l_StateSource_0_AttributeChangedSignal_0 = l_StateSource_0:GetAttributeChangedSignal("RouteRequestedLED");
        v98 = "RouteRequestedLED";
        l_l_StateSource_0_AttributeChangedSignal_0 = l_l_StateSource_0_AttributeChangedSignal_0:Connect(function() --[[ Line: 23 ]]
            -- upvalues: v96 (copy), l_StateSource_0 (copy), v98 (copy)
            v96(l_StateSource_0:GetAttribute(v98));
        end);
        v96(l_StateSource_0:GetAttribute("RouteRequestedLED"));
        l_Maid_1:Give(l_l_StateSource_0_AttributeChangedSignal_0);
    end;
    v88(v92);
    v26(v92);
    return (setmetatable(v92, v4));
end;
v4.Destroy = function(v123) --[[ Line: 253 ]] --[[ Name: Destroy ]]
    if v123.Destroyed then
        return;
    else
        v123.Destroyed = true;
        if v123.Maid then
            v123.Maid:Destroy();
            v123.Maid = nil;
        end;
        setmetatable(v123, nil);
        table.clear(v123);
        v123.Destroyed = true;
        return;
    end;
end;
v4.GetInteractionPosition = function(v124, _, v126) --[[ Line: 271 ]] --[[ Name: GetInteractionPosition ]]
    local l_p_0 = v124.HomeCFrame.p;
    local v128 = 1e999;
    for _, v130 in next, v124.InteractionPoints do
        local l_Magnitude_0 = (v130 - v126).Magnitude;
        if l_Magnitude_0 < v128 then
            v128 = l_Magnitude_0;
            l_p_0 = v130;
        end;
    end;
    return l_p_0;
end;
v4.GetInterctionText = function(v132, _, v134) --[[ Line: 287 ]] --[[ Name: GetInterctionText ]]
    local v135 = "Interact";
    local l_p_1 = v132.HomeCFrame.p;
    local v137 = 1e999;
    for v138, v139 in next, v132.InteractionPoints do
        local l_Magnitude_1 = (v139 - v134).Magnitude;
        if l_Magnitude_1 < v137 then
            v135 = v138;
            v137 = l_Magnitude_1;
            l_p_1 = v139;
        end;
    end;
    return v135;
end;
v4.Interact = function(v141, v142) --[[ Line: 305 ]] --[[ Name: Interact ]]
    -- upvalues: v2 (copy)
    local l_v141_InterctionText_0 = v141:GetInterctionText(nil, v142);
    v2:Send("World Interact", v141.Id, l_v141_InterctionText_0);
end;
v4.SetDetailed = function(_, _) --[[ Line: 311 ]] --[[ Name: SetDetailed ]]

end;
return v4;