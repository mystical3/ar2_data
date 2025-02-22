local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Configs", "ItemData");
local v3 = v0.require("Configs", "CreatorData");
local v4 = v0.require("Libraries", "Interface");
local v5 = v0.require("Libraries", "Network");
local v6 = v0.require("Libraries", "Resources");
local v7 = v0.require("Libraries", "GunBuilder");
local v8 = v0.require("Libraries", "Discovery");
local _ = v0.require("Libraries", "Welds");
local v10 = v0.require("Libraries", "Cameras");
local v11 = v0.require("Libraries", "ViewportIcons");
local v12 = v0.require("Libraries", "Wardrobe");
local v13 = v0.require("Libraries", "UserSettings");
local v14 = v0.require("Libraries", "ColorVariants");
local v15 = v0.require("Classes", "Signals");
local v16 = v0.require("Classes", "Animators");
local v17 = v0.require("Classes", "Maids");
local v18 = v0.require("Classes", "Items");
local v19 = v4:Get("Fade");
local l_v4_Storage_0 = v4:GetStorage("MainMenu");
local l_v10_Camera_0 = v10:GetCamera("MainMenu");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("TweenService");
local l_TextService_0 = game:GetService("TextService");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_Players_0 = game:GetService("Players");
local l_HttpService_0 = game:GetService("HttpService");
local v29 = nil;
local v30 = nil;
local v31 = nil;
local v32 = nil;
local v33 = nil;
local v34 = nil;
local v35 = nil;
local v36 = nil;
local v37 = nil;
local v38 = nil;
local v39 = nil;
local v40 = nil;
local v41 = nil;
local v42 = nil;
local v43 = nil;
local v44 = nil;
local v45 = nil;
local v46 = nil;
local v47 = nil;
local v48 = nil;
local v49 = {};
local v50 = {};
local v51 = {};
local v52 = false;
local v53 = {
    AnchorPoint = Vector2.new(0, 0), 
    Position = UDim2.new(0, 1, 0, 483), 
    Size = UDim2.new(0, 341, 0, 82)
};
local v54 = {
    AnchorPoint = Vector2.new(0.5, 1), 
    Position = UDim2.new(0.5, 0, 1, -40), 
    Size = UDim2.new(0, 302, 0, 82)
};
local v55 = {
    Purchasable = 10, 
    Purchased = 10, 
    NoneLock = 8, 
    Unlocked = 4, 
    Locked = 4
};
local v56 = {
    Accessory = {
        "1", 
        "2"
    }, 
    Belt = true, 
    Bottom = true, 
    Hat = true, 
    Top = true, 
    Vest = true
};
local v57 = {
    Gamepasses = {}, 
    Outfits = {}
};
local _ = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
local v59 = Color3.fromRGB(255, 180, 10);
local v60 = CFrame.new(0, 1.3, 0) * CFrame.Angles(0, 2.792526803190927, 0) * CFrame.Angles(-0.17453292519943295, 0, 0) * CFrame.new(0, 0, 24);
local v61 = "None";
local v62 = "Default";
local v63 = {};
local v64 = {};
local v65 = {};
local v66 = {};
local v67 = {};
local v68 = {};
local v69 = {};
local v70 = v15.new();
local v71 = Random.new();
local function v78(v72) --[[ Line: 136 ]] --[[ Name: pickRandom ]]
    -- upvalues: v71 (copy)
    local v73 = {};
    local v74 = 0;
    for v75, _ in next, v72 do
        v74 = v74 + 1;
        table.insert(v73, v75);
    end;
    local v77 = v73[v71:NextInteger(1, #v73)];
    return v77, v72[v77];
end;
local function _(v79, v80, v81, v82) --[[ Line: 151 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    return l_TextService_0:GetTextSize(v79, v80.TextSize, v80.Font, Vector2.new(v81 or 1000, v82 or 1000));
end;
local function v92(v84, v85, v86) --[[ Line: 164 ]] --[[ Name: splitIntoLines ]]
    -- upvalues: l_TextService_0 (copy)
    local v87 = Vector2.new(1000, 1000);
    local v88 = {};
    local v89 = "";
    for v90 in v84:gmatch("%S+") do
        local l_v90_0 = v90;
        if v89 ~= "" then
            l_v90_0 = v89 .. " " .. v90;
        end;
        if v86 < l_TextService_0:GetTextSize(l_v90_0, v85.TextSize, v85.Font, v87).X then
            table.insert(v88, v89);
            v89 = v90;
        else
            v89 = l_v90_0;
        end;
    end;
    table.insert(v88, v89);
    return v88;
end;
local function v100(v93) --[[ Line: 191 ]] --[[ Name: findOutfit ]]
    -- upvalues: v3 (copy)
    for v94, v95 in next, v3.Outfits do
        if v95.OffSale ~= true then
            for _, v97 in next, v95.Equipment do
                if typeof(v97) == "table" then
                    for _, v99 in next, v97 do
                        if v99 == v93 then
                            return v94, v95;
                        end;
                    end;
                elseif v97 == v93 then
                    return v94, v95;
                end;
            end;
        end;
    end;
    return nil, nil;
end;
local function v104(v101) --[[ Line: 212 ]] --[[ Name: findBundle ]]
    -- upvalues: v3 (copy)
    for _, v103 in next, v3.Bundles do
        if v103.OffSale ~= true and table.find(v103.Outfits, v101) then
            return v103;
        end;
    end;
    return nil;
end;
local function v110(v105) --[[ Line: 222 ]] --[[ Name: isBundleBonusItem ]]
    -- upvalues: v3 (copy)
    for _, v107 in next, v3.Bundles do
        for _, v109 in next, v107.BonusItems do
            if v109 == v105 then
                return true;
            end;
        end;
    end;
    return false;
end;
local function v123(v111, v112, v113, v114) --[[ Line: 234 ]] --[[ Name: setHair ]]
    -- upvalues: v29 (ref), v57 (ref), v3 (copy), v66 (ref), v39 (ref), v59 (copy), v2 (copy), v12 (copy), v11 (copy), v50 (ref), v5 (copy)
    if not v29 then
        return;
    else
        local _ = v29.Equipment:FindFirstChild("Hat");
        local v116 = v57.Gamepasses.HairColors == true;
        if v3.Hair.Colors[v112] == "Paid" and not v116 then
            v112 = v66.HairColor;
        end;
        for _, v118 in next, v39.Swatches:GetChildren() do
            for _, v120 in next, v118:GetChildren() do
                if v120.Name == v112 then
                    v120.ImageColor3 = v59;
                else
                    v120.ImageColor3 = Color3.new(1, 1, 1);
                end;
                if v118.Name == "Paid" then
                    v120.PaidCover.Visible = not v116;
                end;
            end;
        end;
        if v111 ~= "Bald" then
            local v121 = v2[v111];
            local l_v111_0 = v111;
            if v121 then
                l_v111_0 = v121.DisplayName or l_v111_0;
            end;
            v12:SetHair(v29, v111, v112);
            v11:SetViewportIcon(v50.Hair.Selected.Icon, v111, "Creator");
            v50.Hair.NameLine1.Text = l_v111_0;
            v50.Hair.NameLine2.Text = v112 or "???";
            v50.Hair.Selected.Visible = true;
            v50.Hair.Unselected.Visible = false;
        else
            v12:SetHair(v29, "Bald");
            v50.Hair.NameLine1.Text = "";
            v50.Hair.NameLine2.Text = "";
            v50.Hair.Selected.Visible = false;
            v50.Hair.Unselected.Visible = true;
        end;
        if v113 then
            v5:Send("Set Appearance Hair Color", v112);
            v5:Send("Set Appearance Hair Style", v111);
        end;
        if not v114 then
            v66.HairStyle = v111;
            v66.HairColor = v112;
        end;
        return;
    end;
end;
local function v129(v124, v125, v126) --[[ Line: 297 ]] --[[ Name: setSkinColor ]]
    -- upvalues: v3 (copy), v29 (ref), v12 (copy), v31 (ref), v59 (copy), v5 (copy), v66 (ref)
    if not v3.Body.Colors[v124] then
        return;
    elseif not v29 then
        return;
    else
        v12:SetSkinColor(v29, v3.Body.Colors[v124]);
        for _, v128 in next, v31.Swatches:GetChildren() do
            if v128:IsA("GuiButton") and tonumber(v128.Name) then
                if tonumber(v128.Name) == v124 then
                    v128.ImageColor3 = v59;
                else
                    v128.ImageColor3 = Color3.new(1, 1, 1);
                end;
            end;
        end;
        if v125 then
            v5:Send("Set Appearance Skin Color", v124);
        end;
        if not v126 then
            v66.SkinColor = v124;
        end;
        return;
    end;
end;
local function v141(v130, v131, v132, v133) --[[ Line: 327 ]] --[[ Name: setEquipSlot ]]
    -- upvalues: v2 (copy), v29 (ref), v12 (copy), v50 (ref), v92 (copy), v11 (copy), v5 (copy), v66 (ref)
    local v134 = nil;
    if typeof(v130) == "table" then
        local v135, v136 = unpack(v130);
        v130 = v135;
        v134 = v136;
    end;
    local v137 = v2[v131.Name];
    if not v29 then
        return;
    else
        if v130 == "Top" then
            if v131.Name == "Default" or v137 == nil then
                v12:UndressSlot(v29, "Top");
            else
                v12:DressShirt(v29, v131.Name);
            end;
        elseif v130 == "Bottom" then
            if v131.Name == "Default" or v137 == nil then
                v12:UndressSlot(v29, "Bottom");
            else
                v12:DressPants(v29, v131.Name);
            end;
        elseif v137 or v131.Name == "Default" then
            local l_v130_0 = v130;
            if v134 then
                l_v130_0 = v130 .. v134;
            end;
            v12:UndressSlot(v29, l_v130_0);
            if v131.Name ~= "Default" then
                v12:DressAccessory(v29, v131.Name, l_v130_0);
            end;
        end;
        local v139 = v50[v130];
        if v134 and v139[v134] then
            v139 = v139[v134];
        end;
        if v139 then
            if v131.Name ~= "Default" and v2[v131.Name] then
                local v140 = v92(v2[v131.Name].DisplayName, v139.NameLine1, v139.NameLine1.AbsoluteSize.X - 5);
                v139["NameLine" .. 1].Text = v140[1] or "";
                v139["NameLine" .. 2].Text = v140[2] or "";
                v11:SetViewportIcon(v139.Selected.Icon, v131.Name, "Creator");
                v139.Selected.Visible = true;
                v139.Unselected.Visible = false;
            else
                v139["NameLine" .. 1].Text = "";
                v139["NameLine" .. 2].Text = "";
                v139.Selected.Visible = false;
                v139.Unselected.Visible = true;
            end;
        end;
        if v132 then
            if v131.Name == "Default" then
                v5:Send("Clear Appearance Equipment Slot", v130, v134);
            else
                v5:Send("Set Appearance Equipment Slot", v130, v134, v131.Name);
            end;
        end;
        if not v133 then
            if v134 then
                v66.Equipment[v130][v134] = v131;
                return;
            else
                v66.Equipment[v130] = v131;
            end;
        end;
        return;
    end;
end;
local function v155(v142, v143, v144, v145) --[[ Line: 418 ]] --[[ Name: dressManniquin ]]
    -- upvalues: v56 (copy), v141 (copy), v129 (copy), v123 (copy), v18 (copy), v7 (copy)
    local l_Equipment_0 = v142.Equipment;
    local v147 = nil;
    if v144 then
        if l_Equipment_0.Primary then
            v147 = l_Equipment_0.Primary;
        elseif l_Equipment_0.Secondary then
            v147 = l_Equipment_0.Secondary;
        elseif l_Equipment_0.Melee then
            v147 = l_Equipment_0.Melee;
        end;
    end;
    for v148, v149 in next, v56 do
        if l_Equipment_0[v148] then
            if typeof(v149) == "table" then
                for _, v151 in next, v149 do
                    if l_Equipment_0[v148][v151] then
                        v141({
                            v148, 
                            v151
                        }, l_Equipment_0[v148][v151], v143);
                    else
                        v141({
                            v148, 
                            v151
                        }, {
                            Name = "Default"
                        }, v143);
                    end;
                end;
            else
                v141(v148, l_Equipment_0[v148], v143);
            end;
        end;
    end;
    if l_Equipment_0.Backpack then
        v141("Backpack", l_Equipment_0.Backpack, v143);
    end;
    if v142.SkinColor then
        v129(v142.SkinColor, v143);
    end;
    if v142.HairStyle and v142.HairColor then
        v123(v142.HairStyle, v142.HairColor, v143);
    end;
    if v147 and v145 then
        local v152 = v18.new(v147.Name);
        if v147.Attachments then
            for v153, v154 in next, v147.Attachments do
                v152.Attachments[v153] = v18.new(v154.Name, v152);
            end;
        end;
        if v147.SkinId then
            v152.SkinId = v147.SkinId;
        end;
        v145:SetState("EquippedItem", v7:Serialize(v152));
        v152:Destroy();
    end;
end;
local function v164(v156, v157) --[[ Line: 484 ]] --[[ Name: undressManniquin ]]
    -- upvalues: v29 (ref), v56 (copy), v141 (copy), v123 (copy), v129 (copy)
    if not v29 then
        return;
    else
        for v158, v159 in next, v56 do
            if typeof(v159) == "table" then
                for _, v161 in next, v159 do
                    v141({
                        v158, 
                        v161
                    }, {
                        Name = "Default"
                    }, v156, v157);
                end;
            else
                v141(v158, {
                    Name = "Default"
                }, v156, v157);
            end;
        end;
        v123("Bald", "LightBrown", v156, v157);
        v129(3, v156, v157);
        for _, v163 in next, v29.Equipment:GetChildren() do
            v163:Destroy();
        end;
        return;
    end;
end;
local function v178(v165) --[[ Line: 507 ]] --[[ Name: getItemList ]]
    -- upvalues: v3 (copy), v2 (copy), v100 (copy), v110 (copy), v57 (ref), v8 (copy), v55 (copy)
    local v166 = {};
    if v165 == "Hair" then
        for v167, _ in next, v3.Hair.Styles do
            table.insert(v166, {
                Name = v167, 
                DisplayName = v2[v167].DisplayName or v167, 
                Status = "Unlocked"
            });
        end;
    else
        for v169, v170 in next, v2 do
            if v170.EquipSlot == v165 and v170.DisplayedInCreator then
                local v171, v172 = v100(v169);
                local v173 = v110(v169);
                local v174 = false;
                local v175 = "Locked";
                if v172 then
                    v175 = "Purchasable";
                    if v57.Outfits[v171] then
                        v175 = "Purchased";
                    end;
                elseif v8:IsDiscovered(v169) then
                    v175 = v173 and "Purchased" or "Unlocked";
                elseif v170.HideInCreatorIfNotUnlocked then
                    v174 = true;
                end;
                if not v174 then
                    table.insert(v166, {
                        Name = v169, 
                        DisplayName = v170.DisplayName, 
                        Status = v175
                    });
                end;
            end;
        end;
    end;
    table.sort(v166, function(v176, v177) --[[ Line: 561 ]]
        -- upvalues: v55 (ref)
        if v55[v176.Status] == v55[v177.Status] then
            return v176.Name < v177.Name;
        else
            return v55[v176.Status] > v55[v177.Status];
        end;
    end);
    return v166;
end;
local function v190(v179) --[[ Line: 572 ]] --[[ Name: filterContextLists ]]
    -- upvalues: v45 (ref), v46 (ref), v63 (ref), v64 (copy)
    if v179 == "" then
        for _, v181 in next, v45:GetChildren() do
            if v181:IsA("GuiButton") then
                v181.Visible = true;
            end;
        end;
        for _, v183 in next, v46:GetChildren() do
            if v183:IsA("GuiButton") then
                v183.Visible = true;
            end;
        end;
        return;
    else
        for _, v185 in next, v45:GetChildren() do
            if v185:IsA("GuiButton") then
                local v186 = v63[v185];
                if v186 then
                    v185.Visible = not not v186.DisplayName:lower():find(v179:lower());
                end;
            end;
        end;
        for _, v188 in next, v46:GetChildren() do
            if v188:IsA("GuiButton") then
                local v189 = v64[v188];
                if v189 then
                    v188.Visible = not not v189.Name:lower():find(v179:lower());
                end;
            end;
        end;
        return;
    end;
end;
local function v208(v191, v192) --[[ Line: 614 ]] --[[ Name: sortContextList ]]
    -- upvalues: v8 (copy), v55 (copy), v62 (ref), v48 (ref)
    if not v192 then
        v192 = "Default";
    end;
    local v193 = {};
    for v194, _ in next, v191 do
        table.insert(v193, v194);
    end;
    if v192 == "Alphabetical" then
        table.sort(v193, function(v196, v197) --[[ Line: 626 ]]
            -- upvalues: v191 (copy)
            return v191[v196].Name < v191[v197].Name;
        end);
    elseif v192 == "Most Recent" then
        table.sort(v193, function(v198, v199) --[[ Line: 630 ]]
            -- upvalues: v8 (ref), v191 (copy)
            local v200 = v8:IsDiscovered(v191[v198].Name) or 1e999;
            local v201 = v8:IsDiscovered(v191[v199].Name) or 1e999;
            if v200 ~= v201 then
                return v200 < v201;
            else
                return v191[v198].Name < v191[v199].Name;
            end;
        end);
    else
        table.sort(v193, function(v202, v203) --[[ Line: 641 ]]
            -- upvalues: v191 (copy), v55 (ref)
            local v204 = v191[v202];
            local v205 = v191[v203];
            if v55[v204.Status] == v55[v205.Status] then
                return v204.Name < v205.Name;
            else
                return v55[v204.Status] > v55[v205.Status];
            end;
        end);
        v192 = "Default";
    end;
    for v206, v207 in next, v193 do
        v207.LayoutOrder = v206;
    end;
    v62 = v192;
    v48.InnerBox.Label.Text = v62;
end;
local v209 = nil;
local v210 = nil;
local v211 = nil;
local v212 = nil;
local v213 = nil;
local v214 = v17.new();
local l_v214_0 = v214 --[[ copy: 91 -> 99 ]];
v211 = function() --[[ Line: 668 ]] --[[ Name: cleanPurchasePromt ]]
    -- upvalues: l_v214_0 (copy), v68 (ref), v56 (copy), v66 (ref), v141 (copy), v38 (ref)
    l_v214_0:Clean();
    for v216, _ in next, v68 do
        if typeof(v56[v216]) == "table" then
            for _, v219 in next, v56[v216] do
                local v220 = v66.Equipment[v216][v219] or {
                    Name = "Default"
                };
                v141({
                    v216, 
                    v219
                }, v220, false, false);
            end;
        else
            local v221 = v66.Equipment[v216] or {
                Name = "Default"
            };
            v141(v216, v221, false, false);
        end;
    end;
    v38.Preview.Label.Text = "Preview Outfit";
    v38.Visible = false;
    v68 = {};
end;
v213 = function() --[[ Line: 698 ]] --[[ Name: cleanEditPromt ]]
    -- upvalues: l_v214_0 (copy), v37 (ref)
    l_v214_0:Clean();
    v37.Visible = false;
    v37.ErrorText.Text = "";
end;
v210 = function(v222, v223, v224, v225, v226) --[[ Line: 705 ]] --[[ Name: promtOutfitPurchase ]]
    -- upvalues: v211 (ref), v213 (ref), v104 (copy), v56 (copy), v68 (ref), v141 (copy), v38 (ref), v66 (ref), l_v214_0 (copy), v3 (copy), l_Players_0 (copy), v4 (copy), v5 (copy), l_MarketplaceService_0 (copy)
    v211();
    v213();
    local v227 = true;
    local v228 = v104(v222);
    local function v239() --[[ Line: 712 ]] --[[ Name: preview ]]
        -- upvalues: v227 (ref), v56 (ref), v68 (ref), v223 (copy), v141 (ref), v38 (ref), v66 (ref), v226 (copy), v225 (copy), v224 (copy)
        if v227 then
            for v229, v230 in next, v56 do
                if typeof(v230) == "table" then
                    if not v68[v229] then
                        v68[v229] = {};
                    end;
                    for _, v232 in next, v230 do
                        if v223.Equipment[v229] and v223.Equipment[v229][v232] then
                            v68[v229][v232] = {
                                Name = v223.Equipment[v229][v232]
                            };
                        else
                            v68[v229][v232] = {
                                Name = "Default"
                            };
                        end;
                        v141({
                            v229, 
                            v232
                        }, v68[v229][v232], false, true);
                    end;
                else
                    if v223.Equipment[v229] then
                        v68[v229] = {
                            Name = v223.Equipment[v229]
                        };
                    else
                        v68[v229] = {
                            Name = "Default"
                        };
                    end;
                    v141(v229, v68[v229], false, true);
                end;
            end;
            v38.Preview.Label.Text = "Item Only";
            return;
        else
            for v233, _ in next, v68 do
                if typeof(v56[v233]) == "table" then
                    for _, v236 in next, v56[v233] do
                        local v237 = v66.Equipment[v233][v236] or {
                            Name = "Default"
                        };
                        v141({
                            v233, 
                            v236
                        }, v237, false, true);
                    end;
                else
                    local v238 = v66.Equipment[v233] or {
                        Name = "Default"
                    };
                    v141(v233, v238, false, true);
                end;
            end;
            v68 = {};
            if v226 then
                v68[v225] = {
                    [v226] = {
                        Name = v224
                    }
                };
                v141({
                    v225, 
                    v226
                }, {
                    Name = v224
                }, false, true);
            else
                v68[v225] = {
                    Name = v224
                };
                v141(v225, {
                    Name = v224
                }, false, true);
            end;
            v38.Preview.Label.Text = "Entire Outfit";
            return;
        end;
    end;
    if v228 then
        v38.Buy.Label.Text = "Purchase Bundle";
    else
        v38.Buy.Label.Text = "Purchase Outfit";
    end;
    l_v214_0:Give(v38.Buy.MouseButton1Click:Connect(function() --[[ Line: 788 ]]
        -- upvalues: v3 (ref), v222 (copy), l_Players_0 (ref), v4 (ref), v211 (ref), v5 (ref), l_MarketplaceService_0 (ref)
        local l_DevProductId_0 = v3.Outfits[v222].DevProductId;
        local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
        v4:PlaySound("Interface.Click");
        v211();
        if v5:Fetch("Did Save Load", "Purchases") then
            l_MarketplaceService_0:PromptProductPurchase(l_LocalPlayer_0, l_DevProductId_0);
        end;
    end));
    l_v214_0:Give(v38.Preview.MouseButton1Click:Connect(function() --[[ Line: 800 ]]
        -- upvalues: v4 (ref), v227 (ref), v239 (copy)
        v4:PlaySound("Interface.Click");
        v227 = not v227;
        v239();
    end));
    l_v214_0:Give(v38.X.MouseButton1Click:Connect(function() --[[ Line: 806 ]]
        -- upvalues: v4 (ref), v211 (ref)
        v4:PlaySound("Interface.Click");
        v211();
    end));
    v239();
    v38.OutfitName.Text = v222;
    v38.Visible = true;
end;
v212 = function(v242) --[[ Line: 816 ]] --[[ Name: promptEditLodout ]]
    -- upvalues: v211 (ref), v213 (ref), v37 (ref), l_HttpService_0 (copy), l_v214_0 (copy), v4 (copy), v5 (copy), v209 (ref)
    v211();
    v213();
    local v243 = "";
    local v244 = "";
    if v242 then
        v243 = v242.Name;
        v244 = v242.Id;
        v37.LoadoutBox.Date.Text = "Created " .. v242.DateCreated;
    else
        v244 = l_HttpService_0:GenerateGUID(false);
        v37.LoadoutBox.Date.Text = "";
    end;
    l_v214_0:Give(v37.Save.MouseButton1Click:Connect(function() --[[ Line: 832 ]]
        -- upvalues: v37 (ref), v4 (ref), v213 (ref), v5 (ref), v244 (ref), v209 (ref)
        local l_Text_0 = v37.LoadoutBox.EditTitle.TextBox.Text;
        v4:PlaySound("Interface.Click");
        if l_Text_0:gsub("%s", "") == "" then
            v37.ErrorText.Text = "Invalid Loadout Name";
            return;
        else
            if #l_Text_0 <= 20 then
                v213();
                v5:Send("Save Curent Loadout", v244, l_Text_0);
                v209("Loadouts");
            end;
            return;
        end;
    end));
    l_v214_0:Give(v37.Cancel.MouseButton1Click:Connect(function() --[[ Line: 847 ]]
        -- upvalues: v4 (ref), v213 (ref)
        v4:PlaySound("Interface.Click");
        v213();
    end));
    v37.LoadoutBox.Date.Backdrop.Text = v37.LoadoutBox.Date.Text;
    v37.LoadoutBox.EditTitle.TextBox.Text = v243;
    v37.ErrorText.Text = "";
    v37.Visible = true;
end;
v214 = function() --[[ Line: 861 ]] --[[ Name: hideColorVariants ]]
    -- upvalues: v51 (ref), v0 (copy), v40 (ref)
    for _, v247 in next, v51 do
        if v247.Gui then
            v0.destroy(v247.Gui, "MouseButton1Click");
            v247.Gui = nil;
        end;
    end;
    v40.Visible = false;
    v51 = {};
end;
local function v264(v248) --[[ Line: 873 ]] --[[ Name: displayColorVariants ]]
    -- upvalues: v214 (copy), v14 (copy), l_v4_Storage_0 (copy), v40 (ref), v8 (copy), v63 (ref), v51 (ref)
    v214();
    local v249 = {};
    for v250, v251 in next, v14:GetVariants(v248) do
        local v252, _, _ = Color3.toHSV(v251);
        local v255 = l_v4_Storage_0.ColorVariantTemplate:Clone();
        v255.ColorImage.ImageColor3 = v251;
        v255.Parent = v40.Colors;
        if v8:IsDiscovered(v250) then
            v255.LockedCover.Visible = false;
            v255.ColorImage.ImageTransparency = 0;
        else
            v255.LockedCover.Visible = true;
            v255.ColorImage.ImageTransparency = 0.5;
        end;
        v255.MouseButton1Click:Connect(function() --[[ Line: 894 ]]
            -- upvalues: v63 (ref), v250 (copy)
            for v256, v257 in next, v63 do
                if v257.Name == v250 then
                    local l_OnClicked_0 = v256:FindFirstChild("OnClicked");
                    if l_OnClicked_0 then
                        l_OnClicked_0:Fire();
                        return;
                    else
                        break;
                    end;
                end;
            end;
        end);
        table.insert(v249, {
            Name = v250, 
            Gui = v255, 
            Score = v252
        });
    end;
    table.sort(v249, function(v259, v260) --[[ Line: 915 ]]
        return v259.Score < v260.Score;
    end);
    for v261, v262 in next, v249 do
        v262.LayoutOrder = v261;
    end;
    local l_X_0 = v40.Colors.UIListLayout.AbsoluteContentSize.X;
    v40.Size = UDim2.fromOffset(math.max(l_X_0, 86), 58);
    v51 = v249;
    v40.Visible = true;
end;
local v265 = 0;
v209 = function(v266, v267) --[[ Line: 933 ]] --[[ Name: setContextList ]]
    -- upvalues: v29 (ref), v265 (ref), v61 (ref), v43 (ref), v63 (ref), v0 (copy), v32 (ref), v45 (ref), v46 (ref), v211 (ref), v178 (copy), v39 (ref), v214 (copy), l_v4_Storage_0 (copy), l_RunService_0 (copy), v11 (copy), v4 (copy), v123 (copy), v66 (ref), v100 (copy), v57 (ref), v210 (ref), v8 (copy), v141 (copy), v14 (copy), v264 (copy), v49 (ref), v208 (copy), v47 (ref)
    if not v29 then
        return;
    else
        v265 = v265 + 1;
        local l_v265_0 = v265;
        v61 = v266;
        v43 = v267;
        for v269, _ in next, v63 do
            local l_OnClicked_1 = v269:FindFirstChild("OnClicked");
            if l_OnClicked_1 then
                v0.destroy(l_OnClicked_1, "Event");
            end;
            v0.destroy(v269, "MouseButton1Click");
        end;
        v63 = {};
        if v266 == "Loadouts" then
            v32.Notification.Visible = false;
            v45.Visible = false;
            v46.Visible = true;
            v211();
        else
            local v272 = v178(v266);
            local v273 = os.clock();
            if v266 == "Hair" then
                v39.Visible = true;
                v214();
            else
                v39.Visible = false;
            end;
            for v274, v275 in next, v272 do
                local v276 = l_v4_Storage_0.CreatorItem:Clone();
                if os.clock() - v273 > 0.006944444444444444 then
                    l_RunService_0.Heartbeat:Wait();
                    v273 = os.clock();
                end;
                if v265 ~= l_v265_0 then
                    return;
                else
                    v11:SetViewportIcon(v276.Item, v275.Name, "Creator");
                    v276.ItemImage.Visible = false;
                    v276.Item.Visible = true;
                    local v277 = Instance.new("BindableEvent", v276);
                    v277.Name = "OnClicked";
                    v276.MouseButton1Click:Connect(function() --[[ Line: 998 ]]
                        -- upvalues: v277 (copy)
                        v277:Fire();
                    end);
                    v277.Event:Connect(function() --[[ Line: 1002 ]]
                        -- upvalues: v4 (ref), v266 (copy), v211 (ref), v123 (ref), v275 (copy), v66 (ref), v100 (ref), v57 (ref), v210 (ref), v267 (copy), v8 (ref), v141 (ref), v63 (ref), v14 (ref), v264 (ref), v214 (ref)
                        local v278 = false;
                        v4:PlaySound("Interface.Click");
                        if v266 == "Hair" then
                            v211();
                            v123(v275.Name, v66.HairColor, true);
                        else
                            local v279, v280 = v100(v275.Name);
                            if v280 and not v57.Outfits[v279] then
                                v210(v279, v280, v275.Name, v266, v267);
                            elseif v8:IsDiscovered(v275.Name) or v57.Outfits[v279] then
                                v211();
                                if v267 then
                                    v141({
                                        v266, 
                                        v267
                                    }, v275, true);
                                else
                                    v141(v266, v275, true);
                                end;
                                v278 = true;
                            end;
                        end;
                        if v275.Status ~= "Locked" then
                            for v281, v282 in next, v63 do
                                v281.SelectedIcon.Visible = false;
                                if v278 and v282.Name == v275.Name then
                                    v281.SelectedIcon.Visible = true;
                                end;
                            end;
                        end;
                        if v266 ~= "Hair" and v14:HasVariants(v275.Name) and v8:IsDiscovered(v275.Name) then
                            v264(v275.Name);
                            return;
                        else
                            v214();
                            return;
                        end;
                    end);
                    if v275.Status == "Locked" then
                        v276.LockedIcon.Visible = true;
                        v276.Item.ImageColor3 = Color3.new(0.5, 0.5, 0.5);
                        v276.LockedLines.Visible = true;
                    elseif v275.Status == "Purchased" or v275.Status == "Purchasable" then
                        v276.GreenBottomBar.Visible = true;
                        v276.WhiteBottomBar.Visible = false;
                        v276.InnerBox.ImageColor3 = Color3.fromRGB(48, 165, 95);
                        if v275.Status == "Purchasable" then
                            v276.PaidIcon.Visible = true;
                            v276.LockedLines.Visible = true;
                            v276.LockedLines.ImageTransparency = 0.9;
                        end;
                    end;
                    if v266 == "Hair" then
                        v276.SelectedIcon.Visible = v275.Name == v66.HairStyle;
                    elseif v66.Equipment[v266] then
                        v276.SelectedIcon.Visible = v275.Name == v66.Equipment[v266].Name;
                    end;
                    if v14:HasVariants(v275.Name) then
                        v276.HasColorVariants.Visible = true;
                    else
                        v276.HasColorVariants.Visible = false;
                    end;
                    v276.LayoutOrder = v274;
                    v276.Name = v275.Name;
                    v276.Parent = v45;
                    v63[v276] = v275;
                end;
            end;
            v45.Visible = true;
            v46.Visible = false;
            v211();
        end;
        for v283, v284 in next, v49 do
            v284.Visible = v266 == v283;
        end;
        v45.CanvasPosition = Vector2.new();
        v45.CanvasSize = UDim2.new(0, 0, 0, v45.UIGridLayout.AbsoluteContentSize.Y);
        v46.CanvasPosition = Vector2.new();
        v208(v63, "Default");
        v47.Text = "";
        return;
    end;
end;
local function v311() --[[ Line: 1103 ]] --[[ Name: randomizeLoadout ]]
    -- upvalues: v78 (copy), v3 (copy), v57 (ref), v56 (copy), v2 (copy), v100 (copy), v8 (copy), v129 (copy), v123 (copy), v141 (copy)
    local v285, _ = v78(v3.Body.Colors);
    local v287, _ = v78(v3.Hair.Styles);
    local v289, v290 = v78(v3.Hair.Colors);
    local v291 = {};
    if v57.Gamepasses.HairColors ~= true and v290 == "Paid" then
        repeat
            local v292, v293 = v78(v3.Hair.Colors);
            v289 = v292;
        until v293 ~= "Paid";
    end;
    for v294, v295 in next, v56 do
        local v296 = {
            "Default"
        };
        for v297, v298 in next, v2 do
            if v298.EquipSlot == v294 and v298.DisplayedInCreator then
                local v299 = v100(v297);
                local v300 = true;
                if v299 and not v57.Outfits[v299] then
                    v300 = false;
                end;
                if not v8:IsDiscovered(v297) then
                    v300 = false;
                end;
                if v300 then
                    table.insert(v296, v297);
                end;
            end;
        end;
        if typeof(v295) == "table" then
            v291[v294] = {};
            for _, v302 in next, v295 do
                local v303 = v78(v296);
                local v304 = table.remove(v296, v303) or "Default";
                if v304 then
                    v291[v294][v302] = {
                        Name = v304
                    };
                end;
            end;
        else
            local _, v306 = v78(v296);
            if not v306 then
                v306 = "Default";
            end;
            if v306 then
                v291[v294] = {
                    Name = v306
                };
            end;
        end;
    end;
    v129(v285, true);
    v123(v287, v289, true);
    for v307, v308 in next, v291 do
        if typeof(v56[v307]) == "table" then
            for _, v310 in next, v56[v307] do
                v141({
                    v307, 
                    v310
                }, v291[v307][v310], true);
            end;
        else
            v141(v307, v308, true);
        end;
    end;
end;
local v312 = nil;
local l_CreatorOutfit_0 = l_v4_Storage_0:WaitForChild("CreatorOutfit");
local v314 = 0;
local v315 = l_CreatorOutfit_0:Clone();
v315.LayoutOrder = 100000;
v315.Outfit:Destroy();
v315.Empty.Visible = true;
v315.MouseButton1Click:Connect(function() --[[ Line: 1191 ]]
    -- upvalues: v4 (copy), v212 (ref)
    v4:PlaySound("Interface.Click");
    v212();
end);
v315.Parent = v46;
local l_l_CreatorOutfit_0_0 = l_CreatorOutfit_0 --[[ copy: 96 -> 100 ]];
do
    local l_v314_0 = v314;
    v312 = function(v318) --[[ Line: 1198 ]] --[[ Name: buildLoadoutsGuis ]]
        -- upvalues: v46 (ref), v315 (copy), v64 (copy), v67 (ref), v17 (copy), l_l_CreatorOutfit_0_0 (copy), v4 (copy), v155 (copy), v212 (ref), v5 (copy), l_v314_0 (ref), v32 (ref)
        local v319 = 0;
        for _, v321 in next, v46:GetChildren() do
            if v321:IsA("GuiButton") and v321 ~= v315 then
                if v64[v321] then
                    v64[v321] = nil;
                end;
                v321:Destroy();
            end;
        end;
        for v322, v323 in next, v67 do
            v319 = v319 + 1;
            local v324 = v17.new();
            local v325 = l_l_CreatorOutfit_0_0:Clone();
            v325.LayoutOrder = v322;
            v325.Outfit.Visible = true;
            v325.Empty:Destroy();
            v325.Outfit.OutfitName.Text = v323.Name;
            v325.Outfit.OutfitName.Backdrop.Text = v323.Name;
            v325.Outfit.Date.Text = "Created " .. v323.DateCreated;
            v325.Outfit.Date.Backdrop.Text = "Created " .. v323.DateCreated;
            v324:Give(v325.Outfit.MouseButton1Click:Connect(function() --[[ Line: 1227 ]]
                -- upvalues: v4 (ref), v155 (ref), v323 (copy)
                v4:PlaySound("Interface.Click");
                v155(v323, true);
            end));
            v324:Give(v325.Outfit.Edit.MouseButton1Click:Connect(function() --[[ Line: 1232 ]]
                -- upvalues: v4 (ref), v212 (ref), v323 (copy)
                v4:PlaySound("Interface.Click");
                v212(v323);
            end));
            v324:Give(v325.Outfit.Delete.MouseButton1Click:Connect(function() --[[ Line: 1237 ]]
                -- upvalues: v4 (ref), v5 (ref), v323 (copy), v324 (copy), v325 (copy)
                v4:PlaySound("Interface.Click");
                v5:Send("Delete Loadout", v323.Name);
                v324:Destroy();
                v325:Destroy();
            end));
            v325.Parent = v46;
            v64[v325] = v323;
        end;
        local l_Y_0 = v46.UIGridLayout.AbsoluteContentSize.Y;
        local l_Offset_0 = v46.UIPadding.PaddingTop.Offset;
        v46.CanvasSize = UDim2.new(0, 0, 0, l_Y_0 + l_Offset_0);
        if not v318 and l_v314_0 < v319 and not v46.Visible then
            v32.Notification.Visible = true;
            l_v314_0 = v319;
            return;
        else
            v32.Notification.Visible = false;
            return;
        end;
    end;
end;
l_CreatorOutfit_0 = function() --[[ Line: 1263 ]] --[[ Name: waitForPurchasesReady ]]
    -- upvalues: v70 (copy), v5 (copy)
    local v328 = false;
    local v329 = v70:Connect(function() --[[ Line: 1266 ]]
        -- upvalues: v328 (ref)
        v328 = true;
    end);
    v5:Send("Resync Purchases");
    repeat
        wait(0);
    until v328;
    v329:Disconnect();
end;
v314 = function(v330, v331) --[[ Line: 1277 ]] --[[ Name: prepareManniquin ]]
    -- upvalues: v29 (ref), v6 (copy), l_v4_Storage_0 (copy), v16 (copy), v164 (copy), v155 (copy), v12 (copy), l_Players_0 (copy), l_v10_Camera_0 (copy)
    if v29 then
        v29:Destroy();
        v29 = nil;
    end;
    v29 = v6:Get("ReplicatedStorage.Assets.Mannequin");
    v29:SetPrimaryPartCFrame(l_v4_Storage_0.SpawnPlate.MannequinPoint.CFrame);
    v29.Parent = workspace:WaitForChild("Effects");
    l_v4_Storage_0.Shadow:Clone().Parent = v29;
    local v332 = v16.new(v29, "Mannequin");
    v164(false, true);
    local l_status_0, l_result_0 = pcall(v155, v331, false, not v330, v332);
    if not l_status_0 then
        warn("Failed to dess main menu mannequin");
        print(l_result_0);
    end;
    v12:SetFaceFromUserId(v29, l_Players_0.LocalPlayer.UserId);
    l_v10_Camera_0:SetSubject(v332);
    return v332;
end;
v69.IsVisible = function(v335) --[[ Line: 1313 ]] --[[ Name: IsVisible ]]
    return v335.Gui.Visible;
end;
v69.IsClosable = function(_) --[[ Line: 1317 ]] --[[ Name: IsClosable ]]
    return true;
end;
v69.SetVisible = function(v337, v338, v339) --[[ Line: 1321 ]] --[[ Name: SetVisible ]]
    -- upvalues: l_v10_Camera_0 (copy)
    v337.Gui.Visible = v338;
    if v338 then
        l_v10_Camera_0:ShowManniquin();
        v339:SetBlur(0);
        return;
    else
        l_v10_Camera_0:HideManniquin();
        return;
    end;
end;
v69.Start = function(_, v341) --[[ Line: 1332 ]] --[[ Name: Start ]]
    -- upvalues: v5 (copy), v67 (ref), v66 (ref), v65 (ref), l_CreatorOutfit_0 (copy), v314 (copy), v8 (copy), v312 (ref), v0 (copy), v209 (ref), v44 (ref), v42 (ref), v69 (copy), v4 (copy), v19 (copy), l_v10_Camera_0 (copy), v63 (ref), v41 (ref), v1 (copy), v311 (copy)
    local v342 = v5:Fetch("Can Edit Appearance");
    v67 = v5:Fetch("Get Saved Loadouts");
    v66 = v5:Fetch("Get Appearance Data");
    v65 = v5:Fetch("Get Last Loadout");
    l_CreatorOutfit_0();
    local v343 = v314(v342, v66);
    v8:ResyncMasterList();
    v312(true);
    v0.Classes.Characters.resetDamageEffects();
    v209("Loadouts");
    if v342 then
        v44.Visible = true;
        v42.Visible = true;
    else
        v44.Visible = false;
        v42.Visible = false;
    end;
    local v344 = nil;
    local function v348(v345) --[[ Line: 1361 ]] --[[ Name: playButtonClick ]]
        -- upvalues: v69 (ref), v4 (ref), v344 (ref), v19 (ref), v5 (ref), v341 (copy), v343 (copy), l_v10_Camera_0 (ref), v63 (ref)
        v69.abort = nil;
        v4:PlaySound("Interface.Click");
        if not v345 and not v69:IsClosable() then
            return;
        else
            v344:Disconnect();
            if not v345 then
                v19:Fade(0, 2):Wait();
            end;
            v19:SetText("setting ui");
            v4:Show("Chat", "PlayerList");
            v4:Hide("MainMenu");
            if not v345 then
                v5:Send("Set Last Loadout");
                v341();
            end;
            v19:SetText("clean up");
            v343:Destroy();
            l_v10_Camera_0:SetSubject(nil);
            for v346, _ in next, v63 do
                v346:Destroy();
            end;
            v63 = {};
            v19:SetText("");
            v19:Fade(1, v345 and 0 or 0.3);
            return;
        end;
    end;
    v69.abort = function() --[[ Line: 1404 ]]
        -- upvalues: v348 (copy)
        v348(true);
    end;
    v344 = v41.MouseButton1Click:Connect(v348);
    if v1.QuickPlay or v1.QuickRespawn then
        v311();
        v348();
    elseif not v4:Get("DeathScreen"):IsMusicPlaying() then
        v4:Get("MainMenu"):PlayMusic("Creator", 20);
    end;
    v4:Get("SplashScreens"):TrySplash();
end;
v69.IsOutfitHoverVisible = function(_) --[[ Line: 1423 ]] --[[ Name: IsOutfitHoverVisible ]]
    -- upvalues: v30 (ref)
    if v30 then
        return v30.Visible;
    else
        return false;
    end;
end;
v69.GetContextItems = function(_) --[[ Line: 1431 ]] --[[ Name: GetContextItems ]]
    -- upvalues: v63 (ref)
    local v351 = {};
    for v352, v353 in next, v63 do
        if v352.Visible and v353.Name then
            table.insert(v351, {
                Gui = v352, 
                Name = v353.Name
            });
        end;
    end;
    return v351;
end;
v69.GetContextListName = function(_) --[[ Line: 1446 ]] --[[ Name: GetContextListName ]]
    -- upvalues: v61 (ref)
    return v61;
end;
v69.GetColorVariantsList = function(_) --[[ Line: 1450 ]] --[[ Name: GetColorVariantsList ]]
    -- upvalues: v51 (ref)
    return v51;
end;
return function(v356, v357) --[[ Line: 1456 ]]
    -- upvalues: v69 (copy), v30 (ref), v31 (ref), v32 (ref), v33 (ref), v34 (ref), v35 (ref), v36 (ref), v37 (ref), v40 (ref), v39 (ref), v38 (ref), v41 (ref), v42 (ref), v44 (ref), v45 (ref), v46 (ref), v47 (ref), v48 (ref), v49 (ref), v50 (ref), v4 (copy), v129 (copy), v61 (ref), v209 (ref), v123 (copy), v66 (ref), v57 (ref), v3 (copy), l_Players_0 (copy), v5 (copy), l_MarketplaceService_0 (copy), v70 (copy), v141 (copy), v13 (copy), v29 (ref), v12 (copy), v155 (copy), v65 (ref), v212 (ref), v311 (copy), v164 (copy), v190 (copy), v62 (ref), v208 (copy), v63 (ref), v100 (copy), v92 (copy), l_v4_Storage_0 (copy), v2 (copy), v11 (copy), v104 (copy), v6 (copy), v60 (copy), l_TextService_0 (copy), l_UserInputService_0 (copy), v1 (copy), l_RunService_0 (copy), v52 (ref), v54 (copy), v53 (copy), v43 (ref), v67 (ref), v312 (ref)
    v69.Gui = v357;
    v30 = v356.Gui.OutfitHoverDetails;
    v31 = v357.Overview.Skin;
    v32 = v357.Overview.Loadouts;
    v33 = v357.Overview.LastLoadout;
    v34 = v357.Overview.SaveLoadout;
    v35 = v357.Overview.Randomize;
    v36 = v357.Overview.Clear;
    v37 = v357.EditLoadout;
    v40 = v357.ColorVariantPicker;
    v39 = v357.HairColorPicker;
    v38 = v357.BuyLoadout;
    v41 = v357.Play;
    v42 = v357.Context;
    v44 = v357.Overview;
    v45 = v357.Context.ScrollingFrameItems;
    v46 = v357.Context.ScrollingFrameLoadouts;
    v47 = v357.Context.Search.TextBox;
    v48 = v357.Context.Dropdown;
    v49 = {
        Accessory = v357.Context.Background.LabelAccessories, 
        Belt = v357.Context.Background.LabelBelts, 
        Bottom = v357.Context.Background.LabelBottoms, 
        Hair = v357.Context.Background.LabelHair, 
        Hat = v357.Context.Background.LabelHats, 
        Loadouts = v357.Context.Background.LabelLoadouts, 
        Top = v357.Context.Background.LabelTops, 
        Vest = v357.Context.Background.LabelVests
    };
    v50 = {
        Hair = v357.Overview.Hair, 
        Belt = v357.Overview.Belt, 
        Bottom = v357.Overview.Bottom, 
        Hat = v357.Overview.Hat, 
        Top = v357.Overview.Top, 
        Vest = v357.Overview.Vest, 
        Accessory = {
            ["1"] = v357.Overview.Accessory, 
            ["2"] = v357.Overview.Accessory2
        }
    };
    for _, v359 in next, v31.Swatches:GetChildren() do
        if v359:IsA("GuiButton") and tonumber(v359.Name) then
            v359.MouseButton1Click:Connect(function() --[[ Line: 1514 ]]
                -- upvalues: v4 (ref), v129 (ref), v359 (copy)
                v4:PlaySound("Interface.Click");
                v129(tonumber(v359.Name), true);
            end);
        end;
    end;
    for _, v361 in next, v39.Swatches:GetChildren() do
        for _, v363 in next, v361:GetChildren() do
            v363.MouseButton1Click:Connect(function() --[[ Line: 1523 ]]
                -- upvalues: v4 (ref), v61 (ref), v209 (ref), v123 (ref), v66 (ref), v363 (copy), v361 (copy), v57 (ref), v3 (ref), l_Players_0 (ref), v5 (ref), l_MarketplaceService_0 (ref)
                v4:PlaySound("Interface.Click");
                if v61 ~= "Hair" then
                    v209("Hair");
                end;
                v123(v66.HairStyle, v363.Name, true);
                if v361.Name == "Paid" and v57.Gamepasses.HairColors ~= true then
                    local l_HairColors_0 = v3.Gamepasses.HairColors;
                    local l_LocalPlayer_1 = l_Players_0.LocalPlayer;
                    if v5:Fetch("Did Save Load", "Purchases") then
                        l_MarketplaceService_0:PromptGamePassPurchase(l_LocalPlayer_1, l_HairColors_0);
                    end;
                end;
            end);
            if v361.Name == "Paid" then
                v70:Connect(function(_, _) --[[ Line: 1543 ]]
                    -- upvalues: v363 (copy), v57 (ref)
                    v363.PaidCover.Visible = v57.Gamepasses.HairColors ~= true;
                end);
            end;
        end;
    end;
    local function v375(v368, v369, v370) --[[ Line: 1550 ]] --[[ Name: connectEquipButton ]]
        -- upvalues: v4 (ref), v209 (ref), v123 (ref), v66 (ref), v141 (ref)
        local v371 = {
            v370.Selected, 
            v370.Unselected
        };
        for _, v373 in next, v371 do
            v373.MouseButton1Click:Connect(function() --[[ Line: 1554 ]]
                -- upvalues: v4 (ref), v209 (ref), v368 (copy), v369 (copy)
                v4:PlaySound("Interface.Click");
                v209(v368, v369);
            end);
        end;
        v370.Selected.X.MouseButton1Click:Connect(function() --[[ Line: 1560 ]]
            -- upvalues: v4 (ref), v368 (copy), v123 (ref), v66 (ref), v369 (copy), v141 (ref), v370 (copy)
            v4:PlaySound("Interface.Click");
            if v368 == "Hair" then
                v123("Bald", v66.HairColor, true);
            else
                local l_v368_0 = v368;
                if v369 then
                    l_v368_0 = {
                        v368, 
                        v369
                    };
                end;
                v141(l_v368_0, {
                    Name = "Default"
                }, true);
            end;
            v370.Unselected.Visible = true;
            v370.Selected.Visible = false;
        end);
    end;
    for v376, v377 in next, v50 do
        if typeof(v377) == "table" then
            for v378, v379 in next, v377 do
                v375(v376, v378, v379);
            end;
        else
            v375(v376, nil, v377);
        end;
    end;
    local l_Hair_0 = v50.Hair;
    local l_Checkmark_0 = l_Hair_0.Checkbox.Checkmark;
    local l_l_Checkmark_0_0 = l_Checkmark_0 --[[ copy: 4 -> 13 ]];
    l_Hair_0.Checkbox.MouseButton1Click:Connect(function() --[[ Line: 1594 ]]
        -- upvalues: l_l_Checkmark_0_0 (copy), v13 (ref), v29 (ref), v12 (ref)
        l_l_Checkmark_0_0.Visible = not l_l_Checkmark_0_0.Visible;
        if l_l_Checkmark_0_0.Visible then
            v13:Change("Character", "Hats Hide Hair", "Off");
            if v29 then
                v12:SetHairVisible(v29, true);
                return;
            end;
        else
            v13:Change("Character", "Hats Hide Hair", "On");
            if v29 then
                v12:SetHairVisible(v29, false);
            end;
        end;
    end);
    v13:BindToSetting("Character", "Hats Hide Hair", function(v383) --[[ Line: 1612 ]]
        -- upvalues: l_l_Checkmark_0_0 (copy), v29 (ref), v12 (ref)
        l_l_Checkmark_0_0.Visible = v383 == "Off";
        if v29 then
            v12:SetHairVisible(v29, v383 == "Off");
        end;
    end);
    v32.MouseButton1Click:Connect(function() --[[ Line: 1622 ]]
        -- upvalues: v4 (ref), v209 (ref)
        v4:PlaySound("Interface.Click");
        v209("Loadouts");
    end);
    v33.MouseButton1Click:Connect(function() --[[ Line: 1627 ]]
        -- upvalues: v4 (ref), v209 (ref), v155 (ref), v65 (ref)
        v4:PlaySound("Interface.Click");
        v209("Loadouts");
        v155(v65, true);
    end);
    v34.MouseButton1Click:Connect(function() --[[ Line: 1633 ]]
        -- upvalues: v4 (ref), v209 (ref), v212 (ref)
        v4:PlaySound("Interface.Click");
        v209("Loadouts");
        v212();
    end);
    v35.MouseButton1Click:Connect(function() --[[ Line: 1639 ]]
        -- upvalues: v4 (ref), v209 (ref), v311 (ref)
        v4:PlaySound("Interface.Click");
        v209("Loadouts");
        v311();
    end);
    v36.MouseButton1Click:Connect(function() --[[ Line: 1645 ]]
        -- upvalues: v4 (ref), v209 (ref), v164 (ref)
        v4:PlaySound("Interface.Click");
        v209("Loadouts");
        v164(true);
    end);
    v37.LoadoutBox.EditTitle.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 1651 ]]
        -- upvalues: v37 (ref)
        local v384 = #v37.LoadoutBox.EditTitle.TextBox.Text;
        if v384 > 20 then
            v37.ErrorText.Text = "Name too long " .. v384 .. "/" .. 20;
            return;
        else
            v37.ErrorText.Text = "";
            return;
        end;
    end);
    v37.LoadoutBox.EditTitle.TextBox.Focused:Connect(function() --[[ Line: 1662 ]]
        -- upvalues: v4 (ref)
        v4:PlaySound("Interface.Click");
    end);
    v47:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 1668 ]]
        -- upvalues: v47 (ref), v45 (ref), v190 (ref)
        if v47.Text == "" then
            v47.TextTransparency = 0.75;
            v47.Font = Enum.Font.SourceSansItalic;
        else
            v47.TextTransparency = 0;
            v47.Font = Enum.Font.SourceSans;
        end;
        if v47:IsFocused() then
            v45.CanvasPosition = Vector2.new();
        end;
        v190(v47.Text);
    end);
    v47.Focused:Connect(function() --[[ Line: 1684 ]]
        -- upvalues: v4 (ref)
        v4:PlaySound("Interface.Click");
    end);
    l_Hair_0 = function(v385) --[[ Line: 1688 ]] --[[ Name: setDropdown ]]
        -- upvalues: v48 (ref), v62 (ref)
        if v385 then
            v48.Size = UDim2.new(0, 102, 0, v48.InnerBox.Frame.UIListLayout.AbsoluteContentSize.Y + 27);
            v48.InnerBox.Triangle.Rotation = 180;
            v48.InnerBox.Label.Text = "Sort Mode:";
            v48.InnerBox.Frame.Visible = true;
            return;
        else
            v48.Size = UDim2.new(0, 102, 0, 27);
            v48.InnerBox.Triangle.Rotation = 0;
            v48.InnerBox.Label.Text = v62;
            v48.InnerBox.Frame.Visible = false;
            return;
        end;
    end;
    local l_l_Hair_0_0 = l_Hair_0 --[[ copy: 3 -> 14 ]];
    v48.MouseButton1Click:Connect(function() --[[ Line: 1703 ]]
        -- upvalues: v4 (ref), v48 (ref), l_l_Hair_0_0 (copy)
        v4:PlaySound("Interface.Click");
        if v48.InnerBox.Frame.Visible then
            l_l_Hair_0_0(false);
            return;
        else
            l_l_Hair_0_0(true);
            return;
        end;
    end);
    v48.MouseLeave:Connect(function() --[[ Line: 1715 ]]
        -- upvalues: v48 (ref), v4 (ref), l_l_Hair_0_0 (copy)
        if v48.InnerBox.Frame.Visible then
            v4:PlaySound("Interface.Click");
        end;
        l_l_Hair_0_0(false);
    end);
    for _, v388 in next, v48.InnerBox.Frame:GetChildren() do
        if v388:IsA("TextButton") then
            v388.MouseButton1Click:Connect(function() --[[ Line: 1725 ]]
                -- upvalues: v4 (ref), v208 (ref), v63 (ref), v388 (copy), l_Hair_0 (copy), v45 (ref)
                v4:PlaySound("Interface.Click");
                v208(v63, v388.Text);
                l_Hair_0(false);
                v45.CanvasPosition = Vector2.new();
            end);
        end;
    end;
    l_Hair_0 = nil;
    l_Checkmark_0 = false;
    local v389 = {
        Hat = 1, 
        Accessory = {
            ["1"] = 2, 
            ["2"] = 3
        }, 
        Vest = 6, 
        Belt = 7, 
        Top = 4, 
        Bottom = 5
    };
    do
        local l_l_Hair_0_1, l_l_Checkmark_0_1 = l_Hair_0, l_Checkmark_0;
        local function v428(v392) --[[ Line: 1752 ]] --[[ Name: displayOutfit ]]
            -- upvalues: l_l_Checkmark_0_1 (ref), v100 (ref), l_l_Hair_0_1 (ref), v57 (ref), v30 (ref), v92 (ref), v389 (copy), l_v4_Storage_0 (ref), v2 (ref), v11 (ref), v104 (ref), v6 (ref), v60 (ref), v3 (ref), l_TextService_0 (ref)
            if l_l_Checkmark_0_1 then
                return;
            else
                l_l_Checkmark_0_1 = true;
                local v393, v394 = v100(v392.Name);
                if l_l_Hair_0_1 == v392.Name then
                    l_l_Checkmark_0_1 = false;
                    return true;
                elseif v394 and not v57.Outfits[v393] then
                    local l_List_0 = v30.InnerFrame.List;
                    local v396 = v92(v394.Description, v30.DescLine1, v30.AbsoluteSize.X - 14);
                    v30["DescLine" .. 1].Text = v396[1] or "";
                    v30["DescLine" .. 2].Text = v396[2] or "";
                    v30["DescLine" .. 3].Text = v396[3] or "";
                    for _, v398 in next, l_List_0:GetChildren() do
                        if v398:IsA("ImageLabel") then
                            v398:Destroy();
                        end;
                    end;
                    local function v406(v399, v400, v401) --[[ Line: 1789 ]] --[[ Name: addItemGui ]]
                        -- upvalues: v389 (ref), l_v4_Storage_0 (ref), v2 (ref), v92 (ref), v11 (ref), l_List_0 (copy)
                        local v402 = v389[v399];
                        if v400 and typeof(v402) == "table" then
                            v402 = v402[v400];
                        end;
                        local v403 = l_v4_Storage_0.HoverTextItem:Clone();
                        v403.LayoutOrder = v402;
                        v403.Label.Text = v399;
                        v403.Name = v399;
                        local l_v401_0 = v401;
                        if v2[v401] then
                            l_v401_0 = v2[v401].DisplayName or l_v401_0;
                        end;
                        local v405 = v92(l_v401_0, v403.NameLine1, v403.NameLine1.AbsoluteSize.X - 4);
                        v403["NameLine" .. 1].Text = v405[1] or "";
                        v403["NameLine" .. 2].Text = v405[2] or "";
                        v11:SetViewportIcon(v403.Icon, v401, "Creator");
                        v403.Name = v401;
                        v403.Parent = l_List_0;
                    end;
                    for v407, v408 in next, v394.Equipment do
                        if typeof(v408) == "table" then
                            for v409, v410 in next, v408 do
                                v406(v407, v409, v410);
                            end;
                        else
                            v406(v407, nil, v408);
                        end;
                    end;
                    v30.Label.Text = v394.DisplayName;
                    v30.Price.Text = v394.Price;
                    v30.Price.Backdrop.Text = v394.Price;
                    if v394.Price > 999 then
                        v30.Price.TextSize = 20;
                        v30.Price.Backdrop.TextSize = 20;
                    else
                        v30.Price.TextSize = 27;
                        v30.Price.Backdrop.TextSize = 27;
                    end;
                    local v411 = v104(v393);
                    if v411 then
                        local l_Frame_0 = v30.BundleWindow.Frame;
                        for _, v414 in next, l_Frame_0:GetChildren() do
                            if v414:IsA("GuiBase") then
                                v414:Destroy();
                            end;
                        end;
                        for v415, v416 in next, v411.Outfits do
                            local v417 = v6:Find("ReplicatedStorage.Built Outfits"):WaitForChild(v416);
                            local v418 = l_v4_Storage_0.BundleOutfitTemplate:Clone();
                            v418.LayoutOrder = v415;
                            v418.Name = v416;
                            v417:Clone().Parent = v418.Icon.WorldModel;
                            if not v418.Icon.CurrentCamera then
                                local v419 = Instance.new("Camera", v418.Icon);
                                v419.CFrame = v60;
                                v419.FieldOfView = 10;
                                v418.Icon.CurrentCamera = v419;
                            end;
                            local l_v416_0 = v416;
                            if v3.Outfits[v416] then
                                l_v416_0 = v3.Outfits[v416].DisplayName or l_v416_0;
                            end;
                            local v421 = v92(l_v416_0, v418.TextLine1, v418.TextLine1.AbsoluteSize.X - 4);
                            v418["TextLine" .. 1].Text = v421[1] or "";
                            v418["TextLine" .. 2].Text = v421[2] or "";
                            v418["TextLine" .. 3].Text = v421[3] or "";
                            v418.Parent = l_Frame_0;
                        end;
                        for v422, v423 in next, v411.BonusText do
                            local v424 = l_v4_Storage_0.BundleTextTemplate:Clone();
                            v424.LayoutOrder = #v411.Outfits + v422;
                            v424.Name = "Bonus Text";
                            local l_TextLabel_0 = v424.TextLabel;
                            local l_X_1 = v424.TextLabel.AbsoluteSize.X;
                            local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(v423, l_TextLabel_0.TextSize, l_TextLabel_0.Font, Vector2.new(l_X_1 or 1000, 1000));
                            v424.TextLabel.Size = UDim2.new(0, v424.TextLabel.AbsoluteSize.X, 0, l_l_TextService_0_TextSize_0.Y);
                            v424.TextLabel.Text = v423;
                            v424.Size = UDim2.new(0, 52, 0, l_l_TextService_0_TextSize_0.Y + 2);
                            v424.Parent = l_Frame_0;
                        end;
                        v30.BundleWindow.Size = UDim2.fromOffset(155, l_Frame_0.UIListLayout.AbsoluteContentSize.Y + 68);
                        v30.BundleWindow.Visible = true;
                    else
                        v30.BundleWindow.Visible = false;
                    end;
                    l_l_Hair_0_1 = v392.Name;
                    l_l_Checkmark_0_1 = false;
                    return true;
                else
                    l_l_Hair_0_1 = nil;
                    l_l_Checkmark_0_1 = false;
                    return false;
                end;
            end;
        end;
        local function v435() --[[ Line: 1932 ]] --[[ Name: positionGui ]]
            -- upvalues: v356 (copy), l_UserInputService_0 (ref), v1 (ref), v30 (ref)
            local l_AbsoluteSize_0 = v356.Gui.AbsoluteSize;
            local v430 = l_UserInputService_0:GetMouseLocation() - v1.GuiInset;
            local v431 = Vector2.new(155, 108 + v30.InnerFrame.List.UIListLayout.AbsoluteContentSize.Y);
            local v432 = v430 + Vector2.new(-(v431.X + 15), -19);
            local v433 = l_AbsoluteSize_0 - v431;
            local v434 = Vector2.new(math.clamp(v432.X, 0, v433.X), (math.clamp(v432.Y, 0, v433.Y)));
            v30.Size = UDim2.new(0, v431.X, 0, v431.Y);
            v30.Position = UDim2.new(0, v434.X, 0, v434.Y);
        end;
        local function _(v436) --[[ Line: 1949 ]] --[[ Name: findCollision ]]
            -- upvalues: l_UserInputService_0 (ref), v1 (ref)
            local v437 = l_UserInputService_0:GetMouseLocation() - v1.GuiInset;
            local l_AbsolutePosition_0 = v436.AbsolutePosition;
            local v439 = l_AbsolutePosition_0 + v436.AbsoluteSize;
            local v440 = false;
            if v437.X >= l_AbsolutePosition_0.X then
                v440 = v437.X <= v439.X;
            end;
            local v441 = false;
            if v437.Y >= l_AbsolutePosition_0.Y then
                v441 = v437.Y <= v439.Y;
            end;
            return v441 and v440;
        end;
        l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1960 ]]
            -- upvalues: v356 (copy), v30 (ref), v45 (ref), l_UserInputService_0 (ref), v1 (ref), v63 (ref), v428 (copy), v435 (copy)
            if not v356.Gui.Visible then
                v30.Visible = false;
                return;
            else
                local v443 = false;
                if v356.Gui.Content.Creator.Visible then
                    local l_v45_0 = v45;
                    local v445 = l_UserInputService_0:GetMouseLocation() - v1.GuiInset;
                    local l_AbsolutePosition_1 = l_v45_0.AbsolutePosition;
                    local v447 = l_AbsolutePosition_1 + l_v45_0.AbsoluteSize;
                    local v448 = false;
                    if v445.X >= l_AbsolutePosition_1.X then
                        v448 = v445.X <= v447.X;
                    end;
                    local v449 = false;
                    if v445.Y >= l_AbsolutePosition_1.Y then
                        v449 = v445.Y <= v447.Y;
                    end;
                    if v449 and v448 then
                        local v450 = nil;
                        l_v45_0 = nil;
                        for v451, v452 in next, v63 do
                            if v451.Visible then
                                local v453 = l_UserInputService_0:GetMouseLocation() - v1.GuiInset;
                                local l_AbsolutePosition_2 = v451.AbsolutePosition;
                                local v455 = l_AbsolutePosition_2 + v451.AbsoluteSize;
                                local v456 = false;
                                if v453.X >= l_AbsolutePosition_2.X then
                                    v456 = v453.X <= v455.X;
                                end;
                                local v457 = false;
                                if v453.Y >= l_AbsolutePosition_2.Y then
                                    v457 = v453.Y <= v455.Y;
                                end;
                                if v457 and v456 then
                                    v450 = v451;
                                    l_v45_0 = v452;
                                    break;
                                end;
                            end;
                        end;
                        if v450 and v428(l_v45_0) then
                            v435();
                            v443 = true;
                        end;
                    end;
                end;
                if v443 then
                    v30.Visible = true;
                    return;
                else
                    v30.Visible = false;
                    return;
                end;
            end;
        end);
    end;
    l_Hair_0 = function() --[[ Line: 1998 ]] --[[ Name: scale ]]
        -- upvalues: v356 (copy), v52 (ref), v44 (ref), v54 (ref), v41 (ref), v53 (ref)
        if v356.Gui.AbsoluteSize.Y < 757 then
            v52 = true;
        else
            v52 = false;
        end;
        if v52 or not v44.Visible then
            for v458, v459 in next, v54 do
                v41[v458] = v459;
            end;
            return;
        else
            for v460, v461 in next, v53 do
                v41[v460] = v461;
            end;
            return;
        end;
    end;
    l_Checkmark_0 = nil;
    v38:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 2020 ]]
        -- upvalues: v52 (ref), v41 (ref), v38 (ref)
        if v52 then
            v41.Visible = not v38.Visible;
            return;
        else
            v41.Visible = true;
            return;
        end;
    end);
    v37:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 2028 ]]
        -- upvalues: v52 (ref), v41 (ref), v37 (ref)
        if v52 then
            v41.Visible = not v37.Visible;
            return;
        else
            v41.Visible = true;
            return;
        end;
    end);
    do
        local l_l_Checkmark_0_2 = l_Checkmark_0;
        v356.Gui:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 2036 ]]
            -- upvalues: l_l_Checkmark_0_2 (ref), v356 (copy), l_RunService_0 (ref), l_Hair_0 (copy)
            if l_l_Checkmark_0_2 then
                l_l_Checkmark_0_2:Disconnect();
                l_l_Checkmark_0_2 = nil;
            end;
            if v356.Gui.Visible then
                l_l_Checkmark_0_2 = l_RunService_0.Heartbeat:Connect(l_Hair_0);
            end;
        end);
    end;
    v5:Add("Purchases Update", function(v463) --[[ Line: 2048 ]]
        -- upvalues: v57 (ref), v70 (ref), v209 (ref), v61 (ref), v43 (ref)
        local l_v57_0 = v57;
        v57 = v463;
        v70:Fire(v57, l_v57_0);
        v209(v61, v43);
    end);
    v5:Add("Loadouts Updated", function(v465) --[[ Line: 2056 ]]
        -- upvalues: v67 (ref), v312 (ref)
        v67 = v465;
        v312();
    end);
    v44.Visible = false;
    v42.Visible = false;
    return v69;
end;