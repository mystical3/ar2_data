local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Network");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local v7 = {
    Gui = v2:GetGui("VIPLobby")
};
local l_v2_Storage_0 = v2:GetStorage("VIPLobby");
local l_Teams_0 = v7.Gui:WaitForChild("Teams");
local l_Settings_0 = v7.Gui:WaitForChild("Settings");
local v11 = l_v2_Storage_0:WaitForChild("Team Template");
local v12 = l_v2_Storage_0:WaitForChild("Team Slot Template");
local v13 = l_v2_Storage_0:WaitForChild("Map Template");
local v14 = l_v2_Storage_0:WaitForChild("Settings Template");
local v15 = {
    Blocked = v7.Gui:WaitForChild("Blocked"), 
    Start = v7.Gui:WaitForChild("Start"), 
    Cancel = v7.Gui:WaitForChild("Cancel")
};
local v16 = "";
local v17 = 0;
local v18 = false;
local v19 = false;
local v20 = {};
local v21 = {};
local v22 = Random.new();
local function v27(v23, v24, v25, ...) --[[ Line: 45 ]] --[[ Name: findAndDo ]]
    local l_v23_FirstChild_0 = v23:FindFirstChild(v24);
    if l_v23_FirstChild_0 then
        v25(l_v23_FirstChild_0, ...);
    end;
end;
local function v38() --[[ Line: 53 ]] --[[ Name: buildTeamGuis ]]
    -- upvalues: v21 (ref), v11 (copy), l_Teams_0 (copy), v12 (copy), v18 (ref), v19 (ref), v2 (copy), v3 (copy), l_Players_0 (copy)
    for v28, v29 in next, v21 do
        local v30 = v11:Clone();
        v30.LayoutOrder = v28;
        v30.Name = "Team " .. v28;
        v30.Parent = l_Teams_0;
        for v31, _ in next, v29.Roster do
            local v33 = v12:Clone();
            v33.LayoutOrder = v31;
            v33.Name = "Slot " .. v31;
            v33.Parent = v30;
            v33.MouseEnter:Connect(function() --[[ Line: 66 ]]
                -- upvalues: v33 (copy), v18 (ref), v21 (ref), v28 (copy), v31 (copy), v19 (ref)
                v33.UIStroke.Enabled = true;
                if v18 and v21[v28].Roster[v31] ~= "" and v19 then
                    v33.Kick.Visible = true;
                end;
            end);
            v33.Kick.MouseButton1Click:Connect(function() --[[ Line: 78 ]]
                -- upvalues: v2 (ref), v3 (ref), v21 (ref), v28 (copy), v31 (copy)
                v2:PlaySound("Interface.Click");
                v3:Send("VIP Player Kick Down", v21[v28].Roster[v31]);
            end);
            v33.MouseLeave:Connect(function() --[[ Line: 84 ]]
                -- upvalues: v33 (copy)
                v33.UIStroke.Enabled = false;
                v33.Kick.Visible = false;
            end);
        end;
        v30.TeamName.Join.MouseButton1Click:Connect(function() --[[ Line: 90 ]]
            -- upvalues: v2 (ref), v21 (ref), v28 (copy), l_Players_0 (ref), v3 (ref)
            v2:PlaySound("Interface.Click");
            if table.find(v21[v28].Roster, l_Players_0.LocalPlayer.Name) then
                v3:Send("Leave VIP Team");
                return;
            else
                v3:Send("Change VIP Team", v28);
                return;
            end;
        end);
        v30.Size = UDim2.new(1, -6, 0, v30.UIListLayout.AbsoluteContentSize.Y);
        v30.TeamName.TeamName:GetPropertyChangedSignal("TextBounds"):Connect(function() --[[ Line: 102 ]]
            -- upvalues: v30 (copy)
            local l_X_0 = v30.TeamName.TeamName.TextBounds.X;
            v30.TeamName.TeamName.Size = UDim2.new(0, l_X_0, 1, 0);
            v30.TeamName.Join.Position = UDim2.new(1, -l_X_0 - 10, 1, -10);
        end);
        if v18 and v29.NameEditable then
            local v35 = nil;
            do
                local l_v35_0 = v35;
                v30.TeamName.TeamName.FocusLost:Connect(function(v37) --[[ Line: 112 ]]
                    -- upvalues: v3 (ref), v28 (copy), v30 (copy), l_v35_0 (ref)
                    if v37 then
                        v3:Send("Set VIP Team Name", v28, v30.TeamName.TeamName.Text);
                        v30.TeamName.TeamName.Font = Enum.Font.SourceSansItalic;
                        v30.TeamName.TeamName.Text = "filtering...";
                        return;
                    else
                        v30.TeamName.TeamName.Text = l_v35_0;
                        return;
                    end;
                end);
                v30.TeamName.TeamName.Focused:Connect(function() --[[ Line: 123 ]]
                    -- upvalues: l_v35_0 (ref), v30 (copy)
                    l_v35_0 = v30.TeamName.TeamName.Text;
                end);
                v30.TeamName.TeamName.TextEditable = true;
            end;
        else
            v30.TeamName.TeamName.ClickSink.Visible = true;
            v30.TeamName.TeamName.TextEditable = false;
        end;
        v30.TeamName.TeamName.Text = "";
    end;
    l_Teams_0.CanvasSize = UDim2.fromScale(0, l_Teams_0.UIListLayout.AbsoluteContentSize.Y);
