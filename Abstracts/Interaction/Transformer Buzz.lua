local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Resources");
local _ = v0.require("Libraries", "Network");
local v3 = v0.require("Classes", "Maids");
local _ = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v6 = {};
v6.__index = v6;
local l_Volume_0 = v1:Find("ReplicatedStorage.Assets.Sounds.Ambient.Electric Buzz").Volume;
local v8 = TweenInfo.new(0.5, Enum.EasingStyle.Linear);
local _ = TweenInfo.new(0.1, Enum.EasingStyle.Linear);
local function _(v10, v11, v12) --[[ Line: 22 ]] --[[ Name: bindToAttribute ]]
    local v13 = v10:GetAttributeChangedSignal(v11):Connect(function() --[[ Line: 23 ]]
        -- upvalues: v12 (copy), v10 (copy), v11 (copy)
        v12(v10:GetAttribute(v11));
    end);
    v12(v10:GetAttribute(v11));
    return v13;
end;
local function v19(v15, v16, v17, v18) --[[ Line: 32 ]] --[[ Name: tweenVolume ]]
    -- upvalues: l_TweenService_0 (copy), v0 (copy)
    if v15.WorkingTween then
        v15.WorkingTween:Cancel();
    end;
    v15.WorkingTween = l_TweenService_0:Create(v15.BuzzSound, v16, {
        Volume = v17
    });
    v15.WorkingTween.Completed:Connect(function() --[[ Line: 43 ]]
        -- upvalues: v0 (ref), v15 (copy), v18 (copy)
        v0.destroy(v15.WorkingTween, "Completed");
        v15.WorkingTween = nil;
        if v18 then
            v18();
        end;
    end);
    v15.WorkingTween:Play();
end;
v6.new = function(v20, v21, v22) --[[ Line: 57 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), v1 (copy), v19 (copy), v8 (copy), l_Volume_0 (copy), v6 (copy)
    local v23 = {
        Type = "Transformer Buzz", 
        Id = v20, 
        Destroyed = false, 
        HomeCFrame = v21.PrimaryPart.CFrame, 
        Instance = v21, 
        Maid = v3.new()
    };
    v23.BuzzSound = v23.Maid:Give(v1:Get("ReplicatedStorage.Assets.Sounds.Ambient.Electric Buzz"));
    v23.BuzzSound.Parent = v23.Instance.PrimaryPart;
    v23.BuzzSound.Volume = 0;
    v23.WorkingTween = nil;
    local l_Maid_0 = v23.Maid;
    local function v26(v25) --[[ Line: 75 ]]
        -- upvalues: v23 (copy), v19 (ref), v8 (ref), l_Volume_0 (ref)
        if v25 then
            v23.BuzzSound:Play();
            v19(v23, v8, l_Volume_0);
            return;
        else
            v19(v23, v8, 0, function() --[[ Line: 81 ]]
                -- upvalues: v23 (ref)
                v23.BuzzSound:Stop();
            end);
            return;
        end;
    end;
    local l_v22_AttributeChangedSignal_0 = v22:GetAttributeChangedSignal("Emitting");
    local v28 = "Emitting";
    l_v22_AttributeChangedSignal_0 = l_v22_AttributeChangedSignal_0:Connect(function() --[[ Line: 23 ]]
        -- upvalues: v26 (copy), v22 (copy), v28 (copy)
        v26(v22:GetAttribute(v28));
    end);
    v26(v22:GetAttribute("Emitting"));
    l_Maid_0:Give(l_v22_AttributeChangedSignal_0);
    return (setmetatable(v23, v6));
end;
v6.Destroy = function(v29) --[[ Line: 94 ]] --[[ Name: Destroy ]]
    if v29.Destroyed then
        return;
    else
        v29.Destroyed = true;
        if v29.Maid then
            v29.Maid:Destroy();
            v29.Maid = nil;
        end;
        setmetatable(v29, nil);
        table.clear(v29);
        v29.Destroyed = true;
        return;
    end;
end;
v6.GetInteractionPosition = function(v30, _, _) --[[ Line: 112 ]] --[[ Name: GetInteractionPosition ]]
    return v30.HomeCFrame.p;
end;
v6.Interact = function(_, _) --[[ Line: 116 ]] --[[ Name: Interact ]]

end;
v6.SetDetailed = function(_, _) --[[ Line: 120 ]] --[[ Name: SetDetailed ]]

end;
return v6;