local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Cameras");
local _ = v0.require("Libraries", "Network");
local v5 = v0.require("Libraries", "Resources");
local v6 = v0.require("Libraries", "Lighting");
local v7 = v0.require("Libraries", "UserStatistics");
local _ = v0.require("Classes", "Signals");
local v9 = v0.require("Classes", "Springs");
local v10 = v2:Get("Fade");
local l_v3_Camera_0 = v3:GetCamera("MainMenu");
local v12 = v9.new(0, 6, 1);
local v13 = v5:Find("Lighting.MainMenuBlur");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local v18 = {
    Gui = v2:GetGui("MainMenu")
};
local v19 = {};
local v20 = {};
local v21 = {};
local l_Value_0 = v5:Find("ReplicatedStorage.Lighting.Main Menu Config").Value;
local l_IconImages_0 = v2:Get("Controls"):GetIconImages();
local v24 = 1;
local v25 = {
    "Creator", 
    "Skins", 
    "Settings", 
    "Credits"
};
local v26 = {};
local v27 = {
    Creator = v18.Gui.NavigationFrame.Buttons.Creator, 
    Skins = v18.Gui.NavigationFrame.Buttons.Skins, 
    Settings = v18.Gui.NavigationFrame.Buttons.Settings, 
    Credits = v18.Gui.NavigationFrame.Buttons.Credits
};
local v28 = {
    Creator = v5:Get("ReplicatedStorage.Assets.Sounds.Music.Creator")
};
local function _(v29, v30, v31, v32, v33) --[[ Line: 69 ]] --[[ Name: remap ]]
    return v32 + (v33 - v32) * math.clamp((v29 - v30) / (v31 - v30), 0, 1);
end;
local function v44(v35) --[[ Line: 73 ]] --[[ Name: setPage ]]
    -- upvalues: v18 (copy), v25 (copy), v19 (copy), v24 (ref), v27 (copy)
    if not v18:IsClosable() then
        return;
    else
        local l_v35_0 = v35;
        local l_v35_1 = v35;
        if typeof(v35) == "number" then
            if #v25 < l_v35_1 then
                l_v35_1 = 1;
            elseif l_v35_1 < 1 then
                l_v35_1 = 4;
            end;
            l_v35_0 = v25[l_v35_1];
        elseif typeof(v35) == "string" then
            for v38, v39 in next, v25 do
                if v39 == v35 then
                    l_v35_1 = v38;
                    break;
                end;
            end;
        end;
        for v40, v41 in next, v19 do
            if v40 ~= l_v35_0 then
                v41:SetVisible(false, v18);
            end;
        end;
        v19[l_v35_0]:SetVisible(true, v18);
        v24 = l_v35_1;
        for v42, v43 in next, v27 do
            if v42 == l_v35_0 then
                v43.ImageTransparency = 0;
            else
                v43.ImageTransparency = 0.5;
            end;
        end;
        return;
    end;
end;
local function v50() --[[ Line: 124 ]] --[[ Name: setPlayerInfo ]]
    -- upvalues: v7 (copy), l_Players_0 (copy), v18 (copy)
    local l_v7_Statistic_0 = v7:GetStatistic("Character", "TimeAlive");
    local l_v7_Statistic_1 = v7:GetStatistic("Character", "PlayerKills");
    local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
    l_v7_Statistic_0 = if l_v7_Statistic_0 then math.floor(l_v7_Statistic_0 / 1440) else "failed to load";
    if not l_v7_Statistic_1 then
        l_v7_Statistic_1 = "failed to load";
    end;
    v18.Gui.Account.Portrait.Avatar.Image = ("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=48&height=48&format=png"):format(l_LocalPlayer_0.UserId);
    v18.Gui.Account.Username.Text = l_LocalPlayer_0.Name;
    v18.Gui.Account.Days.Text = l_v7_Statistic_0 .. " Days Survived";
    v18.Gui.Account.Kills.Text = l_v7_Statistic_1 .. " Players Killed";
    local v48 = math.max(v18.Gui.Account.Username.TextBounds.X + 63, v18.Gui.Account.Days.TextBounds.X + 60, v18.Gui.Account.Kills.TextBounds.X + 60);
    local v49 = UDim2.new(0, v48, 1, 0);
    v18.Gui.Account.Background.Size = v49;
