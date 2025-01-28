local v0 = {
    Gui = require(game:GetService("ReplicatedFirst").Framework).require("Libraries", "Interface"):GetGui("DragBin")
};
v0.Gui.Changed:Connect(function() --[[ Line: 11 ]]
    -- upvalues: v0 (copy)
    v0.Gui.Visible = true;
end);
v0.Gui.Visible = true;
return v0;