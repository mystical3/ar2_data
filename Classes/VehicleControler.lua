local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Network");
local v2 = v0.require("Libraries", "Raycasting");
local _ = v0.require("Libraries", "Resources");
local _ = v0.require("Libraries", "Geometry");
local v5 = v0.require("Libraries", "Keybinds");
local v6 = v0.require("Classes", "Animators");
local v7 = v0.require("Classes", "OldSprings");
local v8 = v0.require("Classes", "Maids");
local v9 = v0.require("Classes", "Steppers");
local _ = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local v14 = {};
local v15 = {};
v15.__index = v15;
local function _(v16) --[[ Line: 37 ]] --[[ Name: normalize ]]
    if v16.Magnitude > 0 then
        return v16.unit;
    else
        return v16;
    end;
end;
local function _(v18) --[[ Line: 45 ]] --[[ Name: deadzoneInput ]]
    if math.abs(v18) < 0.01 then
        return 0;
    else
        return v18;
    end;
end;
local function v24(v20, v21, v22, ...) --[[ Line: 53 ]] --[[ Name: findAndDo ]]
    local l_v20_FirstChild_0 = v20:FindFirstChild(v21);
    if l_v20_FirstChild_0 then
        v22(l_v20_FirstChild_0, ...);
    end;
end;
local function v27() --[[ Line: 61 ]] --[[ Name: refreshControlsUI ]]
    -- upvalues: v0 (copy)
    local l_Interface_0 = v0.Libraries.Interface;
    local v26 = v0.Classes.Players.get();
    if l_Interface_0 and v26 and v26.Character then
        l_Interface_0:Get("Weapon"):Refresh(v26.Character);
        l_Interface_0:Get("Controls"):Refresh(v26.Character);
    end;
end;
local function v33(v28, v29, v30) --[[ Line: 72 ]] --[[ Name: lightsLogic ]]
    -- upvalues: v6 (copy), v1 (copy)
    if v30.Mechanism.Value == "Toggle" and v29 == "Begin" then
        local v31 = v6.find(v28.Instance);
        local v32 = false;
        if v31 and v31.States.Lights ~= nil then
            v32 = v31.States.Lights;
        end;
        v1:Send("Vehicle Set Lights", v28.Instance, not v32);
        return;
    else
        if v30.Mechanism.Value == "Hold" then
            v1:Send("Vehicle Set Lights", v28.Instance, v29 == "Begin");
        end;
        return;
    end;
end;
local function v39(v34, v35, v36) --[[ Line: 87 ]] --[[ Name: hornKeyLogic ]]
    -- upvalues: v6 (copy), v1 (copy)
    if v36.Mechanism.Value == "Toggle" and v35 == "Begin" then
        local v37 = v6.find(v34.Instance);
        local v38 = false;
        if v37 and v37.States.Horn ~= nil then
            v38 = v37.States.Horn;
        end;
        v1:Send("Vehicle Set Horn", v34.Instance, not v38);
        return;
    else
        if v36.Mechanism.Value == "Hold" then
            v1:Send("Vehicle Set Horn", v34.Instance, v35 == "Begin");
        end;
        return;
    end;
end;
local function v49(v40, v41, v42, v43, v44) --[[ Line: 102 ]] --[[ Name: sirenKeyLogic ]]
    -- upvalues: v6 (copy), v1 (copy)
    if v42.Mechanism.Value == "Toggle" and v41 == "Begin" then
        local v45 = v6.find(v40.Instance);
        local v46 = "Primary";
        local v47 = "Off";
        if v45 and v45.States.Siren then
            v46 = v45.States.Siren;
        end;
        if v43 then
            v47 = "Primary";
        elseif v44 then
            v47 = "Alternate";
        end;
        if v47 == v46 then
            v47 = "Off";
        end;
        v1:Send("Vehicle Set Siren", v40.Instance, v47);
        return;
    else
        if v42.Mechanism.Value == "Hold" then
            local v48 = "Off";
            if v43 then
                v48 = "Primary";
            elseif v44 then
                v48 = "Alternate";
            end;
            v1:Send("Vehicle Set Siren", v40.Instance, v48);
        end;
        return;
    end;
