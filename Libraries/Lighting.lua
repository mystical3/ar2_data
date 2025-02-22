local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Libraries", "Resources");
local v4 = v0.require("Libraries", "UserSettings");
local v5 = v0.require("Classes", "Springs");
local v6 = v0.require("Classes", "Steppers");
local l_Lighting_0 = game:GetService("Lighting");
local l_UserInputService_0 = game:GetService("UserInputService");
local v9 = v3:Find("ReplicatedStorage.Lighting");
local v10 = v5.new(0, 7, 1);
local v11 = "Default";
local v12 = {};
local v13 = {};
local v14 = {};
local v15 = {};
local v16 = nil;
local v17 = nil;
local v18 = {
    Lighting = l_Lighting_0, 
    ColorCorrection = l_Lighting_0:WaitForChild("ColorCorrection"), 
    SunRays = l_Lighting_0:WaitForChild("SunRays"), 
    Bloom = l_Lighting_0:WaitForChild("Bloom"), 
    Atmosphere = l_Lighting_0:WaitForChild("Atmosphere"), 
    Clouds = workspace:WaitForChild("Terrain"):WaitForChild("Clouds")
};
local v19 = v2:Fetch("Get Lighting State");
for v20, v21 in next, v18 do
    v15[v20] = v21.Parent;
end;
local function _(v22, v23, v24, v25, v26) --[[ Line: 59 ]] --[[ Name: remap ]]
    return v25 + (v26 - v25) * ((v22 - v23) / (v24 - v23));
end;
local function v32() --[[ Line: 63 ]] --[[ Name: getTimeNow ]]
    -- upvalues: v19 (ref)
    local v28 = workspace:GetServerTimeNow() - v19.BaseTime;
    local v29 = 86400 / v19.CycleLength;
    local v30 = v28 / 60 * v29;
    local v31 = v19.StartTime + v30;
    return v31 % 1440, v31;
end;
local function _(v33, v34, v35) --[[ Line: 72 ]] --[[ Name: fadeTime ]]
    if v35 < v33 and v35 < v34 then
        v35 = v35 + 1440;
    end;
    local v36 = (v33 - v34) / (v35 - v34);
    return v36, (math.clamp(v36, 0, 1));
end;
local function v45() --[[ Line: 83 ]] --[[ Name: loadConfigs ]]
    -- upvalues: v9 (copy), v14 (copy), v13 (copy)
    local l_Cycle_0 = v9:WaitForChild("Cycle");
    local l_Configs_0 = v9:WaitForChild("Configs");
    for _, v41 in next, l_Cycle_0:GetChildren() do
        v14[v41.Name] = require(v41);
    end;
    for _, v43 in next, l_Configs_0:GetChildren() do
        local v44 = require(v43.Cycle);
        v44.Sky = v43.Sky;
        v44.Sky.Name = v43.Name;
        v13[v43.Name] = v44;
    end;
end;
local function _(v46, v47, v48, v49) --[[ Line: 100 ]] --[[ Name: circularLerp ]]
    if v47 < v46 then
        local l_v47_0 = v47;
        v47 = v46;
        v46 = l_v47_0;
        v48 = 1 - v48;
    end;
    local v51 = v47 - v46;
    if v49 * 0.5 <= v51 then
        v46 = v46 + v49;
        return (v46 + v48 * (v47 - v46)) % v49;
    else
        return v46 + v48 * v51;
    end;
end;
local function v69(v53, v54, v55) --[[ Line: 117 ]] --[[ Name: lerp ]]
    if typeof(v53) == "Color3" then
        local v56, v57, v58 = v53:ToHSV();
        local v59, v60, v61 = v54:ToHSV();
        local l_fromHSV_0 = Color3.fromHSV;
        local l_v56_0 = v56;
        local l_v59_0 = v59;
        local l_v55_0 = v55;
        if l_v59_0 < l_v56_0 then
            local l_l_v59_0_0 = l_v59_0;
            l_v59_0 = l_v56_0;
            l_v56_0 = l_l_v59_0_0;
            l_v55_0 = 1 - l_v55_0;
        end;
        local v67 = l_v59_0 - l_v56_0;
        local v68;
        if v67 >= 0.5 then
            l_v56_0 = l_v56_0 + 1;
            v68 = (l_v56_0 + l_v55_0 * (l_v59_0 - l_v56_0)) % 1;
        else
            v68 = l_v56_0 + l_v55_0 * v67;
        end;
        return l_fromHSV_0(v68, v57 + (v60 - v57) * v55, v58 + (v61 - v58) * v55);
    else
        return v53 + (v54 - v53) * v55;
    end;
