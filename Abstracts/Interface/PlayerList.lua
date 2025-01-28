local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Staff");
local v2 = v0.require("Configs", "Globals");
local v3 = v0.require("Libraries", "Interface");
local v4 = v0.require("Libraries", "Network");
local v5 = v0.require("Libraries", "World");
local v6 = v0.require("Libraries", "Resources");
local v7 = v0.require("Libraries", "Keybinds");
local v8 = v0.require("Libraries", "Wardrobe");
local v9 = v0.require("Classes", "Springs");
local v10 = v0.require("Classes", "Maids");
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_TextService_0 = game:GetService("TextService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_v3_Storage_0 = v3:GetStorage("PlayerList");
local v16 = {
    Gui = v3:GetGui("PlayerList")
};
local l_PlayerActions_0 = v16.Gui:WaitForChild("PlayerActions");
local l_MainList_0 = v16.Gui:WaitForChild("MainList");
local l_PlayerList_0 = l_MainList_0:WaitForChild("PlayerList");
local l_SquadList_0 = l_MainList_0:WaitForChild("SquadList");
local l_Switcher_0 = l_MainList_0:WaitForChild("Switcher");
local l_NoSquad_0 = l_SquadList_0:WaitForChild("ScrollingFrame"):WaitForChild("NoSquad");
local v23 = v16.Gui:WaitForChild("Squad Promt");
local l_KickConfirm_0 = v16.Gui:WaitForChild("KickConfirm");
local l_KickedWarning_0 = v16.Gui:WaitForChild("KickedWarning");
local v26 = v9.new(0, 15, 1);
local v27 = {};
local v28 = {};
local v29 = {};
local v30 = {};
local v31 = {};
local v32 = nil;
local v33 = 0;
local v34 = "Your group leader is kicking you from the group, in %d seconds you will be able to shoot and be shot by your former teammates.";
local v35 = Vector2.new(10000, 100);
local v36 = false;
local v37 = false;
task.spawn(function() --[[ Line: 66 ]]
    -- upvalues: v37 (ref), v4 (copy)
    v37 = v4:Fetch("Is Staff");
end);
local function _(v38, v39, v40) --[[ Line: 72 ]] --[[ Name: lerp ]]
    return v38 + (v39 - v38) * v40;
end;
local function _(v42, v43) --[[ Line: 76 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy), v35 (copy)
    return l_TextService_0:GetTextSize(v42.Text, v42.TextSize, v42.Font, v43 or v35);
end;
local function _(v45, v46, v47) --[[ Line: 83 ]] --[[ Name: connectToAttribute ]]
    local v48 = v45:GetAttributeChangedSignal(v46):Connect(function() --[[ Line: 84 ]]
        -- upvalues: v47 (copy), v45 (copy), v46 (copy)
        v47(v45:GetAttribute(v46));
    end);
    v47(v45:GetAttribute(v46));
    return v48;
end;
local function v56() --[[ Line: 93 ]] --[[ Name: setPlayerCount ]]
    -- upvalues: l_Players_0 (copy), v27 (copy), l_PlayerList_0 (copy), l_SquadList_0 (copy)
    local l_MaxPlayers_0 = l_Players_0.MaxPlayers;
    local v51 = 0;
    for _, _ in next, v27 do
        v51 = v51 + 1;
    end;
    local _ = l_PlayerList_0.ScrollingFrame.Top.Icon.PlayerCount;
    local v55 = string.format("%d/%d", v51, l_MaxPlayers_0);
    l_PlayerList_0.ScrollingFrame.Top.Icon.PlayerCount.Text = v55;
    l_PlayerList_0.ScrollingFrame.Top.Icon.PlayerCount.Backdrop.Text = v55;
    l_SquadList_0.Top.Icon.PlayerCount.Text = v55;
    l_SquadList_0.Top.Icon.PlayerCount.Backdrop.Text = v55;
end;
local function _(v57) --[[ Line: 111 ]] --[[ Name: getMinScrollBinHeight ]]
    -- upvalues: l_PlayerList_0 (copy), l_v3_Storage_0 (copy), l_SquadList_0 (copy)
    if v57 == l_PlayerList_0 then
        local l_Y_0 = v57.ScrollingFrame.Top.AbsoluteSize.Y;
        local l_Y_1 = l_v3_Storage_0.PlayerTemplate.AbsoluteSize.Y;
        local l_Offset_0 = v57.ScrollingFrame.UIListLayout.Padding.Offset;
        return l_Y_0 + l_Y_1 + l_Offset_0;
    elseif v57 == l_SquadList_0 then
        return 62;
    else
        return 0;
    end;
end;
local function _(v62) --[[ Line: 127 ]] --[[ Name: getMaxScrollBinHeight ]]
    -- upvalues: l_PlayerList_0 (copy), v16 (copy)
    if v62 == l_PlayerList_0 then
        return v16.Gui.AbsoluteSize.Y - v62.AbsolutePosition.Y - 411;
    else
        return 1080;
    end;
end;
local function v89(v64, v65, v66) --[[ Line: 139 ]] --[[ Name: connectResizeDragger ]]
    -- upvalues: l_PlayerList_0 (copy), v16 (copy), l_v3_Storage_0 (copy), l_SquadList_0 (copy), v30 (copy), l_UserInputService_0 (copy)
    local l_UIListLayout_0 = v64.ScrollingFrame.UIListLayout;
    local l_DraggerButton_0 = v65.Frame.DraggerButton;
    local v69 = v66 or 0;
    local v70 = false;
    local v71 = 0;
    local v72 = Vector3.new();
    local v73 = Vector3.new();
    local function v84(v74) --[[ Line: 150 ]] --[[ Name: draw ]]
        -- upvalues: v71 (ref), l_UIListLayout_0 (copy), v69 (copy), v64 (copy), l_PlayerList_0 (ref), v16 (ref), l_v3_Storage_0 (ref), l_SquadList_0 (ref), v30 (ref)
        local v75 = v71 + v74.Y;
        local v76 = l_UIListLayout_0.AbsoluteContentSize.Y + v69;
        local l_v64_0 = v64;
        local v78 = math.min((if l_v64_0 == l_PlayerList_0 then v16.Gui.AbsoluteSize.Y - l_v64_0.AbsolutePosition.Y - 411 else 1080) + v69, v76);
        l_v64_0 = v64;
        local v79;
        if l_v64_0 == l_PlayerList_0 then
            local l_Y_2 = l_v64_0.ScrollingFrame.Top.AbsoluteSize.Y;
            local l_Y_3 = l_v3_Storage_0.PlayerTemplate.AbsoluteSize.Y;
            local l_Offset_1 = l_v64_0.ScrollingFrame.UIListLayout.Padding.Offset;
            v79 = l_Y_2 + l_Y_3 + l_Offset_1;
        else
            v79 = l_v64_0 == l_SquadList_0 and 62 or 0;
        end;
        local v83 = v79 + v69;
        v79 = math.clamp(v75, v83, v78);
        if v79 == v78 then
            v30[v64] = "Max";
        elseif v79 == v83 then
            v30[v64] = "Min";
        else
            v30[v64] = "Custom";
        end;
        v64.Size = UDim2.new(0, 350, 0, v79);
    end;
    l_DraggerButton_0.MouseButton1Down:Connect(function() --[[ Line: 169 ]]
        -- upvalues: v71 (ref), v64 (copy), v72 (ref), v73 (ref), v70 (ref)
        v71 = v64.Size.Y.Offset;
        v72 = v73;
        v70 = true;
    end);
    l_UserInputService_0.InputEnded:Connect(function(v85, _) --[[ Line: 175 ]]
        -- upvalues: v70 (ref)
        if v85.UserInputType == Enum.UserInputType.MouseButton1 and v70 then
            v70 = false;
        end;
    end);
    l_UserInputService_0.InputChanged:Connect(function(v87, _) --[[ Line: 181 ]]
        -- upvalues: v73 (ref), v70 (ref), v84 (copy), v72 (ref)
        if v87.UserInputType == Enum.UserInputType.MouseMovement then
            v73 = v87.Position;
        end;
        if v70 then
            v84(v73 - v72);
        end;
    end);
    v30[v64] = "Max";
end;
local function v122(v90) --[[ Line: 194 ]] --[[ Name: setSquadTags ]]
    -- upvalues: v32 (ref), v29 (ref), l_Players_0 (copy), l_v3_Storage_0 (copy), l_TextService_0 (copy), v35 (copy), v16 (copy), v5 (copy), l_UserInputService_0 (copy), v0 (copy), v26 (copy), v3 (copy)
    if not v32 then
        if next(v29) then
            for _, v92 in next, v29 do
                v92:Destroy();
            end;
            v29 = {};
            return;
        end;
    else
        for v93, _ in next, v32.Members do
            if v93 ~= l_Players_0.LocalPlayer and v93.Character and not v29[v93.Character] then
                local v95 = l_v3_Storage_0:WaitForChild("SquadTag"):Clone();
                v95.OuterBox.Maximized.NameLabel.Text = v93.Name;
                local l_OuterBox_0 = v95.OuterBox;
                local l_new_0 = UDim2.new;
                local v98 = 0;
                local l_NameLabel_0 = v95.OuterBox.Maximized.NameLabel;
                l_OuterBox_0.Size = l_new_0(v98, l_TextService_0:GetTextSize(l_NameLabel_0.Text, l_NameLabel_0.TextSize, l_NameLabel_0.Font, v35).X + 20, 0, 23);
                v95.OuterBox.Minimized.Visible = true;
                v95.OuterBox.Maximized.Visible = false;
                v95.Adornee = v93.Character.PrimaryPart;
                v95.Parent = v16.Gui.Parent;
                v29[v93.Character] = v95;
            end;
        end;
        local l_CurrentCamera_0 = workspace.CurrentCamera;
        local l_CFrame_0 = workspace.CurrentCamera.CFrame;
        local l_v5_Distance_0 = v5:GetDistance("Elements", true);
        local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
        local v104 = l_CurrentCamera_0:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y);
        local v105 = v0.Classes.Players.get();
        local v106 = false;
        if v105 and v105.Character and v105.Character.Zooming then
            v106 = true;
        end;
        if v106 then
            v26:SetGoal(1);
        else
            v26:SetGoal(0);
        end;
        local v107 = v26:Update(v90);
        local v108 = nil;
        local v109 = nil;
        local v110 = {};
        for v111, v112 in next, v29 do
            local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v111);
            if v111.Parent and v111.PrimaryPart and v32 and l_l_Players_0_PlayerFromCharacter_0 and v32.Members[l_l_Players_0_PlayerFromCharacter_0] ~= nil then
                local v114 = v111.PrimaryPart.Position + Vector3.new(0, 2, 0, 0) - l_CFrame_0.p;
                local v115 = v104.Direction:Dot(v114.unit);
                if v109 == nil or v109 < v115 then
                    v108 = v112;
                    v109 = v115;
                end;
                v112.Enabled = v114.Magnitude < l_v5_Distance_0;
                if not v3.AllVisible then
                    v112.Enabled = false;
                end;
            else
                table.insert(v110, v111);
            end;
        end;
        for _, v117 in next, v110 do
            local v118 = v29[v117];
            if v118 then
                v118:Destroy();
            end;
            v29[v117] = nil;
        end;
        if v108 and v109 then
            for _, v120 in next, v29 do
                if v120.Parent and v120.Enabled then
                    local v121 = false;
                    if v108 == v120 and v109 > 0.985 and not v106 then
                        v121 = true;
                    end;
                    v120.OuterBox.Maximized.Visible = v121;
                    v120.OuterBox.Minimized.Visible = not v121;
                    v120.OuterBox.Minimized.ImageTransparency = v107 * 0.5;
                    v120.OuterBox.Minimized.Shadow.ImageTransparency = 0.5 + v107 * 0.5;
                end;
            end;
        end;
    end;
