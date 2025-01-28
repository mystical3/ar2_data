local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "FirearmSkinsData");
local v2 = v0.require("Libraries", "Interface");
local v3 = v0.require("Libraries", "GunSkins");
local v4 = v0.require("Libraries", "Network");
local v5 = v2:Get("Dropdown");
local l_v2_Storage_0 = v2:GetStorage("MainMenu");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local v11 = {};
local v12 = nil;
local v13 = "Skins";
local v14 = Random.new();
local function v20(v15, v16) --[[ Line: 33 ]] --[[ Name: dressSkinGui ]]
    local l_Pattern2_0 = v15:FindFirstChild("Pattern2");
    local l_1_0 = v16.Patterns["1"];
    local l_2_0 = v16.Patterns["2"];
    v15.Channel1.Image = l_1_0.Channel1[1];
    v15.Channel1.ImageColor3 = Color3.new(select(2, unpack(l_1_0.Channel1)));
    v15.Channel2.Image = l_1_0.Channel2[1];
    v15.Channel2.ImageColor3 = Color3.new(select(2, unpack(l_1_0.Channel2)));
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
local function v39(v21) --[[ Line: 58 ]] --[[ Name: buildOptionsDisplay ]]
    -- upvalues: v11 (copy), v12 (ref), l_v2_Storage_0 (copy), v20 (copy), v3 (copy)
    local l_Bin_0 = v11.PurchasePannelFrame.Options.Bin;
    local l_Purchase_0 = v11.PurchasePannelFrame.Purchase;
    for _, v25 in next, l_Bin_0:GetChildren() do
        if v25:IsA("GuiBase") then
            v25:Destroy();
        end;
        v12 = nil;
    end;
    local v26 = #v21.Skins;
    local v27 = 0;
    for v28, v29 in next, v21.Skins do
        local v30 = l_v2_Storage_0.PurchaseOptionsTemplate:Clone();
        v30.LayoutOrder = v28;
        v30.Frame2.Frame1.Number.Text = "#" .. (v29.CustomNumber or tostring(v28));
        v20(v30.Skin, v29);
        if v3:IsOwned(v29.Id) then
            v30.Frame2.Checkmark.Visible = true;
            v30.Frame2.Percent.Visible = false;
            v30.Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            v27 = v27 + 1;
        else
            v30.Frame2.Checkmark.Visible = false;
            v30.Frame2.Percent.Visible = true;
            v30.Frame2.BackgroundColor3 = Color3.fromRGB(0, 188, 120);
        end;
        v30.Parent = l_Bin_0;
    end;
    local v31 = v26 - v27;
    if v31 > 0 then
        local v32 = tostring((math.floor(1 / v31 * 100))) .. "%";
        for _, v34 in next, l_Bin_0:GetChildren() do
            if v34:IsA("GuiBase") then
                v34.Frame2.Percent.Text = v32;
                v34.Frame2.Percent.Backdrop.Text = v32;
                local v35 = 30;
                if #v32 > 3 and v34.Frame2.Percent.Visible then
                    v35 = 40;
                end;
                v34.Frame2.Size = UDim2.new(0, v35, 0, 24);
            end;
        end;
        l_Purchase_0.Visible = true;
        v11.PurchasePannelFrame.Options.BottomLine.Visible = true;
        v12 = v21;
    else
        l_Purchase_0.Visible = false;
        v11.PurchasePannelFrame.Options.BottomLine.Visible = true;
    end;
    local l_Y_0 = l_Bin_0.UIGridLayout.AbsoluteContentSize.Y;
    local v37 = math.min(l_Y_0 + 19, 372);
    local v38 = 136;
    if l_Purchase_0.Visible then
        v38 = v38 + 99;
    end;
    v11.PurchasePannelFrame.Options.Bin.CanvasSize = UDim2.new(0, 0, 0, l_Y_0 + 9);
    v11.PurchasePannelFrame.Options.Size = UDim2.new(0, 332, 0, v37);
    v11.PurchasePannelFrame.Size = UDim2.new(0, 332, 0, v37 + v38);
    v11.PurchasePannelFrame.TitleFrame.Info.Count.Text = string.format("%d possible skins, %d owned", v26, v27);
    v11.PurchasePannelFrame.TitleFrame.Info.PriceFrame.Icon.Amount.Text = tostring(v21.Price);
    v11.PurchasePannelFrame.TitleFrame.Info.PriceFrame.Icon.Amount.Backdrop.Text = tostring(v21.Price);
    v11.PurchasePannelFrame.TitleFrame.Info.NameLabel.Text = v21.DisplayName;
    if v21.EventTagged and not v21.OffSale then
        v11.PurchasePannelFrame.TitleFrame.Info.EventTag.Visible = true;
    else
        v11.PurchasePannelFrame.TitleFrame.Info.EventTag.Visible = false;
    end;
    v11.PurchasePannelFrame.Visible = true;
