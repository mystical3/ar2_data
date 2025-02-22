local _ = game:GetService("LocalizationService");
local v1 = require(game:GetService("ReplicatedFirst").Framework);
local v2 = v1.require("Libraries", "Resources");
local _ = v1.require("Libraries", "Network");
local v4 = v1.require("Classes", "Signals");
local l_RunService_0 = game:GetService("RunService");
local l_PlayerGui_0 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local l_GuiMain_0 = l_PlayerGui_0:WaitForChild("GuiMain");
l_GuiMain_0.DisplayOrder = 1;
l_GuiMain_0.Name = "ScreenGui";
l_GuiMain_0.Parent = l_PlayerGui_0;
local l_ScreenGui_0 = Instance.new("ScreenGui");
l_ScreenGui_0.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets;
l_ScreenGui_0.Name = "Topbar Fill";
l_ScreenGui_0.Parent = l_PlayerGui_0;
local v9 = v2:Find("ReplicatedStorage.Client.Abstracts.Interface");
local v10 = v2:Find("ReplicatedStorage.Interface");
local v11 = {
    ScaleSize = Vector2.new(1366, 670), 
    ScaleChangd = v4.new(), 
    TopbarChanged = v4.new()
};
local v12 = {};
local v13 = {};
local v14 = {};
local v15 = {};
local v16 = {};
local function v20(v17) --[[ Line: 44 ]] --[[ Name: loadGui ]]
    -- upvalues: v15 (copy), v12 (copy), v4 (copy), v10 (copy), l_RunService_0 (copy), l_GuiMain_0 (copy)
    if v15[v17] then
        return v15:Wait();
    else
        if not v12[v17] then
            local v18 = v4.new();
            v15[v17] = v18;
            local l_Master_0 = v10:WaitForChild(v17):WaitForChild("Master");
            if l_RunService_0:IsStudio() then
                l_Master_0.Name = v17;
            else
                l_Master_0.Name = "Parent";
            end;
            l_Master_0.Visible = false;
            l_Master_0.Parent = l_GuiMain_0;
            v12[v17] = l_Master_0;
            v15[v17] = nil;
            v18:Fire(l_Master_0);
            v18:Destroy();
        end;
        return v12[v17];
    end;
end;
local function v25(v21) --[[ Line: 75 ]] --[[ Name: loadModule ]]
    -- upvalues: v14 (copy), v13 (copy), v4 (copy), v9 (copy)
    if v14[v21] then
        return v14[v21]:Wait();
    else
        if not v13[v21] then
            local v22 = v4.new();
            v14[v21] = v22;
            local v23 = v9:WaitForChild(v21);
            local v24 = require(v23);
            v13[v21] = v24;
            v14[v21] = nil;
            v22:Fire(v24);
            v22:Destroy();
        end;
        return v13[v21];
    end;
end;
v11.Get = function(_, v27) --[[ Line: 99 ]] --[[ Name: Get ]]
    -- upvalues: v25 (copy), v20 (copy)
    return v25(v27), v20(v27);
end;
v11.GetGui = function(_, v29) --[[ Line: 103 ]] --[[ Name: GetGui ]]
    -- upvalues: v20 (copy)
    return v20(v29);
end;
v11.GetStorage = function(_, v31) --[[ Line: 107 ]] --[[ Name: GetStorage ]]
    -- upvalues: v10 (copy)
    return v10:WaitForChild(v31);
end;
v11.LoadAll = function(_, v33) --[[ Line: 111 ]] --[[ Name: LoadAll ]]
    -- upvalues: v9 (copy), v25 (copy)
    for _, v35 in next, v9:GetChildren() do
        if v35:IsA("ModuleScript") then
            if v33 then
                v33(v35.Name);
            end;
            v25(v35.Name);
        end;
    end;
end;
v11.ClearLoadingGui = function(v36) --[[ Line: 123 ]] --[[ Name: ClearLoadingGui ]]
    -- upvalues: l_GuiMain_0 (copy)
    local l_LoadingGui_0 = l_GuiMain_0:WaitForChild("LoadingGui");
    if l_LoadingGui_0 then
        v36:Get("Fade"):Fade(0, 0);
        v36:Get("Fade"):SetText("");
        l_LoadingGui_0:Destroy();
    end;
end;
v11.GetMasterScreenGui = function(_) --[[ Line: 134 ]] --[[ Name: GetMasterScreenGui ]]
    -- upvalues: l_GuiMain_0 (copy)
    return l_GuiMain_0;
end;
v11.GetScreenSize = function(_) --[[ Line: 138 ]] --[[ Name: GetScreenSize ]]
    -- upvalues: l_GuiMain_0 (copy)
    return l_GuiMain_0.AbsoluteSize;
end;
v11.ConnectScaler = function(v40, v41) --[[ Line: 142 ]] --[[ Name: ConnectScaler ]]
    -- upvalues: l_GuiMain_0 (copy), v11 (copy)
    local v42 = l_GuiMain_0.AbsoluteSize / v11.ScaleSize;
    v42 = Vector2.new(1, 1);
    if v42.Magnitude > 0 then
        v41(v42.Y, v42.X);
    end;
    return v40.ScaleChangd:Connect(v41);
