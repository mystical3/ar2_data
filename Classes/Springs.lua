local v0 = {};
v0.__index = v0;
local l_exp_0 = math.exp;
local l_sin_0 = math.sin;
local l_cos_0 = math.cos;
local l_sqrt_0 = math.sqrt;
v0.new = function(v5, v6, v7) --[[ Line: 18 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    assert(type(v7) == "number");
    assert(type(v6) == "number");
    assert(v7 * v6 >= 0, "Spring does not converge");
    return (setmetatable({
        d = v7, 
        f = v6, 
        g = v5, 
        p = v5, 
        v = v5 * 0
    }, v0));
end;
v0.SetGoal = function(v8, v9) --[[ Line: 32 ]] --[[ Name: SetGoal ]]
    v8.g = v9;
end;
v0.GetPosition = function(v10) --[[ Line: 36 ]] --[[ Name: GetPosition ]]
    return v10.p;
end;
v0.GetVelocity = function(v11) --[[ Line: 40 ]] --[[ Name: GetVelocity ]]
    return v11.v;
end;
v0.GetGoal = function(v12) --[[ Line: 44 ]] --[[ Name: GetGoal ]]
    return v12.g;
end;
v0.Update = function(v13, v14) --[[ Line: 48 ]] --[[ Name: Update ]]
    -- upvalues: l_exp_0 (copy), l_sqrt_0 (copy), l_cos_0 (copy), l_sin_0 (copy)
    local l_d_0 = v13.d;
    local v16 = v13.f * 2 * 3.141592653589793;
    local l_g_0 = v13.g;
    local l_p_0 = v13.p;
    local l_v_0 = v13.v;
    local v20 = l_p_0 - l_g_0;
    local v21 = l_exp_0(-l_d_0 * v16 * v14);
    local v22 = nil;
    local v23 = nil;
    if l_d_0 == 1 then
        v22 = (v20 * (1 + v16 * v14) + l_v_0 * v14) * v21 + l_g_0;
        v23 = (l_v_0 * (1 - v16 * v14) - v20 * (v16 * v16 * v14)) * v21;
    elseif l_d_0 < 1 then
        local v24 = l_sqrt_0(1 - l_d_0 * l_d_0);
        local v25 = l_cos_0(v16 * v24 * v14);
        local v26 = l_sin_0(v16 * v24 * v14);
        local v27 = nil;
        if v24 > 1.0E-4 then
            v27 = v26 / v24;
        else
            local v28 = v14 * v16;
            v27 = v28 + (v28 * v28 * (v24 * v24) * (v24 * v24) / 20 - v24 * v24) * (v28 * v28 * v28) / 6;
        end;
        local v29 = nil;
        if v16 * v24 > 1.0E-4 then
            v29 = v26 / (v16 * v24);
        else
            local v30 = v16 * v24;
            v29 = v14 + (v14 * v14 * (v30 * v30) * (v30 * v30) / 20 - v30 * v30) * (v14 * v14 * v14) / 6;
        end;
        v22 = (v20 * (v25 + l_d_0 * v27) + l_v_0 * v29) * v21 + l_g_0;
        v23 = (l_v_0 * (v25 - v27 * l_d_0) - v20 * (v27 * v16)) * v21;
    else
        local v31 = l_sqrt_0(l_d_0 * l_d_0 - 1);
        local v32 = -v16 * (l_d_0 - v31);
        local v33 = -v16 * (l_d_0 + v31);
        local v34 = (l_v_0 - v20 * v32) / (2 * v16 * v31);
        local v35 = (v20 - v34) * l_exp_0(v32 * v14);
        local v36 = v34 * l_exp_0(v33 * v14);
        v22 = v35 + v36 + l_g_0;
        v23 = v35 * v32 + v36 * v33;
    end;
    v13.p = v22;
    v13.v = v23;
    return v22, v23;
end;
v0.StepTo = function(v37, v38, v39) --[[ Line: 130 ]] --[[ Name: StepTo ]]
    v37:SetGoal(v38);
    return v37:Update(v39);
end;
v0.SnapTo = function(v40, v41) --[[ Line: 136 ]] --[[ Name: SnapTo ]]
    if not v41 then
        v41 = v40.g;
    end;
    v40.g = v41;
    v40.p = v40.g;
    v40.v = v40.v * 0;
    return v40.p, v40.v;
end;
v0.Normalize = function(v42, v43) --[[ Line: 148 ]] --[[ Name: Normalize ]]
    if v43 then
        v42:Update(v43);
    end;
    local l_p_1 = v42.p;
    if typeof(l_p_1) ~= "number" then
        l_p_1 = l_p_1.Magnitude;
    end;
    if l_p_1 > 0 then
        v42.p = v42.p / l_p_1;
    end;
    return v42.p, v42.v;
end;
return v0;