local v0 = require(game:GetService("ReplicatedFirst").Framework).require("Libraries", "Interface");
local v1 = {
    Gui = v0:GetGui("Graph"), 
    Storage = v0:GetStorage("Graph")
};
local v2 = {};
local v3 = nil;
local v4 = 100000;
local v5 = os.clock();
local function v18(v6, v7, v8) --[[ Line: 19 ]] --[[ Name: log ]]
    -- upvalues: v5 (ref), v1 (copy), v4 (ref), v2 (ref)
    local v9 = {
        Value = v6, 
        Delta = os.clock() - v5, 
        Gui = v1.Storage.BarTemplate:Clone()
    };
    v9.Gui.Size = UDim2.new(0, 10, math.min(1, (v6 - v7) / (v8 - v7)), 0);
    v9.Gui.LayoutOrder = v4;
    v9.Gui.Parent = v1.Gui.Bin;
    v4 = v4 - 1;
    v5 = os.clock();
    table.insert(v2, 1, v9);
    repeat
        local v10 = table.remove(v2, 31);
        if v10 and v10.Gui then
            v10.Gui:Destroy();
            v10.Gui = nil;
        end;
    until not v10;
    local v11 = 0;
    local v12 = 0;
    local v13 = 1e999;
    local v14 = -1e999;
    local v15 = 0;
    for _, v17 in next, v2 do
        v11 = v11 + v17.Value;
        v12 = v12 + v17.Delta;
        v13 = math.min(v17.Value, v13);
        v14 = math.max(v17.Value, v14);
        v15 = v15 + 1;
    end;
    if v15 > 0 then
        v1.Gui.Debug.Text = string.format("Avg: %.2f - Max: %.2f - Min: %.2f\nRate: %.2f /s", v11 / v15, v14, v13, 1 / (v12 / v15));
    end;
end;
v1.Wipe = function(_) --[[ Line: 70 ]] --[[ Name: Wipe ]]
    -- upvalues: v2 (ref), v4 (ref), v5 (ref), v3 (ref)
    for _, v21 in next, v2 do
        v21.Gui:Destroy();
        v21.Gui = nil;
    end;
    v2 = {};
    v4 = 100000;
    v5 = os.clock();
    if v3 then
        v3:Disconnect();
        v3 = nil;
    end;
end;
v1.Link = function(v22, v23, v24, v25) --[[ Line: 86 ]] --[[ Name: Link ]]
    -- upvalues: v3 (ref), v18 (copy), v0 (copy)
    v22:Wipe();
    v3 = v23.Changed:Connect(function() --[[ Line: 89 ]]
        -- upvalues: v18 (ref), v23 (copy), v24 (copy), v25 (copy)
        v18(v23.Value, v24, v25);
    end);
    v22.Gui.Upper.Text = tostring(v25);
    v22.Gui.Lower.Text = tostring(v24);
    v0:Show("Graph");
end;
return v1;