end;
local function v75() --[[ Line: 132 ]] --[[ Name: findCharacterLightingMods ]]
    -- upvalues: v0 (copy)
    local l_Players_0 = v0.Classes.Players;
    if l_Players_0 then
        local v71 = l_Players_0.get();
        if v71 and v71.Character and not v71.Character.Dead then
            local l_Character_0 = v71.Character;
            if l_Character_0:HasPerk("Flashlight") and l_Character_0.LightEnabled ~= "" then
                local _, v74 = l_Character_0:HasPerk("Flashlight", true);
                if v74 and v74.LightingMods then
                    return v74.LightingMods;
                end;
            end;
        end;
    end;
end;
local function v85(v76, v77) --[[ Line: 152 ]] --[[ Name: getCurrentKeyframe ]]
    local v78 = 1e999;
    local v79 = nil;
    local v80 = nil;
    for v81, v82 in next, v77.Cycle do
        local l_Time_0 = v82.Time;
        if l_Time_0 <= v76 then
            local v84 = v76 - l_Time_0;
            if v84 < v78 then
                v78 = v84;
                v79 = v82;
                v80 = v81;
            end;
        end;
    end;
    if not v79 then
        v80 = #v77.Cycle;
        v79 = v77.Cycle[v80];
    end;
    return v79, v80;
end;
local function v115(v86, v87) --[[ Line: 181 ]] --[[ Name: getProfileFromMode ]]
    -- upvalues: v13 (copy), v18 (copy), v85 (copy), v69 (copy)
    local v88 = v13[v86];
    local v89 = {};
    if not v88 then
        v88 = v13.Default;
        warn("Invalid config:", v86);
    end;
    if v88.Type == "Static" then
        local _, v91 = next(v88.Cycle);
        if v91 then
            v89.Time = v91.Time;
            v89.IsStatic = true;
            for v92, v93 in next, v91 do
                if v18[v92] then
                    v89[v92] = {};
                    for v94, v95 in next, v93 do
                        v89[v92][v94] = v95;
                    end;
                end;
            end;
        end;
    else
        local v96, v97 = v85(v87, v88);
        local v98 = v88.Cycle[v97 + 1] or v88.Cycle[1];
        local l_Time_1 = v96.Time;
        local l_Time_2 = v98.Time;
        local l_v87_0 = v87;
        local v102 = 0;
        if math.abs(l_Time_1 - l_Time_2) < 0.001 then
            v102 = 1;
        else
            if l_Time_2 < l_Time_1 then
                l_Time_2 = l_Time_2 + 1440;
            end;
            if l_v87_0 < l_Time_1 then
                l_v87_0 = l_v87_0 + 1440;
            end;
            v102 = (l_v87_0 - l_Time_1) / (l_Time_2 - l_Time_1);
        end;
        v89.IsStatic = false;
        v89.Time = v87;
        for v103, v104 in next, v96 do
            if v18[v103] then
                v89[v103] = {};
                for v105, v106 in next, v104 do
                    local v107 = v98[v103][v105] or v106;
                    if v105 == "GeographicLatitude" then
                        local v108 = v89[v103];
                        local l_v106_0 = v106;
                        local l_v107_0 = v107;
                        local l_v102_0 = v102;
                        if l_v107_0 < l_v106_0 then
                            local l_l_v107_0_0 = l_v107_0;
                            l_v107_0 = l_v106_0;
                            l_v106_0 = l_l_v107_0_0;
                            l_v102_0 = 1 - l_v102_0;
                        end;
                        local v113 = l_v107_0 - l_v106_0;
                        local v114;
                        if v113 >= 180 then
                            l_v106_0 = l_v106_0 + 360;
                            v114 = (l_v106_0 + l_v102_0 * (l_v107_0 - l_v106_0)) % 360;
                        else
                            v114 = l_v106_0 + l_v102_0 * v113;
                        end;
                        v108[v105] = v114;
                    else
                        v89[v103][v105] = v69(v106, v107, v102);
                    end;
                end;
            end;
        end;
    end;
    return v89, v88.Sky;
