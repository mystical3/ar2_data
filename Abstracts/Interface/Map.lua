local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Network");
local v4 = v0.require("Libraries", "Resources");
local v5 = v0.require("Libraries", "Keybinds");
local v6 = v0.require("Classes", "Maids");
local l_Players_0 = game:GetService("Players");
local l_TextService_0 = game:GetService("TextService");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local v11 = {
    Gui = v2:GetGui("Map")
};
local l_v2_Storage_0 = v2:GetStorage("Map");
local l_v4_From_0 = v4:FindFrom(v11.Gui, "ClipBin.ClickEater");
local l_v4_From_1 = v4:FindFrom(v11.Gui, "ClipBin.DragBin");
local l_v4_From_2 = v4:FindFrom(v11.Gui, "ClipBin.DragBin.LocalMarker");
local l_v4_From_3 = v4:FindFrom(v11.Gui, "ClipBin.DragBin.CombatRing");
local l_v4_From_4 = v4:FindFrom(v11.Gui, "ClipBin.DragBin.NoZoom");
local l_v4_From_5 = v4:FindFrom(v11.Gui, "ClipBin.DragBin.NoZoomOverlay");
local l_v4_From_6 = v4:FindFrom(v11.Gui, "ClipBin.DragBin.GridLines.Labels");
local v20 = false;
local v21 = false;
local v22 = Vector2.new();
local v23 = Vector2.new();
local v24 = v6.new();
local v25 = {};
local v26 = {};
local v27 = CFrame.new(Vector3.new(-7314.5, 100.5, -6310.580078125, 0), (Vector3.new(-7314.5, 100.5, -6309.580078125, 0)));
local v28 = Random.new();
local function _(v29, v30) --[[ Line: 58 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    return l_TextService_0:GetTextSize(v29, v30.TextSize, v30.Font, Vector2.new(1000, 1000));
end;
local function _(v32) --[[ Line: 65 ]] --[[ Name: getMapPos ]]
    -- upvalues: v27 (copy)
    local v33 = v27:pointToObjectSpace(v32) / Vector3.new(-15360, 0, -13875, 0);
    return Vector2.new(v33.X, v33.Z);
end;
local function v41() --[[ Line: 72 ]] --[[ Name: clampMapPosition ]]
    -- upvalues: l_v4_From_1 (copy), l_v4_From_6 (copy)
    local l_AbsoluteSize_0 = l_v4_From_1.Parent.AbsoluteSize;
    local v36 = l_v4_From_1.AbsoluteSize - l_AbsoluteSize_0;
    local l_Offset_0 = l_v4_From_1.Position.X.Offset;
    local l_Offset_1 = l_v4_From_1.Position.Y.Offset;
    local v39 = math.clamp(l_Offset_0, -v36.X, 0);
    local v40 = math.clamp(l_Offset_1, -v36.Y, 0);
    l_v4_From_1.Position = UDim2.fromOffset(v39, v40);
    l_v4_From_6.Letters.Position = UDim2.new(1, -40, 0, -v40);
    l_v4_From_6.Numbers.Position = UDim2.new(0, -v39, 1, -40);
end;
local function _() --[[ Line: 88 ]] --[[ Name: drawMapAtMouse ]]
    -- upvalues: v23 (ref), v22 (ref), l_v4_From_1 (copy), v41 (copy)
    local v42 = v23 - v22 - l_v4_From_1.Parent.AbsolutePosition;
    l_v4_From_1.Position = UDim2.fromOffset(v42.X, v42.Y);
    v41();
end;
local function v51() --[[ Line: 96 ]] --[[ Name: linkMapMarkers ]]
    -- upvalues: v4 (copy), v11 (copy), v25 (copy), v1 (copy)
    local v44 = v4:Find("Workspace.Map.Shared.Powered.Power Station");
    local l_v4_From_7 = v4:FindFrom(v11.Gui, "ClipBin.DragBin.Locations.Power");
    for _, v47 in next, l_v4_From_7:GetChildren() do
        local v48 = nil;
        for _, v50 in next, v44:GetChildren() do
            if v50.Name == "Substation" and v50:GetAttribute("Designation") == v47.Name then
                v48 = v50;
                break;
            end;
        end;
        if v48 then
            v25[v47] = v48;
        elseif not v1.DebugIsland then
            print("uh oh", v47);
        end;
    end;
end;
v11.SetCombatZone = function(_, v53, v54) --[[ Line: 123 ]] --[[ Name: SetCombatZone ]]
    -- upvalues: v1 (copy), v27 (copy), l_v4_From_3 (copy)
    if v53 and v54 then
        local v55 = Vector3.new(2, 0, 2, 0) * v1.CombatRadius / Vector3.new(-15360, 0, -13875, 0);
        local v56 = v27:pointToObjectSpace(v54) / Vector3.new(-15360, 0, -13875, 0);
        local v57 = Vector2.new(v56.X, v56.Z);
        l_v4_From_3.Position = UDim2.fromScale(v57.X, v57.Y);
        l_v4_From_3.Size = UDim2.fromScale(v55.X, v55.Z);
        l_v4_From_3.Visible = true;
        return;
    else
        l_v4_From_3.Visible = false;
        return;
    end;
end;
v11.Center = function(_) --[[ Line: 137 ]] --[[ Name: Center ]]
    -- upvalues: v11 (copy), v27 (copy), l_v4_From_1 (copy), v41 (copy)
    v11:Zoom(false);
    local l_p_0 = workspace.CurrentCamera.CFrame.p;
    local v60 = v27:pointToObjectSpace(l_p_0) / Vector3.new(-15360, 0, -13875, 0);
    local v61 = Vector2.new(v60.X, v60.Z);
    v60 = l_v4_From_1.Parent.AbsoluteSize * 0.5 - v61 * l_v4_From_1.AbsoluteSize;
    l_v4_From_1.Position = UDim2.fromOffset(v60.X, v60.Y);
    v41();
end;
v11.Zoom = function(_, v63) --[[ Line: 151 ]] --[[ Name: Zoom ]]
    -- upvalues: v20 (ref), v21 (ref), l_v4_From_1 (copy), v22 (ref), v23 (ref), l_v4_From_4 (copy), l_v4_From_5 (copy), v41 (copy)
    if v63 ~= v20 and not v21 then
        local l_AbsolutePosition_0 = l_v4_From_1.Parent.AbsolutePosition;
        local v65 = Vector2.new(l_v4_From_1.Position.X.Offset, l_v4_From_1.Position.Y.Offset);
        v22 = v23 - l_AbsolutePosition_0 - v65;
    end;
    if v63 and not v20 then
        l_v4_From_1.Size = UDim2.fromOffset(2048, 1850);
        l_v4_From_4.Visible = false;
        l_v4_From_5.Visible = false;
        v22 = v22 * 2;
    elseif v20 and not v63 then
        l_v4_From_1.Size = UDim2.fromOffset(1024, 925);
        l_v4_From_4.Visible = true;
        l_v4_From_5.Visible = true;
        v22 = v22 * 0.5;
    end;
    v20 = v63;
    local v66 = v23 - v22 - l_v4_From_1.Parent.AbsolutePosition;
    l_v4_From_1.Position = UDim2.fromOffset(v66.X, v66.Y);
    v41();
end;
v11.DisableGodview = function(_) --[[ Line: 183 ]] --[[ Name: DisableGodview ]]
    -- upvalues: v24 (copy)
    v24:Clean();
end;
v11.EnableGodview = function(v68) --[[ Line: 187 ]] --[[ Name: EnableGodview ]]
    -- upvalues: v4 (copy), v0 (copy), l_Players_0 (copy), l_v2_Storage_0 (copy), l_TextService_0 (copy), l_v4_From_1 (copy), v24 (copy), l_RunService_0 (copy), v27 (copy)
    v68:DisableGodview();
    local v69 = v4:Find("Workspace.Characters");
    local v70 = {};
    local function _(v71) --[[ Line: 193 ]] --[[ Name: clean ]]
        -- upvalues: v70 (copy), v0 (ref)
        local v72 = v70[v71];
        if v72 then
            v0.destroy(v72, "MouseEnter", "MouseLeave");
        end;
        v70[v71] = nil;
    end;
    local function v82(v74) --[[ Line: 203 ]] --[[ Name: track ]]
        -- upvalues: v70 (copy), v0 (ref), l_Players_0 (ref), l_v2_Storage_0 (ref), l_TextService_0 (ref), l_v4_From_1 (ref)
        local v75 = v70[v74];
        if v75 then
            v0.destroy(v75, "MouseEnter", "MouseLeave");
        end;
        v70[v74] = nil;
        while not v74.PrimaryPart do
            task.wait();
        end;
        v75 = nil;
        for _, v77 in next, l_Players_0:GetPlayers() do
            if v77.Character == v74 then
                v75 = v77;
                break;
            end;
        end;
        if v75 then
            local v78 = l_v2_Storage_0:WaitForChild("SquadMarker"):Clone();
            local l_Name_0 = v75.Name;
            local l_TextLabel_0 = v78.MarkerCenter.Tooltip.TextLabel;
            local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(l_Name_0, l_TextLabel_0.TextSize, l_TextLabel_0.Font, Vector2.new(1000, 1000));
            v78.MarkerCenter.Tooltip.TextLabel.Text = v75.Name;
            v78.MarkerCenter.Tooltip.Size = UDim2.fromOffset(l_l_TextService_0_TextSize_0.X + 10, l_l_TextService_0_TextSize_0.Y + 10);
            v78.MouseEnter:Connect(function() --[[ Line: 227 ]]
                -- upvalues: v78 (copy)
                v78.MarkerCenter.Tooltip.Visible = true;
            end);
            v78.MouseLeave:Connect(function() --[[ Line: 231 ]]
                -- upvalues: v78 (copy)
                v78.MarkerCenter.Tooltip.Visible = false;
            end);
            v78.Parent = l_v4_From_1;
            v70[v74] = v78;
        end;
    end;
    v24:Give(l_RunService_0.Heartbeat:Connect(function() --[[ Line: 241 ]]
        -- upvalues: v70 (copy), v27 (ref), v0 (ref)
        for v83, v84 in next, v70 do
            if v83.PrimaryPart then
                local l_Position_0 = v83.PrimaryPart.Position;
                local v86 = v27:pointToObjectSpace(l_Position_0) / Vector3.new(-15360, 0, -13875, 0);
                local v87 = Vector2.new(v86.X, v86.Z);
                v84.Position = UDim2.fromScale(v87.X, v87.Y);
            else
                local v88 = v70[v83];
                if v88 then
                    v0.destroy(v88, "MouseEnter", "MouseLeave");
                end;
                v70[v83] = nil;
            end;
        end;
    end));
    v24:Give(v69.ChildAdded:Connect(function(v89) --[[ Line: 254 ]]
        -- upvalues: v82 (copy)
        v82(v89);
    end));
    v24:Give(v69.ChildRemoved:Connect(function(v90) --[[ Line: 258 ]]
        -- upvalues: v70 (copy), v0 (ref)
        local v91 = v70[v90];
        if v91 then
            v0.destroy(v91, "MouseEnter", "MouseLeave");
        end;
        v70[v90] = nil;
    end));
    for _, v93 in next, v69:GetChildren() do
        coroutine.wrap(v82)(v93);
    end;
    v24:Give(function() --[[ Line: 266 ]]
        -- upvalues: v70 (copy), v0 (ref)
        for v94, _ in next, v70 do
            local v96 = v70[v94];
            if v96 then
                v0.destroy(v96, "MouseEnter", "MouseLeave");
            end;
            v70[v94] = nil;
        end;
    end);
end;
v11.Update = function(_, _) --[[ Line: 273 ]] --[[ Name: Update ]]

end;
v51();
v3:Add("Remove Map Marker", function(v99) --[[ Line: 325 ]]
    -- upvalues: v26 (copy)
    local v100 = v26[v99];
    if v100 then
        v100:Destroy();
        v26[v99] = nil;
    end;
end);
v3:Add("Add Map Marker", function(v101, v102) --[[ Line: 334 ]]
    -- upvalues: v26 (copy), v2 (copy), v27 (copy), l_v2_Storage_0 (copy), v28 (copy), l_v4_From_1 (copy)
    local v103 = v26[v101];
    if v103 then
        v103:Destroy();
        v26[v101] = nil;
    end;
    v2:Get("DeathActions"):Log("Server", {
        {
            Style = "Normal", 
            Text = v102.LogText
        }
    });
    v2:PlaySound(v102.Sound);
    local l_WorldPosition_0 = v102.WorldPosition;
    local v105 = v27:pointToObjectSpace(l_WorldPosition_0) / Vector3.new(-15360, 0, -13875, 0);
    local v106 = Vector2.new(v105.X, v105.Z);
    l_WorldPosition_0 = l_v2_Storage_0.MarkerTemplate:Clone();
    l_WorldPosition_0.Position = UDim2.fromScale(v106.X, v106.Y);
    l_WorldPosition_0.TextLabel.Text = v102.MapText;
    l_WorldPosition_0.TextLabel.Dark.Text = v102.MapText;
    l_WorldPosition_0.TextLabel.Bright.Text = v102.MapText;
    if v28:NextNumber() > 0.5 then
        l_WorldPosition_0.TextLabel.TextYAlignment = Enum.TextYAlignment.Top;
        l_WorldPosition_0.TextLabel.Dark.TextYAlignment = Enum.TextYAlignment.Top;
        l_WorldPosition_0.TextLabel.Bright.TextYAlignment = Enum.TextYAlignment.Top;
        l_WorldPosition_0.TextLabel.Position = UDim2.new(0.5, v28:NextInteger(-5, 5), 0.5, v28:NextNumber(0, -5));
    else
        l_WorldPosition_0.TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom;
        l_WorldPosition_0.TextLabel.Dark.TextYAlignment = Enum.TextYAlignment.Bottom;
        l_WorldPosition_0.TextLabel.Bright.TextYAlignment = Enum.TextYAlignment.Bottom;
        l_WorldPosition_0.TextLabel.Position = UDim2.new(0.5, v28:NextInteger(-5, 5), 0.5, v28:NextNumber(0, 5));
    end;
    v26[v101] = l_WorldPosition_0;
    l_WorldPosition_0.Parent = l_v4_From_1;
end);
v3:Add("Heatmap Display", function(v107, v108) --[[ Line: 383 ]]
    -- upvalues: v27 (copy), l_v4_From_1 (copy)
    for _, v110 in next, v108 do
        local v111 = v27:pointToObjectSpace(v110) / Vector3.new(-15360, 0, -13875, 0);
        local v112 = Vector2.new(v111.X, v111.Z);
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Name = "Heatmap Point";
        l_Frame_0.BorderSizePixel = 0;
        l_Frame_0.BackgroundColor3 = v107;
        l_Frame_0.BackgroundTransparency = 0.34;
        l_Frame_0.ZIndex = 52;
        l_Frame_0.Rotation = 45;
        l_Frame_0.AnchorPoint = Vector2.new(0.5, 0.5);
        l_Frame_0.Size = UDim2.new(0, 10, 0, 10);
        l_Frame_0.Position = UDim2.fromScale(v112.X, v112.Y);
        l_Frame_0.Parent = l_v4_From_1;
        delay(30, function() --[[ Line: 399 ]]
            -- upvalues: l_Frame_0 (copy)
            l_Frame_0:Destroy();
        end);
    end;
end);
local v114 = {};
local l_ScreenGui_0 = Instance.new("ScreenGui");
l_ScreenGui_0.DisplayOrder = 2;
l_ScreenGui_0.Parent = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v116 = Instance.new("TextBox", l_ScreenGui_0);
v116.AnchorPoint = Vector2.new(0.5, 0);
v116.Position = UDim2.new(0.5, 0, 0.5, 0);
v116.Size = UDim2.new(0, 200, 0, 50);
v116.TextWrapped = false;
v116.ClipsDescendants = true;
v116.TextEditable = false;
v116.ClearTextOnFocus = false;
v116.Visible = false;
local v117 = Instance.new("TextButton", l_ScreenGui_0);
v117.AnchorPoint = Vector2.new(0.5, 1);
v117.Position = UDim2.new(0.5, 0, 0.5, -10);
v117.Size = UDim2.new(0, 25, 0, 25);
v117.Visible = false;
v117.Text = "X";
do
    local l_v114_0 = v114;
    v117.MouseButton1Click:Connect(function() --[[ Line: 429 ]]
        -- upvalues: v117 (copy), v116 (copy), l_v114_0 (ref)
        v117.Visible = false;
        v116.Visible = false;
        v116.Text = "";
        l_v114_0 = {};
    end);
    v3:Add("Seto Info", function(v119) --[[ Line: 438 ]]
        -- upvalues: l_v114_0 (ref), v116 (copy), v117 (copy)
        if #l_v114_0 == 0 then
            table.insert(l_v114_0, {
                "PosX", 
                "PosY", 
                "GroupSize", 
                "InCombat", 
                "LifeTime", 
                "PackSize", 
                "PlayerKills", 
                "ZombieKills"
            });
        end;
        for _, v121 in next, v119 do
            table.insert(l_v114_0, v121);
        end;
        local v122 = "";
        for v123 = 1, #l_v114_0 do
            local v124 = l_v114_0[v123];
            local v125 = "";
            for v126 = 1, #v124 do
                v125 = v125 .. v124[v126] .. ",";
            end;
            v122 = v122 .. v125;
            if v123 < #l_v114_0 then
                v122 = v122 .. "\n";
            end;
        end;
        v116.Text = v122;
        v117.Visible = true;
        v116.Visible = true;
    end);
end;
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 482 ]]
    -- upvalues: v11 (copy), l_v4_From_3 (copy), l_Players_0 (copy), v27 (copy), l_v4_From_2 (copy), v25 (copy), v21 (ref)
    if v11.Gui.Visible then
        l_v4_From_3.ImageTransparency = 0.75 * (tick() % 2 / 2) ^ 0.5;
        if l_Players_0.LocalPlayer.Character and l_Players_0.LocalPlayer.Character.PrimaryPart then
            local l_Position_1 = l_Players_0.LocalPlayer.Character.PrimaryPart.Position;
            local v128 = v27:pointToObjectSpace(l_Position_1) / Vector3.new(-15360, 0, -13875, 0);
            local v129 = Vector2.new(v128.X, v128.Z);
            l_v4_From_2.Position = UDim2.fromScale(v129.X, v129.Y);
        end;
        for v130, v131 in next, v25 do
            if v131:GetAttribute("PoweredLED") == "On" then
                v130.Indicator.Image = "rbxassetid://6660451127";
            else
                v130.Indicator.Image = "rbxassetid://6660451308";
            end;
        end;
        return;
    else
        v21 = false;
        return;
    end;
