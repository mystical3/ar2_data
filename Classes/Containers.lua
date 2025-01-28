local v0 = require(game:GetService("ReplicatedFirst").Framework);
local _ = v0.require("Libraries", "Network");
local v2 = v0.require("Classes", "Signals");
local v3 = v0.require("Classes", "Maids");
local v4 = {};
v4.__index = v4;
local function v8(v5) --[[ Line: 15 ]] --[[ Name: makeGrid ]]
    local v6 = {};
    for v7 = 1, v5[1] do
        v6[v7] = {};
    end;
    return v6;
end;
local function v19(v9, v10, v11, v12) --[[ Line: 25 ]] --[[ Name: findSpace ]]
    for v13 = 1, v10[2] do
        if v13 + v11[2] - 1 <= v10[2] then
            for v14 = 1, v10[1] do
                if v14 + v11[1] - 1 <= v10[1] then
                    local v15 = false;
                    for v16 = v14, v14 + v11[1] - 1 do
                        for v17 = v13, v13 + v11[2] - 1 do
                            local v18 = v9[v16][v17];
                            if v18 and v18 ~= v12 then
                                v15 = true;
                                break;
                            end;
                        end;
                        if v15 then
                            break;
                        end;
                    end;
                    if not v15 then
                        return true, {
                            v14, 
                            v13
                        };
                    end;
                end;
            end;
        end;
    end;
    return false, {
        0, 
        0
    };
end;
local function v30(v20, v21, v22, v23, v24) --[[ Line: 61 ]] --[[ Name: gridHasSpace ]]
    local v25 = true;
    if v22[1] + v23[1] - 1 <= v21[1] then
        v25 = v22[2] + v23[2] - 1 > v21[2];
    end;
    local v26 = true;
    if v22[1] >= 1 then
        v26 = v22[2] < 1;
    end;
    if not v26 and not v25 then
        for v27 = v22[1], v22[1] + v23[1] - 1 do
            for v28 = v22[2], v22[2] + v23[2] - 1 do
                local v29 = v20[v27][v28];
                if v24 and v29 and v29 == v24 then
                    v29 = nil;
                end;
                if v29 then
                    return false, {
                        0, 
                        0
                    };
                end;
            end;
        end;
    elseif v26 or v25 then
        return false, {
            0, 
            0
        };
    end;
    return true, v22;