end;
local v123 = nil;
local v124 = nil;
do
    local l_v124_0 = v124;
    local function _() --[[ Line: 305 ]] --[[ Name: kick ]]
        -- upvalues: l_v124_0 (ref), v4 (copy), l_KickConfirm_0 (copy)
        if l_v124_0 then
            v4:Send("Kick From Squad", l_v124_0);
        end;
        l_KickConfirm_0.Visible = false;
    end;
    l_KickConfirm_0.Frame.Accept.MouseButton1Click:Connect(function() --[[ Line: 314 ]]
        -- upvalues: v3 (copy), l_v124_0 (ref), v4 (copy), l_KickConfirm_0 (copy)
        v3:PlaySound("Interface.Click");
        if l_v124_0 then
            v4:Send("Kick From Squad", l_v124_0);
        end;
        l_KickConfirm_0.Visible = false;
    end);
    l_KickConfirm_0.Frame.Accept.MouseButton1Click:Connect(function() --[[ Line: 319 ]]
        -- upvalues: v3 (copy), l_KickConfirm_0 (copy)
        v3:PlaySound("Interface.Click");
        l_KickConfirm_0.Visible = false;
    end);
    l_UserInputService_0.InputBegan:Connect(function(v127, v128) --[[ Line: 325 ]]
        -- upvalues: l_KickConfirm_0 (copy), v3 (copy), l_v124_0 (ref), v4 (copy)
        if not v128 and l_KickConfirm_0.Visible then
            if v127.KeyCode == Enum.KeyCode.Y then
                v3:PlaySound("Interface.Click");
                if l_v124_0 then
                    v4:Send("Kick From Squad", l_v124_0);
                end;
                l_KickConfirm_0.Visible = false;
                return;
            elseif v127.KeyCode == Enum.KeyCode.N then
                v3:PlaySound("Interface.Click");
                l_KickConfirm_0.Visible = false;
            end;
        end;
    end);
    v123 = function(v129) --[[ Line: 338 ]] --[[ Name: promptKickConfirm ]]
        -- upvalues: l_KickConfirm_0 (copy), l_v124_0 (ref)
        l_KickConfirm_0.InnerBoxRight.TextLabel.Text = ("Are you sure you want to kick %s from the group? They will receive a notification that they are being kicked and will be given a 60 second countdown to prepare."):format(v129.Name);
        l_KickConfirm_0.InnerBoxRight.TextLabel.Backdrop.Text = l_KickConfirm_0.InnerBoxRight.TextLabel.Text;
        l_v124_0 = v129;
        l_KickConfirm_0.Visible = true;
    end;