end;
local function v64() --[[ Line: 155 ]] --[[ Name: init ]]
    -- upvalues: v5 (copy), v2 (copy), v18 (copy), v19 (copy), v27 (copy), v24 (ref), v44 (copy), l_v3_Camera_0 (copy), v28 (copy), v21 (copy)
    local v51 = v5:Find("ReplicatedStorage.Client.Abstracts.Interface.MainMenuClasses.TabClasses");
    local v52 = v2:GetStorage("MainMenu"):WaitForChild("SpawnPlate"):Clone();
    local _ = v18.Gui.NavigationFrame.Buttons;
    local l_Content_0 = v18.Gui.Content;
    for _, v56 in next, v51:GetChildren() do
        local v57 = l_Content_0:WaitForChild(v56.Name);
        local v58 = require(v56)(v18, v57);
        v19[v56.Name] = v58;
    end;
    if v19.Skins.EventTagged then
        v27.Skins.EventTag.Visible = true;
    else
        v27.Skins.EventTag.Visible = false;
    end;
    v24 = 1;
    v44(v24);
    l_v3_Camera_0:SetSubjectBackground(v52);
    for _, v60 in next, v28 do
        v60.Parent = v5:Find("Workspace.Effects");
        v60.SoundGroup = v5:Find("SoundService.Music");
        v60.Volume = 0;
    end;
    v21.Wait = function(_) --[[ Line: 191 ]]

    end;
    v21.Connect = function(_, v63) --[[ Line: 195 ]]
        if v63 then
            coroutine.wrap(v63)();
        end;
    end;
    v21.wait = v21.Wait;
    v21.connect = v21.Connect;
end;
v18.Start = function(v65, v66, ...) --[[ Line: 207 ]] --[[ Name: Start ]]
    -- upvalues: v10 (copy), v6 (copy), l_Value_0 (copy), v0 (copy), v2 (copy), v19 (copy)
    v10:Fade(0, 0.3):Wait();
    v10:SetText("loading menu");
    v6:SetMode(l_Value_0);
    v0.Libraries.DustEffects:WipeStorm();
    v2:Show("MainMenu");
    v2:Hide("PlayerList", "Chat", "GameMenu", "Map", "Compass");
    v65:Show(v66);
    v10:SetText("");
    v19[v66]:Start(...);
    v10:Fade(1, 0.3);
end;
v18.StopMusic = function(_, v68) --[[ Line: 224 ]] --[[ Name: StopMusic ]]
    -- upvalues: v20 (copy), v21 (copy), l_TweenService_0 (copy)
    if not v20.CurrentTrack then
        return v21;
    else
        local v69 = TweenInfo.new(v68 or 1);
        local v70 = l_TweenService_0:Create(v20.CurrentTrack, v69, {
            Volume = 0
        });
        v70.Completed:Connect(function() --[[ Line: 235 ]]
            -- upvalues: v20 (ref)
            if v20.CurrentTween then
                v20.CurrentTween:Cancel();
            end;
            v20.CurrentTween = nil;
            if v20.CurrentTrack then
                v20.CurrentTrack:Stop();
            end;
            v20.CurrentTrack = nil;
        end);
        if v20.CurrentTween then
            v20.CurrentTween:Cancel();
        end;
        v20.CurrentTween = v70;
        v70:Play();
        return v70.Completed;
    end;
end;
v18.PlayMusic = function(_, v72, v73) --[[ Line: 262 ]] --[[ Name: PlayMusic ]]
    -- upvalues: v28 (copy), v18 (copy), l_TweenService_0 (copy), v20 (copy)
    if not v28[v72] then
        return;
    else
        v18:StopMusic(0.2):Connect(function() --[[ Line: 269 ]]
            -- upvalues: v73 (copy), l_TweenService_0 (ref), v28 (ref), v72 (copy), v20 (ref)
            local v74 = TweenInfo.new(v73 or 0.1);
            local v75 = l_TweenService_0:Create(v28[v72], v74, {
                Volume = 0.6
            });
            v20.CurrentTrack = v28[v72];
            v20.CurrentTrack.Volume = 0;
            v20.CurrentTrack:Play();
            v75.Completed:Connect(function() --[[ Line: 277 ]]
                -- upvalues: v20 (ref)
                if v20.CurrentTween then
                    v20.CurrentTween:Cancel();
                end;
                v20.CurrentTween = nil;
            end);
            if v20.CurrentTween then
                v20.CurrentTween:Cancel();
            end;
            v20.CurrentTween = v75;
            v75:Play();
        end);
        return;
    end;
