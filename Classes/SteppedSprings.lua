local v0 = require(game:GetService("ReplicatedFirst").Framework).require("Classes", "Springs");
return {
    new = function(v1, v2, v3, v4) --[[ Line: 15 ]] --[[ Name: new ]]
        -- upvalues: v0 (copy)
        local v5 = v0.new(v1, v2, v3, v4);
        local v6 = {
            Spring = v5
        };
        local v7 = tick();
        local v8 = 0;
        local function v11() --[[ Line: 25 ]] --[[ Name: update ]]
            -- upvalues: v7 (ref), v5 (copy)
            local v9 = tick();
            local v10 = v9 - v7;
            if v10 > 0.001 then
                v7 = v9;
                v5:Update(v10);
            end;
            return v5.p, v5.v;
        end;
        v6.GetPosition = function(_) --[[ Line: 39 ]] --[[ Name: GetPosition ]]
            -- upvalues: v7 (ref), v5 (copy)
            local v13 = tick();
            local v14 = v13 - v7;
            if v14 > 0.001 then
                v7 = v13;
                v5:Update(v14);
            end;
            local l_p_0 = v5.p;
            local _ = v5.v;
            return l_p_0;
        end;
        v6.GetVelocity = function(_) --[[ Line: 45 ]] --[[ Name: GetVelocity ]]
            -- upvalues: v7 (ref), v5 (copy)
            local v18 = tick();
            local v19 = v18 - v7;
            if v19 > 0.001 then
                v7 = v18;
                v5:Update(v19);
            end;
            local _ = v5.p;
            return v5.v;
        end;
        v6.Update = function(_, v22) --[[ Line: 51 ]] --[[ Name: Update ]]
            -- upvalues: v8 (ref), v11 (copy)
            v8 = v8 + (v22 or 0);
            return v11();
        end;
        v6.SetGoal = function(_, v24) --[[ Line: 57 ]] --[[ Name: SetGoal ]]
            -- upvalues: v5 (copy)
            return v5:SetGoal(v24);
        end;
        v6.SetPosition = function(_, v26) --[[ Line: 61 ]] --[[ Name: SetPosition ]]
            -- upvalues: v5 (copy)
            v5.p = v26;
        end;
        v6.GetGoal = function(_) --[[ Line: 65 ]] --[[ Name: GetGoal ]]
            -- upvalues: v5 (copy)
            return v5.g;
        end;
        v6.GetSpeed = function(_) --[[ Line: 69 ]] --[[ Name: GetSpeed ]]
            -- upvalues: v5 (copy)
            return v5.f;
        end;
        v6.Retune = function(_, v30, v31) --[[ Line: 73 ]] --[[ Name: Retune ]]
            -- upvalues: v5 (copy)
            v5.f = v30 or v5.f;
            v5.d = v31 or v5.d;
        end;
        v6.Accelerate = function(_, v33) --[[ Line: 78 ]] --[[ Name: Accelerate ]]
            -- upvalues: v7 (ref), v5 (copy), v11 (copy)
            local v34 = tick();
            local v35 = v34 - v7;
            if v35 > 0.001 then
                v7 = v34;
                v5:Update(v35);
            end;
            local l_p_2 = v5.p;
            l_p_2 = v5.v;
            v5.v = v5.v + v33;
            return v11();
        end;
        v6.SnapTo = function(_, v38) --[[ Line: 86 ]] --[[ Name: SnapTo ]]
            -- upvalues: v5 (copy), v11 (copy)
            if not v38 then
                v38 = v5.g;
            end;
            v5.g = v38;
            v5.p = v38;
            v5.v = v38 * 0;
            return v11();
        end;
        v6.Normalize = function(_) --[[ Line: 98 ]] --[[ Name: Normalize ]]
            -- upvalues: v7 (ref), v5 (copy)
            local v40 = tick();
            local v41 = v40 - v7;
            if v41 > 0.001 then
                v7 = v40;
                v5:Update(v41);
            end;
            local l_p_3 = v5.p;
            local _ = v5.v;
            v40 = l_p_3;
            if typeof(l_p_3) == "Vector3" then
                v40 = l_p_3.unit;
            elseif typeof(l_p_3) == "number" then
                v40 = l_p_3 < 0 and -1 or 1;
            end;
            v5.p = v40;
            return v40;
        end;
        return v6;
    end
};