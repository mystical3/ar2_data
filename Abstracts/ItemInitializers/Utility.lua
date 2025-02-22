local v0 = require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Libraries", "Network");
local _ = v0.require("Classes", "Maids");
local _ = v0.require("Classes", "Signals");
local function _(v5) --[[ Line: 12 ]] --[[ Name: findUtilityType ]]
    -- upvalues: v1 (copy)
    for v6, v7 in next, v1.UtilityTypes do
        if v7[v5.Name] then
            return v6;
        end;
    end;
    return v5.Name;
end;
local v50 = {
    TEMPLATE = {
        Properties = function(_, _) --[[ Line: 26 ]] --[[ Name: Properties ]]

        end, 
        Function = function(v11, _) --[[ Line: 30 ]] --[[ Name: Function ]]
            v11.OnUse = function(_, _) --[[ Line: 31 ]]

            end;
        end
    }, 
    HandHeldLights = {
        Properties = function(_, _) --[[ Line: 42 ]] --[[ Name: Properties ]]

        end, 
        Function = function(_, _) --[[ Line: 45 ]] --[[ Name: Function ]]

        end
    }, 
    ChemLights = {
        Properties = function(v19, _) --[[ Line: 50 ]] --[[ Name: Properties ]]
            v19.Cracked = false;
            v19.BurntOut = false;
        end, 
        Function = function(v21, _) --[[ Line: 55 ]] --[[ Name: Function ]]
            -- upvalues: v2 (copy)
            v21.GetRightClickActions = function(v23, _) --[[ Line: 56 ]]
                -- upvalues: v2 (ref)
                local v25 = {};
                if not v23.Cracked and not v23.BurntOut then
                    v25["Crack Light"] = function() --[[ Line: 60 ]]
                        -- upvalues: v23 (copy), v2 (ref)
                        v23.Cracked = true;
                        v23.Cracked = v2:Fetch("Crack Chemlight", v23.Id);
                    end;
                end;
                return v25;
            end;
        end
    }, 
    Binoculars = {
        Properties = function(_, _) --[[ Line: 75 ]] --[[ Name: Properties ]]

        end, 
        Function = function(v28, _) --[[ Line: 79 ]] --[[ Name: Function ]]
            -- upvalues: v0 (copy)
            v28.OnUse = function(_, _) --[[ Line: 80 ]]
                -- upvalues: v0 (ref)
                v0.Libraries.Interface:Get("Binoculars"):SetVariable("ClickId", os.clock());
                return false;
            end;
        end
    }, 
    Rangefinder = {
        Properties = function(_, _) --[[ Line: 92 ]] --[[ Name: Properties ]]

        end, 
        Function = function(v34, _) --[[ Line: 95 ]] --[[ Name: Function ]]
            -- upvalues: v0 (copy)
            v34.OnUse = function(_, _) --[[ Line: 96 ]]
                -- upvalues: v0 (ref)
                v0.Libraries.Interface:Get("Binoculars"):SetVariable("ClickId", os.clock());
                return false;
            end;
        end
    }, 
    ["Road Flare"] = {
        Properties = function(_, _) --[[ Line: 112 ]] --[[ Name: Properties ]]

        end, 
        Function = function(v40, _) --[[ Line: 116 ]] --[[ Name: Function ]]
            -- upvalues: v2 (copy)
            v40.GetRightClickActions = function(v42, _) --[[ Line: 117 ]]
                -- upvalues: v2 (ref)
                return {
                    ["Light Flare"] = function() --[[ Line: 119 ]]
                        -- upvalues: v2 (ref), v42 (copy)
                        v2:Fetch("Light Road Flare", v42.Id);
                    end
                };
            end;
        end
    }, 
    ["Utility Firewood Bundle"] = {
        Properties = function(_, _) --[[ Line: 128 ]] --[[ Name: Properties ]]

        end, 
        Function = function(v46, _) --[[ Line: 132 ]] --[[ Name: Function ]]
            -- upvalues: v2 (copy)
            v46.GetRightClickActions = function(v48, _) --[[ Line: 133 ]]
                -- upvalues: v2 (ref)
                return {
                    ["Make Campfire"] = function() --[[ Line: 135 ]]
                        -- upvalues: v2 (ref), v48 (copy)
                        v2:Fetch("Deploy Fire", v48.Id);
                    end
                };
            end;
        end
    }
};
return function(v51, v52, v53) --[[ Line: 146 ]]
    -- upvalues: v1 (copy), v50 (copy)
    local v54 = false;
    local v55;
    for v56, v57 in next, v1.UtilityTypes do
        if v57[v51.Name] then
            v55 = v56;
            v54 = true;
        end;
        if v54 then
            break;
        end;
    end;
    if not v54 then
        v55 = v51.Name;
    end;
    v54 = false;
    local v58 = v50[v55];
    if v58 and v58.Properties then
        v58.Properties(v51, v52);
    end;
    if not v53 then
        return;
    else
        if v58 and v58.Function then
            v58.Function(v51, v52);
        end;
        return;
    end;
end;