end;
local v40 = nil;
local v41 = nil;
local v42 = {};
local function v44(v43) --[[ Line: 157 ]] --[[ Name: filterString ]]
    return v43:lower():gsub("%p", ""):gsub("%s", "");
end;
local l_v42_0 = v42 --[[ copy: 19 -> 30 ]];
v41 = function(v46) --[[ Line: 161 ]] --[[ Name: filterSkinPacks ]]
    -- upvalues: l_v42_0 (copy)
    local v47 = v46:lower():gsub("%p", ""):gsub("%s", "");
    if v47 == "" then
        for _, v49 in next, l_v42_0 do
            v49.Gui.Visible = true;
        end;
        return;
    else
        for _, v51 in next, l_v42_0 do
            if v51.Name:find(v47) then
                v51.Gui.Visible = true;
            else
                v51.Gui.Visible = false;
            end;
        end;
        return;
    end;
end;
v40 = function(v52) --[[ Line: 179 ]] --[[ Name: buildShopCollectionButtons ]]
    -- upvalues: v1 (copy), l_v2_Storage_0 (copy), v20 (copy), v2 (copy), v39 (copy), l_v42_0 (copy), v11 (copy)
    local v53 = false;
    local v54 = {};
    for v55, v56 in next, v1:GetSkinsData() do
        if not v56.OffSale then
            local v57 = v56.Skins[v56.DisplayIndex or 1];
            local v58 = l_v2_Storage_0.PurchaseCollectionsTemplate:Clone();
            v58.PriceFrame.Icon.Amount.Text = tostring(v56.Price);
            v58.PriceFrame.Icon.Amount.Backdrop.Text = tostring(v56.Price);
            v58.Skin.OverlayImage.Image = v56.DisplayImage or "";
            v58.NameLabel.Text = v56.DisplayName;
            v58.Name = v55;
            v20(v58.Skin, v57);
            v58.Button.MouseButton1Click:Connect(function() --[[ Line: 196 ]]
                -- upvalues: v2 (ref), v39 (ref), v56 (copy)
                v2:PlaySound("Interface.Click");
                v39(v56);
            end);
            if v56.EventTagged and not v56.OffSale then
                v53 = true;
                v58.EventTag.Visible = true;
            else
                v58.EventTag.Visible = false;
            end;
            table.insert(v54, {
                Gui = v58, 
                Data = v56
            });
            table.insert(l_v42_0, {
                Name = v55:lower():gsub("%p", ""):gsub("%s", ""), 
                Gui = v58
            });
        end;
    end;
    table.sort(v54, function(v59, v60) --[[ Line: 221 ]]
        if v59.Data.CreationDate == v60.Data.CreationDate then
            return v59.Gui.Name < v60.Gui.Name;
        else
            return v59.Data.CreationDate > v60.Data.CreationDate;
        end;
    end);
    for v61, v62 in next, v54 do
        v62.Gui.LayoutOrder = v61;
        v62.Gui.Parent = v52;
    end;
    local l_Y_1 = v52.UIGridLayout.AbsoluteContentSize.Y;
    local l_Offset_0 = v52.UIPadding.PaddingTop.Offset;
    local l_Offset_1 = v52.UIPadding.PaddingBottom.Offset;
    local v66 = l_Y_1 + l_Offset_0 + l_Offset_1;
    v52.CanvasSize = UDim2.new(0, 0, 0, v66);
    v11.EventTagged = v53;
