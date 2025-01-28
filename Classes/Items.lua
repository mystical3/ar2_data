local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "ItemData");
local v2 = v0.require("Libraries", "Resources");
local v3 = v0.require("Classes", "Signals");
local v4 = v0.require("Classes", "Maids");
local v5 = v2:Find("ReplicatedStorage.Client.Abstracts.ItemInitializers");
local v6 = {};
local v7 = {
    Parent = true, 
    Id = true, 
    Changed = true, 
    Maid = true, 
    Destroyed = true, 
    Container = true, 
    NodeObject = true, 
    EquipSlot = true, 
    Equipped = true, 
    RecoilData = true, 
    PoseData = true, 
    LastShot = true
};
local function v8(v9) --[[ Line: 35 ]] --[[ Name: copy ]]
    -- upvalues: v8 (copy)
    if type(v9) == "table" then
        local v10 = {};
        for v11, v12 in next, v9 do
            v10[v11] = type(v12) == "table" and v8(v12) or v12;
        end;
        return;
    elseif typeof(v9) == "Instance" then
        return v9:Clone();
    else
        return v9;
    end;
end;
local function _(v13, v14, v15) --[[ Line: 49 ]] --[[ Name: initalizeItem ]]
    -- upvalues: v5 (copy)
    local l_v5_FirstChild_0 = v5:FindFirstChild(v14.Type);
    if l_v5_FirstChild_0 then
        require(l_v5_FirstChild_0)(v13, v14, v15);
        if v14.CanTakeCosmeticSkins then
            v13.SkinId = v13.SkinId or "";
        end;
    end;
end;
local function v18(v19, v20) --[[ Line: 61 ]] --[[ Name: getProps ]]
    -- upvalues: v1 (copy), v5 (copy), v7 (copy), v18 (copy), v8 (copy)
    local v21 = v1[v19.Name];
    local v22 = {};
    local v23 = {
        Name = v19.Name, 
        ClassName = v19.ClassName, 
        Id = v19.Id, 
        GridPosition = v19.GridPosition, 
        GridSize = v19.GridSize, 
        Rotated = v19.Rotated
    };
    local l_v5_FirstChild_1 = v5:FindFirstChild(v21.Type);
    if l_v5_FirstChild_1 then
        require(l_v5_FirstChild_1)(v23, v21, false);
        if v21.CanTakeCosmeticSkins then
            v23.SkinId = v23.SkinId or "";
        end;
    end;
    for v25 in next, v23 do
        local v26 = v19[v25];
        if not v7[v25] then
            if v25 == "Attachments" and type(v26) == "table" then
                local v27 = {};
                for v28, v29 in next, v26 do
                    v27[v28] = v18(v29, true);
                end;
                v22[v25] = v27;
            elseif typeof(v26) ~= "function" then
                v22[v25] = v8(v26);
            end;
        end;
    end;
    if not v20 then

    end;
    return v22;
end;
v6.new = function(v30, v31, v32) --[[ Line: 104 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy), v4 (copy), v8 (copy), v3 (copy), v6 (copy), v5 (copy)
    if not v1[v30] then
        return nil;
    else
        local v33 = v1[v30];
        local v34 = {
            Parent = v32, 
            ClassName = "Item", 
            Name = v30, 
            Id = v31, 
            Visible = "xDDD!!", 
            Maid = v4.new(), 
            GridPosition = {
                1, 
                1
            }, 
            GridSize = v8(v33.GridSize), 
            Rotated = false, 
            Private = {}, 
            ChangedSignals = {}
        };
        v34.Changed = v34.Maid:Give(v3.new());
        local v41 = setmetatable({
            __item = v34
        }, {
            __index = function(_, v36) --[[ Line: 130 ]] --[[ Name: __index ]]
                -- upvalues: v34 (copy), v33 (copy), v6 (ref)
                if v34[v36] ~= nil then
                    return v34[v36];
                elseif v33[v36] ~= nil then
                    return v33[v36];
                else
                    return v6[v36];
                end;
            end, 
            __newindex = function(v37, v38, v39) --[[ Line: 142 ]] --[[ Name: __newindex ]]
                -- upvalues: v34 (copy)
                local v40 = v34[v38] ~= v39;
                rawset(v34, v38, v39);
                rawset(v37, v38, nil);
                if v40 then
                    if v34.Changed then
                        v34.Changed:Fire(v38);
                    end;
                    if v34.ChangedSignals and v34.ChangedSignals[v38] then
                        v34.ChangedSignals[v38]:Fire(v39);
                    end;
                end;
            end
        });
        local l_v5_FirstChild_2 = v5:FindFirstChild(v33.Type);
        if l_v5_FirstChild_2 then
            require(l_v5_FirstChild_2)(v41, v33, true);
            if v33.CanTakeCosmeticSkins then
                v41.SkinId = v41.SkinId or "";
            end;
        end;
        return v41;
    end;
end;
v6.Destroy = function(v43) --[[ Line: 168 ]] --[[ Name: Destroy ]]
    if v43.Destroyed then
        return;
    else
        rawset(v43, "Destroyed", true);
        local l___item_0 = v43.__item;
        setmetatable(v43, nil);
        table.clear(v43);
        if l___item_0 then
            if l___item_0.Maid then
                l___item_0.Maid:Destroy();
            end;
            setmetatable(l___item_0, nil);
            table.clear(l___item_0);
        end;
        v43.Destroyed = true;
        return;
    end;
end;
v6.IsDestroyed = function(v45) --[[ Line: 198 ]] --[[ Name: IsDestroyed ]]
    return v45.Destroyed == true;
end;
v6.GetProperties = function(v46, v47) --[[ Line: 202 ]] --[[ Name: GetProperties ]]
    -- upvalues: v18 (copy)
    return (v18(v46, v47));
end;
v6.FireChanged = function(v48, v49, ...) --[[ Line: 206 ]] --[[ Name: FireChanged ]]
    v48.Changed:Fire(v49);
    if v48.ChangedSignals[v49] then
        v48.ChangedSignals[v49]:Fire(...);
    end;
end;
v6.GetPropertyChangedSignal = function(v50, v51) --[[ Line: 214 ]] --[[ Name: GetPropertyChangedSignal ]]
    -- upvalues: v3 (copy)
    if not v50.ChangedSignals[v51] then
        v50.ChangedSignals[v51] = v50.Maid:Give(v3.new());
    end;
    return v50.ChangedSignals[v51];
end;
return v6;