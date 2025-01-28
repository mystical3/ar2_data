local _ = game:GetService("ProximityPromptService");
local l_RunService_0 = game:GetService("RunService");
local v2 = {
    BenchmarkMode = false, 
    TestChatLock = false, 
    QuickRespawn = false, 
    DevTeamOnlyCommands = false, 
    LootMania = false, 
    VipTestMode = false
};
local function v3() --[[ Line: 16 ]] --[[ Name: flagCorrection ]]
    -- upvalues: v2 (copy), l_RunService_0 (copy)
    if v2.isProdPlace() and not l_RunService_0:IsStudio() then
        v2.BenchmarkMode = false;
        v2.QuickPlay = false;
        v2.DebugIsland = false;
        v2.MKEventLock = false;
        v2.TestChatLock = false;
        v2.VehicleForceSpawn = false;
        v2.VehicleSpawnPerfect = false;
        v2.MKCarLot = false;
        v2.ZombiesAlwaysSpawn = false;
        v2.ZombieSpawnsBlocked = false;
        v2.LootMania = false;
        v2.GlobalChatOutputEnabled = false;
        v2.AllCosmeticsUnlocked = false;
        v2.ZombiesUseCamera = false;
    end;
    if l_RunService_0:IsStudio() == false then
        v2.QuickPlay = false;
        v2.VipTestMode = false;
    end;
    if v2.AllCosmeticsUnlocked then
        v2.DataLoadingBlocked = true;
    end;
end;
v2.isTestPlace = function(v4) --[[ Line: 46 ]] --[[ Name: isTestPlace ]]
    -- upvalues: v2 (copy)
    local v5 = {
        [0] = "Studio", 
        [12123099753] = "Testing Prod. Main", 
        [12123100380] = "Testing Prod. Tourney", 
        [9350727487] = "Testing Public", 
        [9350655892] = "Testing Lobby", 
        [10075727235] = "Testing VIP Lobby", 
        [9350694607] = "Development World", 
        [9350726579] = "Development Feature", 
        [9350725512] = "Development Balance", 
        [10075831055] = "Development Tourney", 
        [9734052822] = "Development Streaming Lite", 
        [9981232472] = "Development Streaming Full", 
        [14818535321] = "Development Events", 
        [18550191373] = "Ban Land"
    };
    if v2.VipTestMode and v4 == "Testing VIP Lobby" then
        return true;
    elseif v4 then
        return v5[game.PlaceId] == v4;
    else
        return v5[game.PlaceId];
    end;
end;
v2.isProdPlace = function(v6) --[[ Line: 79 ]] --[[ Name: isProdPlace ]]
    local v7 = {
        [863266079] = "Production Main", 
        [10077968348] = "Production Tourney", 
        [18550268956] = "Ban Land"
    };
    if v6 then
        return v7[game.PlaceId] == v6;
    else
        return v7[game.PlaceId];
    end;
end;
v2.isPrivateServer = function() --[[ Line: 94 ]] --[[ Name: isPrivateServer ]]
    -- upvalues: l_RunService_0 (copy), v2 (copy)
    if game.PrivateServerId ~= "" then
        return true;
    else
        if l_RunService_0:IsStudio() then
            if v2.isTestPlace("Testing Prod. Tourney") then
                return true;
            elseif v2.isTestPlace("Development Tourney") then
                return true;
            elseif v2.isTestPlace("Testing VIP Lobby") then
                return true;
            end;
        end;
        return false;
    end;
end;
v2.isVIPLobby = function() --[[ Line: 113 ]] --[[ Name: isVIPLobby ]]
    -- upvalues: l_RunService_0 (copy), v2 (copy)
    if l_RunService_0:IsClient() then
        warn("Cannot read VIP settings from the client");
        return false;
    elseif v2.isTestPlace("Testing VIP Lobby") then
        return true;
    elseif v2.isProdPlace("Production Main") and v2.isPrivateServer() then
        return true;
    else
        return false;
    end;
