local v0 = {};
local l_cos_0 = math.cos;
local l_sin_0 = math.sin;
v0.new = function(v3, v4, v5) --[[ Line: 16 ]] --[[ Name: new ]]
    -- upvalues: l_cos_0 (copy), l_sin_0 (copy)
    local v6 = {};
    local v7 = v3 or 0;
    local v8 = v3 or 0;
    local v9 = v3 * 0;
    local v10 = v4 or 1;
    local v11 = v5 or 0.5;
    local v12 = tick();
    local v13 = type(v3);
    local function v25() --[[ Line: 31 ]] --[[ Name: update ]]
        -- upvalues: v12 (ref), v7 (ref), v8 (ref), v10 (ref), v9 (ref), v11 (ref), l_cos_0 (ref), l_sin_0 (ref)
        local v14 = tick() - v12;
        local v15 = v7 - v8;
        if v10 == 0 then
            v7 = v7;
            v9 = v9 * 0;
        elseif v11 < 1 then
            local v16 = (1 - v11 * v11) ^ 0.5;
            local v17 = l_cos_0(v16 * v10 * v14);
            local v18 = l_sin_0(v16 * v10 * v14);
            local v19 = (v9 / v10 + v11 * v15) / v16;
            local v20 = 2.718281828459045 ^ (v11 * v10 * v14);
            local v21 = v17 * (v16 * v19 - v11 * v15);
            local v22 = v18 * (v16 * v15 + v11 * v19);
            v7 = v8 + (v15 * v17 + v19 * v18) / v20;
            v9 = v10 * (v21 - v22) / v20;
        else
            local v23 = v9 / v10 + v15;
            local v24 = 2.718281828459045 ^ (v10 * v14);
            v7 = v8 + (v15 + v23 * v10 * v14) / v24;
            v9 = v10 * (v23 - v15 - v23 * v10 * v14) / v24;
        end;
        v12 = v12 + v14;
    end;
    local v31 = {
        __index = function(_, v27) --[[ Line: 64 ]] --[[ Name: __index ]]
            -- upvalues: v10 (ref), v11 (ref), v8 (ref), v25 (copy), v7 (ref), v9 (ref)
            if v27 == "Speed" then
                return v10;
            elseif v27 == "Damping" then
                return v11;
            elseif v27 == "Target" then
                return v8;
            elseif v27 == "Position" then
                v25();
                return v7;
            elseif v27 == "Velocity" then
                v25();
                return v9;
            else
                return;
            end;
        end, 
        __newindex = function(v28, v29, v30) --[[ Line: 82 ]] --[[ Name: __newindex ]]
            -- upvalues: v10 (ref), v11 (ref), v8 (ref), v7 (ref), v9 (ref)
            if v29 == "Speed" then
                v10 = v30;
            elseif v29 == "Damping" then
                v11 = v30;
            elseif v29 == "Target" then
                v8 = v30;
            elseif v29 == "Position" then
                v7 = v30;
            elseif v29 == "Velocity" then
                v9 = v30;
            end;
            rawset(v28, v29, nil);
        end
    };
    v6.Accelerate = function(_, v33) --[[ Line: 101 ]] --[[ Name: Accelerate ]]
        -- upvalues: v9 (ref), v25 (copy), v7 (ref)
        v9 = v9 + v33;
        v25();
        return v7;
    end;
    v6.Normalize = function(_) --[[ Line: 108 ]] --[[ Name: Normalize ]]
        -- upvalues: v25 (copy), v13 (copy), v7 (ref)
        v25();
        if v13 == "userdata" then
            v7 = v7.unit;
        elseif v7 == 0 then
            v7 = 0;
        elseif v7 > 0 then
            v7 = 1;
        else
            v7 = -1;
        end;
        return v7;
    end;
    v6.SnapToTarget = function(_) --[[ Line: 126 ]] --[[ Name: SnapToTarget ]]
        -- upvalues: v9 (ref), v7 (ref), v8 (ref)
        v9 = v9 * 0;
        v7 = v8;
        return v7;
    end;
    return (setmetatable(v6, v31));
end;
return v0;