end);
v11.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 514 ]]
    -- upvalues: v11 (copy), v2 (copy)
    if v11.Gui.Visible then
        v2:Get("Mouse"):SetIconVisible("Grab", true);
        return;
    else
        v2:Get("Mouse"):SetIconVisible("Grab", false);
        return;
    end;
end);
l_v4_From_0.InputBegan:Connect(function(v132) --[[ Line: 522 ]]
    -- upvalues: v11 (copy), l_v4_From_1 (copy), v22 (ref), v23 (ref), v21 (ref)
    if v132.UserInputType == Enum.UserInputType.MouseButton1 and v11.Gui.Visible then
        local l_AbsolutePosition_1 = l_v4_From_1.Parent.AbsolutePosition;
        local v134 = Vector2.new(l_v4_From_1.Position.X.Offset, l_v4_From_1.Position.Y.Offset);
        v22 = v23 - l_AbsolutePosition_1 - v134;
        v21 = true;
    end;
end);
l_UserInputService_0.InputChanged:Connect(function(v135, _) --[[ Line: 536 ]]
    -- upvalues: v23 (ref), v21 (ref), v22 (ref), l_v4_From_1 (copy), v41 (copy)
    if v135.UserInputType == Enum.UserInputType.MouseMovement then
        v23 = Vector2.new(v135.Position.X, v135.Position.Y);
        if v21 then
            local v137 = v23 - v22 - l_v4_From_1.Parent.AbsolutePosition;
            l_v4_From_1.Position = UDim2.fromOffset(v137.X, v137.Y);
            v41();
        end;
    end;
end);
l_UserInputService_0.InputBegan:Connect(function(v138, v139) --[[ Line: 546 ]]
    -- upvalues: v5 (copy), v11 (copy)
    if v138.UserInputType == Enum.UserInputType.Keyboard and not v139 then
        local l_v5_Bind_0 = v5:GetBind("Zoom Map In");
        local l_v5_Bind_1 = v5:GetBind("Zoom Map Out");
        if l_v5_Bind_0 and l_v5_Bind_0.Key == v138.KeyCode then
            v11:Zoom(true);
            return;
        elseif l_v5_Bind_1 and l_v5_Bind_1.Key == v138.KeyCode then
            v11:Zoom(false);
        end;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v142, _) --[[ Line: 559 ]]
    -- upvalues: v21 (ref)
    if v142.UserInputType == Enum.UserInputType.MouseButton1 and v21 then
        v21 = false;
    end;
end);
return v11;