end;
v2.isVIPServer = function() --[[ Line: 131 ]] --[[ Name: isVIPServer ]]
    -- upvalues: l_RunService_0 (copy), v2 (copy)
    if l_RunService_0:IsClient() then
        warn("Cannot read VIP settings from the client");
        return false;
    elseif v2.isTestPlace("Testing VIP Lobby") then
        return true;
    elseif game.PrivateServerId ~= "" and v2.isProdPlace() then
        return true;
    else
        return false;
    end;
end;
v2.isVIPOwner = function(v8) --[[ Line: 149 ]] --[[ Name: isVIPOwner ]]
    -- upvalues: l_RunService_0 (copy), v2 (copy)
    if l_RunService_0:IsClient() then
        warn("Cannot read VIP settings from the client");
        return false;
    elseif game.PrivateServerOwnerId == v8.UserId then
        return true;
    elseif v2.isTestPlace("Testing VIP Lobby") or l_RunService_0:IsStudio() then
        while not v2.FirstPersonId do
            task.wait(0);
        end;
        return v2.FirstPersonId;
    else
        return false;
    end;
end;
v2.getVIPHostId = function() --[[ Line: 172 ]] --[[ Name: getVIPHostId ]]
    -- upvalues: l_RunService_0 (copy), v2 (copy)
    if l_RunService_0:IsClient() then
        warn("Cannot read VIP settings from the client");
        return 0;
    elseif v2.isTestPlace("Testing VIP Lobby") or l_RunService_0:IsStudio() then
        while not v2.FirstPersonId do
            task.wait(0);
        end;
        return v2.FirstPersonId;
    else
        return game.PrivateServerOwnerId;
    end;
end;
v2.getPlaceIndex = function() --[[ Line: 191 ]] --[[ Name: getPlaceIndex ]]
    -- upvalues: l_RunService_0 (copy)
    local v9 = ({
        [0] = "Studio", 
        [12123099753] = "Testing Prod. Main", 
        [12123100380] = "Testing Prod. Tourney", 
        [9350727487] = "Testing Public", 
        [9350655892] = "Testing Lobby", 
        [10075727235] = "Testing VIP Lobby", 
        [9350694607] = "Development World", 
        [9350726579] = "Development Feature", 
        [9350725512] = "Development Balance", 
        [10075831055] = "Development Tourney", 
        [9734052822] = "Development Streaming Lite", 
        [9981232472] = "Development Streaming Full", 
        [14818535321] = "Development Events", 
        [863266079] = "Production Main", 
        [10077968348] = "Production Tourney", 
        [18550191373] = "Ban Land", 
        [18550268956] = "Ban Land"
    })[game.PlaceId] or "Unknown";
    if l_RunService_0:IsStudio() then
        v9 = "Studio";
    end;
    return v9;