end;
local function v139(v116, v117, v118) --[[ Line: 262 ]] --[[ Name: blendProfiles ]]
    -- upvalues: v18 (copy), v69 (copy)
    local v119 = {};
    for v120, v121 in next, v116 do
        local v122 = v117[v120];
        if v120 == "Time" then
            local l_v121_0 = v121;
            local l_v122_0 = v122;
            local l_v118_0 = v118;
            if l_v122_0 < l_v121_0 then
                local l_l_v122_0_0 = l_v122_0;
                l_v122_0 = l_v121_0;
                l_v121_0 = l_l_v122_0_0;
                l_v118_0 = 1 - l_v118_0;
            end;
            local v127 = l_v122_0 - l_v121_0;
            local v128;
            if v127 >= 720 then
                l_v121_0 = l_v121_0 + 1440;
                v128 = (l_v121_0 + l_v118_0 * (l_v122_0 - l_v121_0)) % 1440;
            else
                v128 = l_v121_0 + l_v118_0 * v127;
            end;
            v119.Time = v128;
        elseif v18[v120] then
            v119[v120] = {};
            for v129, v130 in next, v121 do
                if v129 == "GeographicLatitude" then
                    local v131 = v122[v129] or v130;
                    local v132 = v119[v120];
                    local l_v130_0 = v130;
                    local l_v131_0 = v131;
                    local l_v118_1 = v118;
                    if l_v131_0 < l_v130_0 then
                        local l_l_v131_0_0 = l_v131_0;
                        l_v131_0 = l_v130_0;
                        l_v130_0 = l_l_v131_0_0;
                        l_v118_1 = 1 - l_v118_1;
                    end;
                    local v137 = l_v131_0 - l_v130_0;
                    local v138;
                    if v137 >= 180 then
                        l_v130_0 = l_v130_0 + 360;
                        v138 = (l_v130_0 + l_v118_1 * (l_v131_0 - l_v130_0)) % 360;
                    else
                        v138 = l_v130_0 + l_v118_1 * v137;
                    end;
                    v132[v129] = v138;
                else
                    v119[v120][v129] = v69(v130, v122[v129], v118);
                end;
            end;
        end;
    end;
    v119.IsStatic = v116.IsStatic or v117.Static;
    return v119;
end;
local function v156(v140, v141, v142, v143) --[[ Line: 291 ]] --[[ Name: modLighting ]]
    -- upvalues: v12 (copy), v10 (copy), v69 (copy)
    local l_v12_NightFader_0 = v12:GetNightFader();
    if v141 then
        v10:SetGoal(1);
    else
        v10:SetGoal(0);
    end;
    local v145 = math.clamp(v10:Update(v143), 0, 1);
    if v141 then
        for v146, v147 in next, v141 do
            local v148 = v140[v146];
            if v148 then
                for v149, v150 in next, v147 do
                    local v151 = v148[v149];
                    local v155 = v150(v151, v142, function(v152, v153) --[[ Line: 311 ]]
                        -- upvalues: l_v12_NightFader_0 (copy)
                        local l_l_v12_NightFader_0_0 = l_v12_NightFader_0;
                        return v152 + (v153 - v152) * ((l_l_v12_NightFader_0_0 - 0) / 1);
                    end) or v151;
                    v148[v149] = v69(v151, v155, v145);
                end;
            end;
        end;
    end;
    return v140;
end;
v12.SetMode = function(_, v158) --[[ Line: 330 ]] --[[ Name: SetMode ]]
    -- upvalues: v11 (ref), v16 (ref)
    v11 = v158;
    v16:ForceStep();
end;
v12.Reset = function(v159) --[[ Line: 335 ]] --[[ Name: Reset ]]
    v159:SetMode(nil);
end;
v12.GetNightFader = function(_) --[[ Line: 339 ]] --[[ Name: GetNightFader ]]
    -- upvalues: v19 (ref)
    local v161 = workspace:GetServerTimeNow() - v19.BaseTime;
    local v162 = 86400 / v19.CycleLength;
    local v163 = v161 / 60 * v162;
    local v164 = (v19.StartTime + v163) % 1440;
    if v164 >= 1017.983 and v164 <= 1067.983 then
        return 0 + 1 * ((v164 - 1017.983) / 50);
    elseif v164 >= 361.8 and v164 <= 411.8 then
        return 1 + -1 * ((v164 - 361.8) / 50);
    elseif v164 < 361.8 or v164 > 1067.983 then
        return 1;
    else
        return 0;
    end;
end;
v12.GetState = function(_) --[[ Line: 363 ]] --[[ Name: GetState ]]
    -- upvalues: v19 (ref), v14 (copy), v11 (ref), v13 (copy)
    local v166 = v14[v19.Mode];
    return v166, v13[v11 or v166.LightingConfig];
end;
v12.GetTime = function(_) --[[ Line: 373 ]] --[[ Name: GetTime ]]
    -- upvalues: v32 (copy)
    return v32();
