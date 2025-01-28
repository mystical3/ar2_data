local v0 = require(game:GetService("ReplicatedFirst").Framework).require("Libraries", "UserSettings");
local v1 = game:getService("SoundService");
local v2 = {};
local v3 = {
    Characters = v1:WaitForChild("Characters"), 
    Effects = v1:WaitForChild("Effects"), 
    Vehicles = v1:WaitForChild("Vehicles"), 
    Ambient = v1:WaitForChild("Ambient"), 
    Music = v1:WaitForChild("Music"), 
    Interface = v1:WaitForChild("Interface"), 
    Infected = v1:WaitForChild("Infected")
};
for v4, v5 in next, v3 do
    v0:BindToSetting("Sound Volume", v4, function(v6) --[[ Line: 26 ]]
        -- upvalues: v5 (copy)
        v5.Volume = math.clamp(v6 / 100, 0, 1);
    end);
end;
return v2;