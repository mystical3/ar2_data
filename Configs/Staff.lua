local _ = game:GetService("Players");
local _ = {};
local v2 = {
    Contractor = "Contractor", 
    Moderator = "Moderator", 
    ["Senior Moderator"] = "Senior Moderator", 
    Administrator = "Administrator", 
    ["Chief Administrator"] = "Chief Administrator", 
    Developer = "Developer", 
    Host = "Developer"
};
local v3 = {
    Developer = true, 
    Contractor = false, 
    ["Senior Moderator"] = true, 
    Moderator = true, 
    Administrator = true, 
    ["Chief Administrator"] = true
};
local v4 = {
    [-1] = "Developer", 
    [-2] = "Administrator"
};
local function _(v5, v6) --[[ Line: 35 ]] --[[ Name: getRank ]]
    -- upvalues: v4 (copy), v2 (copy), v3 (copy)
    if v4[v5.UserId] then
        return v4[v5.UserId];
    else
        local l_status_0, l_result_0 = pcall(v5.GetRoleInGroup, v5, 15434910);
        l_result_0 = if l_status_0 then v2[l_result_0 or ""] else nil;
        if v6 and l_result_0 and not v3[l_result_0] then
            l_result_0 = nil;
        end;
        return l_result_0;
    end;
end;
return function(v10, v11) --[[ Line: 63 ]]
    -- upvalues: v4 (copy), v2 (copy), v3 (copy)
    if typeof(v10) == "Instance" and v10:IsA("Player") then
        if v4[v10.UserId] then
            return v4[v10.UserId];
        else
            local l_status_1, l_result_1 = pcall(v10.GetRoleInGroup, v10, 15434910);
            l_result_1 = if l_status_1 then v2[l_result_1 or ""] else nil;
            if v11 and l_result_1 and not v3[l_result_1] then
                l_result_1 = nil;
            end;
            return l_result_1;
        end;
    else
        return nil;
    end;
end;