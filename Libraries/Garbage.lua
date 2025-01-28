local v0 = game:GetService("RunService"):IsServer();
local _ = nil;
local v2 = (if v0 then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework)).require("Classes", "Maids");
return {
    Add = function(_, v4, ...) --[[ Line: 22 ]] --[[ Name: Add ]]
        -- upvalues: v2 (copy)
        local v5 = {
            ...
        };
        task.delay(v4, function() --[[ Line: 25 ]]
            -- upvalues: v5 (copy), v2 (ref)
            repeat
                local v6, v7 = next(v5);
                if v7 then
                    v2.destroyItem(v7);
                    v5[v6] = nil;
                end;
            until not v7;
        end);
    end
};