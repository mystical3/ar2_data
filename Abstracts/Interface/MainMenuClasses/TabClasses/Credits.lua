local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Libraries", "Interface");
local _ = v0.require("Libraries", "Network");
local l_TextService_0 = game:GetService("TextService");
local l_v1_Storage_0 = v1:GetStorage("MainMenu");
local l_CreditsEntryTemplate_0 = l_v1_Storage_0:WaitForChild("CreditsEntryTemplate");
local l_CreditsGroupTemplate_0 = l_v1_Storage_0:WaitForChild("CreditsGroupTemplate");
local v7 = {};
local v8 = {
    {
        Title = "LEAD DESIGNER / PRODUCER", 
        Entries = {
            "Gusmanak"
        }
    }, 
    {
        Title = "PROGRAMMER", 
        Entries = {
            "LMH_Hutch"
        }
    }, 
    {
        Title = "USER INTERFACE & GRAPHICS", 
        Entries = {
            "Blueice506"
        }
    }, 
    {
        Title = "SENIOR DESIGNER", 
        Entries = {
            "Narroby", 
            "bloody1"
        }
    }, 
    {
        Title = "CLOTHING ASSETS", 
        Entries = {
            "Tokui", 
            "GrottyPuff"
        }
    }, 
    {
        Title = "AUDIO PRODUCTION", 
        Entries = {
            "BOZZSYLUX"
        }
    }, 
    {
        Title = "MUSIC", 
        Entries = {
            "Razinox"
        }
    }, 
    {
        Title = "CHARACTER ANIMATION", 
        Entries = {
            "ChadTheCreator", 
            "Wingboy0"
        }
    }, 
    {
        Title = "ARCHITECTURE & INTERIOR DESIGN", 
        Entries = {
            "Prazzy", 
            "SilentJoe2", 
            "144hertz", 
            "ZombieHours", 
            "finwei", 
            "XrxshadowxX", 
            "YasuYoshida"
        }
    }, 
    {
        Title = "3D ASSETS / TEXTURES", 
        Entries = {
            "Joe Swanson (Zenphee)", 
            "Valkenheim"
        }
    }, 
    {
        Title = "3D ASSETS", 
        Entries = {
            "Decuple", 
            "SleepingGiant", 
            "Sandbar3D", 
            "Nilvaat"
        }
    }, 
    {
        Title = "FIREARM ASSETS", 
        Entries = {
            "Ownagesauce"
        }
    }, 
    {
        Title = "ENVIRONMENTAL TEXTURES", 
        Entries = {
            "Derix38", 
            "Storm_er"
        }
    }, 
    {
        Title = "MISCELLANEOUS ASSISTANCE", 
        Entries = {
            "Rubatose", 
            "Windwheel", 
            "queued", 
            "BlueTaslem", 
            "TedArthur", 
            "Stant01", 
            "zaiisao", 
            "Karterness", 
            "jcfc", 
            "sergiu8957", 
            "Zealiance", 
            "Matcel", 
            "Inyo22", 
            "WWIIman1", 
            "WhosAstro", 
            "Ezmoreth", 
            "IDontHaveAUse"
        }
    }
};
local function v13(v9, v10, v11) --[[ Line: 150 ]] --[[ Name: getTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    local l_GetTextBoundsParams_0 = Instance.new("GetTextBoundsParams");
    l_GetTextBoundsParams_0.Text = v9;
    l_GetTextBoundsParams_0.Font = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold);
    l_GetTextBoundsParams_0.Size = v10.TextSize;
    l_GetTextBoundsParams_0.Width = v11 or v10.AbsoluteSize.X;
    return l_TextService_0:GetTextBoundsAsync(l_GetTextBoundsParams_0);
end;
v7.IsVisible = function(v14) --[[ Line: 163 ]] --[[ Name: IsVisible ]]
    return v14.Gui.Visible;
end;
v7.IsClosable = function(_) --[[ Line: 167 ]] --[[ Name: IsClosable ]]
    return true;
end;
v7.SetVisible = function(v16, v17, v18) --[[ Line: 171 ]] --[[ Name: SetVisible ]]
    v16.Gui.Visible = v17;
    if v17 then
        v18:SetBlur(30);
    end;
end;
v7.Start = function(_) --[[ Line: 179 ]] --[[ Name: Start ]]

end;
return function(_, v21) --[[ Line: 185 ]]
    -- upvalues: v7 (copy), v8 (copy), l_CreditsGroupTemplate_0 (copy), l_CreditsEntryTemplate_0 (copy), v13 (copy)
    v7.Gui = v21;
    task.spawn(function() --[[ Line: 191 ]]
        -- upvalues: v8 (ref), l_CreditsGroupTemplate_0 (ref), l_CreditsEntryTemplate_0 (ref), v13 (ref), v21 (copy)
        for v22, v23 in next, v8 do
            local v24 = l_CreditsGroupTemplate_0:Clone();
            v24.LayoutOrder = v22;
            for v25, v26 in next, v23.Entries do
                local v27 = l_CreditsEntryTemplate_0:Clone();
                v27.LayoutOrder = v25;
                v27.Text = v26;
                v27.Parent = v24;
            end;
            local l_X_0 = v13(v23.Title, v24.Title, 1000).X;
            local l_Y_0 = v24.UIListLayout.AbsoluteContentSize.Y;
            v24.Title.Text = v23.Title;
            v24.Title.Size = UDim2.fromOffset(l_X_0 + 44, 43);
            v24.Size = UDim2.fromOffset(300, l_Y_0);
            v24.Parent = v21.ScrollingFrame;
        end;
        local l_Y_1 = v21.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y;
        local v31 = v21.ScrollingFrame.UIPadding.PaddingTop.Offset - v21.ScrollingFrame.UIPadding.PaddingBottom.Offset;
        v21.ScrollingFrame.CanvasSize = UDim2.fromOffset(0, l_Y_1 + v31);
    end);
    return v7;
end;