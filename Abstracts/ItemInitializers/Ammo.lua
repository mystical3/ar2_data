local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Network");
local _ = v0.require("Classes", "Maids");
local _ = v0.require("Classes", "Signals");
local _ = function(v5) --[[ Line: 12 ]] --[[ Name: wrapAmmoCorrector ]]
    if v5.Amount then
        local l_Amount_0 = v5.Amount;
        do
            local l_l_Amount_0_0 = l_Amount_0;
            v5.Maid:Give(v5.Changed:Connect(function(_) --[[ Line: 16 ]]
                -- upvalues: l_l_Amount_0_0 (ref), v5 (copy)
                local l_l_l_Amount_0_0_0 = l_l_Amount_0_0;
                local l_Amount_1 = v5.Amount;
                l_l_Amount_0_0 = l_Amount_1;
                if l_l_l_Amount_0_0_0 < l_Amount_1 then
                    v5.WorkingAmount = l_Amount_1;
                end;
            end));
            v5.WorkingAmount = v5.Amount;
        end;
    end;
end;
return function(v12, _, v14) --[[ Line: 35 ]]
    -- upvalues: v2 (copy)
    v12.Amount = 0;
    v12.AmmoMoving = false;
    if not v14 then
        return;
    else
        if v12.Amount then
            local l_Amount_2 = v12.Amount;
            do
                local l_l_Amount_2_0 = l_Amount_2;
                v12.Maid:Give(v12.Changed:Connect(function(_) --[[ Line: 16 ]]
                    -- upvalues: l_l_Amount_2_0 (ref), v12 (copy)
                    local l_l_l_Amount_2_0_0 = l_l_Amount_2_0;
                    local l_Amount_3 = v12.Amount;
                    l_l_Amount_2_0 = l_Amount_3;
                    if l_l_l_Amount_2_0_0 < l_Amount_3 then
                        v12.WorkingAmount = l_Amount_3;
                    end;
                end));
                v12.WorkingAmount = v12.Amount;
            end;
        end;
        v12.GetAmmoCountText = function(v20) --[[ Line: 49 ]]
            return string.format("%d/%d", v20.WorkingAmount, v20.Capacity);
        end;
        v12.CanCraft = function(v21, v22) --[[ Line: 53 ]]
            if v22.Type == "Ammo" then
                return v22.Caliber == v21.Caliber;
            else
                return false;
            end;
        end;
        v12.OnCraft = function(v23, _, v25) --[[ Line: 61 ]]
            -- upvalues: v2 (ref)
            v2:Send("Inventory Craft Item", v23.Id, v25.Id);
        end;
        return;
    end;
end;