end;
local function v45() --[[ Line: 139 ]] --[[ Name: setTeamGuis ]]
    -- upvalues: v21 (ref), v27 (copy), l_Teams_0 (copy), v19 (ref), v18 (ref), l_Players_0 (copy)
    for v39, v40 in next, v21 do
        v27(l_Teams_0, "Team " .. v39, function(v41) --[[ Line: 141 ]]
            -- upvalues: v40 (copy), v19 (ref), v18 (ref), l_Players_0 (ref), v27 (ref)
            v41.TeamName.TeamName.Text = v40.TeamName;
            v41.TeamName.TeamName.Font = Enum.Font.SourceSansBold;
            v41.TeamName.Join.Visible = v19;
            if v19 and v18 then
                v41.TeamName.TeamName.ClickSink.Visible = not v40.NameEditable;
            else
                v41.TeamName.TeamName.ClickSink.Visible = false;
            end;
            if v41.TeamName.TeamName.ClickSink.Visible then
                v41.TeamName.TeamName:ReleaseFocus(false);
            end;
            if table.find(v40.Roster, l_Players_0.LocalPlayer.Name) then
                v41.TeamName.Join.Text = "LEAVE";
            else
                v41.TeamName.Join.Text = "JOIN";
            end;
            for v42, v43 in next, v40.Roster do
                v27(v41, "Slot " .. v42, function(v44) --[[ Line: 164 ]]
                    -- upvalues: v40 (ref), v43 (copy)
                    v44.BackgroundColor3 = v40.TeamColor;
                    v44.PlayerName.Text = v43;
                end);
            end;
        end);
    end;
end;
local function v50() --[[ Line: 173 ]] --[[ Name: drawMapPicks ]]
    -- upvalues: v20 (ref), l_Settings_0 (copy), v1 (copy)
    local l_Picks_0 = v20.Map.Picks;
    l_Settings_0.Maps.TitleFrame.MapPoints.Text = string.format("%d selected", #l_Picks_0);
    for _, v48 in next, l_Settings_0.Maps:GetChildren() do
        if v48:IsA("ImageButton") then
            local v49 = table.find(l_Picks_0, v48.Name);
            if v49 then
                v48.PickOrder.Text = v1.numberToOrdinalText(v49);
                v48.ImageLabel.ImageTransparency = 0;
                v48.TextLabel.TextColor3 = Color3.new(1, 1, 1);
            else
                v48.PickOrder.Text = "";
                v48.ImageLabel.ImageTransparency = 0.7;
                v48.TextLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8);
            end;
        end;
    end;