end;
local function v59(v50, v51) --[[ Line: 136 ]] --[[ Name: applyDragForce ]]
    local l_DriveSpeed_0 = v50.Config.Physics.DriveSpeed;
    local v53 = 0;
    if v51 < 0 then
        l_DriveSpeed_0 = v50.Config.Physics.ReverseSpeed;
    end;
    for _, v55 in next, v50.Instance:GetDescendants() do
        if v55:IsA("BasePart") then
            v53 = v53 + v55:GetMass();
        end;
    end;
    local l_Velocity_0 = v50.BasePart.Velocity;
    local v57 = math.abs(v51) * l_DriveSpeed_0;
    local v58 = Vector3.new();
    if v57 < l_Velocity_0.magnitude then
        v58 = -(l_Velocity_0 - (if l_Velocity_0.Magnitude > 0 then l_Velocity_0.unit else l_Velocity_0) * v57) * v53 * 1.3 * Vector3.new(1, 0, 1, 0);
    end;
end;
local function v82(v60, v61) --[[ Line: 162 ]] --[[ Name: setWheelSpeeds ]]
    -- upvalues: v0 (copy)
    local l_DriveSpeed_1 = v60.Config.Physics.DriveSpeed;
    if v61 < 0 then
        l_DriveSpeed_1 = v60.Config.Physics.ReverseSpeed;
    end;
    for _, v64 in next, v60.Wheels:GetChildren() do
        local v65 = v60.Config.Physics.Wheels[v64.Name];
        local l_v64_FirstChild_0 = v64:FindFirstChild("Drive Motor");
        local l_PrimaryPart_0 = v64.PrimaryPart;
        local v68 = -v60.BasePart.CFrame.UpVector * l_PrimaryPart_0.Size.Y * 1.5;
        local v69 = Ray.new(l_PrimaryPart_0.CFrame.p, v68);
        local l_workspace_PartOnRayWithIgnoreList_0, _, _, v73 = workspace:FindPartOnRayWithIgnoreList(v69, {
            v60.Instance
        });
        local l_Default_0 = v60.Config.Physics.MaterialGrip.Default;
        if v73 and v60.Config.Physics.MaterialGrip[v73.Name] then
            l_Default_0 = v60.Config.Physics.MaterialGrip[v73.Name];
        end;
        if l_workspace_PartOnRayWithIgnoreList_0 and (l_workspace_PartOnRayWithIgnoreList_0.Name == "Sea Floor" or l_workspace_PartOnRayWithIgnoreList_0.Name == "Lake Floor") and not v60.Config.Physics.BoatMode then
            l_Default_0 = {
                Friction = 1, 
                Speed = 0.01
            };
        end;
        l_PrimaryPart_0.CustomPhysicalProperties = PhysicalProperties.new(10, v65.Friction * l_Default_0.Friction, v65.Elasticity);
        if v65 and v65.DoesDrive and v64.PrimaryPart and l_v64_FirstChild_0 then
            local l_PrimaryPart_1 = v64.PrimaryPart;
            if l_PrimaryPart_1 then
                local l_Attachment_0 = l_PrimaryPart_1:FindFirstChild("Attachment");
                local v77 = l_PrimaryPart_1.Size.Y * 0.5;
                local v78 = -v61 * l_Default_0.Speed;
                local v79 = 1;
                if l_Attachment_0 then
                    local v80 = 1;
                    if v0.Libraries.Interface and not v60.Config.Physics.BoatMode then
                        local v81 = v0.Libraries.Interface:Get("Vehicle");
                        if v81 then
                            v80 = v81:GetWheelHealth(v64.Name);
                        end;
                    end;
                    v79 = if v80 < 0.8 then 1 - (1 - v80 / 0.8) * 0.7 else 1;
                end;
                l_v64_FirstChild_0.AngularVelocity = l_DriveSpeed_1 / v77 * v78 * v79;
            end;
        end;
    end;
