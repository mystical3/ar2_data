local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Cameras");
local v2 = v0.require("Libraries", "Network");
local v3 = v0.require("Libraries", "Resources");
local v4 = v0.require("Libraries", "Interface");
local v5 = v0.require("Libraries", "Lighting");
local v6 = v0.require("Libraries", "World");
local v7 = v0.require("Libraries", "Raycasting");
local v8 = v0.require("Classes", "Signals");
local v9 = v0.require("Classes", "Characters");
local v10 = v0.require("Classes", "Maids");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local v13 = {};
v13.__index = v13;
local v14 = nil;
local function _(v15) --[[ Line: 29 ]] --[[ Name: makeBindable ]]
    local l_BindableEvent_0 = Instance.new("BindableEvent");
    l_BindableEvent_0.Event:Connect(function(...) --[[ Line: 32 ]]
        -- upvalues: v15 (copy)
        v15(...);
    end);
    return l_BindableEvent_0;
end;
local function v18() --[[ Line: 39 ]] --[[ Name: resetCallback ]]
    -- upvalues: v2 (copy)
    v2:Send("Player Character Reset");
end;
v13.new = function(v19) --[[ Line: 45 ]] --[[ Name: new ]]
    -- upvalues: l_LocalPlayer_0 (copy), v10 (copy), v8 (copy), v14 (ref), v13 (copy)
    local v20 = {
        Parent = v19, 
        Type = "Player", 
        Instance = l_LocalPlayer_0, 
        Maid = v10.new()
    };
    v20.CharacterAdded = v20.Maid:Give(v8.new());
    v20.Character = nil;
    v20.FirstSpawn = true;
    v14 = v20;
    return (setmetatable(v20, v13));
end;
v13.get = function() --[[ Line: 62 ]] --[[ Name: get ]]
    -- upvalues: v14 (ref)
    return v14;
end;
v13.Destroy = function(v21) --[[ Line: 68 ]] --[[ Name: Destroy ]]
    if v21.Destroyed then
        return;
    else
        v21.Destroyed = true;
        if v21.Maid then
            v21.Maid:Destroy();
            v21.Maid = nil;
        end;
        setmetatable(v21, nil);
        table.clear(v21);
        return;
    end;
end;
v13.UnloadCharacter = function(v22) --[[ Line: 84 ]] --[[ Name: UnloadCharacter ]]
    -- upvalues: v1 (copy)
    local l_Character_0 = v22.Character;
    if l_Character_0 then
        v1:GetCamera("Character"):Disconnect();
    end;
    v22.Character = nil;
    if l_Character_0 then
        l_Character_0:Destroy();
    end;
