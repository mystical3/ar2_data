local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "ItemData");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Network");
local _ = v0.require("Libraries", "Discovery");
local v5 = v0.require("Libraries", "Resources");
local v6 = v0.require("Libraries", "ViewportIcons");
local v7 = v0.require("Libraries", "UserStatistics");
local v8 = v0.require("Classes", "Maids");
local v9 = v2:Get("Fade");
local l_v2_Storage_0 = v2:GetStorage("DeathScreen");
local l_TextService_0 = game:GetService("TextService");
local l_TweenService_0 = game:GetService("TweenService");
local v13 = {};
local v14 = 1;
local v15 = {
    Gui = v2:GetGui("DeathScreen"), 
    Music = v5:Get("ReplicatedStorage.Assets.Sounds.Music.Death Creator")
};
v15.Music.Parent = v5:Find("Workspace.Effects");
v15.Music.SoundGroup = v5:Find("SoundService.Music");
local function v19() --[[ Line: 36 ]] --[[ Name: displayStats ]]
    -- upvalues: v7 (copy), v15 (copy)
    local l_v7_Statistic_0 = v7:GetStatistic("Character", "TimeAlive");
    local l_v7_Statistic_1 = v7:GetStatistic("Character", "PlayerKills");
    local l_v7_Statistic_2 = v7:GetStatistic("Character", "ZombieKills");
    v15.Gui.MainBin.Stats.Days.Number.Text = tostring((math.floor(l_v7_Statistic_0 / 1440)));
    v15.Gui.MainBin.Stats.Players.Number.Text = tostring(l_v7_Statistic_1);
    v15.Gui.MainBin.Stats.Zombies.Number.Text = tostring(l_v7_Statistic_2);
end;
local function v28(v20, v21, v22) --[[ Line: 46 ]] --[[ Name: splitIntoLines ]]
    -- upvalues: l_TextService_0 (copy)
    local v23 = Vector2.new(1000, 1000);
    local v24 = {};
    local v25 = "";
    for v26 in v20:gmatch("%S+") do
        local l_v26_0 = v26;
        if v25 ~= "" then
            l_v26_0 = v25 .. " " .. v26;
        end;
        if v22 < l_TextService_0:GetTextSize(l_v26_0, v21.TextSize, v21.Font, v23).X then
            table.insert(v24, v25);
            v25 = v26;
        else
            v25 = l_v26_0;
        end;
    end;
    table.insert(v24, v25);
    return v24;
end;
local function v48() --[[ Line: 74 ]] --[[ Name: displayDiscovery ]]
    -- upvalues: v13 (ref), v14 (ref), v3 (copy), v1 (copy), l_v2_Storage_0 (copy), v6 (copy), v28 (copy), v15 (copy)
    for _, v30 in next, v13 do
        for _, v32 in next, v30 do
            v32:Destroy();
        end;
    end;
    v13 = {};
    v14 = 1;
    local v33 = v3:Fetch("Get Lifetime Discovery List");
    local l_next_0 = next;
    local v35 = v33 or {};
    for v36, v37 in l_next_0, v35 do
        if v1[v37] then
            local v38 = math.floor((v36 - 1) / 9) + 1;
            local v39 = (v36 - 1) % 9 + 1;
            local v40 = l_v2_Storage_0.ItemTemplate:Clone();
            v40.LayoutOrder = v36;
            v40.Name = v37;
            v40.Visible = false;
            if not v13[v38] then
                v13[v38] = {};
            end;
            local v41 = {
                [1] = v40.Bottom.Hat.NameLine1, 
                [2] = v40.Bottom.Hat.NameLine2
            };
            v6:SetViewportIcon(v40.Bottom.Hat.Selected.Icon, v37, "Creator");
            local v42 = v1[v37] and v1[v37].DisplayName or v37;
            local v43 = v28(v42, v40.Bottom.Hat.NameLine1, 107);
            for v44, v45 in next, v41 do
                v45.Text = v43[v44] or "";
            end;
            v40.Bottom.Hat.Label.Text = v1[v37].EquipSlot;
            v40.Parent = v15.Gui.MainBin.Unlocks.ItemBin;
            v13[v38][v39] = v40;
        end;
    end;
    if #v13 > 0 then
        for _, v47 in next, v13[1] do
            v47.Visible = true;
        end;
        l_next_0 = v15.Gui.MainBin.Unlocks.ItemBin.UIGridLayout.AbsoluteContentSize.Y;
        v15.Gui.MainBin.Unlocks.ItemBin.Size = UDim2.new(1, 0, 0, l_next_0 + 20);
        v15.Gui.MainBin.Unlocks.Size = UDim2.new(0, 545, 0, l_next_0 + 47);
        v15.Gui.MainBin.Controls.ArrowForward.InnerBox.PageLabel.Text = "1/" .. #v13;
        v15.Gui.MainBin.Controls.ArrowForward.InnerBox.PageLabel.Backdrop.Text = "1/" .. #v13;
        v15.Gui.MainBin.Controls.ArrowBack.Visible = true;
        v15.Gui.MainBin.Controls.ArrowForward.Visible = true;
        v15.Gui.MainBin.Unlocks.Visible = true;
        return;
    else
        v15.Gui.MainBin.Controls.ArrowBack.Visible = false;
        v15.Gui.MainBin.Controls.ArrowForward.Visible = false;
        v15.Gui.MainBin.Unlocks.Visible = false;
        return;
    end;
