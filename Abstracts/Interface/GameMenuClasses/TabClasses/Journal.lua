return function(_, v1) --[[ Line: 1 ]]
    local v2 = require(game:GetService("ReplicatedFirst").Framework);
    local _ = v2.require("Libraries", "Interface");
    local v4 = v2.require("Libraries", "UserStatistics");
    local v5 = {
        Days = 0, 
        Players = 0, 
        Zombies = 0
    };
    local function _() --[[ Line: 10 ]] --[[ Name: update ]]
        -- upvalues: v1 (copy), v5 (copy)
        v1.TextLabel.Text = ("Days Survived: %d \nPlayers Killed: %d \nInfected Killed: %d"):format(v5.Days, v5.Players, v5.Zombies);
    end;
    v4:BindToStatistic("Character", "PlayerKills", function(v7) --[[ Line: 14 ]]
        -- upvalues: v5 (copy), v1 (copy)
        v5.Players = v7;
        v1.TextLabel.Text = ("Days Survived: %d \nPlayers Killed: %d \nInfected Killed: %d"):format(v5.Days, v5.Players, v5.Zombies);
    end);
    v4:BindToStatistic("Character", "ZombieKills", function(v8) --[[ Line: 20 ]]
        -- upvalues: v5 (copy), v1 (copy)
        v5.Zombies = v8;
        v1.TextLabel.Text = ("Days Survived: %d \nPlayers Killed: %d \nInfected Killed: %d"):format(v5.Days, v5.Players, v5.Zombies);
    end);
    v4:BindToStatistic("Character", "TimeAlive", function(v9) --[[ Line: 26 ]]
        -- upvalues: v5 (copy), v1 (copy)
        v5.Days = math.ceil(v9 / 1440);
        v1.TextLabel.Text = ("Days Survived: %d \nPlayers Killed: %d \nInfected Killed: %d"):format(v5.Days, v5.Players, v5.Zombies);
    end);
    return {
        Gui = v1, 
        IsVisible = function(v10) --[[ Line: 35 ]] --[[ Name: IsVisible ]]
            return v10.Gui.Visible;
        end, 
        IsClosable = function(_) --[[ Line: 39 ]] --[[ Name: IsClosable ]]
            return true;
        end, 
        SetVisible = function(_, v13) --[[ Line: 43 ]] --[[ Name: SetVisible ]]
            -- upvalues: v1 (copy), v5 (copy)
            v1.TextLabel.Text = ("Days Survived: %d \nPlayers Killed: %d \nInfected Killed: %d"):format(v5.Days, v5.Players, v5.Zombies);
            v1.Visible = v13;
        end
    };
end;