end;
v124 = nil;
local v130 = nil;
local v131 = {};
do
    local l_v131_0 = v131;
    local function v135(v133) --[[ Line: 352 ]] --[[ Name: declineInvite ]]
        -- upvalues: v4 (copy), l_v131_0 (ref)
        v4:Send("Invite Declined", v133);
        for v134 = #l_v131_0, 1, -1 do
            if l_v131_0[v134].Player == v133 then
                table.remove(l_v131_0, v134);
                return;
            end;
        end;
    end;
    local function _() --[[ Line: 364 ]] --[[ Name: getDisplayedPlayer ]]
        -- upvalues: l_v131_0 (ref)
        local v136 = l_v131_0[1];
        if v136 then
            return v136.Player;
        else
            return nil;
        end;
    end;
    v23.Box.Yes.MouseButton1Click:Connect(function() --[[ Line: 376 ]]
        -- upvalues: l_v131_0 (ref), v4 (copy), v3 (copy), v130 (ref)
        local v138 = l_v131_0[1];
        local v139 = if v138 then v138.Player else nil;
        if v139 then
            v4:Send("Invite Accepted", v139);
            v3:PlaySound("Interface.Click");
            v130();
        end;
    end);
    local l_v135_0 = v135 --[[ copy: 50 -> 75 ]];
    v23.Box.No.MouseButton1Click:Connect(function() --[[ Line: 387 ]]
        -- upvalues: l_v131_0 (ref), v3 (copy), l_v135_0 (copy)
        local v141 = l_v131_0[1];
        local v142 = if v141 then v141.Player else nil;
        v3:PlaySound("Interface.Click");
        if v142 then
            l_v135_0(v142);
        end;
    end);
    l_UserInputService_0.InputBegan:Connect(function(v143, v144) --[[ Line: 398 ]]
        -- upvalues: v23 (copy), l_v131_0 (ref), v4 (copy), v3 (copy), v130 (ref), l_v135_0 (copy)
        if not v144 and v23.Visible then
            local v145 = l_v131_0[1];
            local v146 = if v145 then v145.Player else nil;
            if v143.KeyCode == Enum.KeyCode.Y then
                if v146 then
                    v4:Send("Invite Accepted", v146);
                end;
                v3:PlaySound("Interface.Click");
                v130();
                return;
            elseif v143.KeyCode == Enum.KeyCode.N then
                if v146 then
                    l_v135_0(v146);
                end;
                v3:PlaySound("Interface.Click");
            end;
        end;
    end);
    l_RunService_0.Heartbeat:Connect(function(v147) --[[ Line: 419 ]]
        -- upvalues: l_v131_0 (ref), l_v135_0 (copy), v23 (copy), v3 (copy)
        debug.profilebegin("Invite Queue step");
        local v148 = l_v131_0[1];
        while v148 do
            v148.TimeoutStack = v148.TimeoutStack - v147;
            if v148.TimeoutStack <= 0 then
                l_v135_0(v148.Player);
                v148 = l_v131_0[1];
            else
                break;
            end;
        end;
        if v148 then
            v23.Timeout.Text = string.format("expires in: %d", v148.TimeoutStack);
            v23.Counter.Text = string.format("[ 1 / %d ]", #l_v131_0);
            if v23.Box.TextBin.User.Text ~= v148.Player.Name then
                v23.Box.TextBin.User.TextTransparency = 1;
                v3:PlaySound("Interface.Bweep");
            end;
            v23.Box.TextBin.User.Text = v148.Player.Name;
            local l_User_0 = v23.Box.TextBin.User;
            local l_TextTransparency_0 = v23.Box.TextBin.User.TextTransparency;
            l_User_0.TextTransparency = l_TextTransparency_0 + (0 - l_TextTransparency_0) * 0.1;
            v23.Box.TextBin.User.Size = UDim2.new(0, v23.Box.TextBin.User.TextBounds.X, 1, 0);
            v23.Visible = true;
        else
            v23.Box.TextBin.User.Text = "";
            v23.Visible = false;
        end;
        debug.profileend();
    end);
    v124 = function(v151) --[[ Line: 459 ]] --[[ Name: queueSquadInvite ]]
        -- upvalues: v36 (ref), l_v131_0 (ref)
        if v36 then
            return;
        else
            local v152 = false;
            for _, v154 in next, l_v131_0 do
                if v154.Player == v151 then
                    v152 = true;
                    break;
                end;
            end;
            if not v152 then
                table.insert(l_v131_0, {
                    Player = v151, 
                    TimeoutStack = 60
                });
            end;
            return;
        end;
    end;
    v130 = function() --[[ Line: 481 ]] --[[ Name: clearPendingInvites ]]
        -- upvalues: l_v131_0 (ref), v23 (copy)
        l_v131_0 = {};
        v23.Visible = false;
    end;
end;
v131 = function() --[[ Line: 487 ]] --[[ Name: scalePlayerListGui ]]
    -- upvalues: l_PlayerList_0 (copy), v30 (copy), v16 (copy), l_v3_Storage_0 (copy), l_SquadList_0 (copy)
    local l_Y_4 = l_PlayerList_0.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y;
    if v30[l_PlayerList_0] == "Max" then
        local l_l_PlayerList_0_0 = l_PlayerList_0;
        local v157 = if l_l_PlayerList_0_0 == l_PlayerList_0 then v16.Gui.AbsoluteSize.Y - l_l_PlayerList_0_0.AbsolutePosition.Y - 411 else 1080;
        l_l_PlayerList_0_0 = math.min(l_Y_4 + 2, v157);
        l_PlayerList_0.Size = UDim2.fromOffset(350, l_l_PlayerList_0_0 + 1);
    elseif v30[l_PlayerList_0] == "Min" then
        local l_l_PlayerList_0_1 = l_PlayerList_0;
        local v159;
        if l_l_PlayerList_0_1 == l_PlayerList_0 then
            local l_Y_5 = l_l_PlayerList_0_1.ScrollingFrame.Top.AbsoluteSize.Y;
            local l_Y_6 = l_v3_Storage_0.PlayerTemplate.AbsoluteSize.Y;
            local l_Offset_2 = l_l_PlayerList_0_1.ScrollingFrame.UIListLayout.Padding.Offset;
            v159 = l_Y_5 + l_Y_6 + l_Offset_2;
        else
            v159 = l_l_PlayerList_0_1 == l_SquadList_0 and 62 or 0;
        end;
        l_PlayerList_0.Size = UDim2.fromOffset(350, v159 + 3);
    else
        local l_l_PlayerList_0_2 = l_PlayerList_0;
        local v164 = if l_l_PlayerList_0_2 == l_PlayerList_0 then v16.Gui.AbsoluteSize.Y - l_l_PlayerList_0_2.AbsolutePosition.Y - 411 else 1080;
        l_l_PlayerList_0_2 = math.min(l_Y_4 + 2, v164);
        local v165 = math.min(l_PlayerList_0.Size.Y.Offset, l_l_PlayerList_0_2);
        l_PlayerList_0.Size = UDim2.fromOffset(350, v165);
    end;
    l_PlayerList_0.ScrollingFrame.CanvasSize = UDim2.fromOffset(0, l_Y_4 + 3);
end;
local function v175() --[[ Line: 514 ]] --[[ Name: scaleSquadListGui ]]
    -- upvalues: l_SquadList_0 (copy), v30 (copy), l_PlayerList_0 (copy), v16 (copy), l_v3_Storage_0 (copy)
    local v166 = l_SquadList_0.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y + 12;
    if v30[l_SquadList_0] == "Max" then
        local l_l_SquadList_0_0 = l_SquadList_0;
        l_l_SquadList_0_0 = math.min(v166, if l_l_SquadList_0_0 == l_PlayerList_0 then v16.Gui.AbsoluteSize.Y - l_l_SquadList_0_0.AbsolutePosition.Y - 411 else 1080);
        l_SquadList_0.Size = UDim2.fromOffset(350, l_l_SquadList_0_0);
    elseif v30[l_SquadList_0] == "Min" then
        local l_l_SquadList_0_1 = l_SquadList_0;
        local v169;
        if l_l_SquadList_0_1 == l_PlayerList_0 then
            local l_Y_7 = l_l_SquadList_0_1.ScrollingFrame.Top.AbsoluteSize.Y;
            local l_Y_8 = l_v3_Storage_0.PlayerTemplate.AbsoluteSize.Y;
            local l_Offset_3 = l_l_SquadList_0_1.ScrollingFrame.UIListLayout.Padding.Offset;
            v169 = l_Y_7 + l_Y_8 + l_Offset_3;
        else
            v169 = l_l_SquadList_0_1 == l_SquadList_0 and 62 or 0;
        end;
        l_SquadList_0.Size = UDim2.fromOffset(350, v169);
    else
        local l_l_SquadList_0_2 = l_SquadList_0;
        l_l_SquadList_0_2 = math.min(v166, if l_l_SquadList_0_2 == l_PlayerList_0 then v16.Gui.AbsoluteSize.Y - l_l_SquadList_0_2.AbsolutePosition.Y - 411 else 1080);
        local v174 = math.min(l_SquadList_0.Size.Y.Offset, l_l_SquadList_0_2);
        l_SquadList_0.Size = UDim2.fromOffset(350, v174);
    end;
    l_SquadList_0.ScrollingFrame.CanvasSize = UDim2.fromOffset(0, v166);
end;
local function v178() --[[ Line: 541 ]] --[[ Name: clearPlayerActions ]]
    -- upvalues: l_PlayerActions_0 (copy), v31 (copy)
    for _, v177 in next, l_PlayerActions_0.ActionsBin:GetChildren() do
        if v177:IsA("GuiBase") then
            if v31[v177] then
                v31[v177]:Destroy();
                v31[v177] = nil;
            end;
            v177:Destroy();
        end;
    end;
    l_PlayerActions_0.Visible = false;
end;
local function v182(v179) --[[ Line: 556 ]] --[[ Name: stylePlayerCardNoSquad ]]
    v179.NameButton.NoSquadBottomBorder.Visible = true;
    v179.NameButton.NoSquadInnerBox.Visible = true;
    v179.NameButton.YesSquadInnerBox.Visible = false;
    v179.NameButton.YesSquadOuterBox.Visible = false;
    v179.NameButton.Statuses.Leader.Visible = false;
    v179.NameButton.Statuses.Kick.Visible = false;
    for _, v181 in next, v179.NameButton.Statuses:GetChildren() do
        if v181:IsA("GuiBase") then
            v181.YesSquadBorder.Visible = false;
        end;
    end;
end;
local function v188(v183, v184, v185) --[[ Line: 573 ]] --[[ Name: stylePlayerCardHasSquad ]]
    v183.NameButton.NoSquadBottomBorder.Visible = false;
    v183.NameButton.NoSquadInnerBox.Visible = false;
    v183.NameButton.YesSquadInnerBox.Visible = true;
    v183.NameButton.YesSquadOuterBox.Visible = true;
    v183.NameButton.Statuses.Leader.Visible = v184;
    v183.NameButton.Statuses.Kick.Visible = v185;
    for _, v187 in next, v183.NameButton.Statuses:GetChildren() do
        if v187:IsA("GuiBase") then
            v187.YesSquadBorder.Visible = true;
        end;
    end;
end;
local _ = function() --[[ Line: 590 ]] --[[ Name: clearSquadHighlightsInPlayerList ]]
    -- upvalues: v27 (copy), v182 (copy)
    for _, v190 in next, v27 do
        if v190.Gui then
            v182(v190.Gui);
        end;
    end;
end;
local function v197(v192) --[[ Line: 598 ]] --[[ Name: highlightSquadInPlayerList ]]
    -- upvalues: v27 (copy), v188 (copy), v182 (copy)
    for v193, v194 in next, v27 do
        if v194.Gui then
            if v192.Members[v193] then
                local v195 = v192.Members[v193].Status == "Kicked";
                local v196 = v192.Owner == v193;
                v188(v194.Gui, v196, v195);
            else
                v182(v194.Gui);
            end;
        end;
    end;
end;
local function v230(v198, v199) --[[ Line: 613 ]] --[[ Name: displayPlayerActions ]]
    -- upvalues: l_Players_0 (copy), v36 (ref), v130 (ref), v1 (copy), v32 (ref), v123 (ref), v4 (copy), v3 (copy), v37 (ref), v0 (copy), l_PlayerActions_0 (copy), v178 (copy), l_v3_Storage_0 (copy), v10 (copy), l_TextService_0 (copy), v35 (copy), v31 (copy), v2 (copy)
    local v200 = {};
    local function _(v201, v202) --[[ Line: 616 ]] --[[ Name: add ]]
        -- upvalues: v200 (copy)
        table.insert(v200, {
            Name = v201 or "???", 
            Action = v202 or function() --[[ Line: 619 ]]

            end
        });
    end;
    if v199 == l_Players_0.LocalPlayer then
        local v204 = v36 and "Enable Invites" or "Disable Invites";
        local function v205() --[[ Line: 625 ]]
            -- upvalues: v36 (ref), v130 (ref), v198 (copy)
            v36 = not v36;
            if v36 then
                v130();
            end;
            v198.NameButton.Statuses.DoNotDisturb.Visible = not not v36;
        end;
        table.insert(v200, {
            Name = v204 or "???", 
            Action = v205 or function() --[[ Line: 619 ]]

            end
        });
    elseif not v1(v199) then

    end;
    if v32 and v32.Members[v199] then
        local v206 = l_Players_0.LocalPlayer == v32.Owner;
        local v207 = l_Players_0.LocalPlayer == v199;
        local v208 = v32.Members[v199].Status == "Member";
        if v206 and not v207 and v208 then
            local function v209() --[[ Line: 647 ]]
                -- upvalues: v123 (ref), v199 (copy)
                v123(v199);
            end;
            table.insert(v200, {
                Name = "Kick From Squad", 
                Action = v209 or function() --[[ Line: 619 ]]

                end
            });
            v209 = function() --[[ Line: 651 ]]
                -- upvalues: v4 (ref), v199 (copy)
                v4:Send("Promote Owner", v199);
            end;
            table.insert(v200, {
                Name = "Promote to Leader", 
                Action = v209 or function() --[[ Line: 619 ]]

                end
            });
        end;
        if v207 and v208 then
            local function v210() --[[ Line: 658 ]]
                -- upvalues: v4 (ref)
                v4:Send("Leave Squad");
            end;
            table.insert(v200, {
                Name = "Leave Squad", 
                Action = v210 or function() --[[ Line: 619 ]]

                end
            });
        end;
    end;
    local v211 = v32 == nil;
    if v32 and v32.Owner == l_Players_0.LocalPlayer then
        v211 = not v32.Members[v199];
    end;
    if v211 and l_Players_0.LocalPlayer == v199 then
        v211 = false;
    end;
    if v211 then
        local function v212() --[[ Line: 676 ]]
            -- upvalues: v4 (ref), v199 (copy)
            v4:Send("Invite To Squad", v199);
        end;
        table.insert(v200, {
            Name = "Invite to Squad", 
            Action = v212 or function() --[[ Line: 619 ]]

            end
        });
    end;
    if v199 ~= l_Players_0.LocalPlayer then
        local v213 = v3:Get("Chat");
        local v214 = v213:IsPlayerMuted(v199);
        local l_v213_0 = v213 --[[ copy: 5 -> 16 ]];
        local l_v214_0 = v214 --[[ copy: 6 -> 17 ]];
        table.insert(v200, {
            Name = v214 and "Unmute Chat" or "Mute Chat" or "???", 
            Action = function() --[[ Line: 686 ]]
                -- upvalues: l_v213_0 (copy), v199 (copy), l_v214_0 (copy), v198 (copy)
                l_v213_0:SetPlayerMuted(v199, not l_v214_0);
                v198.NameButton.Statuses.Mute.Visible = not l_v214_0;
            end or function() --[[ Line: 619 ]]

            end
        });
    elseif v37 then
        local function v217() --[[ Line: 694 ]]
            -- upvalues: v4 (ref)
            v4:Send("Toggle Badge");
        end;
        table.insert(v200, {
            Name = "Toggle Badge", 
            Action = v217 or function() --[[ Line: 619 ]]

            end
        });
    end;
    if v37 then
        local l_Current_0 = v0.Libraries.Cameras:GetCurrent();
        local v219 = l_Current_0 and l_Current_0.Name == "Spectate";
        if v199 == l_Players_0.LocalPlayer and v219 then
            local function v220() --[[ Line: 707 ]]
                -- upvalues: v4 (ref)
                v4:Send("Spectate Off");
            end;
            table.insert(v200, {
                Name = "Spectate Off", 
                Action = v220 or function() --[[ Line: 619 ]]

                end
            });
        elseif v199 ~= l_Players_0.LocalPlayer then
            local function v221() --[[ Line: 712 ]]
                -- upvalues: v4 (ref), v199 (copy)
                v4:Send("Spectate Target", v199.Name);
            end;
            table.insert(v200, {
                Name = "Spectate", 
                Action = v221 or function() --[[ Line: 619 ]]

                end
            });
        end;
    end;
    if l_PlayerActions_0.Visible then
        v178();
    end;
    if #v200 > 0 then
        local v222 = 0;
        for v223, v224 in next, v200 do
            local v225 = l_v3_Storage_0.ActionTemplate:Clone();
            v225.ImageButton.NameLabel.Text = v224.Name;
            v225.ImageButton.NameLabel.Backdrop.Text = v224.Name;
            v225.LayoutOrder = v223;
            if v223 == #v200 then
                v225.Border.Visible = false;
            end;
            v225.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 737 ]]
                -- upvalues: v3 (ref), v178 (ref), v224 (copy)
                v3:PlaySound("Interface.Click");
                v178();
                v224.Action();
            end);
            v225.ImageButton.MouseEnter:Connect(function() --[[ Line: 743 ]]
                -- upvalues: v225 (copy)
                v225.HighlightBox.Visible = true;
            end);
            v225.ImageButton.MouseLeave:Connect(function() --[[ Line: 747 ]]
                -- upvalues: v225 (copy)
                v225.HighlightBox.Visible = false;
            end);
            local v226 = v10.new();
            v226:Give(function() --[[ Line: 753 ]]
                -- upvalues: v0 (ref), v225 (copy)
                v0.destroy(v225.ImageButton, "MouseButton1Click", "MouseEnter", "MouseLeave");
            end);
            local l_NameLabel_1 = v225.ImageButton.NameLabel;
            v222 = math.max(v222, l_TextService_0:GetTextSize(l_NameLabel_1.Text, l_NameLabel_1.TextSize, l_NameLabel_1.Font, v35).X);
            v225.Parent = l_PlayerActions_0.ActionsBin;
            v31[v225] = v226;
        end;
        local l_Y_9 = l_PlayerActions_0.ActionsBin.UIListLayout.AbsoluteContentSize.Y;
        local v229 = v198.AbsolutePosition + Vector2.new(-9, v2.GuiInset.Y + 1) + Vector2.new(0, -l_Y_9 * 0.5) + Vector2.new(0, v198.AbsoluteSize.Y * 0.5);
        l_PlayerActions_0.Size = UDim2.fromOffset(v222 + 18, l_Y_9);
        l_PlayerActions_0.Position = UDim2.fromOffset(v229.X, v229.Y);
        l_PlayerActions_0.Visible = true;
    end;
