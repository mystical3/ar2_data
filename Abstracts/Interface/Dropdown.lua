local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local _ = v0.require("Configs", "Globals");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Template_0 = v1:GetStorage("Dropdown"):WaitForChild("Template");
local v5 = {
    Gui = v1:GetGui("Dropdown")
};
local function _(v6) --[[ Line: 28 ]] --[[ Name: isInGui ]]
    -- upvalues: v5 (copy)
    local v7 = Vector2.new(v6.X, v6.Y) - v5.Gui.AbsolutePosition;
    local v8 = false;
    if v7.X >= 0 then
        v8 = v7.X <= v5.Gui.AbsoluteSize.X;
    end;
    local v9 = false;
    if v7.Y >= 0 then
        v9 = v7.Y <= v5.Gui.AbsoluteSize.Y;
    end;
    return v8 and v9;
end;
local function v13() --[[ Line: 38 ]] --[[ Name: clean ]]
    -- upvalues: v5 (copy), v0 (copy)
    for _, v12 in next, v5.Gui:GetChildren() do
        if v12 ~= v5.Gui.InnerBox and v12 ~= v5.Gui.Shadow then
            v0.destroy(v12, "MouseButton1Click", "MouseEnter", "MouseLeave");
        end;
    end;
end;
local function v23(v14) --[[ Line: 46 ]] --[[ Name: buildGuis ]]
    -- upvalues: l_Template_0 (copy), v5 (copy), v1 (copy)
    local v15 = 100;
    local v16 = 0;
    local v17 = 0;
    for _, v19 in next, v14 do
        v17 = v17 + 1;
        local v20 = l_Template_0:Clone();
        v20.Position = UDim2.new(0, 1, 0, (v17 - 1) * 27 + 5);
        v20.TextLabel.Text = v19.Name .. " ";
        v20.TextLabel.Backdrop.Text = v20.TextLabel.Text;
        v20.Parent = v5.Gui;
        v20.Name = v19.Name;
        v15 = math.max(v15, v20.TextLabel.TextBounds.X);
        v16 = math.max(v16, v20.Position.Y.Offset + v20.AbsoluteSize.Y);
        v20.MouseButton1Click:Connect(function() --[[ Line: 64 ]]
            -- upvalues: v1 (ref), v5 (ref), v19 (copy)
            v1:PlaySound("Interface.Click");
            v5:Close();
            v19.Action();
        end);
        v20.MouseEnter:Connect(function() --[[ Line: 70 ]]
            -- upvalues: v5 (ref), v20 (copy)
            for _, v22 in next, v5.Gui:GetChildren() do
                if v22 ~= v5.Gui.InnerBox and v22 ~= v5.Gui.Shadow then
                    v22.BackgroundTransparency = 1;
                end;
            end;
            v20.BackgroundTransparency = 0;
        end);
        v20.MouseLeave:Connect(function() --[[ Line: 80 ]]
            -- upvalues: v20 (copy)
            v20.BackgroundTransparency = 1;
        end);
    end;
    v5.Gui.Size = UDim2.new(0, v15 + 8, 0, v16 + 5);
end;
v5.Open = function(v24, v25) --[[ Line: 90 ]] --[[ Name: Open ]]
    -- upvalues: l_UserInputService_0 (copy), v13 (copy), v23 (copy)
    local v26 = l_UserInputService_0:GetMouseLocation() - Vector2.new(20, 20);
    local v27 = UDim2.new(0, v26.X, 0, v26.Y);
    v13();
    v23(v25);
    local v28 = v26 + v24.Gui.AbsoluteSize;
    local v29 = v24.Gui.Parent.AbsoluteSize - v28;
    local v30 = Vector2.new(math.min(0, v29.X), (math.min(0, v29.Y)));
    v24.Gui.Position = v27 + UDim2.new(0, v30.X, 0, v30.Y);
    v24.Gui.Visible = true;
end;
v5.Close = function(v31) --[[ Line: 110 ]] --[[ Name: Close ]]
    -- upvalues: v13 (copy)
    v31.Gui.Visible = false;
    v13();
end;
v5.IsOpen = function(v32) --[[ Line: 115 ]] --[[ Name: IsOpen ]]
    return v32.Gui.Visible;
end;
l_UserInputService_0.InputBegan:Connect(function(v33, _) --[[ Line: 121 ]]
    -- upvalues: v5 (copy)
    if v33.UserInputType.Name:find("MouseButton") then
        local l_Position_0 = v33.Position;
        local v36 = Vector2.new(l_Position_0.X, l_Position_0.Y) - v5.Gui.AbsolutePosition;
        local v37 = false;
        if v36.X >= 0 then
            v37 = v36.X <= v5.Gui.AbsoluteSize.X;
        end;
        local v38 = false;
        if v36.Y >= 0 then
            v38 = v36.Y <= v5.Gui.AbsoluteSize.Y;
        end;
        if not (v37 and v38) then
            v5:Close();
        end;
    end;
end);
return v5;