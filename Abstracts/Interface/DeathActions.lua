local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local v2 = v0.require("Libraries", "Network");
local l_TextService_0 = game:GetService("TextService");
local _ = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_v1_Storage_0 = v1:GetStorage("DeathActions");
local l_Template_0 = l_v1_Storage_0:WaitForChild("Template");
local v8 = {
    Gui = v1:GetGui("DeathActions")
};
local v9 = {};
local v10 = 0;
local v11 = {
    Bold = l_v1_Storage_0:WaitForChild("Bold Template"), 
    Normal = l_v1_Storage_0:WaitForChild("Normal Template")
};
local v12 = {
    Death = "rbxassetid://3095268176", 
    Default = "rbxassetid://3087799281", 
    Server = "rbxassetid://3087799281"
};
local _ = {};
local function _(v14, v15) --[[ Line: 44 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    return l_TextService_0:GetTextSize(v14, v15.TextSize, v15.Font, Vector2.new(1000, 300));
end;
local function _(v17) --[[ Line: 51 ]] --[[ Name: tweenFadeOut ]]
    v17:Destroy();
end;
local function v23() --[[ Line: 55 ]] --[[ Name: clamp ]]
    -- upvalues: v9 (copy), v10 (ref)
    for v19, v20 in next, v9 do
        local v21 = tick() - v20;
        local v22 = v10 - v19.LayoutOrder - 1;
        if v21 > 15 or v22 >= 4 then
            v9[v19] = nil;
            v19:Destroy();
        end;
    end;
end;
v8.Log = function(_, v25, v26, _) --[[ Line: 69 ]] --[[ Name: Log ]]
    -- upvalues: l_Template_0 (copy), v12 (copy), v11 (copy), l_TextService_0 (copy), v10 (ref), v8 (copy), v9 (copy), v23 (copy)
    local v28 = l_Template_0:Clone();
    v28.InnerBoxLeft.Symbol.Image = v12[v25] or v12.Default;
    for v29, v30 in next, v26 do
        local v31 = v11[v30.Style]:Clone();
        local l_new_0 = UDim2.new;
        local v33 = 0;
        local l_Text_0 = v30.Text;
        v31.Size = l_new_0(v33, l_TextService_0:GetTextSize(l_Text_0, v31.TextSize, v31.Font, Vector2.new(1000, 300)).X, 1, -4);
        v31.Backdrop.Text = v30.Text;
        v31.Text = v30.Text;
        v31.LayoutOrder = v29;
        v31.Parent = v28.InnerBoxRight.Padding;
    end;
    local l_X_0 = v28.InnerBoxRight.Padding.UIListLayout.AbsoluteContentSize.X;
    v28.Size = UDim2.new(0, 36 + l_X_0, 0, 25);
    v28.LayoutOrder = v10;
    v28.Parent = v8.Gui;
    v10 = v10 + 1;
    v9[v28] = tick();
    v23();
end;
v2:Add("Death Action Logger", function(v36, v37, v38) --[[ Line: 94 ]]
    -- upvalues: v8 (copy)
    v8:Log(v36, v37, v38);
end);
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 98 ]]
    -- upvalues: v23 (copy), v1 (copy), v8 (copy)
    debug.profilebegin("death actions UI step");
    v23();
    if not v1:IsVisible("MainMenu", "DeathScreen") then
        v8.Gui.Visible = true;
    else
        v8.Gui.Visible = false;
    end;
    debug.profileend();
end);
return v8;