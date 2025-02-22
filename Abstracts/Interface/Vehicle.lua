local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Configs", "PerkTuning");
local v3 = v0.require("Libraries", "Interface");
local v4 = v0.require("Libraries", "Resources");
local v5 = v0.require("Libraries", "Network");
local v6 = v0.require("Libraries", "Keybinds");
local v7 = v0.require("Classes", "Steppers");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TextService_0 = game:GetService("TextService");
local l_RunService_0 = game:GetService("RunService");
local l_v3_Storage_0 = v3:GetStorage("Vehicle");
local v12 = v4:Find("Workspace.Vehicles.Spawned");
local v13 = {
    Gui = v3:GetGui("Vehicle")
};
local l_HoverGuiTemplate_0 = l_v3_Storage_0:WaitForChild("HoverGuiTemplate");
local _ = v13.Gui:WaitForChild("HoverWindow");
local v16 = nil;
local v17 = {};
local v18 = {};
local v19 = 0;
local v20 = nil;
local v21 = nil;
local l_IconImages_0 = v3:Get("Controls"):GetIconImages();
local l_KeyAliases_0 = v3:Get("Controls"):GetKeyAliases();
local l_Lengths_0, v25 = v3:Get("Controls"):GetLengths();
local v26 = {
    Full = {
        1, 
        2
    }, 
    Good = {
        0.6666666666666666, 
        1
    }, 
    Okay = {
        0.3333333333333333, 
        0.6666666666666666
    }, 
    Bad = {
        0, 
        0.3333333333333333
    }
};
local v27 = {
    Use = {
        Ring = Color3.fromRGB(83, 114, 255), 
        Icon = Color3.fromRGB(255, 255, 255), 
        Backdrop = Color3.fromRGB(0, 0, 0)
    }, 
    Full = {
        Ring = Color3.fromRGB(0, 188, 120), 
        Icon = Color3.fromRGB(255, 255, 255), 
        Backdrop = Color3.fromRGB(0, 0, 0)
    }, 
    Good = {
        Ring = Color3.fromRGB(0, 188, 120), 
        Icon = Color3.fromRGB(0, 188, 120), 
        Backdrop = Color3.fromRGB(0, 0, 0)
    }, 
    Okay = {
        Ring = Color3.fromRGB(255, 190, 40), 
        Icon = Color3.fromRGB(255, 190, 40), 
        Backdrop = Color3.fromRGB(0, 0, 0)
    }, 
    Bad = {
        Ring = Color3.fromRGB(255, 57, 57), 
        Icon = Color3.fromRGB(255, 57, 57), 
        Backdrop = Color3.fromRGB(0, 0, 0)
    }
};
local v28 = {
    Body = "rbxassetid://4463489643", 
    Engine = "rbxassetid://4463487953", 
    FuelTank = "rbxassetid://4463488164", 
    Glass = "rbxassetid://4463488386", 
    Wheels = "rbxassetid://4463489407", 
    Refuel = "rbxassetid://4519280909"
};
local v29 = {
    Body = "rbxassetid://4503380918", 
    Engine = "rbxassetid://4503380466", 
    FuelTank = "rbxassetid://4503380611", 
    Glass = "rbxassetid://4463488386", 
    Wheels = "rbxassetid://4503380834", 
    Refuel = "rbxassetid://4519503351"
};
local v30 = {
    Body = 1, 
    Engine = 2, 
    FuelTank = 3, 
    Glass = 4, 
    Wheels = 5
};
local v31 = {
    FuelTank = "Fuel Tank", 
    Wheels = "Wheel"
};
local v32 = tick();
if tick() - v32 >= 0.016666666666666666 then
    l_RunService_0.Heartbeat:Wait();
    v32 = tick();
