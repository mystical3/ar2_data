local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "UserSettings");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_v2_Storage_0 = v2:GetStorage("GameMenu");
local v6 = l_v2_Storage_0:WaitForChild("Keybind Slider");
local v7 = l_v2_Storage_0:WaitForChild("Keybind Dropdown");
return function(v8, v9, v10) --[[ Line: 22 ]]
    -- upvalues: v6 (copy), v1 (copy), v3 (copy), l_UserInputService_0 (copy), v7 (copy), v0 (copy), v2 (copy)
    local function v40(v11, v12, v13) --[[ Line: 25 ]] --[[ Name: makeSlider ]]
        -- upvalues: v6 (ref), v1 (ref), v3 (ref), v9 (copy), l_UserInputService_0 (ref)
        local v14 = v6:Clone();
        v14.Label.Text = v12;
        v14.Label.Backdrop.Text = v12;
        local l_Bar_0 = v14.Bar;
        local l_Padding_0 = l_Bar_0.Padding;
        local l_Dragger_0 = l_Padding_0.Dragger;
        local v18 = false;
        local v19 = Vector3.new();
        local v20 = v13.Step / (v13.Max - v13.Min);
        local function v27(v21, _) --[[ Line: 40 ]] --[[ Name: drag ]]
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
        local function v30() --[[ Line: 59 ]] --[[ Name: comitChange ]]
            -- upvalues: l_Dragger_0 (copy), v13 (copy), v3 (ref), v9 (ref), v12 (copy)
            local l_Scale_0 = l_Dragger_0.Position.X.Scale;
            local v29 = v13.Min + l_Scale_0 * (v13.Max - v13.Min);
            v3:Change(v9, v12, (math.clamp(v29, v13.Min, v13.Max)));
        end;
        local function v34() --[[ Line: 66 ]] --[[ Name: load ]]
            -- upvalues: v13 (copy), v20 (copy), v1 (ref), l_Bar_0 (copy), l_Dragger_0 (copy)
            local v31 = math.floor((v13.Value - v13.Min) / (v13.Max - v13.Min) / v20 + 0.5) * v20;
            local v32 = v1.getStringRoundingCharacter(v13.Step);
            local v33 = v13.Value < 1 and "0$" or "the fitness gram pacer test";
            l_Bar_0.Value.Text = string.format(v32, v13.Value):gsub(v33, "") .. " " .. v13.Suffix;
            l_Dragger_0.Position = UDim2.new(v31, 0, 0.5, 0);
        end;
        l_UserInputService_0.InputChanged:Connect(function(v35, _) --[[ Line: 78 ]]
            -- upvalues: v27 (copy), v19 (ref)
            if v35.UserInputType == Enum.UserInputType.MouseMovement then
                v27(v35.Position, v35.Position - v19);
                v19 = v35.Position;
            end;
        end);
        l_UserInputService_0.InputEnded:Connect(function(v37, _) --[[ Line: 85 ]]
            -- upvalues: v18 (ref), v30 (copy)
            if v37.UserInputType == Enum.UserInputType.MouseButton1 then
                if v18 then
                    coroutine.wrap(v30)();
                end;
                v18 = false;
            end;
        end);
        l_Dragger_0.MouseButton1Down:Connect(function() --[[ Line: 95 ]]
            -- upvalues: v18 (ref)
            v18 = true;
        end);
        v3:BindToSetting(v11, v12, function(_) --[[ Line: 99 ]]
            -- upvalues: v34 (copy)
            v34();
        end);
        v34();
        return v14;
    end;
    local function v68(v41, v42, v43) --[[ Line: 112 ]] --[[ Name: makeDropdown ]]
        -- upvalues: v7 (ref), v0 (ref), v2 (ref), v3 (ref)
        local v44 = v7:Clone();
        v44.Label.Text = v42;
        v44.Label.Backdrop.Text = v42;
        v44.Dropdown.InnerBox.Label.Text = v43.Value;
        local v45 = {};
        local v46 = true;
        local function _(v47) --[[ Line: 123 ]] --[[ Name: setZIndex ]]
            -- upvalues: v44 (copy)
            v44.Dropdown.ZIndex = 12 + v47;
            v44.Dropdown.InnerBox.ZIndex = 13 + v47;
            v44.Dropdown.InnerBox.Triangle.ZIndex = 14 + v47;
            v44.Dropdown.InnerBox.Label.ZIndex = 14 + v47;
            v44.Dropdown.Shadow.ZIndex = 11 + v47;
        end;
        local function v51() --[[ Line: 131 ]] --[[ Name: close ]]
            -- upvalues: v45 (ref), v0 (ref), v44 (copy), v46 (ref)
            for _, v50 in next, v45 do
                v0.destroy(v50, "MouseEnter", "MouseButton1Click");
            end;
            v44.Dropdown.Size = UDim2.new(0, 71, 0, 27);
            v44.Dropdown.InnerBox.Label.Visible = true;
            v44.Dropdown.InnerBox.Triangle.Visible = true;
            v45 = {};
            v44.Dropdown.ZIndex = 62;
            v44.Dropdown.InnerBox.ZIndex = 63;
            v44.Dropdown.InnerBox.Triangle.ZIndex = 64;
            v44.Dropdown.InnerBox.Label.ZIndex = 64;
            v44.Dropdown.Shadow.ZIndex = 61;
            v46 = true;
        end;
        local _ = function(v52) --[[ Line: 145 ]] --[[ Name: highlight ]]
            -- upvalues: v45 (ref)
            for _, v54 in next, v45 do
                v54.BackgroundTransparency = v54 == v52 and 0 or 1;
            end;
        end;
        local function v66() --[[ Line: 151 ]] --[[ Name: open ]]
            -- upvalues: v51 (copy), v43 (copy), v44 (copy), v45 (ref), v2 (ref), v3 (ref), v41 (copy), v42 (copy), v46 (ref)
            v51();
            local v56 = 27;
            for v57, v58 in next, v43.List do
                local l_TextButton_0 = Instance.new("TextButton");
                l_TextButton_0.Size = UDim2.new(1, -2, 0, 25);
                l_TextButton_0.Position = UDim2.new(0, 1, 0, (v57 - 1) * 25 + 3);
                l_TextButton_0.ZIndex = 100;
                l_TextButton_0.BackgroundTransparency = 1;
                l_TextButton_0.BorderSizePixel = 0;
                l_TextButton_0.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
                l_TextButton_0.Font = Enum.Font.SourceSans;
                l_TextButton_0.TextSize = 18;
                l_TextButton_0.TextTransparency = 0;
                l_TextButton_0.TextColor3 = Color3.new(1, 1, 1);
                l_TextButton_0.TextStrokeTransparency = 1;
                l_TextButton_0.Text = v58;
                l_TextButton_0.AutoButtonColor = false;
                l_TextButton_0.Parent = v44.Dropdown;
                l_TextButton_0.MouseEnter:Connect(function() --[[ Line: 173 ]]
                    -- upvalues: l_TextButton_0 (copy), v45 (ref)
                    local l_l_TextButton_0_0 = l_TextButton_0;
                    for _, v62 in next, v45 do
                        v62.BackgroundTransparency = v62 == l_l_TextButton_0_0 and 0 or 1;
                    end;
                end);
                l_TextButton_0.MouseButton1Click:Connect(function() --[[ Line: 178 ]]
                    -- upvalues: v2 (ref), v44 (ref), v58 (copy), v3 (ref), v41 (ref), v42 (ref), v51 (ref)
                    v2:PlaySound("Interface.Click");
                    v44.Dropdown.InnerBox.Label.Text = v58;
                    v3:Change(v41, v42, v58);
                    v51();
                end);
                v45[v57] = l_TextButton_0;
            end;
            if #v43.List > 0 then
                v56 = #v43.List * 25 + 6;
            end;
            v44.Dropdown.Size = UDim2.new(0, 71, 0, v56);
            v44.Dropdown.InnerBox.Label.Visible = false;
            v44.Dropdown.InnerBox.Triangle.Visible = false;
            local v63 = v45[1];
            for _, v65 in next, v45 do
                v65.BackgroundTransparency = v65 == v63 and 0 or 1;
            end;
            v44.Dropdown.ZIndex = 82;
            v44.Dropdown.InnerBox.ZIndex = 83;
            v44.Dropdown.InnerBox.Triangle.ZIndex = 84;
            v44.Dropdown.InnerBox.Label.ZIndex = 84;
            v44.Dropdown.Shadow.ZIndex = 81;
            v46 = false;
        end;
        v44.Dropdown.MouseButton1Click:Connect(function() --[[ Line: 203 ]]
            -- upvalues: v2 (ref), v66 (copy)
            v2:PlaySound("Interface.Click");
            v66();
        end);
        v44.Dropdown.MouseLeave:Connect(function() --[[ Line: 208 ]]
            -- upvalues: v46 (ref), v2 (ref), v51 (copy)
            if not v46 then
                v2:PlaySound("Interface.Click");
            end;
            v51();
        end);
        v3:BindToSetting(v41, v42, function(v67) --[[ Line: 216 ]]
            -- upvalues: v44 (copy)
            v44.Dropdown.InnerBox.Label.Text = v67;
        end);
        return v44;
    end;
    v8.Main.InnerBox.Label.Text = v9;
    v8.Main.InnerBox.Label.Backdrop.Text = v9;
    local v69 = {
        number = 1, 
        string = 2
    };
    local v70 = {
        number = v40, 
        string = v68
    };
    local v71 = {};
    for v72, v73 in next, v10 do
        if type(v73) == "table" then
            table.insert(v71, v72);
        end;
    end;
    table.sort(v71, function(v74, v75) --[[ Line: 247 ]]
        -- upvalues: v10 (copy), v69 (copy)
        local v76 = v10[v74];
        local v77 = v10[v75];
        local v78 = v69[type(v76.Value)];
        local v79 = v69[type(v77.Value)];
        if v78 == v79 then
            return v74 < v75;
        else
            return v79 < v78;
        end;
    end);
    if #v71 > 0 then
        for v80 = 1, #v71 do
            local v81 = v80 == 1 and 45 or 40;
            local v82 = v71[v80];
            local v83 = v10[v82];
            local v84 = v70[type(v83.Value)];
            if v84 then
                local v85 = v84(v9, v82, v83);
                v85.Position = UDim2.new(0, 0, 0, (v80 - 1) * 40 + 7);
                v85.Parent = v8.Main.OuterBox.InnerBox;
                v8.Main.OuterBox.Size = v8.Main.OuterBox.Size + UDim2.new(0, 0, 0, v81);
                v8.Size = v8.Size + UDim2.new(0, 0, 0, v81);
            end;
        end;
        return;
    else
        v8.Main.OuterBox.Visible = false;
        return;
    end;
end;