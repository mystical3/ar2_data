local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Steppers");
local _ = game:GetService("MarketplaceService");
local v5 = {
    Gui = v1:GetGui("MedalQuest")
};
local l_ConnectWarn_0 = v5.Gui.Center.ConnectWarn;
local l_QuestCard_0 = v5.Gui.Center.QuestCard;
local l_CompleteCard_0 = v5.Gui.Center.CompleteCard;
local v9 = false;
local v10 = nil;
local function _() --[[ Line: 24 ]] --[[ Name: teleportSequence ]]
    -- upvalues: v2 (copy)
    v2:Fetch("Medal Quest Teleport");
end;
local function v12() --[[ Line: 28 ]] --[[ Name: setRemaining ]]

end;
v5.PromptQuest = function(_) --[[ Line: 41 ]] --[[ Name: PromptQuest ]]
    -- upvalues: v9 (ref), v10 (ref), v1 (copy)
    if not v9 then
        v10 = os.clock() + 3;
        v1:Show("MedalQuest");
    end;
end;
v2:Add("Medal Quest Sync", function(v14) --[[ Line: 50 ]]
    -- upvalues: l_QuestCard_0 (copy), l_ConnectWarn_0 (copy), l_CompleteCard_0 (copy), v12 (copy), v9 (ref), v10 (ref)
    if v14.Active then
        l_QuestCard_0.Progress.Text = tonumber(v14.Found);
        l_ConnectWarn_0.Visible = false;
        l_QuestCard_0.Visible = not v14.Completed;
        l_CompleteCard_0.Visible = v14.Completed;
        if v14.Completed then
            pcall(v12);
        end;
    else
        l_ConnectWarn_0.Visible = true;
        l_QuestCard_0.Visible = false;
        l_CompleteCard_0.Visible = false;
    end;
    v9 = v14.Completed;
    if v9 then
        v10 = nil;
    end;
end);
v2:Send("Medal Quest Sync");
v5.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 76 ]]
    -- upvalues: v5 (copy), v10 (ref)
    if not v5.Gui.Visible then
        v10 = nil;
        v5.Gui.TeleportWarn.Visible = false;
    end;
end);
v3.new(0.1, "Heartbeat", function() --[[ Line: 84 ]]
    -- upvalues: v10 (ref), v1 (copy)
    if v10 and os.clock() > v10 then
        v1:Hide("MedalQuest");
    end;
end);
l_CompleteCard_0.RewardIcon.MouseButton1Click:Connect(function() --[[ Line: 90 ]]
    -- upvalues: v5 (copy), v1 (copy)
    v5.Gui.TeleportWarn.Visible = true;
    v1:PlaySound("Interface.Bweep");
end);
v5.Gui.TeleportWarn.Options.Yes.MouseButton1Click:Connect(function() --[[ Line: 95 ]]
    -- upvalues: v5 (copy), v1 (copy), v2 (copy)
    v5.Gui.TeleportWarn.Visible = false;
    v5.Gui.Teleporting.Visible = true;
    v1:PlaySound("Interface.Click");
    v2:Fetch("Medal Quest Teleport");
    v5.Gui.Teleporting.Visible = true;
end);
v5.Gui.TeleportWarn.Options.No.MouseButton1Click:Connect(function() --[[ Line: 105 ]]
    -- upvalues: v1 (copy), v5 (copy)
    v1:PlaySound("Interface.Click");
    v5.Gui.TeleportWarn.Visible = false;
end);
return v5;