end;
local function v98(v83, v84, v85) --[[ Line: 232 ]] --[[ Name: setSteerWheels ]]
    local l_DriveSpeed_2 = v83.Config.Physics.DriveSpeed;
    if v85 < 0 then
        l_DriveSpeed_2 = v83.Config.Physics.ReverseSpeed;
    end;
    local l_Magnitude_0 = (v83.BasePart.CFrame:VectorToObjectSpace(v83.BasePart.Velocity) * Vector3.new(1, 0, 1, 0)).Magnitude;
    local v88 = math.min(math.abs(v85) * l_DriveSpeed_2, l_Magnitude_0);
    local l_FullSteeringUntil_0 = v83.Config.Physics.FullSteeringUntil;
    local l_NoSteeringAfter_0 = v83.Config.Physics.NoSteeringAfter;
    local v91 = 1 - math.clamp((v88 - l_FullSteeringUntil_0) / (l_NoSteeringAfter_0 - l_FullSteeringUntil_0), 0, 1);
    for _, v93 in next, v83.Wheels:GetChildren() do
        local v94 = v83.Config.Physics.Wheels[v93.Name];
        local l_v93_FirstChild_0 = v93:FindFirstChild("Drive Motor");
        local l_Attachment_1 = v93.PrimaryPart:FindFirstChild("Attachment");
        if v94 and v94.DoesSteer and l_v93_FirstChild_0 then
            local v97 = math.rad(v94.SteerAngle * -v84 * v91);
            if l_Attachment_1 then
                v97 = v97 + math.rad(l_Attachment_1.Orientation.Y);
            end;
            l_v93_FirstChild_0.Attachment0.CFrame = CFrame.Angles(0, v97, 0);
        end;
    end;
end;
local function v108(v99, v100, v101) --[[ Line: 267 ]] --[[ Name: handleBumperImpact ]]
    -- upvalues: v2 (copy), v1 (copy)
    local v102 = v99.BasePart.Velocity * Vector3.new(1, 0, 1, 0);
    local l_Magnitude_1 = v102.Magnitude;
    if (v101.Velocity * Vector3.new(1, 0, 1, 0) - v102).Magnitude > 5 and l_Magnitude_1 > 5 and tick() - v99.ShovedAt > 1 then
        local v104 = v2:IsHitZombie(v101);
        local v105 = v2:IsHitCharacter(v101);
        local l_v101_0 = v101;
        local l_Name_0 = v101.Material.Name;
        if v104 or v105 then
            l_v101_0 = v105 or v104;
            l_Name_0 = "Flesh";
        elseif v101.CanCollide == false then
            l_v101_0 = nil;
        end;
        if l_v101_0 then
            v1:Send("Vehicle Bumper Impact", v99.Instance, v100, l_Magnitude_1, l_v101_0, l_Name_0);
        end;
    end;
