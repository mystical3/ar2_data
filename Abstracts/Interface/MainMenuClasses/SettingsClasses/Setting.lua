local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "UserSettings");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_v2_Storage_0 = v2:GetStorage("MainMenu");
local v6 = l_v2_Storage_0:WaitForChild("Keybind Slider");
local v7 = l_v2_Storage_0:WaitForChild("Keybind Dropdown");
return function(v8, v9, v10) --[[ Line: 24 ]]
    -- upvalues: v6 (copy), v1 (copy), v3 (copy), l_UserInputService_0 (copy), v7 (copy), v0 (copy), v2 (copy)
    local function v42(v11, v12, v13) --[[ Line: 27 ]] --[[ Name: makeSlider ]]
        -- upvalues: v6 (ref), v1 (ref), v3 (ref), v9 (copy), l_UserInputService_0 (ref)
        local v14 = v6:Clone();
        v14.Label.Text = v12;
        local l_Bar_0 = v14.Bar;
        local l_Padding_0 = l_Bar_0.Padding;
        local l_Dragger_0 = l_Padding_0.Dragger;
        local v18 = false;
        local v19 = Vector3.new();
        local v20 = v13.Step / (v13.Max - v13.Min);
        local function v27(v21, _) --[[ Line: 41 ]] --[[ Name: drag ]]
            -- upvalues: v18 (ref), l_Padding_0 (copy), v20 (copy), v13 (copy), v1 (ref), l_Dragger_0 (copy), l_Bar_0 (copy), v3 (ref), v9 (ref), v12 (copy)
            if not v18 then
                return;
            else
                local v23 = math.floor(math.clamp((v21.X - l_Padding_0.AbsolutePosition.X) / l_Padding_0.AbsoluteSize.X, 0, 1) / v20 + 0.5) * v20;
                local v24 = v13.Min + v23 * (v13.Max - v13.Min);
                local v25 = v1.getStringRoundingCharacter(v13.Step);
                local v26 = v24 < 1 and "0$" or "the fitness gram pacer test";
                l_Dragger_0.Position = UDim2.new(v23, 0, 0.5, 0);
                l_Bar_0.Value.Text = string.format(v25, v24):gsub(v26, "") .. " " .. v13.Suffix;
                v3:Change(v9, v12, math.clamp(v24, v13.Min, v13.Max), true);
                return;
            end;
        end;
        local function _() --[[ Line: 60 ]] --[[ Name: comitChange ]]
            -- upvalues: l_Dragger_0 (copy), v13 (copy), v3 (ref), v9 (ref), v12 (copy)
            local l_Scale_0 = l_Dragger_0.Position.X.Scale;
            local v29 = v13.Min + l_Scale_0 * (v13.Max - v13.Min);
            v3:Change(v9, v12, (math.clamp(v29, v13.Min, v13.Max)));
        end;
        local function v34() --[[ Line: 67 ]] --[[ Name: load ]]
            -- upvalues: v13 (copy), v20 (copy), v1 (ref), l_Bar_0 (copy), l_Dragger_0 (copy)
            local v31 = math.floor((v13.Value - v13.Min) / (v13.Max - v13.Min) / v20 + 0.5) * v20;
            local v32 = v1.getStringRoundingCharacter(v13.Step);
            local v33 = v13.Value < 1 and "0$" or "the fitness gram pacer test";
            l_Bar_0.Value.Text = string.format(v32, v13.Value):gsub(v33, "") .. " " .. v13.Suffix;
            l_Dragger_0.Position = UDim2.new(v31, 0, 0.5, 0);
        end;
        l_UserInputService_0.InputChanged:Connect(function(v35, _) --[[ Line: 79 ]]
            -- upvalues: v27 (copy), v19 (ref)
            if v35.UserInputType == Enum.UserInputType.MouseMovement then
                v27(v35.Position, v35.Position - v19);
                v19 = v35.Position;
            end;
        end);
        l_UserInputService_0.InputEnded:Connect(function(v37, _) --[[ Line: 86 ]]
            -- upvalues: v18 (ref), l_Dragger_0 (copy), v13 (copy), v3 (ref), v9 (ref), v12 (copy)
            if v37.UserInputType == Enum.UserInputType.MouseButton1 then
                if v18 then
                    local l_Scale_1 = l_Dragger_0.Position.X.Scale;
                    local v40 = v13.Min + l_Scale_1 * (v13.Max - v13.Min);
                    v3:Change(v9, v12, (math.clamp(v40, v13.Min, v13.Max)));
                end;
                v18 = false;
            end;
        end);
        l_Dragger_0.MouseButton1Down:Connect(function() --[[ Line: 96 ]]
            -- upvalues: v18 (ref)
            v18 = true;
        end);
        v3:BindToSetting(v11, v12, function(_) --[[ Line: 100 ]]

        end);
        v34();
        return v14;
    end;
    local function v70(v43, v44, v45) --[[ Line: 113 ]] --[[ Name: makeDropdown ]]
        -- upvalues: v7 (ref), v0 (ref), v2 (ref), v3 (ref)
        local v46 = v7:Clone();
        v46.Label.Text = v44;
        v46.Dropdown.InnerBox.Label.Text = v45.Value;
        local v47 = {};
        local v48 = true;
        local function _(v49) --[[ Line: 123 ]] --[[ Name: setZIndex ]]
            -- upvalues: v46 (copy)
            v46.Dropdown.ZIndex = 12 + v49;
            v46.Dropdown.InnerBox.ZIndex = 13 + v49;
            v46.Dropdown.InnerBox.Triangle.ZIndex = 14 + v49;
            v46.Dropdown.InnerBox.Label.ZIndex = 14 + v49;
            v46.Dropdown.Shadow.ZIndex = 11 + v49;
        end;
        local function v53() --[[ Line: 131 ]] --[[ Name: close ]]
            -- upvalues: v47 (ref), v0 (ref), v46 (copy), v48 (ref)
            for _, v52 in next, v47 do
                v0.destroy(v52, "MouseEnter", "MouseLeave");
            end;
            v46.Dropdown.Size = UDim2.new(0, 71, 0, 27);
            v46.Dropdown.InnerBox.Label.Visible = true;
            v46.Dropdown.InnerBox.Triangle.Visible = true;
            v47 = {};
            v46.Dropdown.ZIndex = 12;
            v46.Dropdown.InnerBox.ZIndex = 13;
            v46.Dropdown.InnerBox.Triangle.ZIndex = 14;
            v46.Dropdown.InnerBox.Label.ZIndex = 14;
            v46.Dropdown.Shadow.ZIndex = 11;
            v48 = true;
        end;
        local _ = function(v54) --[[ Line: 145 ]] --[[ Name: highlight ]]
            -- upvalues: v47 (ref)
            for _, v56 in next, v47 do
                v56.BackgroundTransparency = v56 == v54 and 0 or 1;
            end;
        end;
        local function v68() --[[ Line: 151 ]] --[[ Name: open ]]
            -- upvalues: v53 (copy), v45 (copy), v46 (copy), v47 (ref), v2 (ref), v3 (ref), v43 (copy), v44 (copy), v48 (ref)
            v53();
            local v58 = 27;
            for v59, v60 in next, v45.List do
                local l_TextButton_0 = Instance.new("TextButton");
                l_TextButton_0.Size = UDim2.new(1, -2, 0, 25);
                l_TextButton_0.Position = UDim2.new(0, 1, 0, (v59 - 1) * 25 + 3);
                l_TextButton_0.ZIndex = 100;
                l_TextButton_0.BackgroundTransparency = 1;
                l_TextButton_0.BorderSizePixel = 0;
                l_TextButton_0.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
                l_TextButton_0.Font = Enum.Font.SourceSans;
                l_TextButton_0.TextSize = 18;
                l_TextButton_0.TextTransparency = 0.5;
                l_TextButton_0.TextColor3 = Color3.new();
                l_TextButton_0.TextStrokeTransparency = 1;
                l_TextButton_0.Text = v60;
                l_TextButton_0.AutoButtonColor = false;
                l_TextButton_0.Parent = v46.Dropdown;
                l_TextButton_0.MouseEnter:Connect(function() --[[ Line: 173 ]]
                    -- upvalues: l_TextButton_0 (copy), v47 (ref)
                    local l_l_TextButton_0_0 = l_TextButton_0;
                    for _, v64 in next, v47 do
                        v64.BackgroundTransparency = v64 == l_l_TextButton_0_0 and 0 or 1;
                    end;
                end);
                l_TextButton_0.MouseButton1Click:Connect(function() --[[ Line: 178 ]]
                    -- upvalues: v2 (ref), v46 (ref), v60 (copy), v3 (ref), v43 (ref), v44 (ref), v53 (ref)
                    v2:PlaySound("Interface.Click");
                    v46.Dropdown.InnerBox.Label.Text = v60;
                    v3:Change(v43, v44, v60);
                    v53();
                end);
                v47[v59] = l_TextButton_0;
            end;
            if #v45.List > 0 then
                v58 = #v45.List * 25 + 6;
            end;
            v46.Dropdown.Size = UDim2.new(0, 71, 0, v58);
            v46.Dropdown.InnerBox.Label.Visible = false;
            v46.Dropdown.InnerBox.Triangle.Visible = false;
            local v65 = v47[1];
            for _, v67 in next, v47 do
                v67.BackgroundTransparency = v67 == v65 and 0 or 1;
            end;
            v46.Dropdown.ZIndex = 62;
            v46.Dropdown.InnerBox.ZIndex = 63;
            v46.Dropdown.InnerBox.Triangle.ZIndex = 64;
            v46.Dropdown.InnerBox.Label.ZIndex = 64;
            v46.Dropdown.Shadow.ZIndex = 61;
            v48 = false;
        end;
        v46.Dropdown.MouseButton1Click:Connect(function() --[[ Line: 203 ]]
            -- upvalues: v2 (ref), v68 (copy)
            v2:PlaySound("Interface.Click");
            v68();
        end);
        v46.Dropdown.MouseLeave:Connect(function() --[[ Line: 208 ]]
            -- upvalues: v48 (ref), v2 (ref), v53 (copy)
            if not v48 then
                v2:PlaySound("Interface.Click");
            end;
            v53();
        end);
        v3:BindToSetting(v43, v44, function(v69) --[[ Line: 216 ]]
            -- upvalues: v46 (copy)
            v46.Dropdown.InnerBox.Label.Text = v69;
        end);
        return v46;
    end;
    v8.Main.InnerBox.Label.Text = v9;
    v8.Main.InnerBox.Label.Backdrop.Text = v9;
    local v71 = {
        number = 1, 
        string = 2
    };
    local v72 = {
        number = v42, 
        string = v70
    };
    local v73 = {};
    for v74, v75 in next, v10 do
        if type(v75) == "table" then
            table.insert(v73, v74);
        end;
    end;
    table.sort(v73, function(v76, v77) --[[ Line: 247 ]]
        -- upvalues: v10 (copy), v71 (copy)
        local v78 = v10[v76];
        local v79 = v10[v77];
        local v80 = v71[type(v78.Value)];
        local v81 = v71[type(v79.Value)];
        if v80 == v81 then
            return v76 < v77;
        else
            return v81 < v80;
        end;
    end);
    if #v73 > 0 then
        for v82 = 1, #v73 do
            local v83 = v82 == 1 and 45 or 40;
            local v84 = v73[v82];
            local v85 = v10[v84];
            local v86 = v72[type(v85.Value)];
            if v86 then
                local v87 = v86(v9, v84, v85);
                v87.Position = UDim2.new(0, 0, 0, (v82 - 1) * 40 + 7);
                v87.Parent = v8.Main.OuterBox.InnerBox;
                v8.Main.OuterBox.Size = v8.Main.OuterBox.Size + UDim2.new(0, 0, 0, v83);
                v8.Size = v8.Size + UDim2.new(0, 0, 0, v83);
            end;
        end;
        return;
    else
        v8.Main.OuterBox.Visible = false;
        return;
    end;
end;