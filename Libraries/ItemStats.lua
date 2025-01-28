local v0 = game:GetService("RunService"):IsServer();
local v1 = nil;
v1 = if v0 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local _ = v1.require("Configs", "Globals");
local v3 = v1.require("Configs", "ItemData");
local v4 = {};
local v7 = setmetatable({}, {
    __index = function(_, _) --[[ Line: 19 ]] --[[ Name: __index ]]
        return 0;
    end
});
local v10 = setmetatable({}, {
    __index = function(_, _) --[[ Line: 25 ]] --[[ Name: __index ]]
        return 1e999;
    end
});
local v11 = {
    GunRateOfFire = {
        Min = 55, 
        Max = 1100
    }
};
local function _(v12, v13) --[[ Line: 36 ]] --[[ Name: logStat ]]
    -- upvalues: v11 (copy), v7 (copy), v10 (copy)
    local v14 = v11[v12];
    if v14 then
        v13 = math.clamp(v13, v14.Min, v14.Max);
    end;
    if v7[v12] < v13 then
        v7[v12] = v13;
        return;
    else
        if v13 < v10[v12] then
            v10[v12] = v13;
        end;
        return;
    end;
end;
for _, v17 in next, v3 do
    if v17.Type == "Firearm" then
        local l_FireConfig_0 = v17.FireConfig;
        local l_MuzzleVelocity_0 = l_FireConfig_0.MuzzleVelocity;
        local l_GunMuzzleVelocity_0 = v11.GunMuzzleVelocity;
        if l_GunMuzzleVelocity_0 then
            l_MuzzleVelocity_0 = math.clamp(l_MuzzleVelocity_0, l_GunMuzzleVelocity_0.Min, l_GunMuzzleVelocity_0.Max);
        end;
        if v7.GunMuzzleVelocity < l_MuzzleVelocity_0 then
            v7.GunMuzzleVelocity = l_MuzzleVelocity_0;
        elseif l_MuzzleVelocity_0 < v10.GunMuzzleVelocity then
            v10.GunMuzzleVelocity = l_MuzzleVelocity_0;
        end;
        l_MuzzleVelocity_0 = l_FireConfig_0.DamageFallOff.StartsAt;
        l_GunMuzzleVelocity_0 = v11.MaxEffectiveRange;
        if l_GunMuzzleVelocity_0 then
            l_MuzzleVelocity_0 = math.clamp(l_MuzzleVelocity_0, l_GunMuzzleVelocity_0.Min, l_GunMuzzleVelocity_0.Max);
        end;
        if v7.MaxEffectiveRange < l_MuzzleVelocity_0 then
            v7.MaxEffectiveRange = l_MuzzleVelocity_0;
        elseif l_MuzzleVelocity_0 < v10.MaxEffectiveRange then
            v10.MaxEffectiveRange = l_MuzzleVelocity_0;
        end;
        l_MuzzleVelocity_0 = l_FireConfig_0.DamageFallOff.LowestAt;
        l_GunMuzzleVelocity_0 = v11.MinEffectiveRange;
        if l_GunMuzzleVelocity_0 then
            l_MuzzleVelocity_0 = math.clamp(l_MuzzleVelocity_0, l_GunMuzzleVelocity_0.Min, l_GunMuzzleVelocity_0.Max);
        end;
        if v7.MinEffectiveRange < l_MuzzleVelocity_0 then
            v7.MinEffectiveRange = l_MuzzleVelocity_0;
        elseif l_MuzzleVelocity_0 < v10.MinEffectiveRange then
            v10.MinEffectiveRange = l_MuzzleVelocity_0;
        end;
        l_MuzzleVelocity_0 = l_FireConfig_0.FireRate;
        l_GunMuzzleVelocity_0 = v11.GunRateOfFire;
        if l_GunMuzzleVelocity_0 then
            l_MuzzleVelocity_0 = math.clamp(l_MuzzleVelocity_0, l_GunMuzzleVelocity_0.Min, l_GunMuzzleVelocity_0.Max);
        end;
        if v7.GunRateOfFire < l_MuzzleVelocity_0 then
            v7.GunRateOfFire = l_MuzzleVelocity_0;
        elseif l_MuzzleVelocity_0 < v10.GunRateOfFire then
            v10.GunRateOfFire = l_MuzzleVelocity_0;
        end;
        l_MuzzleVelocity_0 = v17.RecoilData.SpreadBase;
        l_GunMuzzleVelocity_0 = math.tan((math.rad(l_MuzzleVelocity_0 + v17.RecoilData.SpreadAddFPSZoom))) * 1000;
        local v21 = math.tan((math.rad(l_MuzzleVelocity_0 + v17.RecoilData.SpreadAddFPSHip))) * 1000;
        local l_l_GunMuzzleVelocity_0_0 = l_GunMuzzleVelocity_0;
        local l_GunZoomSpread_0 = v11.GunZoomSpread;
        if l_GunZoomSpread_0 then
            l_l_GunMuzzleVelocity_0_0 = math.clamp(l_l_GunMuzzleVelocity_0_0, l_GunZoomSpread_0.Min, l_GunZoomSpread_0.Max);
        end;
        if v7.GunZoomSpread < l_l_GunMuzzleVelocity_0_0 then
            v7.GunZoomSpread = l_l_GunMuzzleVelocity_0_0;
        elseif l_l_GunMuzzleVelocity_0_0 < v10.GunZoomSpread then
            v10.GunZoomSpread = l_l_GunMuzzleVelocity_0_0;
        end;
        l_l_GunMuzzleVelocity_0_0 = v21;
        l_GunZoomSpread_0 = v11.GunHipSpread;
        if l_GunZoomSpread_0 then
            l_l_GunMuzzleVelocity_0_0 = math.clamp(l_l_GunMuzzleVelocity_0_0, l_GunZoomSpread_0.Min, l_GunZoomSpread_0.Max);
        end;
        if v7.GunHipSpread < l_l_GunMuzzleVelocity_0_0 then
            v7.GunHipSpread = l_l_GunMuzzleVelocity_0_0;
        elseif l_l_GunMuzzleVelocity_0_0 < v10.GunHipSpread then
            v10.GunHipSpread = l_l_GunMuzzleVelocity_0_0;
        end;
        l_MuzzleVelocity_0 = v17.RecoilData.KickUpForce;
        l_GunMuzzleVelocity_0 = v17.RecoilData.ShiftForce;
        v21 = v17.RecoilData.SlideForce * 0.2;
        l_l_GunMuzzleVelocity_0_0 = v17.RecoilData.RaiseForce;
        local v24 = l_MuzzleVelocity_0 + l_GunMuzzleVelocity_0 + v21 + l_l_GunMuzzleVelocity_0_0;
        local l_RecoilStability_0 = v11.RecoilStability;
        if l_RecoilStability_0 then
            v24 = math.clamp(v24, l_RecoilStability_0.Min, l_RecoilStability_0.Max);
        end;
        if v7.RecoilStability < v24 then
            v7.RecoilStability = v24;
        elseif v24 < v10.RecoilStability then
            v10.RecoilStability = v24;
        end;
        l_MuzzleVelocity_0 = v17.Handling.StanceChange[1];
        l_GunMuzzleVelocity_0 = v17.Handling.IdleWobbles[1];
        v21 = v17.Handling.StatePose[1];
        l_l_GunMuzzleVelocity_0_0 = v17.Handling.CameraZoom[1];
        l_GunZoomSpread_0 = v17.Handling.AimSpeed[1];
        v24 = v21 + l_MuzzleVelocity_0 + l_GunMuzzleVelocity_0;
        l_RecoilStability_0 = l_l_GunMuzzleVelocity_0_0 + l_GunZoomSpread_0;
        local l_v24_0 = v24;
        local l_Handling_0 = v11.Handling;
        if l_Handling_0 then
            l_v24_0 = math.clamp(l_v24_0, l_Handling_0.Min, l_Handling_0.Max);
        end;
        if v7.Handling < l_v24_0 then
            v7.Handling = l_v24_0;
        elseif l_v24_0 < v10.Handling then
            v10.Handling = l_v24_0;
        end;
        l_v24_0 = l_RecoilStability_0;
        l_Handling_0 = v11.Aim;
        if l_Handling_0 then
            l_v24_0 = math.clamp(l_v24_0, l_Handling_0.Min, l_Handling_0.Max);
        end;
        if v7.Aim < l_v24_0 then
            v7.Aim = l_v24_0;
        elseif l_v24_0 < v10.Aim then
            v10.Aim = l_v24_0;
        end;
    elseif v17.Type == "Backpack" and v17.ContainerSize and not v17.TestItem then
        local v28, v29 = unpack(v17.ContainerSize);
        local v30 = v28 * v29;
        local l_Backpack_0 = v11.Backpack;
        if l_Backpack_0 then
            v30 = math.clamp(v30, l_Backpack_0.Min, l_Backpack_0.Max);
        end;
        if v7.Backpack < v30 then
            v7.Backpack = v30;
        elseif v30 < v10.Backpack then
            v10.Backpack = v30;
        end;
    end;
end;
v4.GetMax = function(_, v33) --[[ Line: 108 ]] --[[ Name: GetMax ]]
    -- upvalues: v7 (copy)
    return v7[v33];
end;
v4.GetMin = function(_, v35) --[[ Line: 112 ]] --[[ Name: GetMin ]]
    -- upvalues: v10 (copy)
    return v10[v35];
end;
v4.ScaleStat = function(_, v37, v38, v39, v40, v41) --[[ Line: 116 ]] --[[ Name: ScaleStat ]]
    -- upvalues: v7 (copy), v10 (copy)
    local v42 = v40 or v7[v38];
    local v43 = v41 or v10[v38];
    return v39 + (v37 - v43) / (v42 - v43) * (1 - v39 * 2);
end;
return v4;