end;
local function _(v231) --[[ Line: 779 ]] --[[ Name: removePlayerCard ]]
    -- upvalues: v27 (copy), v131 (copy), v56 (copy)
    local v232 = v27[v231];
    if v232 then
        if v232.Maid then
            v232.Maid:Destroy();
            v232.Maid = nil;
        end;
        if v232.Gui then
            v232.Gui:Destroy();
            v232.Gui = nil;
        end;
    end;
    v27[v231] = nil;
    v131();
    v56();
end;
local function v251(v234) --[[ Line: 799 ]] --[[ Name: addNewPlayerCard ]]
    -- upvalues: v27 (copy), v131 (copy), v56 (copy), l_Players_0 (copy), l_v3_Storage_0 (copy), v10 (copy), v1 (copy), v2 (copy), l_TextService_0 (copy), v35 (copy), v0 (copy), v230 (copy), v182 (copy), l_PlayerList_0 (copy)
    if v27[v234] then
        local v235 = v27[v234];
        if v235 then
            if v235.Maid then
                v235.Maid:Destroy();
                v235.Maid = nil;
            end;
            if v235.Gui then
                v235.Gui:Destroy();
                v235.Gui = nil;
            end;
        end;
        v27[v234] = nil;
        v131();
        v56();
    end;
    local v236 = v234 == l_Players_0.LocalPlayer;
    local v237 = table.find(l_Players_0:GetPlayers(), v234) or 1000;
    if v236 then
        v237 = 0;
    end;
    local v238 = l_v3_Storage_0.PlayerTemplate:Clone();
    v238.NameButton.NameLabelBin.NameLabel.Text = v234.Name;
    v238.NameButton.NameLabelBin.NameLabel.Backdrop.Text = v234.Name;
    v238.LayoutOrder = v237;
    local v239 = v10.new();
    local v240 = v1(v234);
    local v241 = v2.StaffIcons[v240 or ""];
    if v241 and v240 then
        local l_Icon_0 = v238.NameButton.NameLabelBin.Icon;
        local l_Tooltip_0 = l_Icon_0.Tooltip;
        l_Icon_0.Image = v241;
        l_Icon_0.Backdrop.Image = v241;
        l_Icon_0.Visible = true;
        l_Tooltip_0.TextLabel.Text = v240;
        local l_new_1 = UDim2.new;
        local v245 = 1;
        local l_TextLabel_0 = l_Tooltip_0.TextLabel;
        l_Tooltip_0.Size = l_new_1(v245, l_TextService_0:GetTextSize(l_TextLabel_0.Text, l_TextLabel_0.TextSize, l_TextLabel_0.Font, v35).X - 15, 0, 25);
        l_Icon_0.MouseEnter:Connect(function() --[[ Line: 832 ]]
            -- upvalues: l_Tooltip_0 (copy)
            l_Tooltip_0.Visible = true;
        end);
        l_Icon_0.MouseLeave:Connect(function() --[[ Line: 836 ]]
            -- upvalues: l_Tooltip_0 (copy)
            l_Tooltip_0.Visible = false;
        end);
        v239:Give(function() --[[ Line: 840 ]]
            -- upvalues: v0 (ref), l_Icon_0 (copy)
            v0.destroy(l_Icon_0, "MouseEnter", "MouseLeave");
        end);
        local function v248(v247) --[[ Line: 844 ]]
            -- upvalues: l_Icon_0 (copy)
            l_Icon_0.Visible = v247;
        end;
        local l_v234_AttributeChangedSignal_0 = v234:GetAttributeChangedSignal("Badges");
        local v250 = "Badges";
        l_v234_AttributeChangedSignal_0 = l_v234_AttributeChangedSignal_0:Connect(function() --[[ Line: 84 ]]
            -- upvalues: v248 (copy), v234 (copy), v250 (copy)
            v248(v234:GetAttribute(v250));
        end);
        v248(v234:GetAttribute("Badges"));
        v239:Give(l_v234_AttributeChangedSignal_0);
    end;
    v238.NameButton.MouseButton1Click:Connect(function() --[[ Line: 850 ]]
        -- upvalues: v230 (ref), v238 (copy), v234 (copy)
        v230(v238, v234);
    end);
    v238.MouseEnter:Connect(function() --[[ Line: 854 ]]
        -- upvalues: v238 (copy)
        v238.HighlightBox.Visible = true;
    end);
    v238.MouseLeave:Connect(function() --[[ Line: 858 ]]
        -- upvalues: v238 (copy)
        v238.HighlightBox.Visible = false;
    end);
    v239:Give(function() --[[ Line: 862 ]]
        -- upvalues: v0 (ref), v238 (copy)
        v0.destroy(v238.NameButton, "MouseButton1Click");
        v0.destroy(v238, "MouseEnter", "MouseLeave");
    end);
    v27[v234] = {
        Gui = v238, 
        Maid = v239
    };
    v182(v238);
    v238.Parent = l_PlayerList_0.ScrollingFrame;
    v131();
    v56();
