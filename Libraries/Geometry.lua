local v0 = {};
local v1 = {
    Vector3.new(-1, -1, -1, 0), 
    Vector3.new(1, -1, -1, 0), 
    Vector3.new(-1, 1, -1, 0), 
    Vector3.new(1, 1, -1, 0), 
    Vector3.new(-1, -1, 1, 0), 
    Vector3.new(1, -1, 1, 0), 
    Vector3.new(-1, 1, 1, 0), 
    (Vector3.new(1, 1, 1, 0))
};
local function _(v2, v3) --[[ Line: 22 ]] --[[ Name: isClose ]]
    return math.abs(v2 - v3) < 1.0E-4;
end;
local function v12(v5, v6) --[[ Line: 26 ]] --[[ Name: modifyBoundingBox ]]
    -- upvalues: v1 (copy)
    if v5:IsA("BasePart") then
        local v7 = v5.Size / 2;
        local l_CFrame_0 = v5.CFrame;
        for _, v10 in next, v1 do
            local v11 = l_CFrame_0 * CFrame.new(v7 * v10).p;
            if v11.x > v6[1] then
                v6[1] = v11.x;
            end;
            if v11.x < v6[2] then
                v6[2] = v11.x;
            end;
            if v11.y > v6[3] then
                v6[3] = v11.y;
            end;
            if v11.y < v6[4] then
                v6[4] = v11.y;
            end;
            if v11.z > v6[5] then
                v6[5] = v11.z;
            end;
            if v11.z < v6[6] then
                v6[6] = v11.z;
            end;
        end;
    end;
end;
v0.getSphereSurfacePoint = function(v13, v14, v15) --[[ Line: 46 ]] --[[ Name: getSphereSurfacePoint ]]
    local v16 = v15 - v13.p;
    if v16.Magnitude > 0 then
        v16 = v16.unit;
    end;
    return v13 + v16 * v14, v16;
end;
v0.getBlockSurfacePoint = function(v17, v18, v19) --[[ Line: 58 ]] --[[ Name: getBlockSurfacePoint ]]
    local v20 = v17:PointToObjectSpace(v19);
    local v21 = v18 * 0.5;
    local v22 = Vector3.new(math.clamp(v20.X, -v21.X, v21.X), math.clamp(v20.Y, -v21.Y, v21.Y), (math.clamp(v20.Z, -v21.Z, v21.Z)));
    local v23 = Vector3.new(math.abs(math.abs(v22.X) - v21.X) < 1.0E-4 and math.sign(v22.X) or 0, math.abs(math.abs(v22.Y) - v21.Y) < 1.0E-4 and math.sign(v22.Y) or 0, math.abs(math.abs(v22.Z) - v21.Z) < 1.0E-4 and math.sign(v22.Z) or 0);
    if v23.Magnitude > 0 then
        v23 = v23.unit;
    end;
    return v17 * v22, v23;
end;
v0.getBoundingBox = function(v24, v25) --[[ Line: 81 ]] --[[ Name: getBoundingBox ]]
    local v26 = math.abs((Vector3.new(1, 0, 0, 0):Dot(v24:VectorToWorldSpace((Vector3.new(1, 0, 0, 0))))));
    local v27 = math.abs((Vector3.new(1, 0, 0, 0):Dot(v24:VectorToWorldSpace((Vector3.new(0, 1, 0, 0))))));
    local v28 = math.abs((Vector3.new(1, 0, 0, 0):Dot(v24:VectorToWorldSpace((Vector3.new(0, 0, 1, 0))))));
    local v29 = math.abs((Vector3.new(0, 1, 0, 0):Dot(v24:VectorToWorldSpace((Vector3.new(1, 0, 0, 0))))));
    local v30 = math.abs((Vector3.new(0, 1, 0, 0):Dot(v24:VectorToWorldSpace((Vector3.new(0, 1, 0, 0))))));
    local v31 = math.abs((Vector3.new(0, 1, 0, 0):Dot(v24:VectorToWorldSpace((Vector3.new(0, 0, 1, 0))))));
    local v32 = math.abs((Vector3.new(0, 0, 1, 0):Dot(v24:VectorToWorldSpace((Vector3.new(1, 0, 0, 0))))));
    local v33 = math.abs((Vector3.new(0, 0, 1, 0):Dot(v24:VectorToWorldSpace((Vector3.new(0, 1, 0, 0))))));
    local v34 = math.abs((Vector3.new(0, 0, 1, 0):Dot(v24:VectorToWorldSpace((Vector3.new(0, 0, 1, 0))))));
    return (Vector3.new(v26 * v25.X + v27 * v25.Y + v28 * v25.Z, v29 * v25.X + v30 * v25.Y + v31 * v25.Z, v32 * v25.X + v33 * v25.Y + v34 * v25.Z));
end;
v0.getModelBoundingBox = function(v35) --[[ Line: 101 ]] --[[ Name: getModelBoundingBox ]]
    -- upvalues: v12 (copy)
    local v36 = {
        -1e999, 
        1e999, 
        -1e999, 
        1e999, 
        -1e999, 
        1e999
    };
    for _, v38 in next, v35:GetDescendants() do
        if v38:IsA("BasePart") then
            v12(v38, v36);
        end;
    end;
    return Vector3.new(v36[1] - v36[2], v36[3] - v36[4], v36[5] - v36[6]), (Vector3.new((v36[1] + v36[2]) / 2, (v36[3] + v36[4]) / 2, (v36[5] + v36[6]) / 2));
end;
v0.getClampedClosestPointToRay = function(v39, v40) --[[ Line: 120 ]] --[[ Name: getClampedClosestPointToRay ]]
    local v41 = CFrame.new(v39.Origin, v39.Origin + v39.Direction);
    local l_magnitude_0 = v39.Direction.magnitude;
    local v43 = Vector3.new(0, 0, v41:PointToObjectSpace(v40).Z);
    if v43.Z > 0 then
        return v39.Origin;
    elseif -v43.Z < l_magnitude_0 then
        return v41 * v43;
    else
        return v39.Origin + v39.Direction;
    end;
end;
v0.getDistanceToBoxEdge = function(v44, v45, v46) --[[ Line: 141 ]] --[[ Name: getDistanceToBoxEdge ]]
    -- upvalues: v0 (copy)
    return (v44 - v0.getBlockSurfacePoint(v45, v46, v44)).Magnitude;
end;
return v0;