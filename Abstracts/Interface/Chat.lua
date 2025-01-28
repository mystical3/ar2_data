local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local _ = v0.require("Configs", "ItemData");
local v3 = v0.require("Configs", "EmojiMap");
local v4 = v0.require("Libraries", "Interface");
local v5 = v0.require("Libraries", "Network");
local v6 = v0.require("Libraries", "Keybinds");
local _ = v0.require("Libraries", "Resources");
local _ = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Players_0 = game:GetService("Players");
local l_TextService_0 = game:GetService("TextService");
local l_v4_Gui_0 = v4:GetGui("Chat");
local l_v4_Storage_0 = v4:GetStorage("Chat");
local l_Input_0 = l_v4_Gui_0:WaitForChild("Input");
local l_TextBox_0 = l_Input_0:WaitForChild("TextBox");
local l_Switcher_0 = l_v4_Gui_0:WaitForChild("Switcher");
local l_TabListBin_0 = l_Switcher_0:WaitForChild("TabListBin");
local l_ScrollingFrame_0 = l_v4_Gui_0:WaitForChild("ScrollingFrame");
local l_ChatTemplate_0 = l_v4_Storage_0:WaitForChild("ChatTemplate");
local v20 = {
    Global = l_TabListBin_0:WaitForChild("Global"), 
    Area = l_TabListBin_0:WaitForChild("Area"), 
    Squad = l_TabListBin_0:WaitForChild("Squad")
};
local v21 = 0;
l_Switcher_0.Size = UDim2.fromOffset(l_TabListBin_0.UIListLayout.AbsoluteContentSize.X, 31);
local v22 = {};
local v23 = {};
local v24 = {
    "Global", 
    "Area", 
    "Squad"
};
local v25 = {};
local v26 = {};
for _, v28 in next, v24 do
    v25[v28] = 0;
    v26[v28] = {};
end;
local l_Key_0 = v6:GetBind("Chat Focus").Key;
local l_Key_1 = v6:GetBind("Change Chat Channel").Key;
local v31 = v24[1];
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v33 = true;
local v34 = false;
local v35 = Vector2.new(10000, 100);
local v36 = "Click here or press \"" .. v1.KeyAliases[l_Key_0] .. "\" to chat.";
local function _(v37, v38) --[[ Line: 82 ]] --[[ Name: isInTable ]]
    for v39, v40 in next, v37 do
        if v40 == v38 then
            return true, v39;
        end;
    end;
    return false, 0;
end;
local function v42(v43) --[[ Line: 92 ]] --[[ Name: copyTable ]]
    -- upvalues: v42 (copy)
    local v44 = {};
    for v45, v46 in next, v43 do
        if type(v46) == "table" then
            v44[v45] = v42(v46);
        else
            v44[v45] = v46;
        end;
    end;
    return v44;