end;
local function v258(v252, v253) --[[ Line: 880 ]] --[[ Name: setSquadMannequinFace ]]
    -- upvalues: v8 (copy)
    local l_Head_0 = v252:FindFirstChild("Head");
    local v255 = l_Head_0 and l_Head_0:FindFirstChild("Face");
    local l_Head_1 = v253:FindFirstChild("Head");
    local v257 = l_Head_1 and l_Head_1:FindFirstChild("Face");
    if v255 and v257 then
        v8:SetFace(v253, v255.Texture);
    end;
end;
local function v265(v259, v260) --[[ Line: 892 ]] --[[ Name: setSquadMannequinClothing ]]
    -- upvalues: v8 (copy)
    local l_Shirt_0 = v259:FindFirstChild("Shirt");
    local l_Pants_0 = v259:FindFirstChild("Pants");
    if l_Shirt_0 and l_Pants_0 then
        local v263 = l_Shirt_0:GetAttribute("ItemName") or "Default";
        local v264 = l_Shirt_0:GetAttribute("ItemName") or "Default";
        v8:DressShirt(v260, v263);
        v8:DressShirt(v260, v264);
    end;
end;
local function v272(v266, v267) --[[ Line: 905 ]] --[[ Name: setSquadMannequinHair ]]
    -- upvalues: v8 (copy)
    local l_Hair_0 = v266:FindFirstChild("Hair");
    local v269 = "Bald";
    local v270 = "Chrome";
    if l_Hair_0 then
        local l_Hair_1 = l_Hair_0:FindFirstChild("Hair");
        if l_Hair_1 then
            v269 = l_Hair_1:GetAttribute("Style");
            v270 = l_Hair_1:GetAttribute("Color");
        end;
    end;
    v8:SetHair(v267, v269, v270);
