local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "Keybinds");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_v2_Storage_0 = v2:GetStorage("MainMenu");
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
        l_Edit_0.ImageColor3 = Color3.fromRGB(150, 150, 150);
        l_Edit_0.InnerBox.ImageColor3 = Color3.fromRGB(240, 240, 240);
        l_Edit_0.InnerBox.Label.TextColor3 = Color3.fromRGB(0, 0, 0);
        l_Edit_0.InnerBox.Label.TextTransparency = 0.5;
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
        v28.Main.InnerBox.Label.TextColor3 = Color3.fromRGB(15, 15, 15);
    end;
    local function v71(_, v41, v42) --[[ Line: 157 ]] --[[ Name: makeSlider ]]
        -- upvalues: v6 (ref), v1 (ref), v3 (ref), v29 (copy), l_UserInputService_0 (ref)
        local v43 = v6:Clone();
        v43.Label.Text = v41;
        local l_Bar_0 = v43.Bar;
        local l_Padding_0 = l_Bar_0.Padding;
        local l_Dragger_0 = l_Padding_0.Dragger;
        local v47 = false;
        local v48 = Vector3.new();
        local v49 = v42.Step / (v42.Max - v42.Min);
        local function v56(v50, _) --[[ Line: 171 ]] --[[ Name: drag ]]
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
        local function _() --[[ Line: 190 ]] --[[ Name: comitChange ]]
            -- upvalues: l_Dragger_0 (copy), v42 (copy), v3 (ref), v29 (ref), v41 (copy)
            local l_Scale_0 = l_Dragger_0.Position.X.Scale;
            local v58 = v42.Min + l_Scale_0 * (v42.Max - v42.Min);
            v3:EditBindProperty(v29, v41, (math.clamp(v58, v42.Min, v42.Max)));
        end;
        local function v63() --[[ Line: 197 ]] --[[ Name: load ]]
            -- upvalues: v42 (copy), v49 (copy), v1 (ref), l_Bar_0 (copy), l_Dragger_0 (copy)
            local v60 = math.floor((v42.Value - v42.Min) / (v42.Max - v42.Min) / v49 + 0.5) * v49;
            local v61 = v1.getStringRoundingCharacter(v42.Step);
            local v62 = v42.Value < 1 and "0$" or "the fitness gram pacer test";
            l_Bar_0.Value.Text = string.format(v61, v42.Value):gsub(v62, "") .. " " .. v42.Suffix;
            l_Dragger_0.Position = UDim2.new(v60, 0, 0.5, 0);
        end;
        l_UserInputService_0.InputChanged:Connect(function(v64, _) --[[ Line: 209 ]]
            -- upvalues: v56 (copy), v48 (ref)
            if v64.UserInputType == Enum.UserInputType.MouseMovement then
                v56(v64.Position, v64.Position - v48);
                v48 = v64.Position;
            end;
        end);
        l_UserInputService_0.InputEnded:Connect(function(v66, _) --[[ Line: 216 ]]
            -- upvalues: v47 (ref), l_Dragger_0 (copy), v42 (copy), v3 (ref), v29 (ref), v41 (copy)
            if v66.UserInputType == Enum.UserInputType.MouseButton1 then
                if v47 then
                    local l_Scale_1 = l_Dragger_0.Position.X.Scale;
                    local v69 = v42.Min + l_Scale_1 * (v42.Max - v42.Min);
                    v3:EditBindProperty(v29, v41, (math.clamp(v69, v42.Min, v42.Max)));
                end;
                v47 = false;
            end;
        end);
        l_Dragger_0.MouseButton1Down:Connect(function() --[[ Line: 226 ]]
            -- upvalues: v47 (ref)
            v47 = true;
        end);
        v3.BindChanged:Connect(function(v70) --[[ Line: 230 ]]
            -- upvalues: v41 (copy), v63 (copy)
            if v70 == v41 then
                v63();
            end;
        end);
        v63();
        return v43;
    end;
    local function v99(v72, v73, v74) --[[ Line: 245 ]] --[[ Name: makeDropdown ]]
        -- upvalues: v7 (ref), v0 (ref), v2 (ref), v3 (ref)
        local v75 = v7:Clone();
        v75.Label.Text = v73;
        v75.Dropdown.InnerBox.Label.Text = v74.Value;
        local v76 = {};
        local v77 = true;
        local function _(v78) --[[ Line: 255 ]] --[[ Name: setZIndex ]]
            -- upvalues: v75 (copy)
            v75.Dropdown.ZIndex = 12 + v78;
            v75.Dropdown.InnerBox.ZIndex = 13 + v78;
            v75.Dropdown.InnerBox.Triangle.ZIndex = 14 + v78;
            v75.Dropdown.InnerBox.Label.ZIndex = 14 + v78;
            v75.Dropdown.Shadow.ZIndex = 11 + v78;
        end;
        local function v82() --[[ Line: 263 ]] --[[ Name: close ]]
            -- upvalues: v76 (ref), v0 (ref), v75 (copy), v77 (ref)
            for _, v81 in next, v76 do
                v0.destroy(v81, "MouseEnter", "MouseButton1Click");
            end;
            v75.Dropdown.Size = UDim2.new(0, 71, 0, 27);
            v75.Dropdown.InnerBox.Label.Visible = true;
            v75.Dropdown.InnerBox.Triangle.Visible = true;
            v76 = {};
            v75.Dropdown.ZIndex = 12;
            v75.Dropdown.InnerBox.ZIndex = 13;
            v75.Dropdown.InnerBox.Triangle.ZIndex = 14;
            v75.Dropdown.InnerBox.Label.ZIndex = 14;
            v75.Dropdown.Shadow.ZIndex = 11;
            v77 = true;
        end;
        local _ = function(v83) --[[ Line: 277 ]] --[[ Name: highlight ]]
            -- upvalues: v76 (ref)
            for _, v85 in next, v76 do
                v85.BackgroundTransparency = v85 == v83 and 0 or 1;
            end;
        end;
        local function v97() --[[ Line: 283 ]] --[[ Name: open ]]
            -- upvalues: v82 (copy), v74 (copy), v75 (copy), v2 (ref), v76 (ref), v3 (ref), v72 (copy), v73 (copy), v77 (ref)
            v82();
            local v87 = 27;
            for v88, v89 in next, v74.List do
                local l_TextButton_0 = Instance.new("TextButton");
                l_TextButton_0.Size = UDim2.new(1, -2, 0, 25);
                l_TextButton_0.Position = UDim2.new(0, 1, 0, (v88 - 1) * 25 + 3);
                l_TextButton_0.ZIndex = 100;
                l_TextButton_0.BackgroundTransparency = 1;
                l_TextButton_0.BorderSizePixel = 0;
                l_TextButton_0.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
                l_TextButton_0.Font = Enum.Font.SourceSans;
                l_TextButton_0.TextSize = 18;
                l_TextButton_0.TextTransparency = 0.5;
                l_TextButton_0.TextColor3 = Color3.new();
                l_TextButton_0.TextStrokeTransparency = 1;
                l_TextButton_0.Text = v89;
                l_TextButton_0.AutoButtonColor = false;
                l_TextButton_0.Parent = v75.Dropdown;
                l_TextButton_0.MouseEnter:Connect(function() --[[ Line: 305 ]]
                    -- upvalues: v2 (ref), l_TextButton_0 (copy), v76 (ref)
                    v2:PlaySound("Interface.Click");
                    local l_l_TextButton_0_0 = l_TextButton_0;
                    for _, v93 in next, v76 do
                        v93.BackgroundTransparency = v93 == l_l_TextButton_0_0 and 0 or 1;
                    end;
                end);
                l_TextButton_0.MouseButton1Click:Connect(function() --[[ Line: 310 ]]
                    -- upvalues: v2 (ref), v75 (ref), v89 (copy), v3 (ref), v72 (ref), v73 (ref), v82 (ref)
                    v2:PlaySound("Interface.Click");
                    v75.Dropdown.InnerBox.Label.Text = v89;
                    v3:EditBindProperty(v72, v73, v89);
                    v82();
                end);
                v76[v88] = l_TextButton_0;
            end;
            if #v74.List > 0 then
                v87 = #v74.List * 25 + 6;
            end;
            v75.Dropdown.Size = UDim2.new(0, 71, 0, v87);
            v75.Dropdown.InnerBox.Label.Visible = false;
            v75.Dropdown.InnerBox.Triangle.Visible = false;
            local v94 = v76[1];
            for _, v96 in next, v76 do
                v96.BackgroundTransparency = v96 == v94 and 0 or 1;
            end;
            v75.Dropdown.ZIndex = 62;
            v75.Dropdown.InnerBox.ZIndex = 63;
            v75.Dropdown.InnerBox.Triangle.ZIndex = 64;
            v75.Dropdown.InnerBox.Label.ZIndex = 64;
            v75.Dropdown.Shadow.ZIndex = 61;
            v77 = false;
        end;
        v75.Dropdown.MouseButton1Click:Connect(function() --[[ Line: 335 ]]
            -- upvalues: v2 (ref), v97 (copy)
            v2:PlaySound("Interface.Click");
            v97();
        end);
        v75.Dropdown.MouseLeave:Connect(function() --[[ Line: 340 ]]
            -- upvalues: v77 (ref), v2 (ref), v82 (copy)
            if not v77 then
                v2:PlaySound("Interface.Click");
            end;
            v82();
        end);
        v3.BindChanged:Connect(function(v98) --[[ Line: 348 ]]
            -- upvalues: v73 (copy), v75 (copy), v74 (copy)
            if v98 == v73 then
                v75.Dropdown.InnerBox.Label.Text = v74.Value;
            end;
        end);
        return v75;
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
    local v100 = {
        number = 1, 
        string = 2
    };
    local v101 = {
        number = v71, 
        string = v99
    };
    local v102 = {};
    for v103, v104 in next, v30 do
        if v103 ~= "Key" and type(v104) == "table" then
            table.insert(v102, v103);
        end;
    end;
    table.sort(v102, function(v105, v106) --[[ Line: 390 ]]
        -- upvalues: v30 (copy), v100 (copy)
        local v107 = v30[v105];
        local v108 = v30[v106];
        return v100[type(v107.Value)] < v100[type(v108.Value)];
    end);
    if #v102 > 0 then
        for v109 = 1, #v102 do
            local v110 = v109 == 1 and 45 or 40;
            local v111 = v102[v109];
            local v112 = v30[v111];
            local v113 = v101[type(v112.Value)];
            if v113 then
                local v114 = v113(v29, v111, v112);
                v114.Position = UDim2.new(0, 0, 0, (v109 - 1) * 40 + 7);
                v114.Parent = v28.Main.OuterBox.InnerBox;
                v28.Main.OuterBox.Size = v28.Main.OuterBox.Size + UDim2.new(0, 0, 0, v110);
                v28.Size = v28.Size + UDim2.new(0, 0, 0, v110);
            end;
        end;
    else
        v28.Main.OuterBox.Visible = false;
    end;
    l_Edit_0.MouseButton1Click:Connect(function() --[[ Line: 419 ]]
        -- upvalues: v2 (ref), v33 (ref), v36 (copy), v20 (ref), v3 (ref), v29 (copy), v27 (ref), l_Key_0 (copy), v28 (copy), v37 (copy)
        v2:PlaySound("Interface.Click");
        if v33 then
            return;
        else
            v33 = true;
            v36();
            local v115 = v20();
            if v115 then
                v3:SetKeyBind(v29, v115);
                v27(l_Key_0, v115);
            end;
            v28.Main.InnerBox.Label.TextColor3 = Color3.fromRGB(15, 15, 15);
            v37();
            v33 = false;
            return;
        end;
    end);
    v3.BindOverwritten:Connect(function(v116) --[[ Line: 442 ]]
        -- upvalues: v29 (copy), l_Key_0 (copy), v28 (copy)
        if v116 == v29 then
            l_Key_0.Visible = false;
            v28.Main.InnerBox.Label.TextColor3 = Color3.new(1, 0.3, 0.3);
        end;
    end);
    v3.BindChanged:Connect(function(v117) --[[ Line: 449 ]]
        -- upvalues: v29 (copy), v3 (ref), v27 (ref), l_Key_0 (copy), v37 (copy), v28 (copy)
        if v117 == v29 then
            local l_v3_Bind_1 = v3:GetBind(v29);
            local v119 = l_v3_Bind_1 and l_v3_Bind_1.Key or nil;
            if v119 then
                v27(l_Key_0, v119);
                v37();
                v28.Main.InnerBox.Label.TextColor3 = Color3.fromRGB(15, 15, 15);
                return;
            else
                l_Key_0.Visible = false;
                v28.Main.InnerBox.Label.TextColor3 = Color3.new(1, 0.3, 0.3);
            end;
        end;
    end);
end;