end;
local function v84() --[[ Line: 196 ]] --[[ Name: buildSettingsGuis ]]
    -- upvalues: v20 (ref), v13 (copy), l_Settings_0 (copy), v50 (copy), v2 (copy), v3 (copy), v14 (copy), v0 (copy), l_UserInputService_0 (copy)
    for v51, v52 in next, v20.Map.List do
        local v53 = v13:Clone();
        v53.LayoutOrder = v51;
        v53.Name = v52.Name;
        v53.TextLabel.Text = v52.DisplayName;
        v53.Parent = l_Settings_0.Maps;
        v53.ImageLabel.Image = v52.SmallImage;
        v53.MouseEnter:Connect(function() --[[ Line: 205 ]]
            -- upvalues: v53 (copy)
            v53.UIStroke.Enabled = true;
        end);
        v53.MouseLeave:Connect(function() --[[ Line: 209 ]]
            -- upvalues: v53 (copy)
            v53.UIStroke.Enabled = false;
        end);
        v53.MouseButton1Click:Connect(function() --[[ Line: 213 ]]
            -- upvalues: v50 (ref), v2 (ref), v3 (ref), v52 (copy)
            v50();
            v2:PlaySound("Interface.Click");
            v3:Send("Modify VIP Map Rotation", v52.Name);
        end);
    end;
    for v54, v55 in next, v20.Config do
        local v56 = v14:Clone();
        v56.Name = v55.Name;
        v56.Label.Text = v55.Name;
        v56.Label.Backdrop.Text = v55.Name;
        v56.LayoutOrder = v54;
        v56.Parent = l_Settings_0.Config;
        local v57 = {};
        local v58 = false;
        local v59 = false;
        local function _(v60) --[[ Line: 235 ]] --[[ Name: setZIndex ]]
            -- upvalues: v56 (copy)
            v56.Dropdown.ZIndex = 12 + v60;
            v56.Dropdown.InnerBox.ZIndex = 13 + v60;
            v56.Dropdown.InnerBox.Triangle.ZIndex = 14 + v60;
            v56.Dropdown.InnerBox.Label.ZIndex = 14 + v60;
            v56.Dropdown.Shadow.ZIndex = 11 + v60;
        end;
        do
            local l_v57_0, l_v58_0, l_v59_0 = v57, v58, v59;
            local function v67() --[[ Line: 243 ]] --[[ Name: close ]]
                -- upvalues: l_v57_0 (ref), v0 (ref), v56 (copy), l_v58_0 (ref), l_v59_0 (ref)
                for _, v66 in next, l_v57_0 do
                    v0.destroy(v66, "MouseEnter", "MouseButton1Click");
                end;
                v56.Dropdown.Size = UDim2.new(0, 110, 0, 27);
                v56.Dropdown.InnerBox.Label.Visible = true;
                v56.Dropdown.InnerBox.Triangle.Visible = true;
                l_v57_0 = {};
                v56.Dropdown.ZIndex = 62;
                v56.Dropdown.InnerBox.ZIndex = 63;
                v56.Dropdown.InnerBox.Triangle.ZIndex = 64;
                v56.Dropdown.InnerBox.Label.ZIndex = 64;
                v56.Dropdown.Shadow.ZIndex = 61;
                l_v58_0 = false;
                l_v59_0 = false;
            end;
            local _ = function(v68) --[[ Line: 258 ]] --[[ Name: highlight ]]
                -- upvalues: l_v57_0 (ref)
                for _, v70 in next, l_v57_0 do
                    v70.BackgroundTransparency = v70 == v68 and 0 or 1;
                end;
            end;
            local function v82() --[[ Line: 264 ]] --[[ Name: open ]]
                -- upvalues: v67 (copy), l_v59_0 (ref), v55 (copy), v56 (copy), l_v57_0 (ref), v3 (ref), v2 (ref), l_v58_0 (ref)
                v67();
                l_v59_0 = true;
                local v72 = 27;
                for v73, v74 in next, v55.List do
                    local l_TextButton_0 = Instance.new("TextButton");
                    l_TextButton_0.Size = UDim2.new(1, -2, 0, 25);
                    l_TextButton_0.Position = UDim2.new(0, 1, 0, (v73 - 1) * 25 + 3);
                    l_TextButton_0.ZIndex = 100;
                    l_TextButton_0.BackgroundTransparency = 1;
                    l_TextButton_0.BorderSizePixel = 0;
                    l_TextButton_0.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
                    l_TextButton_0.Font = Enum.Font.SourceSans;
                    l_TextButton_0.TextSize = 18;
                    l_TextButton_0.TextTransparency = 0;
                    l_TextButton_0.TextColor3 = Color3.new(1, 1, 1);
                    l_TextButton_0.TextStrokeTransparency = 1;
                    l_TextButton_0.Text = v74;
                    l_TextButton_0.AutoButtonColor = false;
                    l_TextButton_0.Parent = v56.Dropdown;
                    l_TextButton_0.MouseEnter:Connect(function() --[[ Line: 288 ]]
                        -- upvalues: l_TextButton_0 (copy), l_v57_0 (ref)
                        local l_l_TextButton_0_0 = l_TextButton_0;
                        for _, v78 in next, l_v57_0 do
                            v78.BackgroundTransparency = v78 == l_l_TextButton_0_0 and 0 or 1;
                        end;
                    end);
                    l_TextButton_0.MouseButton1Click:Connect(function() --[[ Line: 292 ]]
                        -- upvalues: v56 (ref), v74 (copy), v3 (ref), v55 (ref), v2 (ref), v67 (ref)
                        v56.Dropdown.InnerBox.Label.Text = v74;
                        v3:Send("Change VIP Setting", v55.Name, v74);
                        v2:PlaySound("Interface.Click");
                        v67();
                    end);
                    l_v57_0[v73] = l_TextButton_0;
                end;
                if #v55.List > 0 then
                    v72 = #v55.List * 25 + 6;
                end;
                v56.Dropdown.Size = UDim2.new(0, 110, 0, v72);
                v56.Dropdown.InnerBox.Label.Visible = false;
                v56.Dropdown.InnerBox.Triangle.Visible = false;
                local v79 = l_v57_0[1];
                for _, v81 in next, l_v57_0 do
                    v81.BackgroundTransparency = v81 == v79 and 0 or 1;
                end;
                v56.Dropdown.ZIndex = 82;
                v56.Dropdown.InnerBox.ZIndex = 83;
                v56.Dropdown.InnerBox.Triangle.ZIndex = 84;
                v56.Dropdown.InnerBox.Label.ZIndex = 84;
                v56.Dropdown.Shadow.ZIndex = 81;
                l_v58_0 = true;
            end;
            v56.Dropdown.MouseButton1Click:Connect(function() --[[ Line: 318 ]]
                -- upvalues: v82 (copy)
                v82();
            end);
            l_UserInputService_0.InputEnded:Connect(function(v83) --[[ Line: 323 ]]
                -- upvalues: l_v59_0 (ref), l_v58_0 (ref), v2 (ref), v67 (copy)
                if v83.UserInputType == Enum.UserInputType.MouseButton1 then
                    task.defer(function() --[[ Line: 325 ]]
                        -- upvalues: l_v59_0 (ref), l_v58_0 (ref), v2 (ref), v67 (ref)
                        if l_v59_0 then
                            l_v59_0 = false;
                            return;
                        else
                            if l_v58_0 then
                                v2:PlaySound("Interface.Click");
                                v67();
                            end;
                            return;
                        end;
                    end);
                end;
            end);
        end;
    end;
    l_Settings_0.Maps.Size = UDim2.new(1, -6, 0, l_Settings_0.Maps.UIListLayout.AbsoluteContentSize.Y);
    l_Settings_0.Config.Size = UDim2.new(1, -6, 0, l_Settings_0.Config.UIListLayout.AbsoluteContentSize.Y);
    l_Settings_0.CanvasSize = UDim2.fromOffset(0, l_Settings_0.UIListLayout.AbsoluteContentSize.Y);
