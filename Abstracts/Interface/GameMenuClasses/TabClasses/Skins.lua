local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "FirearmSkinsData");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "GunSkins");
local v4 = v0.require("Libraries", "Network");
local v5 = v2:Get("Dropdown");
local l_v2_Storage_0 = v2:GetStorage("GameMenu");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local v11 = {};
local v12 = nil;
local v13 = "";
local v14 = false;
local v15 = Random.new();
local function v21(v16, v17) --[[ Line: 34 ]] --[[ Name: dressSkinGui ]]
    local l_Pattern2_0 = v16:FindFirstChild("Pattern2");
    local l_1_0 = v17.Patterns["1"];
    local l_2_0 = v17.Patterns["2"];
    v16.Channel1.Image = l_1_0.Channel1[1];
    v16.Channel1.ImageColor3 = Color3.new(select(2, unpack(l_1_0.Channel1)));
    v16.Channel2.Image = l_1_0.Channel2[1];
    v16.Channel2.ImageColor3 = Color3.new(select(2, unpack(l_1_0.Channel2)));
    if l_Pattern2_0 and l_2_0 then
        l_Pattern2_0.Channel1.Image = l_2_0.Channel1[1];
        l_Pattern2_0.Channel1.ImageColor3 = Color3.new(select(2, unpack(l_2_0.Channel1)));
        l_Pattern2_0.Channel2.Image = l_2_0.Channel2[1];
        l_Pattern2_0.Channel2.ImageColor3 = Color3.new(select(2, unpack(l_2_0.Channel2)));
        l_Pattern2_0.Visible = true;
        return;
    else
        if l_Pattern2_0 then
            l_Pattern2_0.Visible = false;
        end;
        return;
    end;
end;
local function v40(v22) --[[ Line: 59 ]] --[[ Name: buildOptionsDisplay ]]
    -- upvalues: v11 (copy), v12 (ref), l_v2_Storage_0 (copy), v21 (copy), v3 (copy)
    local l_Bin_0 = v11.PurchasePannelFrame.Options.Bin;
    local l_Purchase_0 = v11.PurchasePannelFrame.Purchase;
    for _, v26 in next, l_Bin_0:GetChildren() do
        if v26:IsA("GuiBase") then
            v26:Destroy();
        end;
        v12 = nil;
    end;
    local v27 = #v22.Skins;
    local v28 = 0;
    for v29, v30 in next, v22.Skins do
        local v31 = l_v2_Storage_0.PurchaseOptionsTemplate:Clone();
        v31.LayoutOrder = v29;
        v31.Frame2.Frame1.Number.Text = v30.CustomNumber or "#" .. tostring(v29);
        v21(v31.Skin, v30);
        if v3:IsOwned(v30.Id) then
            v31.Frame2.Checkmark.Visible = true;
            v31.Frame2.Percent.Visible = false;
            v31.Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            v28 = v28 + 1;
        else
            v31.Frame2.Checkmark.Visible = false;
            v31.Frame2.Percent.Visible = true;
            v31.Frame2.BackgroundColor3 = Color3.fromRGB(0, 188, 120);
        end;
        v31.Parent = l_Bin_0;
    end;
    local v32 = v27 - v28;
    if v32 > 0 then
        local v33 = tostring((math.floor(1 / v32 * 100))) .. "%";
        for _, v35 in next, l_Bin_0:GetChildren() do
            if v35:IsA("GuiBase") then
                v35.Frame2.Percent.Text = v33;
                v35.Frame2.Percent.Backdrop.Text = v33;
                local v36 = 30;
                if #v33 > 3 and v35.Frame2.Percent.Visible then
                    v36 = 40;
                end;
                v35.Frame2.Size = UDim2.new(0, v36, 0, 24);
            end;
        end;
        l_Purchase_0.Visible = true;
        v11.PurchasePannelFrame.Options.BottomLine.Visible = true;
        v12 = v22;
    else
        l_Purchase_0.Visible = false;
        v11.PurchasePannelFrame.Options.BottomLine.Visible = true;
    end;
    local l_Y_0 = l_Bin_0.UIGridLayout.AbsoluteContentSize.Y;
    local v38 = math.min(l_Y_0 + 19, 372);
    local v39 = 136;
    if l_Purchase_0.Visible then
        v39 = v39 + 99;
    end;
    v11.PurchasePannelFrame.Options.Bin.CanvasSize = UDim2.new(0, 0, 0, l_Y_0 + 9);
    v11.PurchasePannelFrame.Options.Size = UDim2.new(0, 332, 0, v38);
    v11.PurchasePannelFrame.Size = UDim2.new(0, 332, 0, v38 + v39);
    v11.PurchasePannelFrame.TitleFrame.Info.Count.Text = string.format("%d possible skins, %d owned", v27, v28);
    v11.PurchasePannelFrame.TitleFrame.Info.PriceFrame.Icon.Amount.Text = tostring(v22.Price);
    v11.PurchasePannelFrame.TitleFrame.Info.PriceFrame.Icon.Amount.Backdrop.Text = tostring(v22.Price);
    v11.PurchasePannelFrame.TitleFrame.Info.NameLabel.Text = v22.DisplayName;
    if v22.EventTagged and not v22.OffSale then
        v11.PurchasePannelFrame.TitleFrame.Info.EventTag.Visible = true;
    else
        v11.PurchasePannelFrame.TitleFrame.Info.EventTag.Visible = false;
    end;
    v11.PurchasePannelFrame.Visible = true;
