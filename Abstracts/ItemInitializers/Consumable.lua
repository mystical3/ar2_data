local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "Globals");
local v2 = v0.require("Configs", "PerkTuning");
local v3 = v0.require("Libraries", "Network");
local _ = v0.require("Libraries", "Resources");
local v5 = v0.require("Libraries", "Interface");
local v6 = v0.require("Classes", "Maids");
local _ = v0.require("Classes", "Signals");
local function _(v8) --[[ Line: 15 ]] --[[ Name: displayError ]]
    -- upvalues: v5 (copy)
    v5:Get("DeathActions"):Log("Server", v8);
end;
local function v26(v10, v11, _) --[[ Line: 19 ]] --[[ Name: animatedConsume ]]
    -- upvalues: v6 (copy), v2 (copy), v5 (copy), v3 (copy), v0 (copy)
    local v13 = v6.new();
    local v14 = false;
    local v15 = false;
    local v16 = 1;
    if v11:HasPerk("Trauma Kit") and v10.Type == "Medical" then
        v16 = v2("Trauma Kit", "SpeedModifier");
    end;
    local function v19(v17) --[[ Line: 29 ]] --[[ Name: cancel ]]
        -- upvalues: v15 (ref), v14 (ref), v5 (ref), v11 (copy), v10 (copy)
        if v15 then
            return;
        else
            v14 = true;
            if v17 then
                local v18 = {
                    {
                        Style = "Normal", 
                        Text = v17
                    }
                };
                v5:Get("DeathActions"):Log("Server", v18);
            end;
            v11.Animator:RunAction("Cancel Consume Animation", v10.Name);
            return;
        end;
    end;
    v13:Give(v11.MoveStateChanged:Connect(function(v20, _) --[[ Line: 45 ]]
        -- upvalues: v19 (copy)
        if v20:find("Swimming") then
            v19();
        end;
    end));
    v13:Give(v11.Falling:Connect(function(v22) --[[ Line: 51 ]]
        -- upvalues: v19 (copy)
        if v22 > 0.7 then
            v19();
        end;
    end));
    v13:Give(v11.EquipmentChanged:Connect(function() --[[ Line: 57 ]]
        -- upvalues: v11 (copy), v10 (copy), v19 (copy)
        if v11.EquippedItem ~= v10 then
            v19();
        end;
    end));
    v13:Give(v10.Changed:Connect(function(v23) --[[ Line: 63 ]]
        -- upvalues: v19 (copy)
        if v23 == "Parent" then
            v19();
        end;
    end));
    if v5:IsVisible("GameMenu") and v10.Parent and v10.Parent.ClassName == "Container" and not v10.Parent.IsCarried then
        v13:Give(v5:GetVisibilityChangedSignal("GameMenu"):Connect(function(v24) --[[ Line: 72 ]]
            -- upvalues: v19 (copy)
            if not v24 then
                v19();
            end;
        end));
    end;
    v10.Using = true;
    v3:Send("Register Consume", v10.Id);
    v0.Libraries.Interface:Get("Mouse"):ResetSpinner();
    v0.Libraries.Interface:Get("Mouse"):SetIconVisible("Spinner", true);
    local v25 = v11.Animator:RunAction("Play Consume Animation", v10.Name, 1 / v16);
    if v25 then
        v25:Wait();
    end;
    v15 = true;
    v0.Libraries.Interface:Get("Mouse"):SetIconVisible("Spinner", false);
    v13:Destroy();
    if not v14 then
        v5:Get("Hotbar"):FindReplacement(v10);
    end;
    if v14 then
        v3:Send("Cancel Consume", v10.Id);
    end;
    v10.Using = false;
    return not v14;
end;
return function(v27, _, v29) --[[ Line: 119 ]]
    -- upvalues: v26 (copy), v5 (copy)
    if not v29 then
        return;
    else
        v27.IsUsable = function(v30, v31) --[[ Line: 126 ]]
            local v32 = false;
            if v30.UseValue then
                for v33, _ in next, v30.UseValue do
                    local v35 = v31[v33];
                    if v35 and v35:Get() < v35.Max then
                        v32 = true;
                    end;
                end;
            end;
            return v32;
        end;
        v27.OnUse = function(v36, v37) --[[ Line: 142 ]]
            -- upvalues: v26 (ref), v5 (ref)
            if v36.Using then
                return false;
            elseif v36:IsUsable(v37) then
                return (v26(v36, v37, v36.ConsumeConfig.Animation));
            else
                if v37.EquippedItem == v36 then
                    v37:Unequip();
                end;
                local v38 = {
                    {
                        Style = "Bold", 
                        Text = v36.DisplayName
                    }, 
                    {
                        Style = "Normal", 
                        Text = "can't be used right now"
                    }
                };
                v5:Get("DeathActions"):Log("Server", v38);
                return false;
            end;
        end;
        return;
    end;
end;