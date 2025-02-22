local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Maids");
local v4 = {};
v4.__index = v4;
local _ = {
    ["C-00"] = "S-00", 
    ["C-01"] = "S-01", 
    ["C-02"] = "S-02", 
    ["C-03"] = "S-03", 
    ["C-04"] = "S-04", 
    ["C-05"] = "S-05", 
    ["C-06"] = "S-06", 
    ["C-07"] = "S-07", 
    ["C-08"] = "S-08", 
    ["C-09"] = "S-09", 
    ["C-10"] = "S-10"
};
local function _(v6, v7, v8) --[[ Line: 29 ]] --[[ Name: bindToAttribute ]]
    local v9 = v6:GetAttributeChangedSignal(v7):Connect(function() --[[ Line: 30 ]]
        -- upvalues: v8 (copy), v6 (copy), v7 (copy)
        v8(v6:GetAttribute(v7));
    end);
    v8(v6:GetAttribute(v7));
    return v9;
end;
local _ = function(v11) --[[ Line: 39 ]] --[[ Name: prepModel ]]
    v11.Instance.PrimaryPart.Transparency = 1;
    v11.Instance.PrimaryPart.CanCollide = false;
    for _, v13 in next, v11.Instance:GetDescendants() do
        if v13.Name == "Pivot" then
            v13.Transparency = 1;
        end;
    end;
end;
local function v22(v15) --[[ Line: 50 ]] --[[ Name: getInteractionPoints ]]
    local v16 = {};
    for _, v18 in next, v15.Instance:GetChildren() do
        local v19 = nil;
        local l_Substation_0 = v18:FindFirstChild("Substation");
        if l_Substation_0 then
            v19 = l_Substation_0.Value;
        end;
        if v19 and v18.Name == "Route Switch" then
            local l_Part_0 = Instance.new("Part");
            l_Part_0.Size = v18:GetModelSize() * 1.1;
            l_Part_0.CFrame = v18:GetModelCFrame();
            l_Part_0.Transparency = 0.99;
            l_Part_0.Anchored = true;
            l_Part_0.CanCollide = false;
            l_Part_0.Name = "Hitbox";
            l_Part_0.Parent = v18;
            v16[v19] = l_Part_0.CFrame.p;
        end;
    end;
    return v16;
end;
local function v28(v23, v24) --[[ Line: 80 ]] --[[ Name: setSingleLED ]]
    local v25 = v23 and v23:FindFirstChild("Indicator") or v23 and v23:FindFirstChild("Interact Point");
    if v25 then
        local v26 = "ColorOff";
        if v24 then
            v26 = "ColorOn";
        end;
        local l_v25_FirstChild_0 = v25:FindFirstChild(v26);
        if l_v25_FirstChild_0 then
            v25.Color = l_v25_FirstChild_0.Value;
        end;
        if v24 then
            v25.Material = Enum.Material.Neon;
            return;
        else
            v25.Material = Enum.Material.Glass;
        end;
    end;
end;
local function v37(v29, v30) --[[ Line: 108 ]] --[[ Name: setPoweredLEDs ]]
    -- upvalues: v28 (copy)
    local l_v29_FirstChild_0 = v29:FindFirstChild("LED On");
    local l_v29_FirstChild_1 = v29:FindFirstChild("LED Off");
    local v33 = {};
    local v34 = true;
    if v30 ~= "On" then
        v34 = v30 == "Both";
    end;
    v33[l_v29_FirstChild_0] = v34;
    v34 = true;
    if v30 ~= "Off" then
        v34 = v30 == "Both";
    end;
    v33[l_v29_FirstChild_1] = v34;
    for v35, v36 in next, v33 do
        v28(v35, v36);
    end;
