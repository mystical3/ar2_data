local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Classes", "Springs");
local l_RunService_0 = game:GetService("RunService");
local v4 = v2.new(1, 7, 1);
local v5 = {
    Gui = v1:GetGui("FlashlightFade")
};
local l_ScreenGui_0 = Instance.new("ScreenGui");
l_ScreenGui_0.Parent = v1:GetMasterScreenGui().Parent;
l_ScreenGui_0.DisplayOrder = -1;
l_ScreenGui_0.IgnoreGuiInset = true;
v5.Gui.Parent = l_ScreenGui_0;
local function v12() --[[ Line: 25 ]] --[[ Name: findCharacterLightingFadeValue ]]
    -- upvalues: v0 (copy)
    local l_Players_0 = v0.Classes.Players;
    if l_Players_0 then
        local v8 = l_Players_0.get();
        if v8 and v8.Character then
            local l_Character_0 = v8.Character;
            if l_Character_0:HasPerk("Flashlight") and l_Character_0.LightEnabled ~= "" then
                local _, v11 = l_Character_0:HasPerk("Flashlight", true);
                if v11 and v11.ScreenDimTransparency then
                    return v11.ScreenDimTransparency;
                end;
            end;
        end;
    end;
    return 1;
end;
l_RunService_0.Heartbeat:Connect(function(v13) --[[ Line: 49 ]]
    -- upvalues: v12 (copy), v4 (copy), v5 (copy)
    local v14 = v12();
    local v15 = v4:StepTo(v14, v13);
    v5.Gui.ImageLabel.ImageTransparency = v15;
end);
v5.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 56 ]]
    -- upvalues: v5 (copy)
    v5.Gui.Visible = true;
end);
v5.Gui.Visible = true;
return v5;