local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Keybinds");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_v2_Storage_0 = v2:GetStorage("GameMenu");
local v6 = l_v2_Storage_0:WaitForChild("Keybind Slider");
local v7 = l_v2_Storage_0:WaitForChild("Keybind Dropdown");
local v8 = {
    [Enum.UserInputType.Accelerometer] = true, 
    [Enum.UserInputType.Focus] = true, 
    [Enum.UserInputType.Gyro] = true, 
    [Enum.UserInputType.MouseMovement] = true, 
    [Enum.UserInputType.Touch] = true, 
    [Enum.UserInputType.MouseButton3] = true
};
local v9 = {
    [Enum.UserInputType.Keyboard] = true, 
    [Enum.UserInputType.Gamepad1] = true
};
local l_Lengths_0, v11 = v2:Get("Controls"):GetLengths();
local l_IconImages_0 = v2:Get("Controls"):GetIconImages();
local l_KeyAliases_0 = v2:Get("Controls"):GetKeyAliases();
local l_Escape_0 = Enum.KeyCode.Escape;
local function v20() --[[ Line: 43 ]] --[[ Name: captureNextInput ]]
    -- upvalues: l_UserInputService_0 (copy), v9 (copy), l_Escape_0 (copy), v8 (copy)
    local v15 = nil;
    while true do
        local v16, _ = l_UserInputService_0.InputBegan:wait();
        local v18 = false;
        local v19 = nil;
        v19 = if v9[v16.UserInputType] then v16.KeyCode else v16.UserInputType;
        if v19 == l_Escape_0 then
            return nil;
        else
            if not v8[v19] then
                v15 = v19;
                v18 = true;
            end;
            if v18 then
                return v15;
            end;
        end;
    end;
end;
local function v27(v21, v22) --[[ Line: 73 ]] --[[ Name: setKeyIcon ]]
    -- upvalues: l_KeyAliases_0 (copy), l_IconImages_0 (copy), v11 (copy), l_Lengths_0 (copy)
    local l_Keyboard_0 = Enum.UserInputType.Keyboard;
    if v22.Name:find("MouseButton") then
        l_Keyboard_0 = v22;
    end;
    local v24 = l_KeyAliases_0[v22] or v22.Name;
    local v25 = l_IconImages_0[l_Keyboard_0];
    local l_v11_0 = v11;
    if l_Keyboard_0 == Enum.UserInputType.Keyboard and #v24 > 1 then
        l_v11_0 = l_Lengths_0;
    elseif l_Keyboard_0.Name:find("MouseButton") then
        v24 = "";
    end;
    if v25 then
        v21.Image = v25.Up;
    else
        v21.Image = l_IconImages_0[Enum.UserInputType.Keyboard].Up;
        l_v11_0 = l_Lengths_0;
        v24 = v22.Name;
    end;
    v21.TextLabel.Text = v24;
    v21.Size = UDim2.new(0, l_v11_0, 0, 31);
