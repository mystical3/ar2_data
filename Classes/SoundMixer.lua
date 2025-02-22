local v0 = {};
v0.__index = v0;
local _ = function(v1) --[[ Line: 16 ]] --[[ Name: getMaxWeight ]]
    local v2 = 0;
    for _, v4 in next, v1 do
        if v2 < v4.Weight then
            v2 = v4.Weight;
        end;
    end;
    return v2;
end;
local function v14(v6, v7, v8) --[[ Line: 28 ]] --[[ Name: processMix ]]
    local v9 = v6.Weight / v7;
    local v10 = v6.MaxVolume * v9;
    if v6.FadeStrength == 1 then
        v6.Sound.Volume = v10;
        return;
    else
        local v11 = math.min(v8, 0.2);
        while v11 >= 0.016666666666666666 do
            local l_Volume_0 = v6.Sound.Volume;
            local v13 = v10 - l_Volume_0;
            v6.Sound.Volume = l_Volume_0 + v13 * v6.FadeStrength;
            v11 = v11 - 0.016666666666666666;
        end;
        return;
    end;
end;
v0.new = function() --[[ Line: 53 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    return (setmetatable({
        Configs = {}, 
        WeightMax = 0, 
        Destroyed = false, 
        LastMix = os.clock()
    }, v0));
end;
v0.Destroy = function(v15) --[[ Line: 66 ]] --[[ Name: Destroy ]]
    if v15.Destroyed then
        return;
    else
        v15.Destroyed = true;
        for v16 = #v15.Configs, 1, -1 do
            local v17 = table.remove(v15.Configs, v16);
            if v17 then
                v17.Sound = nil;
            end;
        end;
        setmetatable(v15, nil);
        table.clear(v15);
        v15.Destroyed = true;
        return;
    end;
end;
v0.Mix = function(v18) --[[ Line: 87 ]] --[[ Name: Mix ]]
    -- upvalues: v14 (copy)
    local v19 = os.clock() - v18.LastMix;
    if v19 >= 0.006944444444444444 then
        v18.LastMix = os.clock();
        if v18.WeightMax > 0 then
            for _, v21 in next, v18.Configs do
                v14(v21, v18.WeightMax, v19);
            end;
        end;
    end;
end;
v0.Rebase = function(v22) --[[ Line: 106 ]] --[[ Name: Rebase ]]
    local l_Configs_0 = v22.Configs;
    local v24 = 0;
    for _, v26 in next, l_Configs_0 do
        if v24 < v26.Weight then
            v24 = v26.Weight;
        end;
    end;
    v22.WeightMax = v24;
    v22:Mix();
end;
v0.Add = function(v27, v28, v29, v30) --[[ Line: 112 ]] --[[ Name: Add ]]
    if v27.Destroyed then
        warn("Cannot mix sound, mixer is destroyed", v28.Name);
        print(debug.traceback());
        return;
    else
        table.insert(v27.Configs, {
            Sound = v28, 
            MaxVolume = v28.Volume, 
            OriginalVolume = v28.Volume, 
            Weight = v29 or 1, 
            FadeStrength = v30 or 1
        });
        v27:Rebase();
        return;
    end;
end;
v0.Remove = function(v31, v32) --[[ Line: 134 ]] --[[ Name: Remove ]]
    for v33 = #v31.Configs, 1, -1 do
        local v34 = v31.Configs[v33];
        if v34.Sound == v32 then
            table.remove(v31.Configs, v33);
            v34.Sound.Volume = v34.OriginalVolume;
            v34.Sound = nil;
            v31:Rebase();
            return;
        end;
    end;
end;
v0.SetVolume = function(v35, v36, v37) --[[ Line: 151 ]] --[[ Name: SetVolume ]]
    for _, v39 in next, v35.Configs do
        if v39.Sound == v36 then
            v39.MaxVolume = v37;
            v39.OriginalVolume = v37;
            v35:Rebase();
            return;
        end;
    end;
end;
v0.SetWeight = function(v40, v41, v42) --[[ Line: 164 ]] --[[ Name: SetWeight ]]
    for _, v44 in next, v40.Configs do
        if v44.Sound == v41 then
            v44.Weight = v42;
            v40:Rebase();
            return;
        end;
    end;
end;
v0.SetFadeStrength = function(v45, v46, v47) --[[ Line: 176 ]] --[[ Name: SetFadeStrength ]]
    for _, v49 in next, v45.Configs do
        if v49.Sound == v46 then
            v49.FadeStrength = v47;
            v45:Rebase();
            return;
        end;
    end;
end;
return v0;