end;
v18.GetAPI = function(_, v77) --[[ Line: 295 ]] --[[ Name: GetAPI ]]
    -- upvalues: v19 (copy)
    return v19[v77];
end;
v18.Show = function(v78, v79) --[[ Line: 299 ]] --[[ Name: Show ]]
    -- upvalues: v44 (copy)
    if v78.Gui.Visible then
        v44(v79);
    end;
end;
v18.IsVisible = function(_, v81) --[[ Line: 305 ]] --[[ Name: IsVisible ]]
    -- upvalues: v19 (copy)
    return v19[v81]:IsVisible();
end;
v18.IsClosable = function(_) --[[ Line: 309 ]] --[[ Name: IsClosable ]]
    -- upvalues: v25 (copy), v24 (ref), v19 (copy)
    if not v19[v25[v24]]:IsClosable() then
        return false;
    else
        return true;
    end;
end;
v18.SetBlur = function(_, v84) --[[ Line: 320 ]] --[[ Name: SetBlur ]]
    -- upvalues: v12 (copy)
    v12:SetGoal(v84);
end;
l_UserInputService_0.InputBegan:Connect(function(v85, v86) --[[ Line: 326 ]]
    -- upvalues: v26 (copy), v18 (copy), l_IconImages_0 (copy), v24 (ref), v25 (copy), v44 (copy), v2 (copy)
    local v87 = v26[v85.KeyCode];
    local v88 = true;
    if v87 then
        if not v18.Gui.Visible then
            v88 = false;
        end;
        if not v18:IsClosable() then
            v88 = false;
        end;
        if v88 and v87 and not v86 then
            v87.Image = l_IconImages_0[v85.UserInputType].Down;
            if v87.Name == "NextBind" then
                v24 = v24 + 1;
            elseif v87.Name == "BackBind" then
                v24 = v24 - 1;
            end;
            if v24 > #v25 then
                v24 = 1;
            elseif v24 <= 0 then
                v24 = #v25;
            end;
            v44(v24);
            v2:PlaySound("Interface.Click");
        end;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v89, v90) --[[ Line: 360 ]]
    -- upvalues: v26 (copy), l_IconImages_0 (copy)
    local v91 = v26[v89.KeyCode];
    if v91 and not v90 then
        v91.Image = l_IconImages_0[v89.UserInputType].Up;
    end;
end);
for v92, v93 in next, v27 do
    v93.MouseButton1Click:Connect(function() --[[ Line: 369 ]]
        -- upvalues: v2 (copy), v44 (copy), v92 (copy)
        v2:PlaySound("Interface.Click");
        v44(v92);
    end);
end;
v18.Gui.NavigationFrame.Rules.MouseButton1Click:Connect(function() --[[ Line: 375 ]]
    -- upvalues: v2 (copy)
    v2:PlaySound("Interface.Click");
    v2:Show("Rules");
end);
v18.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 380 ]]
    -- upvalues: v18 (copy), v3 (copy), v2 (copy)
    if v18.Gui.Visible then
        v3:SetCurrent("MainMenu");
        return;
    else
        v18:StopMusic(2);
        v18:SetBlur(0);
        if v2:Get("DeathScreen") and v2:Get("DeathScreen"):IsMusicPlaying() then
            v2:Get("DeathScreen"):FadeOutMusic(2);
        end;
        return;
    end;
end);
l_RunService_0.Heartbeat:Connect(function(v94) --[[ Line: 393 ]]
    -- upvalues: v13 (copy), v12 (copy), v18 (copy)
    v13.Size = v12:Update(v94);
    v18.Gui.BackgroundTransparency = 1 + -0.75 * math.clamp((v13.Size - 0) / 30, 0, 1);
    v18.Gui.TopFade.BackgroundTransparency = 0.15 + 0.85 * math.clamp((v13.Size - 0) / 30, 0, 1);
    v18.Gui.Line.BackgroundTransparency = 1 + -0.15000000000000002 * math.clamp((v13.Size - 0) / 30, 0, 1);
end);
v2:AttachToTopbar(function(v95, _, _) --[[ Line: 401 ]]
    -- upvalues: v18 (copy)
    v18.Gui.NavigationFrame.Position = UDim2.fromOffset(v95.X + 12, 34);
end);
v7:BindToStatistic("Character", "TimeAlive", v50);
v7:BindToStatistic("Character", "PlayerKills", v50);
v64();
return v18;