end;
local function v285(v273, v274) --[[ Line: 921 ]] --[[ Name: setSquadMannequinEquipment ]]
    -- upvalues: v8 (copy)
    local l_Equipment_0 = v273:FindFirstChild("Equipment");
    local l_Equipment_1 = v274:FindFirstChild("Equipment");
    if l_Equipment_0 and l_Equipment_1 then
        for _, v278 in next, l_Equipment_1:GetChildren() do
            local v279 = l_Equipment_0:FindFirstChild(v278.Name) == nil;
            local v280 = not v278:GetAttribute("Is3DClothing");
            if v279 and v280 then
                v8:UndressItem(v274, v278.Name);
            end;
        end;
        for _, v282 in next, l_Equipment_0:GetChildren() do
            local v283 = l_Equipment_1:FindFirstChild(v282.Name) == nil;
            local v284 = not v282:GetAttribute("Is3DClothing");
            if v283 and v284 then
                v8:DressAccessory(v274, v282.Name);
            end;
        end;
    end;
end;
local function _(v286) --[[ Line: 948 ]] --[[ Name: cleanSquadCharacter ]]
    v286:CleanIndex("FaceChange");
    v286:CleanIndex("ShirtChange");
    v286:CleanIndex("PantsChange");
    v286:CleanIndex("EquipmentAdded");
    v286:CleanIndex("EquipmentRemoved");
end;
local function v300(_, v289, v290, v291) --[[ Line: 956 ]] --[[ Name: hookSquadCharacter ]]
    -- upvalues: v258 (copy), v265 (copy), v285 (copy), v8 (copy), v272 (copy), l_v3_Storage_0 (copy)
    v291:CleanIndex("FaceChange");
    v291:CleanIndex("ShirtChange");
    v291:CleanIndex("PantsChange");
    v291:CleanIndex("EquipmentAdded");
    v291:CleanIndex("EquipmentRemoved");
    local l_CurrentCamera_1 = v290.NameButton.OuterBox.ViewportFrame.CurrentCamera;
    local l_Mannequin_0 = v290.NameButton.OuterBox.ViewportFrame.WorldModel.Mannequin;
    v291.FaceChange = v289.Head.Face.Changed:Connect(function() --[[ Line: 963 ]]
        -- upvalues: v258 (ref), v289 (copy), l_Mannequin_0 (copy)
        v258(v289, l_Mannequin_0);
    end);
    v291.ShirtChange = v289.Shirt.Changed:Connect(function() --[[ Line: 967 ]]
        -- upvalues: v265 (ref), v289 (copy), l_Mannequin_0 (copy)
        v265(v289, l_Mannequin_0);
    end);
    v291.PantsChange = v289.Pants.Changed:Connect(function() --[[ Line: 971 ]]
        -- upvalues: v265 (ref), v289 (copy), l_Mannequin_0 (copy)
        v265(v289, l_Mannequin_0);
    end);
    v291.EquipmentAdded = v289.Equipment.ChildAdded:Connect(function() --[[ Line: 975 ]]
        -- upvalues: v285 (ref), v289 (copy), l_Mannequin_0 (copy)
        v285(v289, l_Mannequin_0);
    end);
    v291.EquipmentRemoved = v289.Equipment.ChildRemoved:Connect(function() --[[ Line: 979 ]]
        -- upvalues: v285 (ref), v289 (copy), l_Mannequin_0 (copy)
        v285(v289, l_Mannequin_0);
    end);
    local l_Hair_2 = v289.Hair;
    local function v296(v295) --[[ Line: 983 ]]
        -- upvalues: v8 (ref), l_Mannequin_0 (copy)
        v8:SetHairVisible(l_Mannequin_0, v295);
    end;
    local l_l_Hair_2_AttributeChangedSignal_0 = l_Hair_2:GetAttributeChangedSignal("VisibleUnderHats");
    local v298 = "VisibleUnderHats";
    l_l_Hair_2_AttributeChangedSignal_0 = l_l_Hair_2_AttributeChangedSignal_0:Connect(function() --[[ Line: 84 ]]
        -- upvalues: v296 (copy), l_Hair_2 (copy), v298 (copy)
        v296(l_Hair_2:GetAttribute(v298));
    end);
    v296(l_Hair_2:GetAttribute("VisibleUnderHats"));
    v291.HairVisibility = l_l_Hair_2_AttributeChangedSignal_0;
    v272(v289, l_Mannequin_0);
    v258(v289, l_Mannequin_0);
    v265(v289, l_Mannequin_0);
    v285(v289, l_Mannequin_0);
    local l_Head_2 = v289:FindFirstChild("Head");
    if l_Head_2 then
        v8:SetSkinColor(l_Mannequin_0, l_Head_2.Color);
    end;
    l_CurrentCamera_1.CFrame = l_Mannequin_0.Head.CFrame * l_v3_Storage_0.HeadOffset.Value;
end;
local function v304(v301, v302, v303) --[[ Line: 1003 ]] --[[ Name: setSquadGuiAliveStatus ]]
    if v302 > 0 then
        v301.NameButton.OuterBox.ViewportFrame.Visible = true;
        v301.NameButton.OuterBox.Dead.Visible = false;
        v301.NameButton.OuterBox.WhiteGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        v301.NameButton.OuterBox.WhiteGradient.ImageColor3 = Color3.fromRGB(255, 255, 255);
    else
        v301.NameButton.OuterBox.ViewportFrame.Visible = false;
        v301.NameButton.OuterBox.Dead.Visible = true;
        v301.NameButton.OuterBox.WhiteGradient.BackgroundColor3 = Color3.fromRGB(219, 75, 75);
        v301.NameButton.OuterBox.WhiteGradient.ImageColor3 = Color3.fromRGB(255, 0, 7);
    end;
    v301.NameButton.OuterBox.HealthBar.Padding.Bar.Size = UDim2.new(v302 / 100, 0, 1, 0);
    v301.NameButton.OuterBox.HealthBar.Padding.Bonus.Size = UDim2.new(v303 / 100, 0, 1, 0);