end;
local function _(v47, v48, v49) --[[ Line: 106 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    return l_TextService_0:GetTextSize(v47, v48.TextSize, v48.Font, v49 or v48.AbsoluteSize);
end;
local function v69(v51, v52, v53, v54) --[[ Line: 113 ]] --[[ Name: splitIntoLines ]]
    -- upvalues: v35 (copy), l_TextService_0 (copy)
    local v55 = {};
    local v56 = {};
    local v57 = {};
    for v58 in v52:gmatch("%S+") do
        table.insert(v55, v58);
    end;
    for v59, v60 in next, v55 do
        if v59 ~= #v55 then
            v60 = v60 .. " ";
            v55[v59] = v60;
        end;
        local l_v60_0 = v60;
        local l_v35_0 = v35;
        v56[v59] = l_TextService_0:GetTextSize(l_v60_0, v51.TextSize, v51.Font, l_v35_0 or v51.AbsoluteSize).X;
    end;
    if not next(v55) or not next(v56) then
        return {
            [1] = "?"
        };
    else
        local v63 = 1;
        local v64 = v53 - v56[1];
        local v65 = v55[1];
        for v66 = 2, #v55 do
            local v67 = v55[v66];
            local v68 = v56[v66];
            if v68 <= v64 then
                v64 = v64 - v68;
                v65 = v65 .. v67;
            else
                v57[v63] = v65;
                v63 = v63 + 1;
                v64 = v54 - v68;
                v65 = v67;
            end;
        end;
        v57[v63] = v65;
        return v57;
    end;
end;
local function v86(v70) --[[ Line: 187 ]] --[[ Name: makeNewChatGui ]]
    -- upvalues: l_ScrollingFrame_0 (copy), l_ChatTemplate_0 (copy), v35 (copy), l_TextService_0 (copy), v69 (copy)
    if l_ScrollingFrame_0.AbsoluteWindowSize.X <= 0 then
        return;
    else
        local v71 = l_ChatTemplate_0:Clone();
        v71.Visible = true;
        local l_Name_0 = v70.Sender.Name;
        local l_Sender_0 = v71.Sender;
        local l_v35_1 = v35;
        local v75 = l_TextService_0:GetTextSize(l_Name_0, l_Sender_0.TextSize, l_Sender_0.Font, l_v35_1 or l_Sender_0.AbsoluteSize).X + 11;
        if v70.Badge then
            v71.Icon.Image = v70.Badge;
            v71.Icon.Backdrop.Image = v70.Badge;
            v71.Icon.Visible = true;
            v71.Sender.Position = UDim2.new(0, 35, 0, -1);
            v75 = v75 + 30;
        else
            v71.Icon.Visible = false;
            v71.Sender.Position = UDim2.new(0, 5, 0, -1);
        end;
        local v76 = l_ScrollingFrame_0.AbsoluteWindowSize.X - 6 - v75 - 18;
        local v77 = v69(v71.Box.Body.Body, v70.Message, v76, l_ScrollingFrame_0.AbsoluteWindowSize.X - 6 - 18);
        l_v35_1 = v77[1];
        local l_Body_0 = v71.Box.Body.Body;
        local l_v35_2 = v35;
        l_Name_0 = l_TextService_0:GetTextSize(l_v35_1, l_Body_0.TextSize, l_Body_0.Font, l_v35_2 or l_Body_0.AbsoluteSize).X;
        v71.Sender.Text = v70.Sender.Name;
        v71.Sender.Backdrop.Text = v70.Sender.Name;
        v71.Box.Body.Body.Text = v77[1];
        v71.Box.Body.Body.Backdrop.Text = v77[1];
        v71.Box.ImageColor3 = v70.Color;
        v71.Box.Size = UDim2.new(0, v75, 0, 25);
        v71.Box.Body.Size = UDim2.new(0, math.min(l_Name_0, v76) + 18, 0, 25);
        if #v77 > 1 then
            for v80 = 2, #v77 do
                l_v35_2 = v71.NewLine:Clone();
                l_v35_2.Visible = true;
                l_v35_2.Body.Text = v77[v80];
                l_v35_2.Body.Backdrop.Text = v77[v80];
                l_v35_2.Position = UDim2.new(0, 0, 0, (v80 - 1) * 27);
                local l_new_0 = UDim2.new;
                local v82 = 0;
                local v83 = v77[v80];
                local l_Body_1 = l_v35_2.Body;
                local l_v35_3 = v35;
                l_v35_2.Size = l_new_0(v82, l_TextService_0:GetTextSize(v83, l_Body_1.TextSize, l_Body_1.Font, l_v35_3 or l_Body_1.AbsoluteSize).X + 11, 0, 25);
                l_v35_2.Parent = v71.Box;
            end;
        end;
        v70.LinesUsed = #v77;
        v71.Size = UDim2.new(0, 20, 0, v70.LinesUsed * 27);
        return v71;
    end;
end;
local function v94(v87) --[[ Line: 244 ]] --[[ Name: drawChat ]]
    -- upvalues: l_ScrollingFrame_0 (copy), v26 (copy), v34 (ref), v33 (ref), l_Input_0 (copy)
    for _, v89 in next, l_ScrollingFrame_0:GetChildren() do
        if v89:IsA("GuiBase") then
            v89.Parent = nil;
        end;
    end;
    for _, v91 in next, v26[v87] do
        v91.Gui.Parent = l_ScrollingFrame_0;
    end;
    local l_v34_0 = v34;
    local l_Y_0 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
    l_ScrollingFrame_0.CanvasSize = UDim2.new(0, 0, 0, l_Y_0);
    if l_v34_0 then
        l_ScrollingFrame_0.CanvasPosition = Vector2.new(0, l_Y_0 - l_ScrollingFrame_0.AbsoluteSize.Y);
    end;
    l_ScrollingFrame_0.Visible = v33;
    l_Input_0.Visible = true;
    if not v33 then
        l_Input_0.Position = UDim2.new(0, 16, 0, 68);
        return;
    else
        l_Input_0.Position = UDim2.new(0, 16, 0, 290);
        return;
    end;
end;
local function _() --[[ Line: 274 ]] --[[ Name: setUnreadNotifications ]]
    -- upvalues: v25 (copy), v20 (copy)
    for v95, v96 in next, v25 do
        v20[v95].Notification.Visible = v96 > 0;
    end;
end;
local function v104(v98) --[[ Line: 294 ]] --[[ Name: logChat ]]
    -- upvalues: l_LocalPlayer_0 (copy), v5 (copy), v26 (copy), v23 (copy), v25 (copy), v33 (ref), v34 (ref), v31 (ref), v86 (copy), v21 (ref)
    if v98.Sender == l_LocalPlayer_0 and not v98.Time then
        if v98.Message:gsub(" ", "") == "" then
            return;
        else
            if not v98.Message then
                v98.Message("");
            end;
            v98.Message = v98.Message:gsub("^%s+", "");
            if #v98.Message > 300 then
                v98.Message = string.sub(v98.Message, 1, 300) .. "...";
            end;
            v5:Send("Player Chatted", v98.Channel, v98.Message);
            return;
        end;
    else
        local v99 = true;
        local v100 = v26[v98.Channel];
        if v23[v98.Sender.UserId] and v98.Channel ~= "Squad" then
            v99 = false;
        end;
        if v99 then
            v25[v98.Channel] = v25[v98.Channel] + 1;
            if v33 and v34 then
                v25[v31] = 0;
            end;
            v98.Gui = v86(v98);
            if v98.Gui then
                v98.Gui.LayoutOrder = v21;
                v21 = v21 + 1;
                table.insert(v100, 1, v98);
                local v101 = table.remove(v100, 50);
                if v101 and v101.Gui then
                    v101.Gui:Destroy();
                end;
                table.sort(v100, function(v102, v103) --[[ Line: 341 ]]
                    return v102.Time > v103.Time;
                end);
            end;
        end;
        return;
    end;
end;
local function v116(v105) --[[ Line: 349 ]] --[[ Name: changeChannel ]]
    -- upvalues: v24 (copy), v31 (ref), v20 (copy), v25 (copy), v34 (ref), v94 (copy)
    if not v105 then
        local v106 = #v24;
        local v107 = 1;
        for v108, v109 in next, v24 do
            if v109 == v31 then
                v107 = v108;
            end;
        end;
        for v110 = v107, v107 + v106 - 1 do
            local v111 = v24[v110 % v106 + 1];
            if v20[v111].Visible then
                v31 = v111;
                break;
            end;
        end;
    else
        v31 = v105;
    end;
    for v112, v113 in next, v20 do
        v113.Selected.Visible = v31 == v112;
    end;
    v25[v31] = 0;
    v34 = true;
    v94(v31);
    for v114, v115 in next, v25 do
        v20[v114].Notification.Visible = v115 > 0;
    end;
end;
v22.IsPlayerMuted = function(_, v118) --[[ Line: 387 ]] --[[ Name: IsPlayerMuted ]]
    -- upvalues: v23 (copy)
    if v118 and v23[v118.UserId] then
        return true;
    else
        return false;
    end;
end;
v22.SetPlayerMuted = function(_, v120, v121) --[[ Line: 395 ]] --[[ Name: SetPlayerMuted ]]
    -- upvalues: v23 (copy)
    if v121 then
        v23[v120.UserId] = true;
        return;
    else
        v23[v120.UserId] = nil;
        return;
    end;
end;
v22.ModifyForTourneyLobby = function(_) --[[ Line: 403 ]] --[[ Name: ModifyForTourneyLobby ]]
    -- upvalues: l_Switcher_0 (copy), l_TabListBin_0 (copy), l_ScrollingFrame_0 (copy)
    l_Switcher_0.Visible = false;
    l_Switcher_0.Size = UDim2.fromOffset(l_TabListBin_0.UIListLayout.AbsoluteContentSize.X, 31);
    l_ScrollingFrame_0.Size = UDim2.new(0, 400, 0, 214);
end;
for v123, v124 in next, v20 do
    v124.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 422 ]]
        -- upvalues: v31 (ref), v123 (copy), v33 (ref), v116 (copy), v4 (copy), v94 (copy)
        if v31 == v123 then
            v33 = not v33;
        else
            v33 = true;
            v116(v123);
        end;
        v4:PlaySound("Interface.Click");
        v94(v31);
    end);
