local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Network");
local v2 = v0.require("Classes", "Steppers");
local v3 = Random.new();
local v4 = {
    Color3.fromRGB(219, 219, 219), 
    Color3.fromRGB(255, 107, 107), 
    Color3.fromRGB(34, 34, 34)
};
local v5 = {
    Color3.fromRGB(219, 219, 219), 
    Color3.fromRGB(152, 255, 143), 
    Color3.fromRGB(254, 251, 76)
};
local v6 = Color3.fromRGB(240, 240, 240);
local v7 = Color3.fromRGB(22, 22, 22);
local v8 = {};
v8.__index = v8;
local v9 = {};
local function _() --[[ Line: 32 ]] --[[ Name: getCharacterPosition ]]
    -- upvalues: v0 (copy)
    if v0.Classes.Players then
        local v10 = v0.Classes.Players.get();
        if v10 and v10.Character and v10.Character.HeadPart then
            return v10.Character.HeadPart.Position;
        end;
    end;
end;
v8.new = function(v12, v13, _) --[[ Line: 44 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy), v9 (copy), v8 (copy)
    local v15 = {
        Type = "MedalArcade", 
        Id = v12, 
        Instance = v13
    };
    v15.HomeCFrame = v15.Instance.PrimaryPart.CFrame;
    v15.OriginPos = v15.HomeCFrame.Position;
    v15.Active = v1:Fetch("Medal Arcade Get", v12);
    v9[v12] = setmetatable(v15, v8);
    if v15.Active then
        v15:Activate(true);
        return v15;
    else
        v15:Deactivate(true);
        return v15;
    end;
end;
v8.Destroy = function(v16) --[[ Line: 71 ]] --[[ Name: Destroy ]]
    -- upvalues: v9 (copy)
    if v16.Destroyed then
        return;
    else
        v16.Destroyed = true;
        if v16.Animation then
            v16.Animation:Destroy();
            v16.Animation = nil;
        end;
        v9[v16.Id] = nil;
        setmetatable(v16, nil);
        table.clear(v16);
        v16.Destroyed = true;
        return;
    end;
end;
v8.GetInteractionPosition = function(v17, _, _) --[[ Line: 91 ]] --[[ Name: GetInteractionPosition ]]
    local l_FirstChild_0 = v17.Instance:FindFirstChild("Interact Point");
    if l_FirstChild_0 then
        return l_FirstChild_0.Position;
    else
        return;
    end;
end;
v8.Interact = function(v21) --[[ Line: 99 ]] --[[ Name: Interact ]]
    -- upvalues: v0 (copy), v1 (copy)
    v0.Libraries.Interface:Get("MedalQuest"):PromptQuest();
    v1:Send("World Interact", v21.Id);
end;
v8.SetDetailed = function(_, _) --[[ Line: 104 ]] --[[ Name: SetDetailed ]]

end;
v8.Activate = function(v24, v25) --[[ Line: 108 ]] --[[ Name: Activate ]]
    -- upvalues: v2 (copy), v7 (copy), v5 (copy), v3 (copy), v6 (copy), v4 (copy)
    v24.Instance.PrimaryPart.LoopSound:Play();
    if not v25 then
        v24.Instance.PrimaryPart.StartSound:Play();
    end;
    local v26 = os.clock();
    local v27 = {};
    for _, v29 in next, v24.Instance:GetChildren() do
        if v29.Name == "Button" then
            v29.Material = Enum.Material.Neon;
        elseif v29.Name == "Screen" then
            v29.Material = Enum.Material.Neon;
            table.insert(v27, v29);
        end;
    end;
    if v24.Instance.Parent.Parent.Parent.Name:find("ArcadeMedal") then
        for _, v31 in next, v24.Instance.Parent.Parent.Parent:GetDescendants() do
            local l_ColorOn_0 = v31:FindFirstChild("ColorOn");
            if l_ColorOn_0 then
                v31.Color = l_ColorOn_0.Value;
            end;
            if v31:IsA("Light") then
                v31.Enabled = true;
            end;
        end;
    end;
    if v24.Animation then
        v24.Animation:Destroy();
        v24.Animation = nil;
    end;
    v24.Animation = v2.new(0, "Heartbeat", function() --[[ Line: 148 ]]
        -- upvalues: v24 (copy), v26 (ref), v7 (ref), v5 (ref), v3 (ref), v25 (copy), v6 (ref), v4 (ref), v27 (copy)
        if v24.Destroyed then
            return;
        else
            local v33 = (os.clock() - v26) / v24.Instance.PrimaryPart.StartSound.TimeLength;
            local l_v7_0 = v7;
            local v35 = 0;
            if v24.Instance.PrimaryPart.WinSound.Playing then
                v26 = 0;
                l_v7_0 = v5[v3:NextInteger(1, #v5)];
                v35 = 0.1;
            elseif v33 < 1 and not v25 then
                l_v7_0 = l_v7_0:Lerp(v6, v33 ^ 2);
                v35 = 0.041666666666666664;
            elseif v24.Instance.PrimaryPart.StartSound.Playing then
                l_v7_0 = v6;
            elseif v3:NextNumber() < 0.3333333333333333 then
                l_v7_0 = v4[v3:NextInteger(1, #v4)];
                v35 = v3:NextNumber(0.1, 0.2);
            else
                l_v7_0 = Color3.fromHSV(v3:NextNumber(), v3:NextNumber(0.3, 0.5), v3:NextNumber(0.6, 0.7));
                v35 = v3:NextNumber(0.4, 1.2);
            end;
            for _, v37 in next, v27 do
                v37.Color = l_v7_0;
                for _, v39 in next, v37:GetChildren() do
                    if v39:IsA("Light") then
                        v39.Enabled = true;
                        v39.Color = l_v7_0;
                    end;
                end;
            end;
            if v35 > 0 then
                task.wait(v35);
            end;
            return;
        end;
    end);
    v24.Active = true;
end;
v8.Deactivate = function(v40) --[[ Line: 200 ]] --[[ Name: Deactivate ]]
    -- upvalues: v7 (copy)
    v40.Instance.PrimaryPart.LoopSound:Stop();
    v40.Instance.PrimaryPart.StartSound:Stop();
    if v40.Animation then
        v40.Animation:Destroy();
        v40.Animation = nil;
    end;
    for _, v42 in next, v40.Instance:GetChildren() do
        if v42.Name == "Button" then
            v42.Material = Enum.Material.Plastic;
        elseif v42.Name == "Screen" then
            v42.Color = v7;
            v42.Material = Enum.Material.Glass;
            for _, v44 in next, v42:GetChildren() do
                if v44:IsA("Light") then
                    v44.Enabled = false;
                end;
            end;
        end;
    end;
    if v40.Instance.Parent.Parent.Parent.Name:find("ArcadeMedal") then
        for _, v46 in next, v40.Instance.Parent.Parent.Parent:GetDescendants() do
            local l_ColorOff_0 = v46:FindFirstChild("ColorOff");
            if l_ColorOff_0 then
                v46.Color = l_ColorOff_0.Value;
            end;
            if v46:IsA("Light") then
                v46.Enabled = false;
            end;
        end;
    end;
    v40.Active = false;
end;
v8.Win = function(v48) --[[ Line: 241 ]] --[[ Name: Win ]]
    v48.Instance.PrimaryPart.StartSound:Stop();
    v48.Instance.PrimaryPart.WinSound:Play();
end;
v1:Add("Medal Arcade Win", function(v49) --[[ Line: 248 ]]
    -- upvalues: v9 (copy)
    local v50 = v9[v49];
    if v50 then
        v50:Win();
    end;
end);
v1:Add("Medal Arcade Sync", function(v51) --[[ Line: 256 ]]
    -- upvalues: v9 (copy)
    for v52, v53 in next, v51 do
        local v54 = v9[v52];
        if v54 then
            if v53 then
                v54:Activate();
            else
                v54:Deactivate();
            end;
        end;
    end;
end);
return v8;