end;
return function(v28, v29, v30) --[[ Line: 102 ]]
    -- upvalues: v3 (copy), v6 (copy), v1 (copy), l_UserInputService_0 (copy), v7 (copy), v0 (copy), v2 (copy), v27 (copy), v20 (copy)
    local l_Edit_0 = v28.Main.InnerBox.Edit;
    local l_Key_0 = v28.Main.InnerBox.Key;
    local v33 = false;
    local l_v3_Bind_0 = v3:GetBind(v29);
    if l_v3_Bind_0 then
        l_v3_Bind_0 = l_v3_Bind_0.Key;
    end;
    local function v36(v35) --[[ Line: 115 ]] --[[ Name: setCaptureState ]]
        -- upvalues: l_Edit_0 (copy), l_Key_0 (copy), v28 (copy)
        l_Edit_0.InnerBox.Label.Text = "Enter new keybind...";
        l_Edit_0.Size = UDim2.new(0, 150, 0, 27);
        l_Edit_0.ImageColor3 = Color3.fromRGB(255, 255, 255);
        l_Edit_0.InnerBox.ImageColor3 = Color3.fromRGB(96, 96, 96);
        l_Edit_0.InnerBox.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
        l_Edit_0.InnerBox.Label.TextTransparency = 0;
        l_Edit_0.InnerBox.Label.Font = Enum.Font.SourceSansItalic;
        l_Edit_0.InnerBox.Label.Backdrop.Text = l_Edit_0.InnerBox.Label.Text;
        l_Edit_0.InnerBox.Label.Backdrop.Visible = true;
        l_Key_0.Visible = false;
        l_Edit_0.Active = false;
        if not v35 then
            v28.FocusGrab:CaptureFocus();
        end;
    end;
    local function v37() --[[ Line: 134 ]] --[[ Name: setDefaultState ]]
        -- upvalues: l_Edit_0 (copy), l_Key_0 (copy), v28 (copy)
        l_Edit_0.InnerBox.Label.Text = "Edit";
        l_Edit_0.Size = UDim2.new(0, 54, 0, 27);
        l_Edit_0.ImageColor3 = Color3.fromRGB(255, 255, 255);
        l_Edit_0.InnerBox.ImageColor3 = Color3.fromRGB(0, 0, 0);
        l_Edit_0.InnerBox.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
        l_Edit_0.InnerBox.Label.TextTransparency = 0;
        l_Edit_0.InnerBox.Label.Font = Enum.Font.SourceSans;
        l_Edit_0.InnerBox.Label.Backdrop.Visible = false;
        l_Key_0.Visible = true;
        l_Edit_0.Active = true;
        v28.FocusGrab:ReleaseFocus();
    end;
    local function _() --[[ Line: 149 ]] --[[ Name: setKeyError ]]
        -- upvalues: v28 (copy)
        v28.Main.InnerBox.Label.TextColor3 = Color3.new(1, 0.3, 0.3);
    end;
    local function _() --[[ Line: 153 ]] --[[ Name: removeKeyError ]]
        -- upvalues: v28 (copy)
        v28.Main.InnerBox.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
    end;
    local function v69(_, v41, v42) --[[ Line: 157 ]] --[[ Name: makeSlider ]]
        -- upvalues: v6 (ref), v1 (ref), v3 (ref), v29 (copy), l_UserInputService_0 (ref)
        local v43 = v6:Clone();
        v43.Label.Text = v41;
        v43.Label.Backdrop.Text = v41;
        local l_Bar_0 = v43.Bar;
        local l_Padding_0 = l_Bar_0.Padding;
        local l_Dragger_0 = l_Padding_0.Dragger;
        local v47 = false;
        local v48 = Vector3.new();
        local v49 = v42.Step / (v42.Max - v42.Min);
        local function v56(v50, _) --[[ Line: 172 ]] --[[ Name: drag ]]
            -- upvalues: v47 (ref), l_Padding_0 (copy), v49 (copy), v42 (copy), v1 (ref), l_Dragger_0 (copy), l_Bar_0 (copy)
            if not v47 then
                return;
            else
                local v52 = math.floor(math.clamp((v50.X - l_Padding_0.AbsolutePosition.X) / l_Padding_0.AbsoluteSize.X, 0, 1) / v49 + 0.5) * v49;
                local v53 = v42.Min + v52 * (v42.Max - v42.Min);
                local v54 = v1.getStringRoundingCharacter(v42.Step);
                local v55 = v53 < 1 and "0$" or "the fitness gram pacer test";
                l_Dragger_0.Position = UDim2.new(v52, 0, 0.5, 0);
                l_Bar_0.Value.Text = string.format(v54, v53):gsub(v55, "") .. " " .. v42.Suffix;
                v42.Value = math.clamp(v53, v42.Min, v42.Max);
                return;
            end;
        end;
        local function v59() --[[ Line: 191 ]] --[[ Name: comitChange ]]
            -- upvalues: l_Dragger_0 (copy), v42 (copy), v3 (ref), v29 (ref), v41 (copy)
            local l_Scale_0 = l_Dragger_0.Position.X.Scale;
            local v58 = v42.Min + l_Scale_0 * (v42.Max - v42.Min);
            v3:EditBindProperty(v29, v41, (math.clamp(v58, v42.Min, v42.Max)));
        end;
        local function v63() --[[ Line: 198 ]] --[[ Name: load ]]
            -- upvalues: v42 (copy), v49 (copy), v1 (ref), l_Bar_0 (copy), l_Dragger_0 (copy)
            local v60 = math.floor((v42.Value - v42.Min) / (v42.Max - v42.Min) / v49 + 0.5) * v49;
            local v61 = v1.getStringRoundingCharacter(v42.Step);
            local v62 = v42.Value < 1 and "0$" or "the fitness gram pacer test";
            l_Bar_0.Value.Text = string.format(v61, v42.Value):gsub(v62, "") .. " " .. v42.Suffix;
            l_Dragger_0.Position = UDim2.new(v60, 0, 0.5, 0);
        end;
        l_UserInputService_0.InputChanged:Connect(function(v64, _) --[[ Line: 210 ]]
            -- upvalues: v56 (copy), v48 (ref)
            if v64.UserInputType == Enum.UserInputType.MouseMovement then
                v56(v64.Position, v64.Position - v48);
                v48 = v64.Position;
            end;
        end);
        l_UserInputService_0.InputEnded:Connect(function(v66, _) --[[ Line: 217 ]]
            -- upvalues: v47 (ref), v59 (copy)
            if v66.UserInputType == Enum.UserInputType.MouseButton1 then
                if v47 then
                    coroutine.wrap(v59)();
                end;
                v47 = false;
            end;
        end);
        l_Dragger_0.MouseButton1Down:Connect(function() --[[ Line: 227 ]]
            -- upvalues: v47 (ref)
            v47 = true;
        end);
        v3.BindChanged:Connect(function(v68) --[[ Line: 231 ]]
            -- upvalues: v29 (ref), v63 (copy)
            if v68 == v29 then
                v63();
            end;
        end);
        v63();
        return v43;
    end;
    local function v97(v70, v71, v72) --[[ Line: 246 ]] --[[ Name: makeDropdown ]]
        -- upvalues: v7 (ref), v0 (ref), v3 (ref), v2 (ref)
        local v73 = v7:Clone();
        v73.Label.Text = v71;
        v73.Dropdown.InnerBox.Label.Text = v72.Value;
        local v74 = {};
        local v75 = false;
        local function _(v76) --[[ Line: 256 ]] --[[ Name: setZIndex ]]
            -- upvalues: v73 (copy)
            v73.Dropdown.ZIndex = 12 + v76;
            v73.Dropdown.InnerBox.ZIndex = 13 + v76;
            v73.Dropdown.InnerBox.Triangle.ZIndex = 14 + v76;
            v73.Dropdown.InnerBox.Label.ZIndex = 14 + v76;
            v73.Dropdown.Shadow.ZIndex = 11 + v76;
        end;
        local function v80() --[[ Line: 264 ]] --[[ Name: close ]]
            -- upvalues: v74 (ref), v0 (ref), v73 (copy), v75 (ref)
            for _, v79 in next, v74 do
                v0.destroy(v79, "MouseEnter", "MouseButton1Click");
            end;
            v73.Dropdown.Size = UDim2.new(0, 71, 0, 27);
            v73.Dropdown.InnerBox.Label.Visible = true;
            v73.Dropdown.InnerBox.Triangle.Visible = true;
            v74 = {};
            v73.Dropdown.ZIndex = 62;
            v73.Dropdown.InnerBox.ZIndex = 63;
            v73.Dropdown.InnerBox.Triangle.ZIndex = 64;
            v73.Dropdown.InnerBox.Label.ZIndex = 64;
            v73.Dropdown.Shadow.ZIndex = 61;
            v75 = false;
        end;
        local _ = function(v81) --[[ Line: 278 ]] --[[ Name: highlight ]]
            -- upvalues: v74 (ref)
            for _, v83 in next, v74 do
                v83.BackgroundTransparency = v83 == v81 and 0 or 1;
            end;
        end;
        local function v95() --[[ Line: 284 ]] --[[ Name: open ]]
            -- upvalues: v80 (copy), v72 (copy), v73 (copy), v74 (ref), v3 (ref), v70 (copy), v71 (copy), v2 (ref), v75 (ref)
            v80();
            local v85 = 27;
            for v86, v87 in next, v72.List do
                local l_TextButton_0 = Instance.new("TextButton");
                l_TextButton_0.Size = UDim2.new(1, -2, 0, 25);
                l_TextButton_0.Position = UDim2.new(0, 1, 0, (v86 - 1) * 25 + 3);
                l_TextButton_0.ZIndex = 100;
                l_TextButton_0.BackgroundTransparency = 1;
                l_TextButton_0.BorderSizePixel = 0;
                l_TextButton_0.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
                l_TextButton_0.Font = Enum.Font.SourceSans;
                l_TextButton_0.TextSize = 18;
                l_TextButton_0.TextTransparency = 0;
                l_TextButton_0.TextColor3 = Color3.new(1, 1, 1);
                l_TextButton_0.TextStrokeTransparency = 1;
                l_TextButton_0.Text = v87;
                l_TextButton_0.AutoButtonColor = false;
                l_TextButton_0.Parent = v73.Dropdown;
                l_TextButton_0.MouseEnter:Connect(function() --[[ Line: 306 ]]
                    -- upvalues: l_TextButton_0 (copy), v74 (ref)
                    local l_l_TextButton_0_0 = l_TextButton_0;
                    for _, v91 in next, v74 do
                        v91.BackgroundTransparency = v91 == l_l_TextButton_0_0 and 0 or 1;
                    end;
                end);
                l_TextButton_0.MouseButton1Click:Connect(function() --[[ Line: 310 ]]
                    -- upvalues: v73 (ref), v87 (copy), v3 (ref), v70 (ref), v71 (ref), v2 (ref), v80 (ref)
                    v73.Dropdown.InnerBox.Label.Text = v87;
                    v3:EditBindProperty(v70, v71, v87);
                    v2:PlaySound("Interface.Click");
                    v80();
                end);
                v74[v86] = l_TextButton_0;
            end;
            if #v72.List > 0 then
                v85 = #v72.List * 25 + 6;
            end;
            v73.Dropdown.Size = UDim2.new(0, 71, 0, v85);
            v73.Dropdown.InnerBox.Label.Visible = false;
            v73.Dropdown.InnerBox.Triangle.Visible = false;
            local v92 = v74[1];
            for _, v94 in next, v74 do
                v94.BackgroundTransparency = v94 == v92 and 0 or 1;
            end;
            v73.Dropdown.ZIndex = 82;
            v73.Dropdown.InnerBox.ZIndex = 83;
            v73.Dropdown.InnerBox.Triangle.ZIndex = 84;
            v73.Dropdown.InnerBox.Label.ZIndex = 84;
            v73.Dropdown.Shadow.ZIndex = 81;
            v75 = true;
        end;
        v73.Dropdown.MouseButton1Click:Connect(function() --[[ Line: 335 ]]
            -- upvalues: v2 (ref), v95 (copy)
            v2:PlaySound("Interface.Click");
            v95();
        end);
        v73.Dropdown.MouseLeave:Connect(function() --[[ Line: 340 ]]
            -- upvalues: v75 (ref), v2 (ref), v80 (copy)
            if v75 then
                v2:PlaySound("Interface.Click");
            end;
            v80();
        end);
        v3.BindChanged:Connect(function(v96) --[[ Line: 348 ]]
            -- upvalues: v71 (copy), v73 (copy), v72 (copy)
            if v96 == v71 then
                v73.Dropdown.InnerBox.Label.Text = v72.Value;
            end;
        end);
        return v73;
    end;
    if l_v3_Bind_0 then
        v27(l_Key_0, l_v3_Bind_0);
        v37();
    else
        v28.Main.InnerBox.Label.TextColor3 = Color3.new(1, 0.3, 0.3);
        l_Key_0.Visible = false;
    end;
    v28.Main.InnerBox.Label.Text = v29;
    v28.Main.InnerBox.Label.Backdrop.Text = v29;
    local v98 = {
        number = 1, 
        string = 2
    };
    local v99 = {
        number = v69, 
        string = v97
    };
    local v100 = {};
    for v101, v102 in next, v30 do
        if v101 ~= "Key" and type(v102) == "table" then
            table.insert(v100, v101);
        end;
    end;
    table.sort(v100, function(v103, v104) --[[ Line: 390 ]]
        -- upvalues: v30 (copy), v98 (copy)
        local v105 = v30[v103];
        local v106 = v30[v104];
        return v98[type(v105.Value)] < v98[type(v106.Value)];
    end);
    if #v100 > 0 then
        for v107 = 1, #v100 do
            local v108 = v107 == 1 and 45 or 40;
            local v109 = v100[v107];
            local v110 = v30[v109];
            local v111 = v99[type(v110.Value)];
            if v111 then
                local v112 = v111(v29, v109, v110);
                v112.Position = UDim2.new(0, 0, 0, (v107 - 1) * 40 + 7);
                v112.Parent = v28.Main.OuterBox.InnerBox;
                v28.Main.OuterBox.Size = v28.Main.OuterBox.Size + UDim2.new(0, 0, 0, v108);
                v28.Size = v28.Size + UDim2.new(0, 0, 0, v108);
            end;
        end;
    else
        v28.Main.OuterBox.Visible = false;
    end;
    l_Edit_0.MouseButton1Click:Connect(function() --[[ Line: 419 ]]
        -- upvalues: v33 (ref), v36 (copy), v20 (ref), v3 (ref), v29 (copy), v27 (ref), l_Key_0 (copy), v28 (copy), v37 (copy), v2 (ref)
        if v33 then
            return;
        else
            v33 = true;
            v36();
            local v113 = v20();
            if v113 then
                v3:SetKeyBind(v29, v113);
                v27(l_Key_0, v113);
            end;
            v28.Main.InnerBox.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
            v37();
            v2:PlaySound("Interface.Click");
            v33 = false;
            return;
        end;
    end);
    v3.BindOverwritten:Connect(function(v114) --[[ Line: 441 ]]
        -- upvalues: v29 (copy), l_Key_0 (copy), v28 (copy)
        if v114 == v29 then
            l_Key_0.Visible = false;
            v28.Main.InnerBox.Label.TextColor3 = Color3.new(1, 0.3, 0.3);
        end;
    end);
    v3.BindChanged:Connect(function(v115) --[[ Line: 448 ]]
        -- upvalues: v29 (copy), v3 (ref), v27 (ref), l_Key_0 (copy), v37 (copy), v28 (copy)
        if v115 == v29 then
            local l_Key_1 = v3:GetBind(v29).Key;
            if l_Key_1 then
                v27(l_Key_0, l_Key_1);
                v37();
                v28.Main.InnerBox.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
                return;
            else
                l_Key_0.Visible = false;
                v28.Main.InnerBox.Label.TextColor3 = Color3.new(1, 0.3, 0.3);
            end;
        end;
    end);
end;