end;
v45();
local v168 = nil;
v16 = v6.new(0, "Heartbeat", function(_, v170) --[[ Line: 383 ]]
    -- upvalues: v19 (ref), v11 (ref), v115 (copy), v14 (copy), v139 (copy), v75 (copy), v156 (copy), l_Lighting_0 (copy), v18 (copy), v168 (ref), v17 (ref), v15 (copy)
    local v171 = workspace:GetServerTimeNow() - v19.BaseTime;
    local v172 = 86400 / v19.CycleLength;
    local v173 = v171 / 60 * v172;
    local v174 = v19.StartTime + v173;
    local v175 = v174 % 1440;
    local l_v174_0 = v174;
    v171 = nil;
    v172 = nil;
    if v11 then
        v173, v174 = v115(v11, v175);
        v171 = v173;
        v172 = v174;
    else
        v173 = v14[v19.Mode].DistanceBlends;
        v174 = v14[v19.Mode].LightingConfig;
        local v177, v178 = v115(v174, v175);
        v171 = v177;
        v172 = v178;
        if v19.Into then
            v177 = v14[v19.Into.Mode].LightingConfig;
            local v179;
            v178, v179 = v115(v177, v175);
            local l_Start_0 = v19.Into.Start;
            local l_Finish_0 = v19.Into.Finish;
            if l_Finish_0 < v175 and l_Finish_0 < l_Start_0 then
                l_Finish_0 = l_Finish_0 + 1440;
            end;
            local v182 = (v175 - l_Start_0) / (l_Finish_0 - l_Start_0);
            local _ = math.clamp(v182, 0, 1);
            v171 = v139(v171, v178, v182);
            v172 = v179;
        end;
        if v173 then
            v177 = workspace.CurrentCamera.CFrame.Position;
            for v184 = 1, #v173 do
                local v185 = v173[v184];
                local l_Magnitude_0 = (v177 - v185.Origin).Magnitude;
                local l_FadeStartsAt_0 = v185.FadeStartsAt;
                local l_FullyBlendedAt_0 = v185.FullyBlendedAt;
                local v189 = 0 + 1 * ((l_Magnitude_0 - l_FadeStartsAt_0) / (l_FullyBlendedAt_0 - l_FadeStartsAt_0));
                if v189 > 0 then
                    l_FadeStartsAt_0 = v115(v185.Config, v175);
                    v171 = v139(v171, l_FadeStartsAt_0, (math.clamp(v189, 0, 1)));
                end;
            end;
        end;
        v177 = v75();
        if v177 then
            v171 = v156(v171, v177, l_v174_0, v170);
        end;
    end;
    if v171 then
        if v171.IsStatic and v171.Time then
            l_Lighting_0:SetMinutesAfterMidnight(v171.Time);
        else
            l_Lighting_0:SetMinutesAfterMidnight(v175);
        end;
        for v190, v191 in next, v171 do
            local v192 = v18[v190];
            if v192 then
                for v193, v194 in next, v191 do
                    v192[v193] = v194;
                end;
            end;
        end;
        v173 = v18.Atmosphere:GetAttribute("Density");
        if v173 then
            v18.Atmosphere.Density = v173;
        end;
        v168 = v171;
    end;
    if v172 ~= v17 then
        if v17 then
            v17.Parent = nil;
        end;
        v172.Parent = l_Lighting_0;
        v17 = v172;
    end;
    for v195, v196 in next, v15 do
        if v18[v195].Parent ~= v196 then
            v18[v195].Parent = v196;
        end;
    end;
end);
l_UserInputService_0.InputBegan:Connect(function(v197, _) --[[ Line: 472 ]]
    -- upvalues: l_UserInputService_0 (copy), v168 (ref), v1 (copy), v18 (copy)
    if v197.KeyCode == Enum.KeyCode.L and l_UserInputService_0:IsKeyDown(Enum.KeyCode.LeftControl) and l_UserInputService_0:IsKeyDown(Enum.KeyCode.LeftShift) then
        local v199 = v168 or {};
        warn("Lighting debug");
        v1.printTable(v199, "Last Lighting Calc:");
        print();
        print("Lighting Read:", game.Lighting:GetMinutesAfterMidnight());
        for v200, v201 in next, v18 do
            local v202 = v199[v200];
            if v202 then
                print("-", v200 .. ":");
                for v203 in next, v202 do
                    print("   -", v203, v201[v203]);
                end;
            end;
        end;
    end;
end);
v4:BindToSetting("Game Quality", "Lighting Quality", function(_) --[[ Line: 497 ]]
    -- upvalues: v18 (copy), l_Lighting_0 (copy)
    v18.Clouds.Enabled = true;
    v18.Atmosphere.Parent = l_Lighting_0;
end);
v4:BindToSetting("Game Quality", "Lighting Smoothness", function(v205) --[[ Line: 502 ]]
    -- upvalues: v16 (ref)
    if v205 == "Ultra" then
        v16:SetRate(0);
        return;
    elseif v205 == "High" then
        v16:SetRate(0.03333333333333333);
        return;
    elseif v205 == "Medium" then
        v16:SetRate(0.5);
        return;
    else
        v16:SetRate(5);
        return;
    end;
end);
v2:Add("Lighting State Update", function(v206) --[[ Line: 515 ]]
    -- upvalues: v19 (ref)
    v19 = v206;
end);
return v12;