end;
local function v56(v49) --[[ Line: 145 ]] --[[ Name: setDiscoverPage ]]
    -- upvalues: v13 (ref), v14 (ref), v15 (copy)
    if #v13 > 0 then
        local v50 = v14 + v49;
        local v51 = #v13;
        if v50 < 1 then
            v50 = v51;
        elseif v51 < v50 then
            v50 = 1;
        end;
        for _, v53 in next, v13[v14] do
            v53.Visible = false;
        end;
        for _, v55 in next, v13[v50] do
            v55.Visible = true;
        end;
        v15.Gui.MainBin.Controls.ArrowForward.InnerBox.PageLabel.Text = v50 .. "/" .. #v13;
        v15.Gui.MainBin.Controls.ArrowForward.InnerBox.PageLabel.Backdrop.Text = v50 .. "/" .. #v13;
        v14 = v50;
    end;
end;
v15.Start = function(v57) --[[ Line: 173 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy), v15 (copy), v8 (copy), v2 (copy), v9 (copy), v3 (copy), v56 (copy), v19 (copy), v48 (copy)
    local l_QuickRespawn_0 = v0.Configs.Globals.QuickRespawn;
    local l_Controls_0 = v15.Gui.MainBin.Controls;
    local v60 = v8.new();
    local function v62(v61) --[[ Line: 180 ]] --[[ Name: continueSequence ]]
        -- upvalues: v15 (ref), v2 (ref), v60 (copy), v9 (ref), v3 (ref), v0 (ref)
        v15.abort = nil;
        v2:PlaySound("Interface.Click");
        v60:Destroy();
        if v61 then
            v9:Fade(1, 0.1);
        else
            v9:Fade(0, 1):Wait();
        end;
        v2:Hide("DeathScreen");
        if not v61 then
            v2:Get("MainMenu"):Start("Creator", function() --[[ Line: 195 ]]
                -- upvalues: v3 (ref), v0 (ref)
                v3:Send("Spawn In Character");
                v0.Classes.Players.get().CharacterAdded:Wait();
            end);
        end;
    end;
    v15.abort = function() --[[ Line: 202 ]]
        -- upvalues: v62 (copy), v0 (ref), v57 (copy)
        v62(true);
        v0.Classes.Characters.resetDamageEffects();
        v57:FadeOutMusic(0.2);
    end;
    v60:Give(l_Controls_0.Continue.MouseButton1Click:Connect(function() --[[ Line: 211 ]]
        -- upvalues: v62 (copy)
        v62();
    end));
    v60:Give(l_Controls_0.ArrowForward.MouseButton1Click:Connect(function() --[[ Line: 215 ]]
        -- upvalues: v2 (ref), v56 (ref)
        v2:PlaySound("Interface.Click");
        v56(1);
    end));
    v60:Give(l_Controls_0.ArrowBack.MouseButton1Click:Connect(function() --[[ Line: 220 ]]
        -- upvalues: v2 (ref), v56 (ref)
        v2:PlaySound("Interface.Click");
        v56(-1);
    end));
    v19();
    v48();
    v2:Get("Unlock"):ClearQueue();
    v2:Hide("Chat", "PlayerList");
    v2:Show("DeathScreen");
    v9:Fade(1, 2);
    v57:FadeInMusic(20);
    if l_QuickRespawn_0 then
        task.wait(0.5);
        v62();
    end;
end;
v15.IsMusicPlaying = function(_) --[[ Line: 246 ]] --[[ Name: IsMusicPlaying ]]
    -- upvalues: v15 (copy)
    return v15.Music.IsPlaying;
end;
v15.FadeInMusic = function(v64, v65) --[[ Line: 250 ]] --[[ Name: FadeInMusic ]]
    -- upvalues: v0 (copy), l_TweenService_0 (copy)
    if v64.MusicFadeOutTween then
        v64.MusicFadeOutTween:Cancel();
        v0.destroy(v64.MusicFadeOutTween, "Completed");
        v64.MusicFadeOutTween = nil;
    else
        v64.Music:Stop();
        v64.Music.Volume = 0;
    end;
    local v66 = l_TweenService_0:Create(v64.Music, TweenInfo.new(v65), {
        Volume = 0.6
    });
    v66.Completed:Connect(function() --[[ Line: 267 ]]
        -- upvalues: v64 (copy), v66 (copy)
        if v64.MusicFadeInTween == v66 then
            v64.MusicFadeInTween = nil;
        end;
    end);
    v64.MusicFadeInTween = v66;
    v66:Play();
    v64.Music:Play();
end;
v15.FadeOutMusic = function(v67, v68) --[[ Line: 279 ]] --[[ Name: FadeOutMusic ]]
    -- upvalues: l_TweenService_0 (copy)
    if v67.MusicFadeInTween then
        v67.MusicFadeInTween:Cancel();
        v67.MusicFadeInTween = nil;
    end;
    local v69 = l_TweenService_0:Create(v67.Music, TweenInfo.new(v68), {
        Volume = 0
    });
    v69.Completed:Connect(function() --[[ Line: 291 ]]
        -- upvalues: v67 (copy), v69 (copy)
        v67.Music:Stop();
        if v67.MusicFadeOutTween == v69 then
            v67.MusicFadeOutTween = nil;
        end;
    end);
    v67.MusicFadeOutTween = v69;
    v69:Play();
end;
return v15;