end;
local function v90() --[[ Line: 346 ]] --[[ Name: setSettingsGui ]]
    -- upvalues: v20 (ref), v50 (copy), v27 (copy), l_Settings_0 (copy)
    for _, _ in next, v20.Map.List do
        v50();
    end;
    for _, v88 in next, v20.Config do
        v27(l_Settings_0.Config, v88.Name, function(v89) --[[ Line: 352 ]]
            -- upvalues: v88 (copy)
            v89.Dropdown.InnerBox.Label.Text = v88.Value .. " " .. v88.Suffix;
        end);
    end;
end;
local function v94(v91) --[[ Line: 358 ]] --[[ Name: setStartButton ]]
    -- upvalues: v15 (copy), v7 (copy), l_Settings_0 (copy), l_Teams_0 (copy)
    for v92, v93 in next, v15 do
        v93.Visible = v91 == v92;
    end;
    if v91 == "Start" or v91 == "Blocked" then
        v7.Gui.Configure.Visible = true;
    else
        v7.Gui.Configure.Visible = false;
    end;
    if not v7.Gui.Configure.Visible then
        l_Settings_0.Visible = false;
        l_Teams_0.Visible = true;
    end;
end;
v7.Start = function(v95) --[[ Line: 377 ]] --[[ Name: Start ]]
    -- upvalues: v18 (ref), v3 (copy), v21 (ref), v20 (ref), v19 (ref), v15 (copy), v7 (copy), l_Settings_0 (copy), l_Teams_0 (copy), v38 (copy), v45 (copy), v84 (copy), v90 (copy), v2 (copy), v94 (copy), l_RunService_0 (copy), v17 (ref), v16 (ref), v22 (copy)
    v18 = v3:Fetch("Is VIP Owner");
    v21 = v3:Fetch("Get VIP Team Data");
    v20 = v3:Fetch("Get VIP Settings");
    v19 = v3:Fetch("Can Join VIP Teams");
    for v96, v97 in next, v15 do
        v97.Visible = v96 == "nah dude";
    end;
    v7.Gui.Configure.Visible = false;
    if not v7.Gui.Configure.Visible then
        l_Settings_0.Visible = false;
        l_Teams_0.Visible = true;
    end;
    v38();
    v45();
    v84();
    v90();
    if v18 then
        v95.Gui.Configure.Visible = true;
        v95.Gui.Configure.MouseButton1Click:Connect(function() --[[ Line: 394 ]]
            -- upvalues: v2 (ref), l_Settings_0 (ref), l_Teams_0 (ref)
            v2:PlaySound("Interface.Click");
            l_Settings_0.Visible = not l_Settings_0.Visible;
            l_Teams_0.Visible = not l_Settings_0.Visible;
        end);
        v94(v3:Fetch("Get Start Button"));
        v15.Start.MouseButton1Click:Connect(function() --[[ Line: 403 ]]
            -- upvalues: v2 (ref), v3 (ref)
            v2:PlaySound("Interface.Click");
            v3:Send("Request Match Start");
        end);
        v15.Cancel.MouseButton1Click:Connect(function() --[[ Line: 408 ]]
            -- upvalues: v2 (ref), v3 (ref)
            v2:PlaySound("Interface.Click");
            v3:Send("Request Match Cancel");
        end);
    else
        v95.Gui.Configure.Visible = false;
    end;
    v3:Add("Update VIP Team Data", function(v98) --[[ Line: 417 ]]
        -- upvalues: v21 (ref), v45 (ref)
        v21 = v98;
        v45();
    end);
    v3:Add("Update VIP Settings", function(v99) --[[ Line: 423 ]]
        -- upvalues: v20 (ref), v90 (ref)
        v20 = v99;
        v90();
    end);
    v3:Add("Set Start Button", function(v100) --[[ Line: 429 ]]
        -- upvalues: v18 (ref), v94 (ref)
        if v18 then
            v94(v100);
        end;
    end);
    v3:Add("Set Teams Joinable", function(v101) --[[ Line: 435 ]]
        -- upvalues: v19 (ref), v45 (ref)
        v19 = v101;
        v45();
    end);
    v3:Add("Set Status Text", function(v102, v103) --[[ Line: 441 ]]
        -- upvalues: v95 (copy)
        v95.Gui.ServerText.Big.Text = v102 or "";
        v95.Gui.ServerText.Small.Text = v103 or "";
        v95.Gui.ServerText.Visible = true;
    end);
    v3:Add("Prompt Rejoin", function() --[[ Line: 448 ]]
        -- upvalues: v95 (copy), v3 (ref), v2 (ref)
        local v104 = {};
        local _ = function() --[[ Line: 451 ]] --[[ Name: clean ]]
            -- upvalues: v104 (copy)
            for _, v106 in next, v104 do
                v106:Disconnect();
            end;
        end;
        table.insert(v104, v95.Gui.Rejoin.Prompt.Yes.MouseButton1Click:Connect(function() --[[ Line: 457 ]]
            -- upvalues: v3 (ref), v104 (copy), v95 (ref), v2 (ref)
            v3:Send("Rejoin Confirm");
            for _, v109 in next, v104 do
                v109:Disconnect();
            end;
            v95.Gui.Rejoin.Status.Text = "Teleporting, please wait...";
            v95.Gui.Rejoin.Status.Visible = true;
            v95.Gui.Rejoin.Prompt.Visible = false;
            v2:PlaySound("Interface.Click");
        end));
        table.insert(v104, v95.Gui.Rejoin.Prompt.No.MouseButton1Click:Connect(function() --[[ Line: 468 ]]
            -- upvalues: v104 (copy), v95 (ref), v2 (ref)
            for _, v111 in next, v104 do
                v111:Disconnect();
            end;
            v95.Gui.Rejoin.Visible = false;
            v2:PlaySound("Interface.Click");
        end));
        v95.Gui.Rejoin.Status.Visible = false;
        v95.Gui.Rejoin.Prompt.Visible = true;
        v95.Gui.Rejoin.Visible = true;
        v2:PlaySound("Interface.Bweep");
    end);
    v3:Send("Request Rejoin Lookup");
    l_RunService_0.Heartbeat:Connect(function(v112) --[[ Line: 485 ]]
        -- upvalues: v17 (ref), v20 (ref), v16 (ref), v22 (ref), v95 (copy), v2 (ref)
        if v17 <= 0 then
            local l_Picks_1 = v20.Map.Picks;
            local _ = v20.Map.List;
            local v115 = nil;
            local v116 = nil;
            for _, v118 in next, v20.Map.List do
                if v118.BigImage == v16 then
                    v115 = v118.Name;
                    break;
                end;
            end;
            if v115 then
                local v119 = false;
                for _, v121 in next, v20.Config do
                    if v121.Name == "Map rotation" and v121.Value == "Shuffle all" then
                        v119 = true;
                        break;
                    end;
                end;
                if v119 then
                    local l_List_1 = v20.Map.List;
                    return l_List_1[v22:NextInteger(1, #l_List_1)].Name;
                else
                    local l_Picks_2 = v20.Map.Picks;
                    local v124 = table.find(l_Picks_2, v115);
                    if v124 then
                        v116 = l_Picks_2[1 + v124 % #l_Picks_2];
                    end;
                end;
            elseif #l_Picks_1 > 0 then
                v116 = l_Picks_1[1];
            end;
            if v116 then
                for _, v126 in next, v20.Map.List do
                    if v126.Name == v116 then
                        v16 = v126.BigImage;
                        v17 = 4.3;
                        break;
                    end;
                end;
            else
                v16 = "";
            end;
        end;
        local l_ImageLabel_0 = v95.Gui.Backdrop.Image.ImageLabel;
        local v128 = l_ImageLabel_0.Image ~= v16;
        if v16 == "" then
            l_ImageLabel_0.ImageTransparency = 1;
        else
            local v129 = (v128 and 1 or -1) * (v112 * 1.3);
            l_ImageLabel_0.ImageTransparency = math.clamp(l_ImageLabel_0.ImageTransparency + v129, 0, 1);
        end;
        if v128 and l_ImageLabel_0.ImageTransparency >= 1 then
            v95.Gui.Backdrop.Image.ImageLabel.Image = v16;
        end;
        if v95.Gui.Backdrop.Image.ImageLabel.Image == v16 then
            v17 = v17 - v112;
        end;
        local v130 = v2:GetScreenSize() - Vector2.new(410, 0);
        local v131 = math.max(v130.X, v130.Y);
        v95.Gui.Backdrop.Image.Size = UDim2.new(0, v131, 0, v131);
    end);
    v3:Send("Refresh Status Request");
    v2:Show("VIPLobby");
    v2:Get("Fade"):Fade(1, 1);
end;
return v7;