end;
local function v318(v305, v306, v307) --[[ Line: 1022 ]] --[[ Name: setSquadGuiEquipStatus ]]
    -- upvalues: v0 (copy), l_TextService_0 (copy), v35 (copy)
    local v308 = v0.Configs.ItemData[v306];
    local v309 = v0.Configs.ItemData[v307];
    if v308 then
        v305.NameButton.GunLabelBin.Primary.NameLabel.Text = v308.IconLabelText or v308.DisplayName or v306;
        local l_Primary_0 = v305.NameButton.GunLabelBin.Primary;
        local l_new_2 = UDim2.new;
        local v312 = 0;
        local l_NameLabel_2 = v305.NameButton.GunLabelBin.Primary.NameLabel;
        l_Primary_0.Size = l_new_2(v312, l_TextService_0:GetTextSize(l_NameLabel_2.Text, l_NameLabel_2.TextSize, l_NameLabel_2.Font, v35).X + 8, 1, 0);
        v305.NameButton.GunLabelBin.Primary.Visible = true;
    else
        v305.NameButton.GunLabelBin.Primary.Visible = false;
    end;
    if v309 then
        v305.NameButton.GunLabelBin.Secondary.NameLabel.Text = v309.IconLabelText or v309.DisplayName or v307;
        local l_Secondary_0 = v305.NameButton.GunLabelBin.Secondary;
        local l_new_3 = UDim2.new;
        local v316 = 0;
        local l_NameLabel_3 = v305.NameButton.GunLabelBin.Secondary.NameLabel;
        l_Secondary_0.Size = l_new_3(v316, l_TextService_0:GetTextSize(l_NameLabel_3.Text, l_NameLabel_3.TextSize, l_NameLabel_3.Font, v35).X + 8, 1, 0);
        v305.NameButton.GunLabelBin.Secondary.Visible = true;
        return;
    else
        v305.NameButton.GunLabelBin.Secondary.Visible = false;
        return;
    end;
end;
local function _(v319) --[[ Line: 1043 ]] --[[ Name: removeSqauadPlayerCard ]]
    -- upvalues: v28 (copy), v175 (copy)
    local v320 = v28[v319];
    if v320 then
        if v320.Maid then
            v320.Maid:Destroy();
            v320.Maid = nil;
        end;
        if v320.Gui then
            v320.Gui:Destroy();
            v320.Gui = nil;
        end;
    end;
    v175();
    v28[v319] = nil;
end;
local function v335(v322) --[[ Line: 1062 ]] --[[ Name: addSquadPlayerCard ]]
    -- upvalues: l_Players_0 (copy), v28 (copy), v175 (copy), v10 (copy), l_v3_Storage_0 (copy), v6 (copy), v300 (copy), v304 (copy), v318 (copy), l_SquadList_0 (copy)
    if v322 == l_Players_0.LocalPlayer then
        return;
    else
        if v28[v322] then
            local v323 = v28[v322];
            if v323 then
                if v323.Maid then
                    v323.Maid:Destroy();
                    v323.Maid = nil;
                end;
                if v323.Gui then
                    v323.Gui:Destroy();
                    v323.Gui = nil;
                end;
            end;
            v175();
            v28[v322] = nil;
        end;
        local v324 = table.find(l_Players_0:GetPlayers(), v322) or 1000;
        local v325 = v10.new();
        local _ = v322:WaitForChild("Stats");
        local l_Health_0 = v322.Stats:WaitForChild("Health");
        local l_HealthBonus_0 = v322.Stats:WaitForChild("HealthBonus");
        local l_Primary_1 = v322.Stats:WaitForChild("Primary");
        local l_Secondary_1 = v322.Stats:WaitForChild("Secondary");
        local v331 = l_v3_Storage_0.SquadTemplate:Clone();
        v331.NameButton.NameLabelBin.NameLabel.Text = v322.Name;
        v331.NameButton.NameLabelBin.NameLabel.Backdrop.Text = v322.Name;
        v331.LayoutOrder = v324;
        v331.Name = "Frame";
        local l_ViewportFrame_0 = v331.NameButton.OuterBox.ViewportFrame;
        l_ViewportFrame_0.CurrentCamera = Instance.new("Camera", l_ViewportFrame_0);
        l_ViewportFrame_0.CurrentCamera.CameraType = Enum.CameraType.Custom;
        l_ViewportFrame_0.CurrentCamera.FieldOfView = 10;
        local v333 = v6:Get("ReplicatedStorage.Assets.Mannequin");
        v333:SetPrimaryPartCFrame(CFrame.new());
        v333.Parent = l_ViewportFrame_0.WorldModel;
        v325.CharacterAdded = v322.CharacterAdded:Connect(function(v334) --[[ Line: 1097 ]]
            -- upvalues: v300 (ref), v322 (copy), v331 (copy), v325 (copy)
            v300(v322, v334, v331, v325);
        end);
        v325.HealthHook = l_Health_0.Changed:Connect(function() --[[ Line: 1101 ]]
            -- upvalues: v304 (ref), v331 (copy), l_Health_0 (copy), l_HealthBonus_0 (copy)
            v304(v331, l_Health_0.Value, l_HealthBonus_0.Value);
        end);
        v325.HealthBonusHook = l_HealthBonus_0.Changed:Connect(function() --[[ Line: 1105 ]]
            -- upvalues: v304 (ref), v331 (copy), l_Health_0 (copy), l_HealthBonus_0 (copy)
            v304(v331, l_Health_0.Value, l_HealthBonus_0.Value);
        end);
        v325.PrimaryChanged = l_Primary_1.Changed:Connect(function() --[[ Line: 1109 ]]
            -- upvalues: v318 (ref), v331 (copy), l_Primary_1 (copy), l_Secondary_1 (copy)
            v318(v331, l_Primary_1.Value, l_Secondary_1.Value);
        end);
        v325.SecondaryChanged = l_Secondary_1.Changed:Connect(function() --[[ Line: 1113 ]]
            -- upvalues: v318 (ref), v331 (copy), l_Primary_1 (copy), l_Secondary_1 (copy)
            v318(v331, l_Primary_1.Value, l_Secondary_1.Value);
        end);
        v28[v322] = {
            Gui = v331, 
            Maid = v325
        };
        if v322.Character then
            v300(v322, v322.Character, v331, v325);
        end;
        v304(v331, l_Health_0.Value, l_HealthBonus_0.Value);
        v318(v331, l_Primary_1.Value, l_Secondary_1.Value);
        v331.Parent = l_SquadList_0.ScrollingFrame;
        v175();
        return;
    end;
end;
local function v341(v336) --[[ Line: 1136 ]] --[[ Name: setSquadListLeaderIcon ]]
    -- upvalues: v28 (copy)
    for v337, v338 in next, v28 do
        local v339 = v336.Members[v337];
        local v340 = nil;
        if v339 and v339.Status == "Kicked" then
            v340 = "rbxassetid://5665189806";
        elseif v337 == v336.Owner then
            v340 = "rbxassetid://6115555621";
        end;
        v338.Gui.NameButton.NameLabelBin.Leader.Icon.Image = v340 or "";
        v338.Gui.NameButton.NameLabelBin.Leader.Visible = v340 ~= nil;
        v338.Gui.NameButton.NameLabelBin.NoIcon.Visible = v340 == nil;
    end;
