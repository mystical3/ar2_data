local l_RunService_0 = game:GetService("RunService");
local v1 = l_RunService_0:IsServer();
local _ = l_RunService_0:IsStudio();
local _ = nil;
local v4 = (if v1 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework)).require("Libraries", "Resources");
local v5 = {
    Character = {
        EquippedItem = "__NIL,", 
        Binoculars = "__NIL,", 
        Light = "__NIL,", 
        CleanGun = false, 
        Ninja = false, 
        AtEase = false, 
        FirstPerson = false, 
        LookDirection = Vector3.new(0, 0, -1, 0), 
        MoveState = "Initialize", 
        ShoulderSwap = false, 
        Zooming = false, 
        InventorySearch = false
    }, 
    Mannequin = {
        EquippedItem = "__NIL,", 
        Binoculars = "__NIL,", 
        Light = "__NIL,", 
        CleanGun = false, 
        Ninja = false, 
        AtEase = false, 
        FirstPerson = false, 
        LookDirection = Vector3.new(0, 0, -1, 0), 
        MoveState = "Initialize", 
        ShoulderSwap = false, 
        Zooming = false, 
        InventorySearch = false
    }, 
    Zombie = {
        Target = "__NIL,", 
        AgroPercent = 0, 
        AgroState = "Initialize", 
        MoveState = "Initialize"
    }, 
    Corpse = {
        Animation = ""
    }, 
    Vehicle = {
        Throttle = 0, 
        Steer = 0, 
        Lights = false, 
        Horn = false, 
        Siren = "Off"
    }
};
local v6 = {
    Mannequin = {
        Bin = nil, 
        AnimationControllerType = "Humanoid", 
        CanSleep = false
    }, 
    Character = {
        Bin = v4:Find("Workspace.Characters"), 
        AnimationControllerType = "Humanoid", 
        CanSleep = true
    }, 
    Zombie = {
        Bin = v4:Find("Workspace.Zombies.Mobs"), 
        AnimationControllerType = "AnimationController", 
        CanSleep = true
    }, 
    Vehicle = {
        Bin = v4:Find("Workspace.Vehicles.Spawned"), 
        AnimationControllerType = nil, 
        CanSleep = true
    }, 
    Corpse = {
        Bin = v4:Find("Workspace.Corpses"), 
        AnimationControllerType = "AnimationController", 
        CanSleep = true
    }
};
return {
    ConfigTemplates = v5, 
    AutoBindConfig = v6, 
    NIL = "__NIL,", 
    canSleep = function(v7, v8, v9) --[[ Line: 111 ]] --[[ Name: canSleep ]]
        -- upvalues: v6 (copy)
        if not v8.PrimaryPart then
            return false, 100000, false;
        else
            local v10 = v8.PrimaryPart.Position - v9.p;
            local v11 = v9.LookVector:Dot(v10.Unit);
            local l_Magnitude_0 = v10.Magnitude;
            local v13 = l_Magnitude_0 > 1000;
            local v14 = v11 < 0;
            local v15 = false;
            local v16 = true;
            if v6[v7] then
                v16 = v6[v7].CanSleep;
            end;
            if l_Magnitude_0 < 500 then
                v14 = false;
            end;
            if v16 and (v14 or v13) then
                v15 = true;
            end;
            return v15, l_Magnitude_0, not v14;
        end;
    end
};