end;
local function v136(v109) --[[ Line: 294 ]] --[[ Name: connectEvents ]]
    -- upvalues: v24 (copy), l_CollectionService_0 (copy), v108 (copy), v9 (copy), v1 (copy), l_UserInputService_0 (copy), v5 (copy), v39 (copy), v33 (copy), v49 (copy)
    v24(v109.Instance, "Interaction", function(v110) --[[ Line: 295 ]]
        -- upvalues: v109 (copy), l_CollectionService_0 (ref), v108 (ref)
        local v111 = tick();
        for _, v113 in next, v110:GetChildren() do
            if v113.Name == "Impact Hitbox" then
                v109.Maid:Give(v113.Touched:Connect(function(v114) --[[ Line: 300 ]]
                    -- upvalues: v111 (ref), l_CollectionService_0 (ref), v109 (ref), v108 (ref), v113 (copy)
                    if tick() - v111 >= 0.25 and l_CollectionService_0:HasTag(v114, "Vehicle Impact") and v109:IsControlling() then
                        v111 = tick();
                        v108(v109, v113, v114);
                    end;
                end));
            end;
        end;
    end);
    v109.Maid:Give(v9.new(0, "Stepped", function(v115) --[[ Line: 315 ]]
        -- upvalues: v109 (copy)
        debug.profilebegin("Vehicle Step");
        local v116 = nil;
        if not v109:IsControlling() then
            v116 = Vector3.new(0, 0, 0, 0);
        end;
        v109:Step(v115, v116);
        debug.profileend();
    end));
    v109.Maid:Give(v9.new(0.1, "Stepped", function(_) --[[ Line: 327 ]]
        -- upvalues: v109 (copy), v1 (ref)
        if v109:IsControlling() then
            local l_Position_0 = v109.ThrottleSolver.Position;
            local l_Position_1 = v109.SteerSolver.Position;
            v109.Drivable = v1:Fetch("Vehicle Report Input", v109.Instance, l_Position_0, l_Position_1);
        end;
    end));
    v109.Maid:Give(l_UserInputService_0.InputBegan:Connect(function(v120, v121) --[[ Line: 336 ]]
        -- upvalues: v5 (ref), v109 (copy), v39 (ref), v33 (ref), l_UserInputService_0 (ref), v49 (ref)
        local l_v5_Bind_0 = v5:GetBind("Vehicle Lights");
        local l_v5_Bind_1 = v5:GetBind("Vehicle Horn");
        local l_v5_Bind_2 = v5:GetBind("Vehicle Siren");
        local l_v5_Bind_3 = v5:GetBind("Vehicle Siren 2");
        if v109:IsControlling() and not v121 then
            if l_v5_Bind_1 and l_v5_Bind_1.Key == v120.KeyCode then
                v39(v109, "Begin", l_v5_Bind_1);
                return;
            elseif l_v5_Bind_0 and l_v5_Bind_0.Key == v120.KeyCode then
                v33(v109, "Begin", l_v5_Bind_0);
                return;
            elseif l_v5_Bind_2 then
                local v126 = l_UserInputService_0:IsKeyDown(l_v5_Bind_2.Key);
                local v127 = l_UserInputService_0:IsKeyDown(l_v5_Bind_3.Key);
                if v126 or v127 then
                    v49(v109, "Begin", l_v5_Bind_2, v126, v127);
                end;
            end;
        end;
    end));
    v109.Maid:Give(l_UserInputService_0.InputEnded:Connect(function(v128, v129) --[[ Line: 361 ]]
        -- upvalues: v5 (ref), v109 (copy), v39 (ref), v33 (ref), l_UserInputService_0 (ref), v49 (ref)
        local l_v5_Bind_4 = v5:GetBind("Vehicle Lights");
        local l_v5_Bind_5 = v5:GetBind("Vehicle Horn");
        local l_v5_Bind_6 = v5:GetBind("Vehicle Siren");
        local l_v5_Bind_7 = v5:GetBind("Vehicle Siren 2");
        if v109:IsControlling() and not v129 then
            if l_v5_Bind_5 and l_v5_Bind_5.Key == v128.KeyCode then
                v39(v109, "End", l_v5_Bind_5);
                return;
            elseif l_v5_Bind_4 and l_v5_Bind_4.Key == v128.KeyCode then
                v33(v109, "End", l_v5_Bind_4);
                return;
            elseif l_v5_Bind_6 and l_v5_Bind_6.Key == v128.KeyCode then
                local v134 = l_UserInputService_0:IsKeyDown(l_v5_Bind_6.Key);
                local v135 = l_UserInputService_0:IsKeyDown(l_v5_Bind_7.Key);
                if v134 or v135 then
                    v49(v109, "End", l_v5_Bind_6, v134, v135);
                end;
            end;
        end;
    end));
end;
v15.get = function(v137) --[[ Line: 389 ]] --[[ Name: get ]]
    -- upvalues: v14 (copy)
    for _, v139 in next, v14 do
        if v139.Instance == v137 then
            return v139;
        end;
    end;
    return nil;
end;
v15.remove = function(v140) --[[ Line: 399 ]] --[[ Name: remove ]]
    -- upvalues: v14 (copy), v82 (copy)
    for v141, v142 in next, v14 do
        if v142.Instance == v140 then
            v82(v142, 0);
            v142:Destroy();
            table.remove(v14, v141);
            return;
        end;
    end;
end;
v15.new = function(v143, v144) --[[ Line: 413 ]] --[[ Name: new ]]
    -- upvalues: v15 (copy), v8 (copy), v7 (copy), v14 (copy), v136 (copy), v27 (copy)
    local v145 = setmetatable({}, v15);
    v145.Name = v143.Name;
    v145.Maid = v8.new();
    v145.Instance = v143;
    v145.DriverSeat = v143:WaitForChild("Seats"):WaitForChild("Driver");
    v145.BasePart = v143:WaitForChild("Base");
    v145.Config = require(v143:WaitForChild("Config"));
    v145.ThrottleSolver = v7.new(0, v145.Config.Physics.ThrottleResponce, 1);
    v145.SteerSolver = v7.new(v144, v145.Config.Physics.SteerResponce, 1);
    v145.SteerSolver.Target = 0;
    v145.Wheels = v143:WaitForChild("Wheels");
    v145.DownForce = nil;
    v145.LastInputSend = tick();
    v145.LastStepSpeed = 0;
    v145.ShovedAt = 0;
    table.insert(v14, v145);
    v136(v145);
    v27();
    return v145;