end;
local v41 = nil;
local v42 = nil;
local v43 = {};
local function v45(v44) --[[ Line: 158 ]] --[[ Name: filterString ]]
    return v44:lower():gsub("%p", ""):gsub("%s", "");
end;
local l_v43_0 = v43 --[[ copy: 20 -> 31 ]];
v42 = function(v47) --[[ Line: 162 ]] --[[ Name: filterSkinPacks ]]
    -- upvalues: l_v43_0 (copy)
    local v48 = v47:lower():gsub("%p", ""):gsub("%s", "");
    if v48 == "" then
        for _, v50 in next, l_v43_0 do
            v50.Gui.Visible = true;
        end;
        return;
    else
        for _, v52 in next, l_v43_0 do
            if v52.Name:find(v48) then
                v52.Gui.Visible = true;
            else
                v52.Gui.Visible = false;
            end;
        end;
        return;
    end;
end;
v41 = function(v53) --[[ Line: 180 ]] --[[ Name: buildShopCollectionButtons ]]
    -- upvalues: v1 (copy), l_v2_Storage_0 (copy), v21 (copy), v2 (copy), v40 (copy), l_v43_0 (copy), v11 (copy)
    local v54 = false;
    local v55 = {};
    for v56, v57 in next, v1:GetSkinsData() do
        if not v57.OffSale then
            local v58 = v57.Skins[v57.DisplayIndex or 1];
            local v59 = l_v2_Storage_0.PurchaseCollectionsTemplate:Clone();
            v59.PriceFrame.Icon.Amount.Text = tostring(v57.Price);
            v59.PriceFrame.Icon.Amount.Backdrop.Text = tostring(v57.Price);
            v59.Skin.OverlayImage.Image = v57.DisplayImage or "";
            v59.NameLabel.Text = v57.DisplayName;
            v59.Name = v56;
            v21(v59.Skin, v58);
            v59.Button.MouseButton1Click:Connect(function() --[[ Line: 197 ]]
                -- upvalues: v2 (ref), v40 (ref), v57 (copy)
                v2:PlaySound("Interface.Click");
                v40(v57);
            end);
            if v57.EventTagged and not v57.OffSale then
                v54 = true;
                v59.EventTag.Visible = true;
            else
                v59.EventTag.Visible = false;
            end;
            table.insert(v55, {
                Gui = v59, 
                Data = v57
            });
            table.insert(l_v43_0, {
                Name = v56:lower():gsub("%p", ""):gsub("%s", ""), 
                Gui = v59
            });
        end;
    end;
    table.sort(v55, function(v60, v61) --[[ Line: 222 ]]
        if v60.Data.CreationDate == v61.Data.CreationDate then
            return v60.Gui.Name < v61.Gui.Name;
        else
            return v60.Data.CreationDate > v61.Data.CreationDate;
        end;
    end);
    for v62, v63 in next, v55 do
        v63.Gui.LayoutOrder = v62;
        v63.Gui.Parent = v53;
    end;
    local l_Y_1 = v53.UIGridLayout.AbsoluteContentSize.Y;
    local l_Offset_0 = v53.UIPadding.PaddingTop.Offset;
    local l_Offset_1 = v53.UIPadding.PaddingBottom.Offset;
    local v67 = l_Y_1 + l_Offset_0 + l_Offset_1;
    v53.CanvasSize = UDim2.new(0, 0, 0, v67);
    v11.EventTagged = v54;
