local l_HttpService_0 = game:GetService("HttpService");
local l_JSONEncode_0 = l_HttpService_0.JSONEncode;
local l_JSONDecode_0 = l_HttpService_0.JSONDecode;
local v3 = {};
local v4 = {
    Vector2 = "RJSON_V2", 
    Vector3 = "RJSON_V3", 
    UDim = "RJSON_UD", 
    UDim2 = "RJSON_U2", 
    Color3 = "RJSON_C3", 
    BrickColor = "RJSON_BC", 
    EnumItem = "RJSON_EI", 
    CFrame = "RJSON_CF"
};
local v39 = {
    RJSON_V2 = function(v5) --[[ Line: 21 ]]
        return v5.X, v5.Y;
    end, 
    RJSON_V3 = function(v6) --[[ Line: 22 ]]
        return v6.X, v6.Y, v6.Z;
    end, 
    RJSON_UD = function(v7) --[[ Line: 23 ]]
        return v7.Scale, v7.Offset;
    end, 
    RJSON_U2 = function(v8) --[[ Line: 24 ]]
        return v8.X.Scale, v8.X.Offset, v8.Y.Scale, v8.Y.Offset;
    end, 
    RJSON_C3 = function(v9) --[[ Line: 25 ]]
        return v9.R, v9.G, v9.B;
    end, 
    RJSON_BC = function(v10) --[[ Line: 26 ]]
        return v10.Number;
    end, 
    RJSON_EI = function(v11) --[[ Line: 27 ]]
        return tostring(v11.EnumType), v11.Name;
    end, 
    RJSON_CF = function(v12) --[[ Line: 29 ]]
        local v13 = nil;
        local v14 = nil;
        local v15 = nil;
        local v16 = nil;
        local v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28 = v12:components();
        local v29 = v20 + v24 + v28;
        if v29 > 0 then
            local v30 = math.sqrt(1 + v29);
            local v31 = 0.5 / v30;
            v13 = (v27 - v25) * v31;
            v14 = (v22 - v26) * v31;
            v15 = (v23 - v21) * v31;
            v16 = v30 * 0.5;
        else
            local v32 = 0;
            if v20 < v24 then
                v32 = 1;
            end;
            if (v32 == 0 and v20 or v24) < v28 then
                v32 = 2;
            end;
            if v32 == 0 then
                local v33 = math.sqrt(v20 - v24 - v28 + 1);
                local v34 = 0.5 / v33;
                v13 = v33 * 0.5;
                v14 = (v23 + v21) * v34;
                v15 = (v26 + v22) * v34;
                v16 = (v27 - v25) * v34;
            elseif v32 == 1 then
                local v35 = math.sqrt(v24 - v28 - v20 + 1);
                local v36 = 0.5 / v35;
                v13 = (v21 + v23) * v36;
                v14 = v35 * 0.5;
                v15 = (v27 + v25) * v36;
                v16 = (v22 - v26) * v36;
            elseif v32 == 2 then
                local v37 = math.sqrt(v28 - v20 - v24 + 1);
                local v38 = 0.5 / v37;
                v13 = (v22 + v26) * v38;
                v14 = (v25 + v27) * v38;
                v15 = v37 * 0.5;
                v16 = (v23 - v21) * v38;
            end;
        end;
        return v17, v18, v19, v13, v14, v15, v16;
    end
};
local v42 = {
    RJSON_V3 = Vector2.new, 
    RJSON_V2 = Vector2.new, 
    RJSON_UD = UDim.new, 
    RJSON_U2 = UDim2.new, 
    RJSON_C3 = Color3.new, 
    RJSON_BC = BrickColor.new, 
    RJSON_EI = function(v40, v41) --[[ Line: 83 ]]
        return Enum[v40][v41];
    end, 
    RJSON_CF = function(...) --[[ Line: 87 ]]
        return CFrame.new(...);
    end
};
local function v43(v44) --[[ Line: 94 ]] --[[ Name: serialize ]]
    -- upvalues: v4 (copy), v39 (copy), v43 (copy)
    local v45 = {};
    for v46, v47 in next, v44 do
        if type(v47) == "userdata" then
            if v4[typeof(v47)] then
                local v48 = v4[typeof(v47)];
                local v49 = {
                    v39[v48](v47)
                };
                v45[v46] = v48 .. table.concat(v49, ",");
            end;
        elseif type(v47) == "table" then
            v45[v46] = v43(v47);
        elseif type(v47) ~= "function" then
            v45[v46] = v47;
        end;
    end;
    return v45;
end;
local function v50(v51) --[[ Line: 115 ]] --[[ Name: deserialize ]]
    -- upvalues: v42 (copy), v50 (copy)
    local v52 = {};
    for v53, v54 in next, v51 do
        if type(v54) == "string" then
            for v55, v56 in next, v42 do
                if v54:match("^" .. v55) then
                    local v57 = v54:sub(#v55 + 1);
                    local v58 = {};
                    for v59 in v57:gmatch("([^,]+)") do
                        table.insert(v58, tonumber(v59) or v59);
                    end;
                    v54 = v56(unpack(v58));
                    break;
                end;
            end;
            v52[v53] = v54;
        elseif type(v54) == "table" then
            v52[v53] = v50(v54);
        else
            v52[v53] = v54;
        end;
    end;
    return v52;
end;
v3.Encode = function(_, v61) --[[ Line: 148 ]] --[[ Name: Encode ]]
    -- upvalues: v43 (copy), l_JSONEncode_0 (copy), l_HttpService_0 (copy)
    local v62 = v43(v61);
    return (l_JSONEncode_0(l_HttpService_0, v62));
end;
v3.Decode = function(_, v64) --[[ Line: 155 ]] --[[ Name: Decode ]]
    -- upvalues: l_JSONDecode_0 (copy), l_HttpService_0 (copy), v50 (copy)
    local v65 = l_JSONDecode_0(l_HttpService_0, v64);
    return (v50(v65));
end;
return v3;