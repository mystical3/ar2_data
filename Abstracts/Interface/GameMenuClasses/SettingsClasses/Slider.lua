local l_UserInputService_0 = game:GetService("UserInputService");
local v1 = Vector3.new();
local v2 = false;
local function v4(_) --[[ Line: 13 ]] --[[ Name: drag ]]

end;
l_UserInputService_0.InputChanged:Connect(function(v5, _) --[[ Line: 19 ]]
    -- upvalues: v4 (ref), v1 (ref)
    if v5.UserInputType == Enum.UserInputType.MouseMovement then
        v4(v5.Position, v5.Position - v1);
        v1 = v5.Position;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v7, _) --[[ Line: 26 ]]
    -- upvalues: v2 (ref)
    if v7.UserInputType == Enum.UserInputType.MouseButton1 then
        v2 = false;
    end;
end);
return function(v9, v10) --[[ Line: 32 ]]
    -- upvalues: v1 (ref), v2 (ref), v4 (ref)
    local l_Bar_0 = v9.InnerBox.Bar;
    local l_Dragger_0 = l_Bar_0.Dragger;
    local v13 = 0;
    v9.InnerBox.Label.Text = v10.Name;
    l_Dragger_0.MouseButton1Down:Connect(function() --[[ Line: 39 ]]
        -- upvalues: v13 (ref), l_Dragger_0 (copy), v1 (ref), v2 (ref)
        v13 = l_Dragger_0.AbsolutePosition.X - v1.X;
        v2 = true;
    end);
    v4 = function(v14, _) --[[ Line: 44 ]] --[[ Name: drag ]]
        -- upvalues: v2 (ref), v13 (ref), l_Bar_0 (copy), l_Dragger_0 (copy)
        if not v2 then
            return;
        else
            local v16 = v13 + v14.X - l_Bar_0.AbsolutePosition.X;
            local v17 = l_Bar_0.AbsoluteSize.X - 23;
            local v18 = math.clamp(v16, 3, v17);
            local v19 = (v18 - 3) / (v17 - 3);
            l_Dragger_0.Position = UDim2.new(0, v18, 0.5, 0);
            l_Bar_0.Value.Text = math.floor(v19 * 100 + 0.5);
            return;
        end;
    end;
end;