end;
v43 = nil;
v45 = nil;
local v68 = nil;
local v69 = nil;
local v70 = {};
local v71 = {};
local v72 = 1;
local v73 = 1;
local function _(v74) --[[ Line: 254 ]] --[[ Name: filterString ]]
    return v74:lower():gsub("%p", ""):gsub("%s", "");
end;
do
    local l_v70_0, l_v72_0, l_v73_0 = v70, v72, v73;
    local function v93() --[[ Line: 258 ]] --[[ Name: sortWorkingList ]]
        -- upvalues: v11 (copy), l_v70_0 (ref), v1 (copy), l_v73_0 (ref), l_v72_0 (ref)
        local v79 = v11.Gui.Collection.Search.TextBox.Text:lower():gsub("%p", ""):gsub("%s", "");
        if v79 ~= "" then
            for _, v81 in next, l_v70_0 do
                if (v1:GetSkinGroupInfo(v81.Group).DisplayName .. v1:FindSkinIndex(v81.Id)):lower():gsub("%p", ""):gsub("%s", ""):find(v79) then
                    v81.Visible = true;
                else
                    v81.Visible = false;
                end;
            end;
        else
            for _, v83 in next, l_v70_0 do
                v83.Visible = true;
            end;
        end;
        table.sort(l_v70_0, function(v84, v85) --[[ Line: 280 ]]
            -- upvalues: v1 (ref)
            local l_DisplayName_0 = v1:GetSkinGroupInfo(v84.Group).DisplayName;
            local l_DisplayName_1 = v1:GetSkinGroupInfo(v85.Group).DisplayName;
            local v88 = v84.Visible and 1 or 0;
            local v89 = v85.Visible and 1 or 0;
            if v88 == v89 then
                if l_DisplayName_0 == l_DisplayName_1 then
                    return v1:FindSkinIndex(v84.Id) < v1:FindSkinIndex(v85.Id);
                else
                    return l_DisplayName_0 < l_DisplayName_1;
                end;
            else
                return v89 < v88;
            end;
        end);
        local v90 = 0;
        for v91 = 1, #l_v70_0 do
            local v92 = l_v70_0[v91];
            if v92 and v92.Visible then
                v90 = v91;
            else
                break;
            end;
        end;
        if v90 > 0 then
            l_v73_0 = math.max(1, (math.ceil(#l_v70_0 / 16)));
        else
            l_v73_0 = 1;
        end;
        if l_v73_0 < l_v72_0 then
            l_v72_0 = l_v73_0;
        end;
    end;
    local l_v71_0 = v71 --[[ copy: 25 -> 32 ]];
    local function v100() --[[ Line: 324 ]] --[[ Name: refreshDisplay ]]
        -- upvalues: l_v72_0 (ref), l_v70_0 (ref), v11 (copy), l_v71_0 (copy), v21 (copy), v1 (copy), v3 (copy)
        local v95 = (l_v72_0 - 1) * 16;
        for v96 = 1, 16 do
            local v97 = l_v70_0[v96 + v95];
            local v98 = v11.CollectionSlots[v96];
            l_v71_0[v98] = nil;
            if v98 then
                if v97 and v97.Visible then
                    v21(v98.Skin.Skin, v97);
                    v98.Skin.NameLabel.Text = v97.DisplayName or v1:GetSkinGroupInfo(v97.Group).DisplayName;
                    v98.Skin.NameLabel.Size = UDim2.new(0, v98.Skin.NameLabel.TextBounds.X + 2, 0, 14);
                    v98.Skin.NameLabel.Number.Text = "#" .. (v97.CustomNumber or v1:FindSkinIndex(v97.Id));
                    local v99 = "";
                    if v3:IsFavorited(v97.Id) then
                        v99 = v99 .. "(F)";
                    end;
                    v98.Skin.DebugLabel.Text = v99;
                    v98.Empty.Visible = false;
                    v98.Skin.Visible = true;
                    l_v71_0[v98] = v97;
                else
                    v98.Empty.Visible = true;
                    v98.Skin.Visible = false;
                end;
            end;
        end;
    end;
    v45 = function(v101, v102) --[[ Line: 366 ]] --[[ Name: setSkinsPage ]]
        -- upvalues: l_v72_0 (ref), l_v73_0 (ref), v11 (copy), v100 (copy)
        if not v101 then
            v101 = l_v72_0;
        end;
        if not v102 then
            v102 = 0;
        end;
        local l_l_v73_0_0 = l_v73_0;
        local v104 = v101 + v102;
        if v104 < 1 then
            v104 = l_l_v73_0_0;
        elseif l_l_v73_0_0 < v104 then
            v104 = 1;
        end;
        local v105 = "Page " .. v104;
        v11.Gui.Collection.ArrowBack.InnerBox.NameLabel.Text = v105;
        v11.Gui.Collection.ArrowBack.InnerBox.NameLabel.Backdrop.Text = v105;
        l_v72_0 = v104;
        v100();
    end;
    v69 = function() --[[ Line: 396 ]] --[[ Name: filterSkins ]]
        -- upvalues: v93 (copy), v45 (ref)
        v93();
        v45();
    end;
    v43 = function(v106) --[[ Line: 401 ]] --[[ Name: updateSkinsGui ]]
        -- upvalues: v3 (copy), l_v70_0 (ref), v93 (copy), v45 (ref), l_v72_0 (ref)
        if not v106 then
            v106 = v3:GetList();
        end;
        l_v70_0 = v106;
        v93();
        v45(l_v72_0);
    end;
    v68 = function(v107) --[[ Line: 411 ]] --[[ Name: getSkinId ]]
        -- upvalues: l_v71_0 (copy)
        if l_v71_0[v107] then
            return l_v71_0[v107].Id;
        else
            return nil;
        end;
    end;
end;
v70 = function(v108, v109) --[[ Line: 420 ]] --[[ Name: styleAlpha ]]
    return 1 - ((math.cos(3.141592653589793 * v108) + 1) / 2) ^ v109;
end;
v71 = function(v110) --[[ Line: 427 ]] --[[ Name: displayUnlockGui ]]
    -- upvalues: v1 (copy), v11 (copy), v15 (copy), v3 (copy), l_v2_Storage_0 (copy), v21 (copy), v2 (copy), l_RunService_0 (copy)
    local l_v1_SkinFromId_0 = v1:GetSkinFromId(v110);
    local l_ItemBin_0 = v11.Gui.Shop.Spinner.ItemBin;
    if not l_v1_SkinFromId_0 then
        return;
    else
        local v113 = v15:NextInteger(75, 100);
        local v114 = {};
        for _, v116 in next, v1:FindRollerSkins(v110) do
            if not v3:IsOwned(v116.Id) or v116.Id == v110 then
                table.insert(v114, v116);
            end;
        end;
        for _, v118 in next, l_ItemBin_0:GetChildren() do
            if v118:IsA("GuiBase") then
                v118:Destroy();
            end;
        end;
        for v119 = 1, v113 do
            local v120 = v114[v15:NextInteger(1, #v114)];
            if v119 == v113 - 3 + 1 then
                v120 = l_v1_SkinFromId_0;
            end;
            local v121 = l_v2_Storage_0.SpinnerTemplate:Clone();
            v21(v121.Skin, v120);
            v121.LayoutOrder = v119;
            v121.Parent = l_ItemBin_0;
        end;
        local v122 = Vector2.new(l_ItemBin_0.UIListLayout.AbsoluteContentSize.X + 18 - l_ItemBin_0.AbsoluteSize.X, 0);
        local v123 = Vector2.new(0, 0);
        local v124 = v114[v15:NextInteger(1, #v114)];
        local v125 = l_v2_Storage_0.SpinnerTemplate:Clone();
        v21(v125.Skin, v124);
        v125.LayoutOrder = v113 + 1;
        v125.Parent = l_ItemBin_0;
        local v126 = v15:NextNumber(0.2, 0.45) * math.sign(v15:NextNumber(0, 1) - 0.5);
        local v127 = (v125.AbsoluteSize.X + 10) * v126;
        v122 = v122 + Vector2.new(v127, 0);
        l_ItemBin_0.CanvasPosition = Vector2.new(0, 0);
        l_ItemBin_0.CanvasSize = UDim2.new(0, l_ItemBin_0.UIListLayout.AbsoluteContentSize.X + 18, 1, 0);
        while v11.PurchasePannelFrame.Purchase.InputSink.Visible do
            v11.PurchasePannelFrame.Purchase.InputSink.Changed:Wait();
        end;
        v124 = nil;
        v125 = false;
        v124 = v11.Gui.Shop.Spinner.Skip.MouseButton1Click:Connect(function() --[[ Line: 498 ]]
            -- upvalues: v2 (ref), v125 (ref)
            v2:PlaySound("Interface.Click");
            v125 = true;
        end);
        v11.Gui.Shop.Spinner.Visible = true;
        v11.Gui.Shop.Collections.Visible = false;
        v11.Gui.Shop.PurchasePannel.Visible = false;
        v11.Gui.Categories.Visible = false;
        v126 = -0.5;
        v127 = 0;
        local v128 = v15:NextNumber(1.5, 4);
        repeat
            v126 = v126 + l_RunService_0.RenderStepped:Wait();
            if v125 then
                v126 = 10;
            end;
            local v129 = 1 - ((math.cos(3.141592653589793 * math.clamp(v126 / 10, 0, 1)) + 1) / 2) ^ v128;
            if 1 / (v113 - 3 + 0.5) < v129 - v127 then
                local v130 = 1.1 - (1 - v129) * 0.2;
                v127 = v129;
                v2:PlaySound("Interface.Snap", nil, v130);
            end;
            l_ItemBin_0.CanvasPosition = v123 + (v122 - v123) * v129;
        until v126 >= 10;
        l_ItemBin_0.CanvasPosition = v122;
        if not v125 then
            v2:PlaySound("Interface.Slap");
            wait(0.25);
        end;
        v124:Disconnect();
        v124 = nil;
        v11.Gui.Shop.Spinner.Visible = false;
        v2:PlaySound("Interface.Bweep");
        v126 = v11.Gui.Shop.Unlock;
        v21(v126.Item.Skin, l_v1_SkinFromId_0);
        v126.Item.NameLabel.Text = v1:GetSkinGroupInfo(l_v1_SkinFromId_0.Group).DisplayName;
        v126.Item.NameLabel.Size = UDim2.new(0, v126.Item.NameLabel.TextBounds.X + 2, 0, 14);
        v126.Item.NameLabel.Number.Text = "#" .. v1:FindSkinIndex(l_v1_SkinFromId_0.Id);
        v126.Visible = true;
        v11:SetTab("Shop");
        v126.Continue.MouseButton1Click:Wait();
        v2:PlaySound("Interface.Click");
        v126.Visible = false;
        v11.Gui.Shop.Collections.Visible = true;
        v11.Gui.Shop.PurchasePannel.Visible = true;
        v11.Gui.Categories.Visible = true;
        v11:SetTab("Shop");
        return;
    end;
end;
v11.IsClosable = function(_) --[[ Line: 577 ]] --[[ Name: IsClosable ]]
    -- upvalues: v11 (copy), v14 (ref)
    if v11.Gui.Shop.Unlock.Visible then
        return false;
    elseif v11.Gui.Shop.Spinner.Visible then
        return false;
    elseif v14 then
        return false;
    else
        return true;
    end;
end;
v11.IsVisible = function(v132) --[[ Line: 595 ]] --[[ Name: IsVisible ]]
    return v132.Gui.Visible;
end;
v11.SetVisible = function(v133, v134) --[[ Line: 599 ]] --[[ Name: SetVisible ]]
    -- upvalues: v3 (copy)
    if #v3:GetList() == 0 then
        v133:SetTab("Shop");
    else
        v133:SetTab("Collection");
    end;
    v133.Gui.Visible = v134;
end;
v11.SetTab = function(v135, v136) --[[ Line: 609 ]] --[[ Name: SetTab ]]
    -- upvalues: v11 (copy), v13 (ref)
    local v137 = v135.CategorySelectButtons[v136];
    local v138 = UDim2.new(1, -1, 0, 0);
    for v139, v140 in next, v135.CategorySelectButtons do
        if v139 == v136 then
            v140.Button.ImageTransparency = 0;
            v140.Window.Visible = true;
        else
            v140.Button.ImageTransparency = 0.75;
            v140.Window.Visible = false;
        end;
    end;
    v11.Gui.Shop.Collections.Search.TextBox.Text = "";
    v13 = v136;
    v135.Gui.Categories.Selector.Position = v137.Button.Position + v138;
end;
return function(_, v142) --[[ Line: 630 ]]
    -- upvalues: v11 (copy), v2 (copy), v68 (ref), v4 (copy), v3 (copy), v5 (copy), v12 (ref), l_Players_0 (copy), v14 (ref), l_MarketplaceService_0 (copy), v45 (ref), v71 (copy), v40 (copy), v43 (ref), l_UserInputService_0 (copy), v69 (ref), v42 (ref), v41 (ref)
    v11.Gui = v142;
    v11.PurchasePannelFrame = v142.Shop.PurchasePannel;
    v11.PurchaseCollectionsFrame = v142.Shop.Collections;
    v11.CategorySelectButtons = {
        Collection = {
            Button = v142.Categories.Collection, 
            Window = v142.Collection
        }, 
        Shop = {
            Button = v142.Categories.Shop, 
            Window = v142.Shop
        }
    };
    v11.CollectionSlots = {};
    for _, v144 in next, v142.Collection.Page:GetChildren() do
        if v144:IsA("GuiBase") then
            v11.CollectionSlots[v144.LayoutOrder] = v144;
        end;
    end;
    for v145, v146 in next, v11.CategorySelectButtons do
        v146.Button.MouseButton1Click:Connect(function() --[[ Line: 658 ]]
            -- upvalues: v2 (ref), v11 (ref), v145 (copy)
            v2:PlaySound("Interface.Click");
            v11:SetTab(v145);
        end);
    end;
    for _, v148 in next, v11.CollectionSlots do
        local _ = {
            v148.Skin.MouseButton1Click, 
            v148.Skin.MouseButton2Click
        };
        v148.Empty.MouseButton1Click:Connect(function() --[[ Line: 670 ]]
            -- upvalues: v2 (ref), v11 (ref)
            v2:PlaySound("Interface.Click");
            v11:SetTab("Shop");
        end);
        for _, v151 in next, {
            v148.Skin.MouseButton1Click, 
            v148.Skin.MouseButton2Click
        } do
            v151:Connect(function() --[[ Line: 676 ]]
                -- upvalues: v2 (ref), v68 (ref), v148 (copy), v4 (ref), v3 (ref), v5 (ref)
                local v152 = v2:Get("GameMenu");
                local v153 = {};
                if v152 then
                    local l_v152_API_0 = v152:GetAPI("Inventory");
                    if l_v152_API_0 and l_v152_API_0.Inventory then
                        local l_Equipment_0 = l_v152_API_0.Inventory.Equipment;
                        local l_Containers_0 = l_v152_API_0.Inventory.Containers;
                        for _, v158 in next, l_Equipment_0 do
                            if v158.CanTakeCosmeticSkins then
                                table.insert(v153, {
                                    Name = "Apply to " .. v158.DisplayName, 
                                    Action = function() --[[ Line: 692 ]] --[[ Name: Action ]]
                                        -- upvalues: v68 (ref), v148 (ref), v4 (ref), v158 (copy)
                                        local v159 = v68(v148);
                                        if v159 then
                                            v4:Send("Inventory Paint Item", v158.Id, v159);
                                        end;
                                    end
                                });
                            end;
                        end;
                        for _, v161 in next, l_Containers_0 do
                            if v161.IsCarried then
                                for _, v163 in next, v161.Occupants do
                                    if v163.CanTakeCosmeticSkins then
                                        table.insert(v153, {
                                            Name = "Apply to " .. v163.DisplayName, 
                                            Action = function() --[[ Line: 710 ]] --[[ Name: Action ]]
                                                -- upvalues: v68 (ref), v148 (ref), v4 (ref), v163 (copy)
                                                local v164 = v68(v148);
                                                if v164 then
                                                    v4:Send("Inventory Paint Item", v163.Id, v164);
                                                end;
                                            end
                                        });
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                local v165 = v68(v148);
                if v165 then
                    local _ = v3:IsFavorited(v165);
                end;
                if #v153 > 0 then
                    v5:Open(v153);
                end;
                v2:PlaySound("Interface.Click");
            end);
        end;
    end;
    v11.PurchasePannelFrame.Purchase.MouseButton1Click:Connect(function() --[[ Line: 751 ]]
        -- upvalues: v2 (ref), v12 (ref), l_Players_0 (ref), v4 (ref), v11 (ref), v14 (ref), l_MarketplaceService_0 (ref)
        v2:PlaySound("Interface.Click");
        if v12 then
            local l_DevProductId_0 = v12.DevProductId;
            local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
            if l_DevProductId_0 and l_LocalPlayer_0 and v4:Fetch("Did Save Load", "Purchases") then
                v11.PurchasePannelFrame.Purchase.InputSink.Visible = true;
                v14 = true;
                l_MarketplaceService_0:PromptProductPurchase(l_LocalPlayer_0, l_DevProductId_0);
            end;
        end;
    end);
    v11.Gui.Collection.ArrowBack.MouseButton1Click:Connect(function() --[[ Line: 769 ]]
        -- upvalues: v2 (ref), v45 (ref)
        v2:PlaySound("Interface.Click");
        v45(nil, -1);
    end);
    v11.Gui.Collection.ArrowForward.MouseButton1Click:Connect(function() --[[ Line: 774 ]]
        -- upvalues: v2 (ref), v45 (ref)
        v2:PlaySound("Interface.Click");
        v45(nil, 1);
    end);
    v3.SkinAdded:Connect(function(v169) --[[ Line: 779 ]]
        -- upvalues: v11 (ref), v2 (ref), v71 (ref), v12 (ref), v40 (ref), v14 (ref)
        if v11:IsVisible() and v2:IsVisible("GameMenu") then
            v71(v169);
            if v12 then
                v40(v12);
            end;
            v14 = false;
        end;
    end);
    v3.SkinsSynced:Connect(function() --[[ Line: 791 ]]
        -- upvalues: v43 (ref), v3 (ref), v45 (ref)
        v43(v3:GetList());
        v45();
    end);
    l_MarketplaceService_0.PromptProductPurchaseFinished:Connect(function(_, _, v172) --[[ Line: 801 ]]
        -- upvalues: v14 (ref), v11 (ref)
        if not v172 then
            v14 = false;
        end;
        v11.PurchasePannelFrame.Purchase.InputSink.Visible = false;
    end);
    l_UserInputService_0.InputBegan:Connect(function(_, _) --[[ Line: 811 ]]

    end);
    v11.Gui.Collection.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 825 ]]
        -- upvalues: v69 (ref), v11 (ref)
        v69(v11.Gui.Collection.Search.TextBox.Text);
    end);
    v11.Gui.Shop.Collections.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 829 ]]
        -- upvalues: v42 (ref), v11 (ref)
        v42(v11.Gui.Shop.Collections.Search.TextBox.Text);
    end);
    v41(v142.Shop.Collections.ScrollingFrame);
    v43(v3:ResyncMasterList());
    v45(1);
    return v11;
end;