end;
v4:Add("Squad Update", function(v342) --[[ Line: 1159 ]]
    -- upvalues: l_Players_0 (copy), v32 (ref), v335 (copy), v28 (copy), v175 (copy), v197 (copy), l_Switcher_0 (copy), l_PlayerList_0 (copy), l_SquadList_0 (copy), v27 (copy), v182 (copy), v33 (ref), v34 (ref), v341 (copy), l_NoSquad_0 (copy)
    if v342 then
        local v343 = {};
        for v344, v345 in next, v342.Members do
            local l_l_Players_0_FirstChild_0 = l_Players_0:FindFirstChild(v344);
            if l_l_Players_0_FirstChild_0 then
                v343[l_l_Players_0_FirstChild_0] = v345;
            end;
        end;
        v342.Members = v343;
    end;
    if v32 and v342 then
        for v347, _ in next, v342.Members do
            if not v32.Members[v347] then
                v335(v347);
            end;
        end;
        for v349, _ in next, v32.Members do
            if not v342.Members[v349] then
                local v351 = v28[v349];
                if v351 then
                    if v351.Maid then
                        v351.Maid:Destroy();
                        v351.Maid = nil;
                    end;
                    if v351.Gui then
                        v351.Gui:Destroy();
                        v351.Gui = nil;
                    end;
                end;
                v175();
                v28[v349] = nil;
            end;
        end;
        v197(v342);
    elseif v32 == nil and v342 then
        for v352, _ in next, v342.Members do
            v335(v352);
        end;
        v197(v342);
        l_Switcher_0.TabListBin.Players.Selected.Visible = false;
        l_Switcher_0.TabListBin.Squads.Selected.Visible = true;
        l_PlayerList_0.Visible = false;
        l_SquadList_0.Visible = true;
    elseif v32 and v342 == nil then
        for v354, _ in next, v32.Members do
            local v356 = v28[v354];
            if v356 then
                if v356.Maid then
                    v356.Maid:Destroy();
                    v356.Maid = nil;
                end;
                if v356.Gui then
                    v356.Gui:Destroy();
                    v356.Gui = nil;
                end;
            end;
            v175();
            v28[v354] = nil;
        end;
        for _, v358 in next, v27 do
            if v358.Gui then
                v182(v358.Gui);
            end;
        end;
        v335(l_Players_0.LocalPlayer);
        l_Switcher_0.TabListBin.Players.Selected.Visible = true;
        l_Switcher_0.TabListBin.Squads.Selected.Visible = false;
        l_PlayerList_0.Visible = true;
        l_SquadList_0.Visible = false;
    end;
    if v342 then
        local v359 = v342.Members[l_Players_0.LocalPlayer];
        if v359.Status ~= "Member" then
            v33 = tick() + v359.TimerDelay;
            if v359.Status == "Kicked" then
                v34 = "Your group leader is kicking you from the group, in %d seconds you will be able to shoot and be shot by your former teammates.";
            else
                v34 = "You are leaving a group. In %d seconds you will be able to shoot and be shot by your former teammates.";
            end;
        end;
    end;
    if v342 then
        v341(v342);
    end;
    if v342 then
        l_NoSquad_0.Visible = false;
        l_SquadList_0.SizeDragger.Visible = true;
    else
        l_NoSquad_0.Visible = true;
        l_SquadList_0.SizeDragger.Visible = false;
    end;
    v175();
    v32 = v342;
end);
v4:Add("Prompt Invite To Squad", function(v360) --[[ Line: 1258 ]]
    -- upvalues: v124 (ref)
    v124(v360);
end);
l_RunService_0.Heartbeat:Connect(function(v361) --[[ Line: 1264 ]]
    -- upvalues: v33 (ref), l_KickedWarning_0 (copy), v34 (ref), v122 (copy)
    debug.profilebegin("Playerlist UI Step");
    local v362 = math.floor(tick() - v33 + 0.5);
    local v363 = math.clamp(v362, 0, 60);
    if v362 < 60 then
        l_KickedWarning_0.InnerBoxRight.TextLabel.Text = v34:format(60 - v363);
        l_KickedWarning_0.InnerBoxRight.TextLabel.Backdrop.Text = l_KickedWarning_0.InnerBoxRight.TextLabel.Text;
        l_KickedWarning_0.Visible = true;
    else
        l_KickedWarning_0.Visible = false;
    end;
    v122(v361);
    debug.profileend();
end);
l_UserInputService_0.InputBegan:Connect(function(v364, v365) --[[ Line: 1285 ]]
    -- upvalues: l_PlayerActions_0 (copy), v178 (copy), v7 (copy), l_PlayerList_0 (copy), l_Switcher_0 (copy), l_SquadList_0 (copy)
    if v364.UserInputType == Enum.UserInputType.MouseButton1 and not v365 and l_PlayerActions_0.Visible then
        v178();
    end;
    if v364.UserInputType == Enum.UserInputType.Keyboard then
        local l_v7_Bind_0 = v7:GetBind("Change Player List Tab");
        if l_v7_Bind_0 and l_v7_Bind_0.Key and l_v7_Bind_0.Key == v364.KeyCode then
            if l_PlayerList_0.Visible then
                l_Switcher_0.TabListBin.Squads.Selected.Visible = true;
                l_Switcher_0.TabListBin.Players.Selected.Visible = false;
                l_PlayerList_0.Visible = false;
                l_SquadList_0.Visible = true;
                return;
            else
                l_Switcher_0.TabListBin.Players.Selected.Visible = true;
                l_Switcher_0.TabListBin.Squads.Selected.Visible = false;
                l_PlayerList_0.Visible = true;
                l_SquadList_0.Visible = false;
            end;
        end;
    end;
end);
l_Switcher_0.TabListBin.Players.IconButton.MouseButton1Click:Connect(function() --[[ Line: 1313 ]]
    -- upvalues: l_Switcher_0 (copy), l_PlayerList_0 (copy), l_SquadList_0 (copy)
    l_Switcher_0.TabListBin.Players.Selected.Visible = true;
    l_Switcher_0.TabListBin.Squads.Selected.Visible = false;
    l_PlayerList_0.Visible = true;
    l_SquadList_0.Visible = false;
end);
l_Switcher_0.TabListBin.Squads.IconButton.MouseButton1Click:Connect(function() --[[ Line: 1321 ]]
    -- upvalues: l_Switcher_0 (copy), l_PlayerList_0 (copy), l_SquadList_0 (copy)
    l_Switcher_0.TabListBin.Squads.Selected.Visible = true;
    l_Switcher_0.TabListBin.Players.Selected.Visible = false;
    l_PlayerList_0.Visible = false;
    l_SquadList_0.Visible = true;
end);
l_PlayerList_0.ScrollingFrame.MouseEnter:Connect(function() --[[ Line: 1329 ]]
    -- upvalues: l_PlayerList_0 (copy)
    l_PlayerList_0.ScrollingFrame.ScrollingEnabled = true;
end);
l_PlayerList_0.ScrollingFrame.MouseLeave:Connect(function() --[[ Line: 1333 ]]
    -- upvalues: l_PlayerList_0 (copy)
    l_PlayerList_0.ScrollingFrame.ScrollingEnabled = false;
end);
l_PlayerList_0.ScrollingFrame.ScrollingEnabled = false;
v16.Gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 1339 ]]
    -- upvalues: v131 (copy), v175 (copy)
    v131();
    v175();
end);
l_PlayerList_0.ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 1344 ]]
    -- upvalues: v178 (copy)
    v178();
end);
l_Players_0.PlayerAdded:Connect(function(v367) --[[ Line: 1348 ]]
    -- upvalues: v251 (copy)
    v251(v367);
end);
l_Players_0.PlayerRemoving:Connect(function(v368) --[[ Line: 1352 ]]
    -- upvalues: v27 (copy), v131 (copy), v56 (copy)
    local v369 = v27[v368];
    if v369 then
        if v369.Maid then
            v369.Maid:Destroy();
            v369.Maid = nil;
        end;
        if v369.Gui then
            v369.Gui:Destroy();
            v369.Gui = nil;
        end;
    end;
    v27[v368] = nil;
    v131();
    v56();
end);
v89(l_SquadList_0, l_SquadList_0.SizeDragger, 12);
v89(l_PlayerList_0, l_PlayerList_0.SizeDragger, 3);
l_NoSquad_0.Visible = true;
l_SquadList_0.SizeDragger.Visible = false;
for _, v371 in next, l_Players_0:GetPlayers() do
    v251(v371);
end;
return v16;