end;
l_UserInputService_0.InputEnded:Connect(function(v125, v126) --[[ Line: 435 ]]
    -- upvalues: l_v4_Gui_0 (copy), l_Key_0 (ref), l_TextBox_0 (copy), l_Key_1 (ref), l_Switcher_0 (copy), v33 (ref), v116 (copy), v4 (copy)
    if not v126 and l_v4_Gui_0.Visible then
        if v125.KeyCode == l_Key_0 then
            if not l_TextBox_0:IsFocused() then
                l_TextBox_0.Text = "";
                l_TextBox_0:CaptureFocus();
                return;
            end;
        elseif v125.KeyCode == l_Key_1 and l_Switcher_0.Visible then
            v33 = true;
            v116();
            v4:PlaySound("Interface.Click");
        end;
    end;
end);
l_TextBox_0.FocusLost:Connect(function(v127) --[[ Line: 452 ]]
    -- upvalues: v104 (copy), l_LocalPlayer_0 (copy), v31 (ref), l_TextBox_0 (copy), v36 (ref)
    if v127 then
        v104({
            Sender = l_LocalPlayer_0, 
            Channel = v31, 
            Message = l_TextBox_0.Text
        });
    end;
    l_TextBox_0.TextTransparency = 0.5;
    l_TextBox_0.Text = v36;
end);
l_TextBox_0.Focused:Connect(function() --[[ Line: 465 ]]
    -- upvalues: v33 (ref), v94 (copy), v31 (ref), l_TextBox_0 (copy)
    v33 = true;
    v94(v31);
    l_TextBox_0.TextTransparency = 0.1;
end);
l_TextBox_0:GetPropertyChangedSignal("ContentText"):Connect(function() --[[ Line: 472 ]]
    -- upvalues: l_TextBox_0 (copy), v3 (copy), l_TextService_0 (copy), l_Input_0 (copy)
    local v129 = l_TextBox_0.Text:gsub("(:[%w_]+:)", function(v128) --[[ Line: 473 ]]
        -- upvalues: v3 (ref)
        return v3[v128] or v128;
    end);
    if l_TextBox_0.Text ~= v129 then
        l_TextBox_0.Text = v129;
        return;
    else
        local l_ContentText_0 = l_TextBox_0.ContentText;
        local l_l_TextBox_0_0 = l_TextBox_0;
        local v132 = Vector2.new(700, 25);
        l_ContentText_0 = math.max(l_TextService_0:GetTextSize(l_ContentText_0, l_l_TextBox_0_0.TextSize, l_l_TextBox_0_0.Font, v132 or l_l_TextBox_0_0.AbsoluteSize).X, l_TextBox_0.TextBounds.X) + 10;
        l_TextBox_0.Backdrop.Text = l_TextBox_0.Text;
        l_Input_0.Size = UDim2.new(0, l_ContentText_0, 0, 25);
        return;
    end;
end);
l_ScrollingFrame_0.Changed:Connect(function() --[[ Line: 490 ]]
    -- upvalues: l_ScrollingFrame_0 (copy), v34 (ref), v25 (copy), v31 (ref), v20 (copy)
    local v133 = l_ScrollingFrame_0.CanvasSize.Y.Offset - l_ScrollingFrame_0.AbsoluteSize.Y;
    if v133 > 0 then
        local v134 = l_ScrollingFrame_0.CanvasPosition.Y == v133;
        if v134 and not v34 then
            v34 = true;
            v25[v31] = 0;
            for v135, v136 in next, v25 do
                v20[v135].Notification.Visible = v136 > 0;
            end;
        end;
        v34 = v134;
        return;
    else
        v34 = true;
        return;
    end;
end);
v5:Add("Player Chatted", function(v137) --[[ Line: 508 ]]
    -- upvalues: v104 (copy), v94 (copy), v31 (ref), v25 (copy), v20 (copy)
    v104(v137);
    v94(v31);
    for v138, v139 in next, v25 do
        v20[v138].Notification.Visible = v139 > 0;
    end;
end);
v6.BindChanged:Connect(function(v140) --[[ Line: 514 ]]
    -- upvalues: l_Key_1 (ref), v6 (copy), l_Key_0 (ref), v36 (ref), v1 (copy), l_TextBox_0 (copy)
    if v140 == "Change Chat Channel" then
        l_Key_1 = v6:GetBind("Change Chat Channel").Key;
        return;
    else
        if v140 == "Chat Focus" then
            l_Key_0 = v6:GetBind("Chat Focus").Key;
            v36 = "Click here or press \"" .. v1.KeyAliases[l_Key_0] .. "\" to chat.";
            l_TextBox_0:CaptureFocus();
            l_TextBox_0:ReleaseFocus();
        end;
        return;
    end;
end);
l_v4_Gui_0:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 526 ]]
    -- upvalues: l_TextBox_0 (copy), l_v4_Gui_0 (copy), v4 (copy)
    if l_TextBox_0:IsFocused() then
        l_TextBox_0:ReleaseFocus();
    end;
    if not l_v4_Gui_0.Visible then
        v4:Hide("MedalQuest");
    end;
end);
v4:AttachToTopbar(function(v141, _, v143) --[[ Line: 536 ]]
    -- upvalues: l_Switcher_0 (copy)
    if v143 then
        l_Switcher_0.Position = UDim2.fromOffset(v141.X + 16, 34);
        return;
    else
        l_Switcher_0.Position = UDim2.fromOffset(58, 6);
        return;
    end;
end);
for v144, v145 in next, v25 do
    v20[v144].Notification.Visible = v145 > 0;
end;
v116(v31);
l_ScrollingFrame_0.CanvasPosition = Vector2.new(0, 1.0E48);
return v22;