end;
v32 = function(v33, v34, _) --[[ Line: 136 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    return l_TextService_0:GetTextSize(v33, v34.TextSize, v34.Font, Vector2.new(1000, 150));
end;
local function _(v36, v37, v38) --[[ Line: 143 ]] --[[ Name: clampPositionToBox ]]
    local v39 = v36:PointToObjectSpace(v38);
    local v40 = v37 * 0.5;
    return v36 * Vector3.new(math.clamp(v39.X, -v40.X, v40.X), math.clamp(v39.Y, -v40.Y, v40.Y), (math.clamp(v39.Z, -v40.Z, v40.Z)));
end;
local function v53(v42) --[[ Line: 156 ]] --[[ Name: findClosestCar ]]
    -- upvalues: v16 (ref), v12 (copy)
    if v16 then
        local l_v16_ModelCFrame_0 = v16:GetModelCFrame();
        local l_v16_ModelSize_0 = v16:GetModelSize();
        local v45 = l_v16_ModelCFrame_0:PointToObjectSpace(v42);
        local v46 = l_v16_ModelSize_0 * 0.5;
        if (l_v16_ModelCFrame_0 * Vector3.new(math.clamp(v45.X, -v46.X, v46.X), math.clamp(v45.Y, -v46.Y, v46.Y), (math.clamp(v45.Z, -v46.Z, v46.Z))) - v42).Magnitude <= 10 then
            return v16;
        end;
    end;
    for _, v48 in next, v12:GetChildren() do
        local l_v48_ModelCFrame_0 = v48:GetModelCFrame();
        local l_v48_ModelSize_0 = v48:GetModelSize();
        local v51 = l_v48_ModelCFrame_0:PointToObjectSpace(v42);
        local v52 = l_v48_ModelSize_0 * 0.5;
        v51 = (l_v48_ModelCFrame_0 * Vector3.new(math.clamp(v51.X, -v52.X, v52.X), math.clamp(v51.Y, -v52.Y, v52.Y), (math.clamp(v51.Z, -v52.Z, v52.Z))) - v42).Magnitude;
        if v51 <= 10 then
            return v48, v51;
        end;
    end;
    return nil;
end;
local _ = function() --[[ Line: 186 ]] --[[ Name: hideRepairGuis ]]
    -- upvalues: v17 (ref), v13 (copy)
    for _, v55 in next, v17 do
        v55.Visible = false;
    end;
    v13.Gui.HoverWindow.Visible = false;
end;
local _ = function() --[[ Line: 194 ]] --[[ Name: clearPartCacheMap ]]
    -- upvalues: v17 (ref)
    for _, v58 in next, v17 do
        v58:Destroy();
    end;
    v17 = {};
end;
local function _(v60) --[[ Line: 202 ]] --[[ Name: buildHoverGui ]]
    -- upvalues: l_HoverGuiTemplate_0 (copy), v28 (copy), v13 (copy)
    local v61 = l_HoverGuiTemplate_0:Clone();
    v61.Icon.Image = v28[v60] or "";
    v61.Name = v60;
    v61.Visible = false;
    v61.Parent = v13.Gui;
    return v61;
end;
local function v78(v63) --[[ Line: 212 ]] --[[ Name: updateInteractionMap ]]
    -- upvalues: v17 (ref), l_HoverGuiTemplate_0 (copy), v28 (copy), v13 (copy)
    local l_Wheels_0 = v63:FindFirstChild("Wheels");
    local l_Interaction_0 = v63:FindFirstChild("Interaction");
    if l_Wheels_0 then
        for _, v67 in next, l_Wheels_0:GetChildren() do
            local v68 = v67:FindFirstChild("Rim") or v67.PrimaryPart;
            if v68 and not v17[v68] and not v68:HasTag("Interact Ignores") then
                local l_v17_0 = v17;
                local v70 = l_HoverGuiTemplate_0:Clone();
                v70.Icon.Image = v28.Wheels or "";
                v70.Name = "Wheels";
                v70.Visible = false;
                v70.Parent = v13.Gui;
                l_v17_0[v68] = v70;
            end;
        end;
    end;
    if l_Interaction_0 then
        for _, v72 in next, l_Interaction_0:GetChildren() do
            if v72:IsA("BasePart") then
                if v72.Name:find("Repair") then
                    local v73 = v72.Name:gsub("Repair ", "");
                    if not v17[v72] then
                        local l_v17_1 = v17;
                        local v75 = l_HoverGuiTemplate_0:Clone();
                        v75.Icon.Image = v28[v73] or "";
                        v75.Name = v73;
                        v75.Visible = false;
                        v75.Parent = v13.Gui;
                        l_v17_1[v72] = v75;
                    end;
                elseif v72.Name == "Refuel" and not v17[v72] then
                    local l_v17_2 = v17;
                    local v77 = l_HoverGuiTemplate_0:Clone();
                    v77.Icon.Image = v28.Refuel or "";
                    v77.Name = "Refuel";
                    v77.Visible = false;
                    v77.Parent = v13.Gui;
                    l_v17_2[v72] = v77;
                end;
            end;
        end;
    end;
end;
local function _() --[[ Line: 251 ]] --[[ Name: clearRepairStats ]]
    -- upvalues: v18 (ref), v19 (ref)
    v18 = {};
    v19 = 0;
end;
local function _(v80) --[[ Line: 256 ]] --[[ Name: fetchRepairStats ]]
    -- upvalues: v18 (ref), v5 (copy), v19 (ref)
    v18 = v5:Fetch("Get Vehicle Health Stats", v80);
    v19 = tick();
    if v18.FuelAmount then
        v18.Refuel = v18.FuelAmount;
        v18.FuelAmount = nil;
    end;
end;
local function v94() --[[ Line: 267 ]] --[[ Name: findGuiUnderMouse ]]
    -- upvalues: l_UserInputService_0 (copy), v1 (copy), v17 (ref)
    local v82 = l_UserInputService_0:GetMouseLocation() - v1.GuiInset;
    local v83 = {};
    for v84, v85 in next, v17 do
        if v85.Visible then
            local l_AbsolutePosition_0 = v85.AbsolutePosition;
            local v87 = v85.AbsoluteSize * 0.5;
            local v88 = l_AbsolutePosition_0 + v87;
            local l_X_0 = v87.X;
            local l_Magnitude_0 = (v88 - v82).Magnitude;
            if l_Magnitude_0 <= l_X_0 then
                table.insert(v83, {
                    Gui = v85, 
                    Part = v84, 
                    Distance = l_Magnitude_0
                });
            end;
        end;
    end;
    table.sort(v83, function(v91, v92) --[[ Line: 286 ]]
        return v91.Distance < v92.Distance;
    end);
    local v93 = v83[1];
    if v93 then
        return v93.Gui, v93.Part;
    else
        return nil, nil;
    end;
end;
local function _(v95) --[[ Line: 299 ]] --[[ Name: percentToName ]]
    -- upvalues: v26 (copy)
    local v96 = "Full";
    for v97, v98 in next, v26 do
        local v99, v100 = unpack(v98);
        if v99 <= v95 and v95 < v100 then
            v96 = v97;
        end;
    end;
    return v96;
end;
local function v111(v102, v103) --[[ Line: 313 ]] --[[ Name: findGroupHealth ]]
    -- upvalues: v18 (ref), v26 (copy)
    if not v102 or not v103 then
        return nil, 0;
    elseif not v102.Parent then
        return nil, 0;
    else
        local v104 = nil;
        if v103.Name == "Wheels" then
            if v18.Wheels and v18.Wheels[v102.Parent.Name] then
                v104 = v18.Wheels[v102.Parent.Name];
            end;
        elseif v18[v103.Name] then
            v104 = v18[v103.Name];
        end;
        if v104 then
            local l_v104_0 = v104;
            local v106 = "Full";
            for v107, v108 in next, v26 do
                local v109, v110 = unpack(v108);
                if v109 <= l_v104_0 and l_v104_0 < v110 then
                    v106 = v107;
                end;
            end;
            return v106, v104;
        else
            return nil, 0;
        end;
    end;
end;
local function v128(v112) --[[ Line: 344 ]] --[[ Name: findVehicleUseItems ]]
    -- upvalues: v0 (copy)
    local l_Players_0 = v0.Classes.Players;
    local v114 = nil;
    if l_Players_0 then
        local v115 = v0.Classes.Players.get();
        if v115 then
            local l_Character_0 = v115.Character;
            if l_Character_0 then
                v114 = l_Character_0.Inventory;
            end;
        end;
    end;
    if v114 then
        local v117 = {};
        for _, v119 in next, v114.Containers do
            if v119.IsCarried then
                for _, v121 in next, v119.Occupants do
                    if v121.Type == "RepairTool" and v121.RepairSlot == v112 then
                        table.insert(v117, v121);
                    elseif v121.Type == "FuelCan" and v121.RefuelType == v112 and v121.Amount > 0 then
                        table.insert(v117, v121);
                    end;
                end;
            end;
        end;
        table.sort(v117, function(v122, v123) --[[ Line: 377 ]]
            if v122.Amount and v123.Amount and v122.QualityTier == v123.QualityTier then
                return v122.Amount > v123.Amount;
            else
                return v122.QualityTier > v123.QualityTier;
            end;
        end);
        local v124 = table.remove(v117, 1);
        local v125 = nil;
        if v124 then
            for v126 = 1, #v117 do
                local v127 = v117[v126];
                if v127.QualityTier < v124.QualityTier then
                    return v124, v127;
                end;
            end;
        end;
        return v124, v125;
    else
        return nil, nil;
    end;
end;
local function v139() --[[ Line: 410 ]] --[[ Name: canSyphon ]]
    -- upvalues: v0 (copy), v18 (ref)
    local l_Players_1 = v0.Classes.Players;
    local v130 = nil;
    local v131 = nil;
    local v132 = false;
    local v133 = false;
    if v18 and v18.Refuel <= 0 then
        return false;
    else
        if l_Players_1 then
            local v134 = v0.Classes.Players.get();
            if v134 then
                v130 = v134.Character;
                if v130 then
                    v131 = v130.Inventory;
                end;
            end;
        end;
        if v131 then
            for _, v136 in next, v131.Containers do
                if v136.IsCarried then
                    for _, v138 in next, v136.Occupants do
                        if v138.Type == "FuelCan" and v138.Amount < v138.Capacity then
                            v132 = true;
                        end;
                    end;
                end;
            end;
        end;
        if v132 and v130 then
            v133 = v130:HasPerk("Fuel Syphon");
        end;
        return v133;
    end;
end;
local function v147(v140, v141, v142, v143) --[[ Line: 455 ]] --[[ Name: setControlGui ]]
    -- upvalues: l_KeyAliases_0 (copy), l_IconImages_0 (copy), l_Lengths_0 (copy), v25 (copy)
    local v144 = l_KeyAliases_0[v141] or v141.Name;
    local v145 = l_IconImages_0[Enum.UserInputType.Keyboard];
    local v146 = #v144 > 1;
    if v141.EnumType == Enum.UserInputType then
        v140.TextLabel.Text = "";
        v145 = l_IconImages_0[v141];
        v146 = false;
    else
        v140.TextLabel.Text = v144;
    end;
    v140.Size = UDim2.new(0, v146 and l_Lengths_0 or v25, 0, 31);
    v140.Image = v145.Up;
    v140.Box.ContextName.Text = v142;
    if v143 then
        v140.Box.ContextName.Text = v140.Box.ContextName.Text .. " (" .. v143.QualityName .. ")";
    end;
    v140.Box.ContextName.Backdrop.Text = v140.Box.ContextName.Text;
    v140.Box.Size = UDim2.new(0, v140.Box.ContextName.TextBounds.X + 26, 0, 25);
end;
local function v171(v148, v149, v150, v151) --[[ Line: 481 ]] --[[ Name: attachHoverWindow ]]
    -- upvalues: v13 (copy), v27 (copy), v128 (copy), v6 (copy), v139 (copy), v20 (ref), v5 (copy), v16 (ref), v19 (ref), v147 (copy), v21 (ref), v2 (copy), l_TextService_0 (copy), v29 (copy), v31 (copy)
    local l_HoverWindow_1 = v13.Gui.HoverWindow;
    local v153 = math.floor(v150 * 100) .. "%";
    local l_Icon_0 = v27[v149].Icon;
    local v155 = "HEALTH";
    local l_Name_0 = v148.Name;
    local v157 = "Repair";
    if v148.Name == "Refuel" then
        v155 = "CAPACITY";
        l_Name_0 = "Fuel";
        v157 = "Refuel";
    end;
    local l_l_Name_0_0 = l_Name_0;
    local v159, v160 = v128(l_Name_0);
    local l_v6_Bind_0 = v6:GetBind("Secondary Interact");
    local l_MouseButton1_0 = Enum.UserInputType.MouseButton1;
    local v163 = false;
    if l_l_Name_0_0 == "Wheels" then
        l_l_Name_0_0 = v151.Parent.Name;
    end;
    if v157 == "Refuel" and v139() then
        v163 = true;
    end;
    if v159 then
        if v20 == nil or v20.Type ~= l_l_Name_0_0 then
            v20 = {
                Type = l_l_Name_0_0, 
                UseTime = 0.5, 
                UseInput = l_MouseButton1_0, 
                Use = function() --[[ Line: 517 ]] --[[ Name: Use ]]
                    -- upvalues: v159 (copy), v5 (ref), v16 (ref), v151 (copy), v19 (ref)
                    local l_Amount_0 = v159.Amount;
                    if v159.Amount then
                        v159.Amount = 0;
                    end;
                    if v5:Fetch("Vehicle Use Item", v159.Id, v16, v151) then
                        v19 = 0;
                        return;
                    else
                        if l_Amount_0 and v159.Amount then
                            v159.Amount = l_Amount_0;
                        end;
                        return;
                    end;
                end
            };
        end;
        v147(l_HoverWindow_1.Controls.MainControl, l_MouseButton1_0, v157, v159);
        l_HoverWindow_1.Controls.MainControl.Visible = true;
    else
        l_HoverWindow_1.Controls.MainControl.Visible = false;
    end;
    if v163 and l_v6_Bind_0 and l_v6_Bind_0.Key then
        if v21 == nil or v21.Type ~= "Syphon" then
            v21 = {
                Type = "Syphon", 
                UseTime = v2("Fuel Syphon", "UseTime"), 
                UseInput = l_v6_Bind_0.Key, 
                Use = function() --[[ Line: 548 ]] --[[ Name: Use ]]
                    -- upvalues: v5 (ref), v16 (ref), v151 (copy)
                    v5:Fetch("Vehicle Syphon Fuel", v16, v151);
                end
            };
        end;
        v147(l_HoverWindow_1.Controls.SecondControl, l_v6_Bind_0.Key, "Syphon Fuel", {
            QualityName = "Utility"
        });
        l_HoverWindow_1.Controls.SecondControl.Visible = true;
    elseif v160 and l_v6_Bind_0 and l_v6_Bind_0.Key then
        if v21 == nil or v21.Type ~= l_l_Name_0_0 then
            v21 = {
                Type = l_l_Name_0_0, 
                UseTime = 0.5, 
                UseInput = l_v6_Bind_0.Key, 
                Use = function() --[[ Line: 564 ]] --[[ Name: Use ]]
                    -- upvalues: v160 (copy), v5 (ref), v16 (ref), v151 (copy), v19 (ref)
                    local l_Amount_1 = v160.Amount;
                    if v160.Amount then
                        v160.Amount = 0;
                    end;
                    if v5:Fetch("Vehicle Use Item", v160.Id, v16, v151) then
                        v19 = 0;
                        return;
                    else
                        if l_Amount_1 and v160.Amount then
                            v160.Amount = l_Amount_1;
                        end;
                        return;
                    end;
                end
            };
        end;
        v147(l_HoverWindow_1.Controls.SecondControl, l_v6_Bind_0.Key, v157, v160);
        l_HoverWindow_1.Controls.SecondControl.Visible = true;
    else
        l_HoverWindow_1.Controls.SecondControl.Visible = false;
    end;
    l_HoverWindow_1.Dynamic.Bar.Fill.Size = UDim2.new(v150, 0, 1, 0);
    l_HoverWindow_1.Dynamic.Percentage.Text = v153;
    local l_Percentage_0 = l_HoverWindow_1.Dynamic.Percentage;
    local l_new_0 = UDim2.new;
    local v168 = 0;
    local l_v155_0 = v155;
    local l_Percentage_1 = l_HoverWindow_1.Dynamic.Percentage;
    l_Percentage_0.Size = l_new_0(v168, l_TextService_0:GetTextSize(l_v155_0, l_Percentage_1.TextSize, l_Percentage_1.Font, Vector2.new(1000, 150)).X - 6, 0, 16);
    l_HoverWindow_1.Dynamic.Description.Text = v155;
    l_Percentage_0 = l_HoverWindow_1.Dynamic.Description;
    l_new_0 = UDim2.new;
    v168 = 0;
    l_v155_0 = v155;
    l_Percentage_1 = l_HoverWindow_1.Dynamic.Description;
    l_Percentage_0.Size = l_new_0(v168, l_TextService_0:GetTextSize(l_v155_0, l_Percentage_1.TextSize, l_Percentage_1.Font, Vector2.new(1000, 150)).X + 5, 0, 16);
    l_HoverWindow_1.Position = v148.Position + UDim2.new(0, v148.AbsoluteSize.X * 0.5 + 15, 0, -(v148.AbsoluteSize.X * 0.5));
    l_HoverWindow_1.Size = UDim2.new(0, l_HoverWindow_1.Dynamic.UIListLayout.AbsoluteContentSize.X + 18, 0, 82);
    l_HoverWindow_1.Type.Image = v29[v148.Name];
    l_HoverWindow_1.OuterBox.ImageColor3 = l_Icon_0;
    l_HoverWindow_1.Title.Text = v31[l_Name_0] or l_Name_0;
end;
local function v193(v172) --[[ Line: 601 ]] --[[ Name: positionAndSetGuis ]]
    -- upvalues: v17 (ref), v13 (copy), v111 (copy), v27 (copy), v94 (copy), v171 (copy)
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local l_p_0 = l_CurrentCamera_0.CFrame.p;
    if not next(v17) then
        for _, v176 in next, v17 do
            v176.Visible = false;
        end;
        v13.Gui.HoverWindow.Visible = false;
        return;
    else
        for v177, v178 in next, v17 do
            local v179, v180 = l_CurrentCamera_0:WorldToViewportPoint(v177.Position);
            local l_Magnitude_1 = (v177.Position - l_p_0).Magnitude;
            local l_Magnitude_2 = (v177.Position * Vector3.new(1, 0, 1, 0) - v172 * Vector3.new(1, 0, 1, 0)).Magnitude;
            local v183 = 40 - math.floor(l_Magnitude_1);
            local v184 = math.clamp((l_Magnitude_2 - 7) / 0.6, 0, 1);
            v183 = v183 - v183 % 2;
            if v184 == 1 then
                v180 = false;
            end;
            if v180 then
                local v185 = v111(v177, v178);
                if v185 then
                    local v186 = v27[v185];
                    v178.Backdrop.ZIndex = v183;
                    v178.Backdrop.ImageTransparency = v184 * 0.75 + 0.25;
                    v178.Backdrop.ImageColor3 = v186.Backdrop;
                    v178.Icon.ZIndex = v183 + 1;
                    v178.Icon.ImageTransparency = v184;
                    v178.Icon.ImageColor3 = v186.Icon;
                    v178.Ring.ZIndex = v183 + 1;
                    v178.Ring.ImageTransparency = v184;
                    v178.Ring.ImageColor3 = v186.Ring;
                    v178.Position = UDim2.fromOffset(v179.X, v179.Y);
                    v178.ZIndex = v183;
                    v178.Visible = true;
                else
                    v178.Visible = false;
                end;
            else
                v178.Visible = false;
            end;
        end;
        local v187, v188 = v94();
        local v189, v190 = v111(v188, v187);
        if v187 and v189 then
            v171(v187, v189, v190, v188);
            for _, v192 in next, v17 do
                if v192 == v187 then
                    v192.Backdrop.ImageTransparency = 0.25;
                    v192.Icon.ImageTransparency = 0;
                    v192.Ring.ImageTransparency = 0;
                elseif v192.Visible then
                    v192.Backdrop.ImageTransparency = 0.925;
                    v192.Icon.ImageTransparency = 0.9;
                    v192.Ring.ImageTransparency = 0.9;
                end;
            end;
            v13.Gui.HoverWindow.Visible = true;
            return;
        else
            v13.Gui.HoverWindow.Visible = false;
            return;
        end;
    end;
end;
local function v204(v194, v195) --[[ Line: 679 ]] --[[ Name: updateRepairGuiInfo ]]
    -- upvalues: v17 (ref), v18 (ref), v19 (ref), v78 (copy), v5 (copy)
    if not v195 then
        for _, v197 in next, v17 do
            v197:Destroy();
        end;
        v17 = {};
        v18 = {};
        v19 = 0;
        return;
    else
        local l_v195_ModelCFrame_0 = v195:GetModelCFrame();
        local l_v195_ModelSize_0 = v195:GetModelSize();
        local v200 = l_v195_ModelCFrame_0:PointToObjectSpace(v194);
        local v201 = l_v195_ModelSize_0 * 0.5;
        if (l_v195_ModelCFrame_0 * Vector3.new(math.clamp(v200.X, -v201.X, v201.X), math.clamp(v200.Y, -v201.Y, v201.Y), (math.clamp(v200.Z, -v201.Z, v201.Z))) - v194).Magnitude <= 10 then
            v78(v195);
            if tick() - v19 > 3 then
                v18 = v5:Fetch("Get Vehicle Health Stats", v195);
                v19 = tick();
                if v18.FuelAmount then
                    v18.Refuel = v18.FuelAmount;
                    v18.FuelAmount = nil;
                    return;
                end;
            end;
        else
            for _, v203 in next, v17 do
                v203:Destroy();
            end;
            v17 = {};
            v18 = {};
            v19 = 0;
        end;
        return;
    end;
end;
local function v233(v205, v206) --[[ Line: 704 ]] --[[ Name: updateDriveDisplayGui ]]
    -- upvalues: v18 (ref), v13 (copy), l_v3_Storage_0 (copy), v28 (copy), v30 (copy), v26 (copy), v27 (copy)
    if v205 and next(v18) then
        local l_Name_1 = v206.Name;
        local l_Config_0 = v206:FindFirstChild("Config");
        if l_Config_0 then
            l_Config_0 = require(l_Config_0);
            if l_Config_0.DisplayName then
                l_Name_1 = l_Config_0.DisplayName;
            end;
        end;
        for v209, v210 in next, v18 do
            if v209 == "Wheels" then
                for v211, v212 in next, v210 do
                    local v213 = false;
                    if l_Config_0 and l_Config_0.Health and l_Config_0.Health.Wheels then
                        local v214 = l_Config_0.Health.Wheels[v211];
                        if v214 and v214.InvisibleWheel then
                            v213 = true;
                        end;
                    end;
                    if not v213 then
                        local l_FirstChild_0 = v13.Gui.DriveDisplay.Icons:FindFirstChild(v209 .. " " .. v211);
                        if not l_FirstChild_0 then
                            l_FirstChild_0 = l_v3_Storage_0.DriveDisplayTemplate:Clone();
                            l_FirstChild_0.Icon.Image = v28[v209] or "";
                            l_FirstChild_0.LayoutOrder = v30[v209] or 10;
                            l_FirstChild_0.Name = v209 .. " " .. v211;
                            l_FirstChild_0.Parent = v13.Gui.DriveDisplay.Icons;
                        end;
                        local v216 = "Full";
                        for v217, v218 in next, v26 do
                            local v219, v220 = unpack(v218);
                            if v219 <= v212 and v212 < v220 then
                                v216 = v217;
                            end;
                        end;
                        v216 = v27[v216];
                        l_FirstChild_0.Backdrop.ZIndex = 1;
                        l_FirstChild_0.Backdrop.ImageTransparency = 0.25;
                        l_FirstChild_0.Backdrop.ImageColor3 = v216.Backdrop;
                        l_FirstChild_0.Icon.ZIndex = 2;
                        l_FirstChild_0.Icon.ImageTransparency = 0;
                        l_FirstChild_0.Icon.ImageColor3 = v216.Icon;
                        l_FirstChild_0.Ring.ZIndex = 2;
                        l_FirstChild_0.Ring.ImageTransparency = 0;
                        l_FirstChild_0.Ring.ImageColor3 = v216.Ring;
                    end;
                end;
            elseif v209 ~= "Refuel" then
                local l_FirstChild_1 = v13.Gui.DriveDisplay.Icons:FindFirstChild(v209);
                if not l_FirstChild_1 then
                    l_FirstChild_1 = l_v3_Storage_0.DriveDisplayTemplate:Clone();
                    l_FirstChild_1.Icon.Image = v28[v209] or "";
                    l_FirstChild_1.LayoutOrder = v30[v209] or 10;
                    l_FirstChild_1.Name = v209;
                    l_FirstChild_1.Parent = v13.Gui.DriveDisplay.Icons;
                end;
                local v222 = "Full";
                for v223, v224 in next, v26 do
                    local v225, v226 = unpack(v224);
                    if v225 <= v210 and v210 < v226 then
                        v222 = v223;
                    end;
                end;
                v222 = v27[v222];
                l_FirstChild_1.Backdrop.ZIndex = 1;
                l_FirstChild_1.Backdrop.ImageTransparency = 0.25;
                l_FirstChild_1.Backdrop.ImageColor3 = v222.Backdrop;
                l_FirstChild_1.Icon.ZIndex = 2;
                l_FirstChild_1.Icon.ImageTransparency = 0;
                l_FirstChild_1.Icon.ImageColor3 = v222.Icon;
                l_FirstChild_1.Ring.ZIndex = 2;
                l_FirstChild_1.Ring.ImageTransparency = 0;
                l_FirstChild_1.Ring.ImageColor3 = v222.Ring;
            end;
        end;
        if v18.Refuel then
            local v227 = math.clamp(v18.Refuel, 0, 1);
            v13.Gui.DriveDisplay.Fuel.Frame.Bar.Size = UDim2.new(v227, 0, 1, 0);
        end;
        local l_X_1 = v13.Gui.DriveDisplay.Icons.UIListLayout.AbsoluteContentSize.X;
        v13.Gui.DriveDisplay.Fuel.Size = UDim2.new(0, math.max(152, l_X_1), 0, 20);
        v13.Gui.DriveDisplay.Info.VehicleName.Text = l_Name_1;
        v13.Gui.DriveDisplay.Info.VehicleName.Backdrop.Text = l_Name_1;
        local l_Velocity_0 = v206.PrimaryPart.Velocity;
        local v230 = v206.PrimaryPart.CFrame:VectorToObjectSpace(l_Velocity_0);
        v13.Gui.DriveDisplay.Info.Speed.Text = tostring((math.abs((math.floor(v230.Z)))));
        v13.Gui.DriveDisplay.Info.Speed.Backdrop.Text = v13.Gui.DriveDisplay.Info.Speed.Text;
        v13.Gui.DriveDisplay.Info.Speed.Size = UDim2.new(0, v13.Gui.DriveDisplay.Info.Speed.TextBounds.X + 1, 0, 22);
        return;
    else
        for _, v232 in next, v13.Gui.DriveDisplay.Icons:GetChildren() do
            if v232:IsA("Frame") then
                v232:Destroy();
            end;
        end;
        return;
    end;
end;
v13.GetVehicle = function(_) --[[ Line: 814 ]] --[[ Name: GetVehicle ]]
    -- upvalues: v16 (ref)
    return v16;
end;
v13.GetInteractionRange = function(_) --[[ Line: 818 ]] --[[ Name: GetInteractionRange ]]
    return 10;
end;
v13.GetWheelHealth = function(_, v237) --[[ Line: 822 ]] --[[ Name: GetWheelHealth ]]
    -- upvalues: v18 (ref)
    if v18 and v18.Wheels and v18.Wheels[v237] then
        return v18.Wheels[v237];
    else
        return 0;
    end;
end;
v13.GetIcon = function(_, v239) --[[ Line: 832 ]] --[[ Name: GetIcon ]]
    -- upvalues: v28 (copy)
    return v28[v239];
end;
v13.IsInteracting = function(_) --[[ Line: 838 ]] --[[ Name: IsInteracting ]]
    -- upvalues: v13 (copy)
    return v13.Gui.HoverWindow.Visible;
end;
local _ = v7.new(0.1, "Heartbeat", function() --[[ Line: 844 ]]
    -- upvalues: v0 (copy), v53 (copy), v16 (ref), v17 (ref), v19 (ref), v204 (copy), v233 (copy)
    if v0.Classes.Players then
        local v241 = v0.Classes.Players.get();
        if v241 then
            local l_Character_1 = v241.Character;
            if l_Character_1 and l_Character_1.RootPart then
                local l_Position_0 = l_Character_1.RootPart.Position;
                local v244 = l_Character_1.Vehicle or v53(l_Position_0);
                if v244 then
                    if v16 ~= v244 then
                        for _, v246 in next, v17 do
                            v246:Destroy();
                        end;
                        v17 = {};
                        v19 = 0;
                    end;
                    v16 = v244;
                end;
                v204(l_Position_0, v16);
                v233(l_Character_1.Sitting, v16);
            end;
        end;
    end;
end);
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 873 ]]
    -- upvalues: v3 (copy), v13 (copy), v0 (copy), v193 (copy), v20 (ref), v21 (ref), v17 (ref)
    if v3:IsVisible("GameMenu") then
        v13.Gui.Visible = false;
        return;
    else
        debug.profilebegin("Vehicle UI Render step");
        local l_Players_2 = v0.Classes.Players;
        local v249 = false;
        if l_Players_2 then
            local v250 = v0.Classes.Players.get();
            if v250 then
                local l_Character_2 = v250.Character;
                if l_Character_2 and l_Character_2.RootPart then
                    local v252 = l_Character_2.EquippedItem ~= nil;
                    local v253 = l_Character_2.Sitting == true;
                    if v252 and l_Character_2.AtEaseInput then
                        v252 = false;
                    end;
                    if not v252 and not v253 then
                        local l_Position_1 = l_Character_2.RootPart.Position;
                        v193(l_Position_1);
                        v249 = true;
                    end;
                    if v253 then
                        v13.Gui.DriveDisplay.Visible = true;
                    else
                        v13.Gui.DriveDisplay.Visible = false;
                    end;
                end;
            end;
        end;
        if not v13.Gui.HoverWindow.Visible then
            v20 = nil;
            v21 = nil;
        end;
        if not v249 then
            for _, v256 in next, v17 do
                v256.Visible = false;
            end;
            v13.Gui.HoverWindow.Visible = false;
            v20 = nil;
            v21 = nil;
        end;
        local v257 = false;
        for _, v259 in next, {
            v20, 
            v21
        } do
            if v259.InputStarted then
                local v260 = (tick() - v259.InputStarted) / v259.UseTime;
                if v259.UseTime == 0 then
                    v260 = 1;
                end;
                v13.Gui.HoverWindow.Controls.UseBar.Fill.Size = UDim2.new(v260, 0, 1, 0);
                v13.Gui.HoverWindow.Controls.UseBar.Visible = v260 < 1;
                if v13.Gui.HoverWindow.Controls.UseBar.Visible then
                    v257 = true;
                end;
                if v260 >= 1 then
                    local l_Use_0 = v259.Use;
                    v20 = nil;
                    v21 = nil;
                    coroutine.wrap(l_Use_0)();
                    break;
                end;
            end;
        end;
        if not v257 then
            v13.Gui.HoverWindow.Controls.UseBar.Visible = false;
        end;
        v13.Gui.Visible = true;
        debug.profileend();
        return;
    end;
end);
l_UserInputService_0.InputBegan:Connect(function(v262, v263) --[[ Line: 973 ]]
    -- upvalues: v20 (ref), v21 (ref)
    if v263 then
        return;
    else
        local v264 = {
            v20, 
            v21
        };
        local v265 = false;
        for v266 = 1, 2 do
            local v267 = v264[v266];
            if v267 and (v262.UserInputType == v267.UseInput or v262.KeyCode == v267.UseInput) then
                if v265 then
                    v267.InputStarted = nil;
                else
                    v265 = true;
                    v267.InputStarted = tick();
                end;
            end;
        end;
        return;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v268, _) --[[ Line: 1005 ]]
    -- upvalues: v20 (ref), v21 (ref)
    local v270 = {
        v20, 
        v21
    };
    local v271 = v270[1];
    if v271 and (v268.UserInputType == v271.UseInput or v268.KeyCode == v271.UseInput) then
        v271.InputStarted = nil;
    end;
    v271 = v270[2];
    if v271 and (v268.UserInputType == v271.UseInput or v268.KeyCode == v271.UseInput) then
        v271.InputStarted = nil;
    end;
end);
return v13;