end;
v11.AttachToTopbar = function(v43, v44) --[[ Line: 153 ]] --[[ Name: AttachToTopbar ]]
    -- upvalues: l_ScreenGui_0 (copy)
    local v45 = l_ScreenGui_0.AbsolutePosition * Vector2.new(1, -1);
    v44(v45, l_ScreenGui_0.AbsoluteSize, v45.X > 0);
    return v43.TopbarChanged:Connect(v44);
end;
v11.GetVisibilityChangedSignal = function(v46, v47) --[[ Line: 163 ]] --[[ Name: GetVisibilityChangedSignal ]]
    -- upvalues: v16 (copy), v4 (copy)
    if not v46:Get(v47) then
        warn(v47, "is not a valid interface element");
        return;
    else
        if not v16[v47] then
            v16[v47] = v4.new();
        end;
        return v16[v47];
    end;
end;
v11.ToggleVisbility = function(_) --[[ Line: 177 ]] --[[ Name: ToggleVisbility ]]
    -- upvalues: l_GuiMain_0 (copy)
    l_GuiMain_0.Enabled = not l_GuiMain_0.Enabled;
end;
v11.Show = function(_, ...) --[[ Line: 181 ]] --[[ Name: Show ]]
    -- upvalues: v12 (copy), v16 (copy)
    xpcall(function() --[[ Line: 182 ]]
        PluginManager():CreatePlugin():Deactivate();
    end, function() --[[ Line: 184 ]]
        local v50 = {};
        v50 = nil;
    end);
    for _, v52 in next, {
        ...
    } do
        if v12[v52] then
            v12[v52].Visible = true;
            if v16[v52] then
                v16[v52]:Fire(true);
            end;
        end;
    end;
end;
v11.Hide = function(_, ...) --[[ Line: 199 ]] --[[ Name: Hide ]]
    -- upvalues: v12 (copy), v16 (copy)
    for _, v55 in next, {
        ...
    } do
        if v12[v55] then
            v12[v55].Visible = false;
            if v16[v55] then
                v16[v55]:Fire(false);
            end;
        end;
    end;
end;
v11.IsVisible = function(_, ...) --[[ Line: 211 ]] --[[ Name: IsVisible ]]
    -- upvalues: v12 (copy)
    for _, v58 in next, {
        ...
    } do
        if v12[v58] and v12[v58].Visible then
            return true;
        end;
    end;
    return false;
end;
v11.PlaySound = function(_, v60, v61, v62) --[[ Line: 221 ]] --[[ Name: PlaySound ]]
    -- upvalues: v2 (copy), v1 (copy)
    local v63 = v2:Get("ReplicatedStorage.Assets.Sounds." .. v60);
    v63.SoundGroup = v2:Find("SoundService.Interface");
    v63.Parent = workspace.Sounds;
    v63.Ended:Connect(function() --[[ Line: 226 ]]
        -- upvalues: v1 (ref), v63 (copy)
        v1.destroy(v63, "Ended");
    end);
    if v61 then
        v63.Volume = v61;
    end;
    if v62 then
        v63.PlaybackSpeed = v62;
    end;
    v63:Play();
    return v63.Ended;
end;
v11.HideAll = function(v64) --[[ Line: 243 ]] --[[ Name: HideAll ]]
    -- upvalues: l_GuiMain_0 (copy)
    v64.AllVisible = false;
    l_GuiMain_0.Enabled = v64.AllVisible;
end;
v11.ShowAll = function(v65) --[[ Line: 249 ]] --[[ Name: ShowAll ]]
    -- upvalues: l_GuiMain_0 (copy)
    v65.AllVisible = true;
    l_GuiMain_0.Enabled = v65.AllVisible;
end;
v11.ToggleAll = function(v66) --[[ Line: 255 ]] --[[ Name: ToggleAll ]]
    if v66.AllVisible then
        v66:HideAll();
        return;
    else
        v66:ShowAll();
        return;
    end;
end;
l_GuiMain_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 265 ]]
    -- upvalues: l_GuiMain_0 (copy), v11 (copy)
    local v67 = l_GuiMain_0.AbsoluteSize / v11.ScaleSize;
    if v67.Magnitude > 0 then
        v11.ScaleChangd:Fire(v67.Y, v67.X);
    end;
end);
l_ScreenGui_0:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 273 ]]
    -- upvalues: l_ScreenGui_0 (copy), v11 (copy)
    local v68 = l_ScreenGui_0.AbsolutePosition * Vector2.new(1, -1);
    local l_AbsoluteSize_0 = l_ScreenGui_0.AbsoluteSize;
    local v70 = v68.X > 0;
    v11.TopbarChanged:Fire(v68, l_AbsoluteSize_0, v70);
end);
v11:ShowAll();
return v11;