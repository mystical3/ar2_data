local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Network");
local v4 = v0.require("Classes", "Maids");
local l_RunService_0 = game:GetService("RunService");
local l_TextService_0 = game:GetService("TextService");
local v7 = {
    Gui = v2:GetGui("SaveData")
};
local v8 = 3;
local v9 = {
    Purchases = "Your purchase history has failed to load. Everything you've purchased is still safe, it just wont be avalible for this play session. Purchasing new items has been temporarily disabled as well.", 
    Player = "Your player data has failed to load. Your keybinds, settings, statistics, loadouts, and item discovery list will not be avalible this play session. This play session will not save any new item unlocks or changes to settings/stats.", 
    Character = "Your character has failed to load. Your character is still exists, it just didn't load for this play session. You will be given a fresh character to play on that WILL NOT save/overwrite the character that failed to load."
};
if l_RunService_0:IsStudio() then
    v8 = 0.2;
end;
v7.TryWarning = function(_) --[[ Line: 36 ]] --[[ Name: TryWarning ]]
    -- upvalues: v9 (copy), v3 (copy), v1 (copy), v4 (copy), v8 (ref), v7 (copy), l_TextService_0 (copy), v2 (copy), l_RunService_0 (copy)
    local v11 = {};
    for v12, v13 in next, v9 do
        if not v3:Fetch("Did Save Load", v12) then
            v11[v12] = v13;
        end;
    end;
    if v1.DataLoadingBlocked then
        v11 = {
            ["Offline Mode"] = "The Developers have turned off data loading and saving for this play session. Nothing you collect or do will save. Your saved data has not been loaded."
        };
        if v1.AllCosmeticsUnlocked then
            v11["Cosmetics Unlocked"] = "All findable items, paid outfits, and gun skins have been unlocked.";
        end;
    end;
    if next(v11) then
        local v14 = v4.new();
        local l_QuickPlay_0 = v1.QuickPlay;
        local l_v8_0 = v8;
        local v17 = false;
        local l_Controls_0 = v7.Gui.MainBin.Controls;
        local v19 = "";
        for v20, v21 in next, v11 do
            v19 = v19 .. "<b>" .. v20:upper() .. ":</b>" .. " " .. v21 .. "\n\n";
        end;
        local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(v19, v7.Gui.MainBin.WarningText.textSize, v7.Gui.MainBin.WarningText.Font, Vector2.new(v7.Gui.MainBin.AbsoluteSize.X, 9000));
        v7.Gui.MainBin.WarningText.Text = v19:gsub("%s+$", "");
        v7.Gui.MainBin.WarningText.Size = UDim2.new(1, 0, 0, l_l_TextService_0_TextSize_0.Y);
        local function v23() --[[ Line: 80 ]] --[[ Name: fadeOut ]]
            -- upvalues: l_Controls_0 (copy), v2 (ref), v17 (ref)
            l_Controls_0.Progress.Visible = false;
            l_Controls_0.Continue.Visible = false;
            v2:Get("Fade"):SetText("");
            v2:Get("Fade"):Fade(0, 1):Wait();
            v2:Hide("SaveData");
            v17 = true;
        end;
        local function _(v24, v25, v26) --[[ Line: 92 ]] --[[ Name: lerp ]]
            return v24 + (v25 - v24) * v26;
        end;
        v14:Give(l_Controls_0.Continue.MouseButton1Down:Connect(function() --[[ Line: 98 ]]
            -- upvalues: l_QuickPlay_0 (ref)
            l_QuickPlay_0 = true;
        end));
        v14:Give(l_Controls_0.Continue.MouseButton1Up:Connect(function() --[[ Line: 102 ]]
            -- upvalues: l_QuickPlay_0 (ref)
            l_QuickPlay_0 = false;
        end));
        v14:Give(l_Controls_0.Continue.MouseLeave:Connect(function() --[[ Line: 106 ]]
            -- upvalues: l_QuickPlay_0 (ref)
            l_QuickPlay_0 = false;
        end));
        v14:Give(l_RunService_0.Heartbeat:Connect(function(v28) --[[ Line: 110 ]]
            -- upvalues: l_QuickPlay_0 (ref), l_v8_0 (ref), v8 (ref), l_Controls_0 (copy), v14 (copy), v23 (copy)
            if l_QuickPlay_0 then
                l_v8_0 = l_v8_0 - v28;
            else
                l_v8_0 = l_v8_0 + v28;
            end;
            l_v8_0 = math.clamp(l_v8_0, 0, v8);
            local v29 = 1 - math.clamp(l_v8_0 / v8, 0, 1);
            local v30 = v29 > 0 and 0.8 or 1;
            l_Controls_0.Progress.Fill.Size = UDim2.fromScale(v29, 1);
            local l_Progress_0 = l_Controls_0.Progress;
            local l_BackgroundTransparency_0 = l_Controls_0.Progress.BackgroundTransparency;
            l_Progress_0.BackgroundTransparency = l_BackgroundTransparency_0 + (v30 - l_BackgroundTransparency_0) * 0.3;
            if l_v8_0 <= 0 then
                v14:Clean();
                v23();
            end;
        end));
        v2:Show("SaveData");
        v2:Get("Fade"):Fade(1, 0.3):Wait();
        repeat
            task.wait(0);
        until v17;
        return;
    else
        v2:Hide("SaveData");
        return;
    end;
end;
return v7;