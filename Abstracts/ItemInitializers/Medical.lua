local _ = require(game:GetService("ReplicatedFirst").Framework);
return function(v1, v2, v3) --[[ Line: 5 ]]
    require(script.Parent:WaitForChild("Consumable"))(v1, v2, v3);
    if not v3 then
        return;
    else
        v1.IsUsable = function(v4, v5) --[[ Line: 14 ]]
            local l_next_0 = next;
            local v7 = v4.UseBoost or {};
            for v8, v9 in l_next_0, v7 do
                local v10 = v5[v8];
                if v10 and v10.Bonus:Get() < v9.Value then
                    return true;
                end;
            end;
            l_next_0 = next;
            v7 = v4.UseValue or {};
            for v11, v12 in l_next_0, v7 do
                local v13 = v5[v11];
                if v12 > 0 and v13 and v13:Get() < v13.Max then
                    return true;
                end;
            end;
            if next(v4.UseFreeze or {}) then
                return true;
            else
                l_next_0 = next;
                v7 = v4.UseRestore or {};
                for v14, _ in l_next_0, v7 do
                    local v16 = v5[v14];
                    if v16 and v16.Bonus:Get(true) < 1 then
                        return true;
                    end;
                end;
                return false;
            end;
        end;
        return;
    end;
end;