end;
v15.Destroy = function(v146) --[[ Line: 448 ]] --[[ Name: Destroy ]]
    if v146.Destroyed then
        return;
    else
        v146.Destroyed = true;
        if v146.Maid then
            v146.Maid:Destroy();
            v146.Maid = nil;
        end;
        setmetatable(v146, nil);
        table.clear(v146);
        v146.Destroyed = true;
        return;
    end;
end;
v15.Step = function(v147, _, v149) --[[ Line: 466 ]] --[[ Name: Step ]]
    -- upvalues: v0 (copy), v82 (copy), v98 (copy), v59 (copy)
    local l_Players_0 = v0.Classes.Players;
    local v151 = false;
    if l_Players_0 then
        local v152 = v0.Classes.Players.get();
        if v152 then
            local l_Character_0 = v152.Character;
            if l_Character_0 and l_Character_0.MoveVector then
                local l_MoveVector_0 = l_Character_0.MoveVector;
                if v149 then
                    l_MoveVector_0 = v149;
                end;
                local l_ThrottleSolver_0 = v147.ThrottleSolver;
                local v156 = -l_MoveVector_0.Z;
                l_ThrottleSolver_0.Target = math.abs(v156) < 0.01 and 0 or v156;
                l_ThrottleSolver_0 = v147.SteerSolver;
                v156 = l_MoveVector_0.X;
                l_ThrottleSolver_0.Target = math.abs(v156) < 0.01 and 0 or v156;
                v151 = true;
            end;
        end;
    end;
    if not v151 then
        v147.ThrottleSolver.Target = 0;
    end;
    if v147.Drivable ~= true then
        v147.ThrottleSolver.Target = 0;
    end;
    local l_Position_2 = v147.ThrottleSolver.Position;
    local l_Position_3 = v147.SteerSolver.Position;
    v82(v147, l_Position_2);
    v98(v147, l_Position_3, l_Position_2);
    if not v147.Config.Physics.BoatMode then
        v59(v147, l_Position_2);
    end;
end;
v15.IsControlling = function(v159) --[[ Line: 511 ]] --[[ Name: IsControlling ]]
    -- upvalues: v0 (copy)
    if v0.Classes.Players then
        local v160 = v0.Classes.Players.get();
        if v160 and v160.Character and v160.Character.Sitting and v160.Character.IsVehicleDriver then
            return v160.Character.Vehicle == v159.Instance;
        end;
    end;
    return false;
end;
v15.HasHorn = function(v161) --[[ Line: 527 ]] --[[ Name: HasHorn ]]
    if v161.Config and v161.Config.Sounds.HornLoop then
        return true;
    else
        return false;
    end;
end;
v15.HasSiren = function(v162) --[[ Line: 535 ]] --[[ Name: HasSiren ]]
    if v162.Config and v162.Config.Sounds.Siren then
        return true;
    else
        return false;
    end;
end;
v15.HasLights = function(v163) --[[ Line: 543 ]] --[[ Name: HasLights ]]
    if v163.Instance and v163.Instance:FindFirstChild("Lights") then
        return true;
    else
        return false;
    end;
end;
v1:Add("Vehicle Push Impulse", function(v164, v165, v166) --[[ Line: 553 ]]
    local l_PrimaryPart_2 = v164.PrimaryPart;
    if l_PrimaryPart_2 then
        l_PrimaryPart_2:ApplyImpulseAtPosition(v166, v165);
    end;
end);
v1:Add("Take Vehicle Ownership", function(v168, v169) --[[ Line: 561 ]]
    -- upvalues: v15 (copy)
    v15.new(v168, v169);
    return true;
end);
v1:Add("Drop Vehicle Ownership", function(v170) --[[ Line: 567 ]]
    -- upvalues: v15 (copy)
    v15.remove(v170);
    return true;
end);
return v15;