end;
v42 = nil;
v44 = nil;
local v67 = nil;
local v68 = nil;
local v69 = {};
local v70 = {};
local v71 = 1;
local v72 = 1;
local function _(v73) --[[ Line: 253 ]] --[[ Name: filterString ]]
    return v73:lower():gsub("%p", ""):gsub("%s", "");
end;
do
    local l_v69_0, l_v71_0, l_v72_0 = v69, v71, v72;
    local function v92() --[[ Line: 257 ]] --[[ Name: sortWorkingList ]]
        -- upvalues: v11 (copy), l_v69_0 (ref), v1 (copy), l_v72_0 (ref), l_v71_0 (ref)
        local v78 = v11.Gui.Collection.Search.TextBox.Text:lower():gsub("%p", ""):gsub("%s", "");
        if v78 ~= "" then
            for _, v80 in next, l_v69_0 do
                if (v1:GetSkinGroupInfo(v80.Group).DisplayName .. v1:FindSkinIndex(v80.Id)):lower():gsub("%p", ""):gsub("%s", ""):find(v78) then
                    v80.Visible = true;
                else
                    v80.Visible = false;
                end;
            end;
        else
            for _, v82 in next, l_v69_0 do
                v82.Visible = true;
            end;
        end;
        table.sort(l_v69_0, function(v83, v84) --[[ Line: 279 ]]
            -- upvalues: v1 (ref)
            local l_DisplayName_0 = v1:GetSkinGroupInfo(v83.Group).DisplayName;
            local l_DisplayName_1 = v1:GetSkinGroupInfo(v84.Group).DisplayName;
            local v87 = v83.Visible and 1 or 0;
            local v88 = v84.Visible and 1 or 0;
            if v87 == v88 then
                if l_DisplayName_0 == l_DisplayName_1 then
                    return v1:FindSkinIndex(v83.Id) < v1:FindSkinIndex(v84.Id);
                else
                    return l_DisplayName_0 < l_DisplayName_1;
                end;
            else
                return v88 < v87;
            end;
        end);
        local v89 = 0;
        for v90 = 1, #l_v69_0 do
            local v91 = l_v69_0[v90];
            if v91 and v91.Visible then
                v89 = v90;
            else
                break;
            end;
        end;
        if v89 > 0 then
            l_v72_0 = math.max(1, (math.ceil(#l_v69_0 / 16)));
        else
            l_v72_0 = 1;
        end;
        if l_v72_0 < l_v71_0 then
            l_v71_0 = l_v72_0;
        end;
    end;
    local l_v70_0 = v70 --[[ copy: 24 -> 31 ]];
    local function v98() --[[ Line: 323 ]] --[[ Name: refreshDisplay ]]
        -- upvalues: l_v71_0 (ref), l_v69_0 (ref), v11 (copy), l_v70_0 (copy), v20 (copy), v1 (copy)
        local v94 = (l_v71_0 - 1) * 16;
        for v95 = 1, 16 do
            local v96 = l_v69_0[v95 + v94];
            local v97 = v11.CollectionSlots[v95];
            l_v70_0[v97] = nil;
            if v97 then
                if v96 and v96.Visible then
                    v20(v97.Skin.Skin, v96);
                    v97.Skin.NameLabel.Text = v96.DisplayName or v1:GetSkinGroupInfo(v96.Group).DisplayName;
                    v97.Skin.NameLabel.Size = UDim2.new(0, v97.Skin.NameLabel.TextBounds.X + 2, 0, 14);
                    v97.Skin.NameLabel.Number.Text = "#" .. (v96.CustomNumber or v1:FindSkinIndex(v96.Id));
                    v97.Empty.Visible = false;
                    v97.Skin.Visible = true;
                    l_v70_0[v97] = v96;
                else
                    v97.Empty.Visible = true;
                    v97.Skin.Visible = false;
                end;
            end;
        end;
    end;
    v44 = function(v99, v100) --[[ Line: 355 ]] --[[ Name: setSkinsPage ]]
        -- upvalues: l_v71_0 (ref), l_v72_0 (ref), v11 (copy), v98 (copy)
        if not v99 then
            v99 = l_v71_0;
        end;
        if not v100 then
            v100 = 0;
        end;
        local l_l_v72_0_0 = l_v72_0;
        local v102 = v99 + v100;
        if v102 < 1 then
            v102 = l_l_v72_0_0;
        elseif l_l_v72_0_0 < v102 then
            v102 = 1;
        end;
        local v103 = "Page " .. v102;
        v11.Gui.Collection.ArrowBack.InnerBox.NameLabel.Text = v103;
        v11.Gui.Collection.ArrowBack.InnerBox.NameLabel.Backdrop.Text = v103;
        l_v71_0 = v102;
        v98();
    end;
    v68 = function() --[[ Line: 385 ]] --[[ Name: filterSkins ]]
        -- upvalues: v92 (copy), v44 (ref)
        v92();
        v44();
    end;
    v42 = function(v104) --[[ Line: 390 ]] --[[ Name: updateSkinsGui ]]
        -- upvalues: v3 (copy), l_v69_0 (ref), v92 (copy), v44 (ref), l_v71_0 (ref)
        if not v104 then
            v104 = v3:GetList();
        end;
        l_v69_0 = v104;
        v92();
        v44(l_v71_0);
    end;
    v67 = function(v105) --[[ Line: 400 ]] --[[ Name: getSkinId ]]
        -- upvalues: l_v70_0 (copy)
        if l_v70_0[v105] then
            return l_v70_0[v105].Id;
        else
            return nil;
        end;
    end;
end;
v69 = function(v106, v107) --[[ Line: 409 ]] --[[ Name: styleAlpha ]]
    return 1 - ((math.cos(3.141592653589793 * v106) + 1) / 2) ^ v107;
end;
v70 = function(v108) --[[ Line: 416 ]] --[[ Name: displayUnlockGui ]]
    -- upvalues: v1 (copy), v11 (copy), v14 (copy), v3 (copy), l_v2_Storage_0 (copy), v20 (copy), v2 (copy), l_RunService_0 (copy)
    local l_v1_SkinFromId_0 = v1:GetSkinFromId(v108);
    local l_ItemBin_0 = v11.Gui.Shop.Spinner.ItemBin;
    if not l_v1_SkinFromId_0 then
        return;
    else
        local v111 = v14:NextInteger(75, 100);
        local v112 = {};
        for _, v114 in next, v1:FindRollerSkins(v108) do
            if not v3:IsOwned(v114.Id) or v114.Id == v108 then
                table.insert(v112, v114);
            end;
        end;
        for _, v116 in next, l_ItemBin_0:GetChildren() do
            if v116:IsA("GuiBase") then
                v116:Destroy();
            end;
        end;
        for v117 = 1, v111 do
            local v118 = v112[v14:NextInteger(1, #v112)];
            if v117 == v111 - 3 + 1 then
                v118 = l_v1_SkinFromId_0;
            end;
            local v119 = l_v2_Storage_0.SpinnerTemplate:Clone();
            v20(v119.Skin, v118);
            v119.LayoutOrder = v117;
            v119.Parent = l_ItemBin_0;
        end;
        local v120 = Vector2.new(l_ItemBin_0.UIListLayout.AbsoluteContentSize.X + 18 - l_ItemBin_0.AbsoluteSize.X, 0);
        local v121 = Vector2.new(0, 0);
        local v122 = v112[v14:NextInteger(1, #v112)];
        local v123 = l_v2_Storage_0.SpinnerTemplate:Clone();
        v20(v123.Skin, v122);
        v123.LayoutOrder = v111 + 1;
        v123.Parent = l_ItemBin_0;
        local v124 = v14:NextNumber(0.2, 0.45) * math.sign(v14:NextNumber(0, 1) - 0.5);
        local v125 = (v123.AbsoluteSize.X + 10) * v124;
        v120 = v120 + Vector2.new(v125, 0);
        l_ItemBin_0.CanvasPosition = Vector2.new(0, 0);
        l_ItemBin_0.CanvasSize = UDim2.new(0, l_ItemBin_0.UIListLayout.AbsoluteContentSize.X + 18, 1, 0);
        while v11.PurchasePannelFrame.Purchase.InputSink.Visible do
            v11.PurchasePannelFrame.Purchase.InputSink.Changed:Wait();
        end;
        v122 = nil;
        v123 = false;
        v122 = v11.Gui.Shop.Spinner.Skip.MouseButton1Click:Connect(function() --[[ Line: 487 ]]
            -- upvalues: v2 (ref), v123 (ref)
            v2:PlaySound("Interface.Click");
            v123 = true;
        end);
        v11.Gui.Shop.Spinner.Visible = true;
        v11.Gui.Shop.Collections.Visible = false;
        v11.Gui.Shop.PurchasePannel.Visible = false;
        v11.Gui.Categories.Visible = false;
        v124 = -0.5;
        v125 = 0;
        local v126 = v14:NextNumber(1.5, 4);
        repeat
            v124 = v124 + l_RunService_0.RenderStepped:Wait();
            if v123 then
                v124 = 10;
            end;
            local v127 = 1 - ((math.cos(3.141592653589793 * math.clamp(v124 / 10, 0, 1)) + 1) / 2) ^ v126;
            if 1 / (v111 - 3 + 0.5) < v127 - v125 then
                local v128 = 1.1 - (1 - v127) * 0.2;
                v125 = v127;
                v2:PlaySound("Interface.Snap", nil, v128);
            end;
            l_ItemBin_0.CanvasPosition = v121 + (v120 - v121) * v127;
        until v124 >= 10;
        l_ItemBin_0.CanvasPosition = v120;
        if not v123 then
            v2:PlaySound("Interface.Slap");
            wait(0.25);
        end;
        v122:Disconnect();
        v122 = nil;
        v11.Gui.Shop.Spinner.Visible = false;
        v2:PlaySound("Interface.Bweep");
        v124 = v11.Gui.Shop.Unlock;
        v20(v124.Item.Skin, l_v1_SkinFromId_0);
        v124.Item.NameLabel.Text = v1:GetSkinGroupInfo(l_v1_SkinFromId_0.Group).DisplayName;
        v124.Item.NameLabel.Size = UDim2.new(0, v124.Item.NameLabel.TextBounds.X + 2, 0, 14);
        v124.Item.NameLabel.Number.Text = "#" .. v1:FindSkinIndex(l_v1_SkinFromId_0.Id);
        v124.Visible = true;
        v11:SetTab("Shop");
        v124.Continue.MouseButton1Click:Wait();
        v2:PlaySound("Interface.Click");
        v124.Visible = false;
        v11.Gui.Shop.Collections.Visible = true;
        v11.Gui.Shop.PurchasePannel.Visible = true;
        v11.Gui.Categories.Visible = true;
        v11:SetTab("Shop");
        return;
    end;
end;
v11.IsVisible = function(v129) --[[ Line: 566 ]] --[[ Name: IsVisible ]]
    return v129.Gui.Visible;
end;
v11.IsClosable = function(_) --[[ Line: 570 ]] --[[ Name: IsClosable ]]
    -- upvalues: v11 (copy)
    if v11.Gui.Shop.Unlock.Visible then
        return false;
    elseif v11.Gui.Shop.Spinner.Visible then
        return false;
    else
        return true;
    end;
end;
v11.Start = function(_) --[[ Line: 584 ]] --[[ Name: Start ]]

end;
v11.SetVisible = function(v132, v133, v134) --[[ Line: 588 ]] --[[ Name: SetVisible ]]
    -- upvalues: v3 (copy)
    if #v3:GetList() == 0 then
        v132:SetTab("Shop");
    else
        v132:SetTab("Collection");
    end;
    if v133 then
        v134:SetBlur(30);
    end;
    v132.Gui.Visible = v133;
end;
v11.SetTab = function(v135, v136) --[[ Line: 602 ]] --[[ Name: SetTab ]]
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
return function(_, v142) --[[ Line: 624 ]]
    -- upvalues: v11 (copy), v2 (copy), v67 (ref), v4 (copy), v5 (copy), v12 (ref), l_Players_0 (copy), l_MarketplaceService_0 (copy), v44 (ref), v3 (copy), v42 (ref), v70 (copy), v39 (copy), l_UserInputService_0 (copy), v68 (ref), v41 (ref), v40 (ref)
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
        v146.Button.MouseButton1Click:Connect(function() --[[ Line: 652 ]]
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
        v148.Empty.MouseButton1Click:Connect(function() --[[ Line: 664 ]]
            -- upvalues: v2 (ref), v11 (ref)
            v2:PlaySound("Interface.Click");
            v11:SetTab("Shop");
        end);
        for _, v151 in next, {
            v148.Skin.MouseButton1Click, 
            v148.Skin.MouseButton1Click
        } do
            v151:Connect(function() --[[ Line: 670 ]]
                -- upvalues: v2 (ref), v67 (ref), v148 (copy), v4 (ref), v5 (ref)
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
                                    Action = function() --[[ Line: 686 ]] --[[ Name: Action ]]
                                        -- upvalues: v67 (ref), v148 (ref), v4 (ref), v158 (copy)
                                        local v159 = v67(v148);
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
                                            Action = function() --[[ Line: 704 ]] --[[ Name: Action ]]
                                                -- upvalues: v67 (ref), v148 (ref), v4 (ref), v163 (copy)
                                                local v164 = v67(v148);
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
                if #v153 > 0 then
                    v5:Open(v153);
                end;
                v2:PlaySound("Interface.Click");
            end);
        end;
    end;
    v11.PurchasePannelFrame.Purchase.MouseButton1Click:Connect(function() --[[ Line: 728 ]]
        -- upvalues: v2 (ref), v12 (ref), l_Players_0 (ref), v4 (ref), v11 (ref), l_MarketplaceService_0 (ref)
        v2:PlaySound("Interface.Click");
        if v12 then
            local l_DevProductId_0 = v12.DevProductId;
            local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
            if l_DevProductId_0 and l_LocalPlayer_0 and v4:Fetch("Did Save Load", "Purchases") then
                v11.PurchasePannelFrame.Purchase.InputSink.Visible = true;
                l_MarketplaceService_0:PromptProductPurchase(l_LocalPlayer_0, l_DevProductId_0);
            end;
        end;
    end);
    v11.Gui.Collection.ArrowBack.MouseButton1Click:Connect(function() --[[ Line: 744 ]]
        -- upvalues: v2 (ref), v44 (ref)
        v2:PlaySound("Interface.Click");
        v44(nil, -1);
    end);
    v11.Gui.Collection.ArrowForward.MouseButton1Click:Connect(function() --[[ Line: 749 ]]
        -- upvalues: v2 (ref), v44 (ref)
        v2:PlaySound("Interface.Click");
        v44(nil, 1);
    end);
    v3.SkinAdded:Connect(function(v167) --[[ Line: 754 ]]
        -- upvalues: v42 (ref), v3 (ref), v11 (ref), v2 (ref), v70 (ref), v12 (ref), v39 (ref)
        v42(v3:ResyncMasterList());
        if v11:IsVisible() and v2:IsVisible("MainMenu") then
            v70(v167);
        end;
        if v12 then
            v39(v12);
        end;
    end);
    l_MarketplaceService_0.PromptProductPurchaseFinished:Connect(function(_, _, _) --[[ Line: 766 ]]
        -- upvalues: v11 (ref)
        v11.PurchasePannelFrame.Purchase.InputSink.Visible = false;
    end);
    l_UserInputService_0.InputBegan:Connect(function(_, _) --[[ Line: 770 ]]

    end);
    v11.Gui.Collection.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 782 ]]
        -- upvalues: v68 (ref), v11 (ref)
        v68(v11.Gui.Collection.Search.TextBox.Text);
    end);
    v11.Gui.Shop.Collections.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 786 ]]
        -- upvalues: v41 (ref), v11 (ref)
        v41(v11.Gui.Shop.Collections.Search.TextBox.Text);
    end);
    v40(v142.Shop.Collections.ScrollingFrame);
    v42(v3:ResyncMasterList());
    v44(1);
    return v11;
end;