end;
v2.StaffIcons = {
    Developer = "rbxassetid://1053845911", 
    ["Chief Administrator"] = "rbxassetid://1053845911", 
    Administrator = "rbxassetid://1056883499", 
    ["Senior Moderator"] = "rbxassetid://1056883499", 
    Moderator = "rbxassetid://1056883499", 
    Contractor = "rbxassetid://2706046974"
};
v2.MapLeftTopCorner = Vector3.new(-7000, 0, -7000, 0);
v2.MapChunkSize = 250;
v2.LootChunkSize = 40;
v2.UtilitySlotLimit = 6;
v2.UtilityTypes = {
    HandHeldLights = {
        Flashlight = true, 
        Lantern = true, 
        ["Survival Flashlight"] = true, 
        ["Military Flashlight"] = true
    }, 
    ChemLights = {
        ["Blue Chemlight"] = true, 
        ["Green Chemlight"] = true, 
        ["Red Chemlight"] = true
    }, 
    Binoculars = {
        Binoculars = true
    }, 
    Rangefinder = {
        ["Military Rangefinder"] = true
    }
};
v2.printTable = function(v10, v11, v12) --[[ Line: 268 ]]
    -- upvalues: v2 (copy)
    local v13 = v11 or tostring(v10);
    local v14 = v12 or 0;
    local function v15(...) --[[ Line: 274 ]] --[[ Name: newLine ]]
        -- upvalues: v14 (ref)
        print(string.rep("    ", v14):gsub("^%s", ""), ...);
    end;
    local function _(v16) --[[ Line: 278 ]] --[[ Name: modDepth ]]
        -- upvalues: v14 (ref)
        v14 = math.max(v14 + v16, 0);
    end;
    if v10 and next(v10) then
        v15(v13, "{");
        v14 = math.max(v14 + 1, 0);
        for v18, v19 in next, v10 do
            if typeof(v19) == "table" then
                v2.printTable(v19, v18, v14);
            else
                if typeof(v19) == "function" then
                    v19 = "FUNCTION()";
                end;
                v15(v18, "=", v19);
            end;
        end;
        v14 = math.max(v14 + -1, 0);
        v15("}");
    else
        v15(v13, "{}");
    end;
end;
v2.formatTime = function(v20) --[[ Line: 307 ]]
    local v21 = v20 / 60;
    local v22 = v21 / 60;
    local v23 = v22 / 24;
    local v24 = "1 second";
    if v23 > 2 then
        return math.floor(v23) .. " days";
    elseif v22 > 2 then
        return math.floor(v22) .. " hours";
    elseif v21 > 2 then
        return math.floor(v21) .. " minutes";
    else
        if v20 > 2 then
            v24 = math.floor(v20) .. " seconds";
        end;
        return v24;
    end;
end;
v2.getStringRoundingCharacter = function(v25) --[[ Line: 327 ]]
    if v25 > 1 then
        return "%d";
    else
        return "%." .. tostring((string.len((tostring(v25):gsub("^0%.", ""):gsub("0$", ""))))) .. "f";
    end;
end;
v2.numberToOrdinalText = function(v26) --[[ Line: 340 ]]
    local v27 = math.floor(v26);
    if v27 ~= v26 then
        return "";
    else
        local v28 = v27 / 10 == math.floor(v27 / 10);
        local v29 = v27 % 10;
        local v30 = "";
        if v27 >= 4 and v27 <= 20 or v28 then
            v30 = "th";
        elseif v29 == 3 then
            v30 = "rd";
        elseif v29 == 2 then
            v30 = "nd";
        elseif v29 == 1 then
            v30 = "st";
        end;
        return string.format("%d%s", v27, v30);
    end;
end;
v2.getPositionHash = function(v31) --[[ Line: 365 ]]
    local v32 = math.floor(v31.X);
    local v33 = math.floor(v31.Y);
    local v34 = math.floor(v31.Z);
    return v32 * 73856093 + v33 * 19351301 + v34 * 83492791;
end;
v2.lerp = function(v35, v36, v37) --[[ Line: 373 ]]
    if typeof(v35) == "Color3" then
        local v38, v39, v40 = v35:ToHSV();
        local v41, v42, v43 = v36:ToHSV();
        local v44 = v39 + (v42 - v39) * v37;
        local v45 = v40 + (v43 - v40) * v37;
        local v46 = 0;
        local v47 = v41 - v38;
        if v41 < v38 then
            local l_v41_0 = v41;
            v41 = v38;
            v38 = l_v41_0;
            v37 = 1 - v37;
            v47 = -v47;
        end;
        if v47 > 0.5 then
            v38 = v38 + 1;
            v46 = (v38 + v37 * (v41 - v38)) % 1;
        elseif v47 <= 0.5 then
            v46 = v38 + v37 * v47;
        end;
        return Color3.fromHSV(v46, v44, v45);
    else
        return v35 + (v36 - v35) * v37;
    end;