end;
local function v74(v38, v39, v40) --[[ Line: 122 ]] --[[ Name: linkSubstationModel ]]
    -- upvalues: v37 (copy), v28 (copy)
    local l_v39_Attribute_0 = v39:GetAttribute("Designation");
    local v42 = nil;
    local v43 = nil;
    for _, v45 in next, v40:GetChildren() do
        if v45.Name == "General Indicator" and not v42 then
            if v45.Substation.Value == l_v39_Attribute_0 then
                v42 = v45;
            end;
        elseif v45.name == "Route Switch" and not v43 and v45.Substation.Value == l_v39_Attribute_0 then
            v43 = v45;
        end;
        if v42 and v43 then
            break;
        end;
    end;
    if v42 then
        local l_v42_FirstChild_0 = v42:FindFirstChild("Power Indicator");
        local l_v42_FirstChild_1 = v42:FindFirstChild("Request Indicator");
        local l_v42_FirstChild_2 = v42:FindFirstChild("Route Indicator");
        if l_v42_FirstChild_0 then
            local l_Maid_0 = v38.Maid;
            local l_l_v42_FirstChild_0_0 = l_v42_FirstChild_0 --[[ copy: 6 -> 19 ]];
            local function v52(v51) --[[ Line: 149 ]]
                -- upvalues: v37 (ref), l_l_v42_FirstChild_0_0 (copy)
                v37(l_l_v42_FirstChild_0_0, v51);
            end;
            local l_v39_AttributeChangedSignal_0 = v39:GetAttributeChangedSignal("PoweredLED");
            local v54 = "PoweredLED";
            local l_v52_0 = v52 --[[ copy: 12 -> 20 ]];
            local l_v54_0 = v54 --[[ copy: 16 -> 21 ]];
            l_v39_AttributeChangedSignal_0 = l_v39_AttributeChangedSignal_0:Connect(function() --[[ Line: 30 ]]
                -- upvalues: l_v52_0 (copy), v39 (copy), l_v54_0 (copy)
                l_v52_0(v39:GetAttribute(l_v54_0));
            end);
            v52(v39:GetAttribute("PoweredLED"));
            l_Maid_0:Give(l_v39_AttributeChangedSignal_0);
        end;
        if l_v42_FirstChild_2 then
            local l_Maid_1 = v38.Maid;
            local function v59(v58) --[[ Line: 155 ]]
                -- upvalues: v37 (ref), l_v42_FirstChild_2 (copy)
                v37(l_v42_FirstChild_2, v58);
            end;
            local l_v39_AttributeChangedSignal_1 = v39:GetAttributeChangedSignal("RoutedLED");
            local v61 = "RoutedLED";
            local l_v59_0 = v59 --[[ copy: 12 -> 17 ]];
            local l_v61_0 = v61 --[[ copy: 16 -> 18 ]];
            l_v39_AttributeChangedSignal_1 = l_v39_AttributeChangedSignal_1:Connect(function() --[[ Line: 30 ]]
                -- upvalues: l_v59_0 (copy), v39 (copy), l_v61_0 (copy)
                l_v59_0(v39:GetAttribute(l_v61_0));
            end);
            v59(v39:GetAttribute("RoutedLED"));
            l_Maid_1:Give(l_v39_AttributeChangedSignal_1);
        end;
        if l_v42_FirstChild_1 then
            local l_Maid_2 = v38.Maid;
            local function v66(v65) --[[ Line: 161 ]]
                -- upvalues: v28 (ref), l_v42_FirstChild_1 (copy)
                v28(l_v42_FirstChild_1:FindFirstChild("LED"), v65);
            end;
            local l_v39_AttributeChangedSignal_2 = v39:GetAttributeChangedSignal("RouteRequestedLED");
            local v68 = "RouteRequestedLED";
            l_v39_AttributeChangedSignal_2 = l_v39_AttributeChangedSignal_2:Connect(function() --[[ Line: 30 ]]
                -- upvalues: v66 (copy), v39 (copy), v68 (copy)
                v66(v39:GetAttribute(v68));
            end);
            v66(v39:GetAttribute("RouteRequestedLED"));
            l_Maid_2:Give(l_v39_AttributeChangedSignal_2);
        end;
    end;
    if v43 then
        local l_Maid_3 = v38.Maid;
        local function v71(v70) --[[ Line: 168 ]]
            -- upvalues: v37 (ref), v43 (ref)
            v37(v43, v70);
        end;
        local l_v39_AttributeChangedSignal_3 = v39:GetAttributeChangedSignal("RoutedLED");
        local v73 = "RoutedLED";
        l_v39_AttributeChangedSignal_3 = l_v39_AttributeChangedSignal_3:Connect(function() --[[ Line: 30 ]]
            -- upvalues: v71 (copy), v39 (copy), v73 (copy)
            v71(v39:GetAttribute(v73));
        end);
        v71(v39:GetAttribute("RoutedLED"));
        l_Maid_3:Give(l_v39_AttributeChangedSignal_3);
    end;