end;
v2:Add("Unload Character", function() --[[ Line: 100 ]]
    -- upvalues: v13 (copy)
    return v13.get():UnloadCharacter();
end);
v2:Add("Load Character", function(v24) --[[ Line: 104 ]]
    -- upvalues: v13 (copy), v9 (copy), v1 (copy), v4 (copy), v2 (copy), v5 (copy)
    local v25 = v13.get();
    v25:UnloadCharacter();
    local v26 = v9.new(v24, v25);
    v25.Character = v25.Maid:Give(v26);
    v25.CharacterAdded:Fire(v26);
    v25.FirstSpawn = false;
    v1:GetCamera("Character"):Connect(v26);
    v1:SetCurrent("Character");
    local v27 = v4:Get("Hotbar");
    v27:Connect(v25.Character);
    v27:Import(v2:Fetch("Get Hotbar Order"));
    v4:Show("Hotbar", "Controls", "Weapon");
    v4:Get("Controls"):Refresh(v25.Character);
    v4:Get("Weapon"):Refresh(v25.Character);
    v5:Reset();
end);
v2:Add("Unload For Exit", function() --[[ Line: 132 ]]
    -- upvalues: v13 (copy), v1 (copy)
    local v28 = v13.get();
    if v28 then
        v28:UnloadCharacter();
        v1:SetCurrent("Default");
    end;
    return true;
end);
v2:Add("Character Dead", function(v29) --[[ Line: 143 ]]
    -- upvalues: v13 (copy), v3 (copy), v0 (copy), v1 (copy), v4 (copy)
    local v30 = v13.get();
    if v30 and v30.Character then
        v30.Character.Health:Set(0);
        v30:UnloadCharacter();
    end;
    local v31 = v3:Get("ReplicatedStorage.Assets.Sounds.Music.Death Sound");
    v31.SoundGroup = v3:Find("SoundService.Music");
    v31.Parent = v3:Find("Workspace.Effects");
    v31.Ended:Connect(function() --[[ Line: 155 ]]
        -- upvalues: v0 (ref), v31 (copy)
        v0.destroy(v31, "Ended");
    end);
    v31:Play();
    v1:GetCamera("Corpse"):Connect(v29);
    v1:SetCurrent("Corpse");
    v4:Get("Unlock"):ClearQueue();
    v4:Hide("GameMenu", "Compass", "Map", "Hotbar", "Controls", "Weapon", "Reticle");
    return true;
end);
v2:Add("Vehicle Character Set", function(v32, v33) --[[ Line: 179 ]]
    -- upvalues: v14 (ref)
    if v14 and v14.Character then
        return v14.Character:SetSitting(v32, v33);
    else
        return false;
    end;
end);
v2:Add("Vehicle Camera Disconnect", function() --[[ Line: 187 ]]
    -- upvalues: v1 (copy)
    v1:GetCamera("Character"):DisconnectVehicle();
    v1:SetCurrent("Character");
end);
v2:Add("Character Rubber Band Rest", function() --[[ Line: 192 ]]
    -- upvalues: v14 (ref)
    if v14 and v14.Character then
        v14.Character.NetworkedStateSync = tick() + 1;
        v14.Character.RubberBandReset = 4;
        return true;
    else
        return false;
    end;
end);
v2:Add("Character State Update", function(v34) --[[ Line: 203 ]]
    -- upvalues: v14 (ref), v4 (copy)
    if v14 and v14.Character then
        for v35, v36 in next, v34.Stats do
            local v37 = v14.Character[v35];
            if v37 and v37.Bonus then
                local v38 = false;
                if v37.ChangeTier ~= v36.ChangeTier or v37.Frozen ~= v36.Frozen then
                    v38 = true;
                end;
                if v37:Get() ~= v36.Value then
                    v38 = false;
                end;
                v37.ChangeTier = v36.ChangeTier;
                v37.Frozen = v36.Frozen;
                v37.Bonus:Set(v36.Bonus);
                v37:Set(v36.Value);
                if v38 then
                    v37:Set(v37:Get(), v37:Get());
                end;
            end;
        end;
        if v14.Character.IsInCitadelArena ~= v34.IsInCitadelArena then
            v14.Character.IsInCitadelArena = v34.IsInCitadelArena;
            v4:Get("Hotbar"):Draw();
        end;
        v4:Get("Map"):SetCombatZone(v34.InCombat, v34.CombatZone);
        v4:Get("Hotbar"):SetCombatStatus(v34.CombatTimer);
    end;
end);
v2:Add("Teleport Sequence", function(v39, v40, v41) --[[ Line: 249 ]]
    -- upvalues: v14 (ref), v0 (copy), v6 (copy), v7 (copy)
    if v14 and v14.Character then
        local l_RootPart_0 = v14.Character.RootPart;
        local v43 = l_RootPart_0.CFrame.Rotation + v39;
        if v41 then
            v0.Libraries.Interface:Get("Fade"):Fade(0, 0.25):Wait();
        end;
        l_RootPart_0.Anchored = true;
        l_RootPart_0.CFrame = v43;
        v6:Set(v39, "Teleport", 100, v40):Wait();
        local v44 = Ray.new(v39, (Vector3.new(0, -50, 0, 0)));
        local v45 = os.clock();
        repeat
            local v46 = v7:CastWithWhiteList(v44, {
                workspace.Map
            });
            task.wait(0);
            local v47 = os.clock() - v45 > 30;
        until v46 or v47;
        if v41 then
            task.delay(1.1, function() --[[ Line: 281 ]]
                -- upvalues: v0 (ref)
                v0.Libraries.Interface:Get("Fade"):Fade(1, 0.25);
            end);
        end;
        l_RootPart_0.Anchored = false;
    end;
    return true;
end);
v2:Add("Character Perks Update", function(v48) --[[ Line: 292 ]]
    -- upvalues: v14 (ref)
    if v14 and v14.Character then
        v14.Character.ActivePerks = v48;
        v14.Character.PerksChanged:Fire();
    end;
end);
coroutine.wrap(function() --[[ Line: 299 ]]
    -- upvalues: l_StarterGui_0 (copy), v18 (copy)
    while true do
        local l_pcall_0 = pcall;
        local l_SetCore_0 = l_StarterGui_0.SetCore;
        local l_l_StarterGui_0_0 = l_StarterGui_0;
        local v52 = "ResetButtonCallback";
        local l_v18_0 = v18;
        local l_BindableEvent_1 = Instance.new("BindableEvent");
        l_BindableEvent_1.Event:Connect(function(...) --[[ Line: 32 ]]
            -- upvalues: l_v18_0 (copy)
            l_v18_0(...);
        end);
        if not l_pcall_0(l_SetCore_0, l_l_StarterGui_0_0, v52, l_BindableEvent_1) then
            wait(0.2);
        else
            break;
        end;
    end;
end)();
return v13;