end;
v4.new = function(v31, v32, v33, v34, v35) --[[ Line: 89 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), v8 (copy), v2 (copy), v4 (copy)
    local v36 = {
        ClassName = "Container", 
        Parent = v35, 
        Type = v32, 
        Name = v33, 
        DisplayName = v33, 
        Id = v31, 
        Maid = v3.new(), 
        IsCarried = false, 
        Occupants = {}, 
        Grid = v8(v34), 
        Size = v34
    };
    v36.OccupantAdded = v36.Maid:Give(v2.new());
    v36.OccupantRemoved = v36.Maid:Give(v2.new());
    v36.OccupantMoved = v36.Maid:Give(v2.new());
    v36.GridRebuilt = v36.Maid:Give(v2.new());
    return (setmetatable(v36, v4));
end;
v4.Destroy = function(v37) --[[ Line: 117 ]] --[[ Name: Destroy ]]
    if v37.Destroyed then
        return;
    else
        v37.Destroyed = true;
        for _, v39 in next, v37.Occupants do
            v39:Destroy();
        end;
        if v37.Maid then
            v37.Maid:Destroy();
            v37.Maid = nil;
        end;
        setmetatable(v37, nil);
        table.clear(v37);
        v37.Destroyed = true;
        return;
    end;
end;
v4.Find = function(v40, v41) --[[ Line: 139 ]] --[[ Name: Find ]]
    local l_v41_0 = v41;
    if type(l_v41_0) == "table" then
        l_v41_0 = v41.Id;
    end;
    if v40.Occupants[l_v41_0] then
        return v40.Occupants[l_v41_0], l_v41_0;
    else
        return nil, "";
    end;
end;
v4.FindFromPosition = function(v43, v44) --[[ Line: 153 ]] --[[ Name: FindFromPosition ]]
    local v45, v46 = unpack(v44);
    local v47 = v43.Grid[v45] and v43.Grid[v45][v46];
    if v47 then
        return v43:Find(v47);
    else
        return nil;
    end;
end;
v4.HasSpace = function(v48, v49, v50, v51) --[[ Line: 164 ]] --[[ Name: HasSpace ]]
    -- upvalues: v30 (copy), v19 (copy)
    v51 = if v51 and v51.Id then v51.Id else nil;
    if v50 then
        return v30(v48.Grid, v48.Size, v50, v49, v51);
    else
        return v19(v48.Grid, v48.Size, v49, v51);
    end;
end;
v4.Insert = function(v52, v53, v54) --[[ Line: 178 ]] --[[ Name: Insert ]]
    -- upvalues: v30 (copy), v19 (copy)
    local v55 = false;
    local v56 = {
        0, 
        0
    };
    if v54 then
        local v57, v58 = v30(v52.Grid, v52.Size, v54, v53.GridSize);
        v55 = v57;
        v56 = v58;
    else
        local v59, v60 = v19(v52.Grid, v52.Size, v53.GridSize, v53.Id);
        v55 = v59;
        v56 = v60;
    end;
    if v55 then
        for v61 = v56[1], v56[1] + v53.GridSize[1] - 1 do
            for v62 = v56[2], v56[2] + v53.GridSize[2] - 1 do
                if v52.Grid[v61] then
                    v52.Grid[v61][v62] = v53.Id;
                end;
            end;
        end;
        v53.Parent = v52;
        v53.GridPosition = v56;
        v52.Occupants[v53.Id] = v53;
        v52.OccupantAdded:Fire(v53);
        return true;
    else
        return false;
    end;
end;
v4.Remove = function(v63, v64) --[[ Line: 209 ]] --[[ Name: Remove ]]
    local v65, v66 = v63:Find(v64);
    if v65 and v66 then
        local v67 = {};
        for v68, v69 in next, v63.Grid do
            for v70, v71 in next, v69 do
                if v71 == v65.Id then
                    table.insert(v67, {
                        v68, 
                        v70
                    });
                end;
            end;
        end;
        for _, v73 in next, v67 do
            local v74, v75 = unpack(v73);
            if v63.Grid[v74] then
                v63.Grid[v74][v75] = nil;
            end;
        end;
        v63.Occupants[v66] = nil;
        v63.OccupantRemoved:Fire(v65);
        return true, v65;
    else
        return false;
    end;
end;
v4.Move = function(_, _, _) --[[ Line: 240 ]] --[[ Name: Move ]]
    return true;
end;
v4.Sort = function(v79) --[[ Line: 244 ]] --[[ Name: Sort ]]
    -- upvalues: v8 (copy), v19 (copy)
    local v80 = {};
    for _, v82 in next, v79.Occupants do
        if v82.Visible then
            table.insert(v80, v82);
        end;
    end;
    table.sort(v80, function(v83, v84) --[[ Line: 253 ]]
        local v85 = v83.GridSize[1] * v83.GridSize[2];
        local v86 = v84.GridSize[1] * v84.GridSize[2];
        if v85 == v86 then
            return v83.DisplayName < v84.DisplayName;
        else
            return v86 < v85;
        end;
    end);
    local v87 = v8(v79.Size);
    for _, v89 in next, v80 do
        local v90, v91 = v19(v87, v79.Size, v89.GridSize, v89.Id);
        if v90 then
            for v92 = v91[1], v91[1] + v89.GridSize[1] - 1 do
                for v93 = v91[2], v91[2] + v89.GridSize[2] - 1 do
                    if v87[v92] then
                        v87[v92][v93] = v89.Id;
                    end;
                end;
            end;
            v89.GridPosition = v91;
        else
            v89.Visible = false;
        end;
    end;
    v79.Grid = v87;
    v79.GridRebuilt:Fire();
end;
v4.RebuildGrid = function(v94) --[[ Line: 288 ]] --[[ Name: RebuildGrid ]]
    -- upvalues: v8 (copy)
    v94.Grid = v8(v94.Size);
    for _, v96 in next, v94.Occupants do
        for v97 = v96.GridPosition[1], v96.GridPosition[1] + v96.GridSize[1] - 1 do
            for v98 = v96.GridPosition[2], v96.GridPosition[2] + v96.GridSize[2] - 1 do
                if v94.Grid[v97] then
                    v94.Grid[v97][v98] = v96.Id;
                end;
            end;
        end;
        v96.Parent = v94;
    end;
    v94.GridRebuilt:Fire();
end;
v4.Count = function(v99) --[[ Line: 306 ]] --[[ Name: Count ]]
    local v100 = 0;
    for _, _ in next, v99.Occupants do
        v100 = v100 + 1;
    end;
    return v100;
end;
v4.IsEmpty = function(v103) --[[ Line: 316 ]] --[[ Name: IsEmpty ]]
    if next(v103.Occupants) then
        return false;
    else
        return true;
    end;
end;
return v4;