end;
local function v87(v75, v76, v77) --[[ Line: 174 ]] --[[ Name: linkCircuitModel ]]
    -- upvalues: v37 (copy)
    local l_v76_Attribute_0 = v76:GetAttribute("Designation");
    local v79 = nil;
    for _, v81 in next, v77:GetChildren() do
        if v81.Name == "Circuit Indicator" and v81.Circuit.Value == l_v76_Attribute_0 then
            v79 = v81;
            break;
        end;
    end;
    if v79 then
        local l_Maid_4 = v75.Maid;
        local function v84(v83) --[[ Line: 188 ]]
            -- upvalues: v37 (ref), v79 (ref)
            v37(v79, v83);
        end;
        local l_v76_AttributeChangedSignal_0 = v76:GetAttributeChangedSignal("ReadyLED");
        local v86 = "ReadyLED";
        l_v76_AttributeChangedSignal_0 = l_v76_AttributeChangedSignal_0:Connect(function() --[[ Line: 30 ]]
            -- upvalues: v84 (copy), v76 (copy), v86 (copy)
            v84(v76:GetAttribute(v86));
        end);
        v84(v76:GetAttribute("ReadyLED"));
        l_Maid_4:Give(l_v76_AttributeChangedSignal_0);
    end;
end;
v4.new = function(v88, v89, _) --[[ Line: 196 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), v1 (copy), v22 (copy), v74 (copy), v87 (copy), v4 (copy)
    local v91 = {
        Type = "Power Station", 
        Id = v88, 
        Destroyed = false, 
        HomeCFrame = v89.PrimaryPart.CFrame, 
        Instance = v89, 
        Maid = v3.new(), 
        StateSource = v1:Find("Workspace.Map.Shared.Powered.Power Station")
    };
    v91.InteractionPoints = v22(v91);
    if v91.StateSource then
        for _, v93 in next, v91.StateSource:GetChildren() do
            if v93.Name == "Substation" then
                v74(v91, v93, v91.Instance);
            elseif v93.Name == "Circuit" then
                v87(v91, v93, v91.Instance);
            end;
        end;
    end;
    v91.Instance.PrimaryPart.Transparency = 1;
    v91.Instance.PrimaryPart.CanCollide = false;
    for _, v95 in next, v91.Instance:GetDescendants() do
        if v95.Name == "Pivot" then
            v95.Transparency = 1;
        end;
    end;
    return (setmetatable(v91, v4));
end;
v4.Destroy = function(v96) --[[ Line: 230 ]] --[[ Name: Destroy ]]
    if v96.Destroyed then
        return;
    else
        v96.Destroyed = true;
        if v96.Maid then
            v96.Maid:Destroy();
            v96.Maid = nil;
        end;
        setmetatable(v96, nil);
        table.clear(v96);
        v96.Destroyed = true;
        return;
    end;
end;
v4.GetInteractionPosition = function(v97, _, v99) --[[ Line: 248 ]] --[[ Name: GetInteractionPosition ]]
    local l_p_0 = v97.HomeCFrame.p;
    local v101 = 1e999;
    for _, v103 in next, v97.InteractionPoints do
        local l_Magnitude_0 = (v103 - v99).Magnitude;
        if l_Magnitude_0 < v101 then
            v101 = l_Magnitude_0;
            l_p_0 = v103;
        end;
    end;
    return l_p_0;
end;
v4.GetInterctionText = function(v105, _, v107) --[[ Line: 264 ]] --[[ Name: GetInterctionText ]]
    local v108 = "Interact";
    local l_p_1 = v105.HomeCFrame.p;
    local v110 = 1e999;
    for v111, v112 in next, v105.InteractionPoints do
        local l_Magnitude_1 = (v112 - v107).Magnitude;
        if l_Magnitude_1 < v110 then
            v108 = v111;
            v110 = l_Magnitude_1;
            l_p_1 = v112;
        end;
    end;
    return v108;
end;
v4.IsSubstationRouted = function(v114, v115) --[[ Line: 282 ]] --[[ Name: IsSubstationRouted ]]
    for _, v117 in next, v114.StateSource:GetChildren() do
        if v117.Name == "Substation" and v117:GetAttribute("Designation") == v115 then
            return v117:GetAttribute("Routed");
        end;
    end;
    return false;
end;
v4.Interact = function(v118, v119) --[[ Line: 294 ]] --[[ Name: Interact ]]
    -- upvalues: v2 (copy)
    local l_v118_InterctionText_0 = v118:GetInterctionText(nil, v119);
    v2:Send("World Interact", v118.Id, l_v118_InterctionText_0);
end;
v4.SetDetailed = function(_, _) --[[ Line: 300 ]] --[[ Name: SetDetailed ]]

end;
return v4;