end;
v2.ContainerTypeWeights = {
    Permanant = 1, 
    Carried = 2, 
    Corpse = 3, 
    Furniture = 4, 
    Vehicle = 5, 
    Vicinity = 100
};
v2.ContainerOrderSort = function(v49) --[[ Line: 414 ]]
    -- upvalues: v2 (copy)
    table.sort(v49, function(v50, v51) --[[ Line: 415 ]]
        -- upvalues: v2 (ref)
        local v52 = v2.ContainerTypeWeights[v50.Type] or 10000;
        local v53 = v2.ContainerTypeWeights[v51.Type] or 10000;
        if v52 == v53 then
            return v50.Id < v51.Id;
        else
            return v52 < v53;
        end;
    end);
end;
v2.CosmeticSlots = {
    Accessory = true, 
    Belt = true, 
    Bottom = true, 
    Hat = true, 
    Top = true, 
    Vest = true
};
v2.DamageColors = setmetatable({
    White = Color3.fromRGB(255, 255, 255), 
    Orange = Color3.fromRGB(255, 180, 10), 
    Red = Color3.fromRGB(220, 75, 75), 
    Grey = Color3.fromRGB(200, 200, 200), 
    Pink = Color3.fromRGB(255, 190, 190), 
    Purple = Color3.fromRGB(216, 165, 255), 
    Blue = Color3.fromRGB(159, 209, 255)
}, {
    __index = function(_, v55) --[[ Line: 458 ]] --[[ Name: __index ]]
        local v56 = 1;
        local _ = 0.65909093618393;
        local _ = 0.86274510622025;
        local v59 = 0.44645550847054;
        local _ = 1;
        local _ = 0.86666667461395;
        local v62 = math.clamp(v55, 0, 1);
        local v63 = v62 * 0.34090906381607 + 0.65909093618393;
        local v64 = v62 * 0.003921568393699948 + 0.86274510622025;
        local v65 = 0;
        local v66 = v59 - v56;
        if v59 < v56 then
            local l_v59_0 = v59;
            v59 = v56;
            v56 = l_v59_0;
            v62 = 1 - v62;
            v66 = -v66;
        end;
        if v66 > 0.5 then
            v56 = v56 + 1;
            v65 = (v56 + v62 * (v59 - v56)) % 1;
        elseif v66 <= 0.5 then
            v65 = v56 + v62 * v66;
        end;
        return Color3.fromHSV(v65, v63, v64);
    end
});
v2.KeyAliases = setmetatable({
    [Enum.KeyCode.LeftShift] = "L-Shift", 
    [Enum.KeyCode.RightShift] = "R-Shift", 
    [Enum.KeyCode.LeftControl] = "L-Ctrl", 
    [Enum.KeyCode.RightControl] = "R-Ctrl", 
    [Enum.KeyCode.LeftAlt] = "L-Alt", 
    [Enum.KeyCode.RightAlt] = "R-Alt", 
    [Enum.KeyCode.CapsLock] = "CAPS", 
    [Enum.KeyCode.One] = "1", 
    [Enum.KeyCode.Two] = "2", 
    [Enum.KeyCode.Three] = "3", 
    [Enum.KeyCode.Four] = "4", 
    [Enum.KeyCode.Five] = "5", 
    [Enum.KeyCode.Six] = "6", 
    [Enum.KeyCode.Seven] = "7", 
    [Enum.KeyCode.Eight] = "8", 
    [Enum.KeyCode.Nine] = "9", 
    [Enum.KeyCode.Zero] = "0", 
    [Enum.KeyCode.KeypadOne] = "Num-1", 
    [Enum.KeyCode.KeypadTwo] = "Num-2", 
    [Enum.KeyCode.KeypadThree] = "Num-3", 
    [Enum.KeyCode.KeypadFour] = "Num-4", 
    [Enum.KeyCode.KeypadFive] = "Num-5", 
    [Enum.KeyCode.KeypadSix] = "Num-6", 
    [Enum.KeyCode.KeypadSeven] = "Num-7", 
    [Enum.KeyCode.KeypadEight] = "Num-8", 
    [Enum.KeyCode.KeypadNine] = "Num-9", 
    [Enum.KeyCode.KeypadZero] = "Num-0", 
    [Enum.KeyCode.Minus] = "-", 
    [Enum.KeyCode.Equals] = "=", 
    [Enum.KeyCode.Tilde] = "~", 
    [Enum.KeyCode.LeftBracket] = "[", 
    [Enum.KeyCode.RightBracket] = "]", 
    [Enum.KeyCode.RightParenthesis] = ")", 
    [Enum.KeyCode.LeftParenthesis] = "(", 
    [Enum.KeyCode.Semicolon] = ";", 
    [Enum.KeyCode.Quote] = "'", 
    [Enum.KeyCode.BackSlash] = "\\", 
    [Enum.KeyCode.Comma] = ",", 
    [Enum.KeyCode.Period] = ".", 
    [Enum.KeyCode.Slash] = "/", 
    [Enum.KeyCode.Asterisk] = "*", 
    [Enum.KeyCode.Plus] = "+", 
    [Enum.KeyCode.Period] = ".", 
    [Enum.KeyCode.Backquote] = "`", 
    [Enum.UserInputType.MouseButton3] = "Button-3", 
    [Enum.KeyCode.Unknown] = "??"
}, {
    __index = function(_, v69) --[[ Line: 538 ]] --[[ Name: __index ]]
        return v69.Name;
    end
});
v2.GuiInset = game:GetService("GuiService"):GetGuiInset();
v2.DustMaterials = {
    Carpet = "Light", 
    Ceramic = "Light", 
    Concrete = "Light", 
    Gravel = "Heavy", 
    Linoleum = "Light", 
    Meat = "Heavy", 
    Metal = "Light", 
    Sand = "Heavy", 
    Wood = "Light"
};
local l_Globals_0 = game:GetService("ReplicatedStorage"):WaitForChild("Globals");
local function v71(v72, v73) --[[ Line: 565 ]] --[[ Name: toTableValue ]]
    -- upvalues: v71 (copy)
    if v72:IsA("Folder") then
        local v74 = {};
        for _, v76 in next, v72:GetChildren() do
            v71(v76, v74);
        end;
        v72.ChildAdded:Connect(function(v77) --[[ Line: 573 ]]
            -- upvalues: v71 (ref), v74 (copy)
            v71(v77, v74);
        end);
        v73[v72.Name] = v74;
        return;
    else
        if v72:IsA("ValueBase") then
            v72.Changed:Connect(function() --[[ Line: 580 ]]
                -- upvalues: v73 (copy), v72 (copy)
                v73[v72.Name] = v72.Value;
            end);
            v73[v72.Name] = v72.Value;
        end;
        return;
    end;
end;
local function v78(v79, v80) --[[ Line: 588 ]] --[[ Name: setFromTable ]]
    -- upvalues: v78 (copy)
    if v79:IsA("Folder") and typeof(v80) == "table" then
        for v81, v82 in next, v80 do
            local l_v79_FirstChild_0 = v79:FindFirstChild(v81);
            if l_v79_FirstChild_0 then
                v78(l_v79_FirstChild_0, v82);
            else
                warn("DUR", v79, v81);
            end;
        end;
        return;
    else
        if v79:IsA("ValueBase") then
            v79.Value = v80;
        end;
        return;
    end;
end;
for _, v85 in next, l_Globals_0:GetChildren() do
    v71(v85, v2);
end;
_G.Globals = v2;
_G.ReplicatedGlobals = l_Globals_0;
v3();
for _, v87 in next, l_Globals_0:GetChildren() do
    v78(v87, v2[v87.Name]);
end;
return v2;