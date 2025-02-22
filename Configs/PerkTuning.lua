local v2 = {
    Electrolytes = {
        DrainRateMod = 0.666
    }, 
    ["Energy Supplement"] = {
        DrainRateMod = 0.75
    }, 
    ["Seasoning Kit"] = {
        Modify = function(v0) --[[ Line: 11 ]] --[[ Name: Modify ]]
            return (math.min(v0 + 15, 0));
        end
    }, 
    ["Multivitamin Booster"] = {
        BoosterTimeMod = 1.5
    }, 
    ["Mess Kit"] = {
        Modify = function(v1) --[[ Line: 21 ]] --[[ Name: Modify ]]
            if v1 > 0 then
                return v1 * (1 + (100 - v1) * 0.0082);
            else
                return v1;
            end;
        end
    }, 
    ["Gun Cleaning Kit"] = {
        AccuracyModifier = 0.8, 
        FlashModifier = 0.6, 
        FlashModResetTimer = 0.1518987341772152
    }, 
    ["LMG Belt Loading Tool"] = {
        TransferRateChanges = {
            ExtraAmount = 0, 
            SpeedMod = 0.75
        }, 
        Items = {
            "7.62x63mm 100rd Box Magazine M1919A6", 
            "5.56x45mm 100rd Box Magazine M249", 
            "7.62x51mm 100rd Box Magazine M60", 
            "7.62x7.62mm 700rd Box Magazine M60Mod1", 
            "7.62x54mmR 100rd Box Magazine PKM"
        }
    }, 
    ["Rifle Magazine Loading Tool"] = {
        TransferRateChanges = {
            ExtraAmount = 0, 
            SpeedMod = 0.75
        }, 
        Items = {
            "7.62x63mm 20rd Magazine BAR", 
            "5.45x39mm AK 30rd Magazine", 
            "5.45x39mm AK 30rd Magazine Plum", 
            "5.45x39mm AK 45rd Magazine", 
            "5.56mm STANAG 100rd Drum Magazine", 
            "5.56mm STANAG 20rd Magazine", 
            "5.56mm STANAG 30rd Magazine", 
            "5.56mm STANAG 50rd Extended Magazine", 
            "5.56x45mm 20rd Magazine Mini-14", 
            "5.56x45mm 30rd Magazine Mini-14", 
            "7.62x39mm AK 30rd Magazine", 
            "7.62x39mm AK 40rd Extended Magazine", 
            "7.62x39mm AK 75rd Drum Magazine", 
            "7.62x51mm 10rd Magazine L96A1", 
            "7.62x51mm 10rd Magazine PSG-1", 
            "7.62x51mm STANAG 20rd Magazine", 
            "7.62x51mm STANAG 30rd Extended Magazine", 
            "7.62x51mm STANAG 50rd Drum Magazine", 
            "7.62x54mmR 10rd Magazine SVT-40", 
            ".30 Carbine 15rd Magazine M1 Carbine"
        }
    }, 
    ["Water Purification"] = {
        Configs = {
            ["Drinkable Water Fresh"] = {
                UseTime = 2, 
                UseText = "Drink purified water", 
                Consume = {
                    UseValue = {
                        Hydration = 20
                    }, 
                    UseBoost = {}, 
                    UseFreeze = {}
                }
            }, 
            ["Drinkable Water Hot"] = {
                UseTime = 2, 
                UseText = "Drink spring water", 
                Consume = {
                    UseValue = {
                        Hydration = 20, 
                        Health = 0
                    }, 
                    UseBoost = {}, 
                    UseFreeze = {}
                }
            }
        }
    }, 
    ["Sharpening Stone"] = {
        DamageModifier = 1.2, 
        Items = {
            "Chef Knife", 
            "Combat Knife", 
            "Fire Axe", 
            "Hatchet", 
            "NCO Katana", 
            "NCO KatanaMod1", 
            "Officers Sword", 
            "Pocket Knife", 
            "Longsword", 
            "Frozen Longsword", 
            "Shiv", 
            "Abomination Claws"
        }
    }, 
    ["Blunt Griptape"] = {
        DamageModifier = 1.2, 
        Items = {
            "Baton", 
            "Crowbar", 
            "Entrenchment Shovel", 
            "Keyboard Warrior"
        }
    }, 
    ["Climbing Gear"] = {
        LadderSpeedBoost = 1.2, 
        GroundedVaultHeightStudBoost = 0.5, 
        AirVaultHeightStudBoost = 1, 
        VaultLengthMod = 0.5
    }, 
    ["Athletic Gear"] = {
        JumpPowerBoost = 3.5, 
        FallDamagePower = 2
    }, 
    ["Scent Cover"] = {
        SoundRangeMod = 0.5, 
        SightRangeMod = 0.5
    }, 
    ["Fuel Syphon"] = {
        UseTime = 3, 
        UseText = "Syphon Fuel"
    }, 
    ["Mechanics Toolset"] = {
        NoUseChance = 0.5, 
        StatBoost = 1.2
    }, 
    ["Trauma Kit"] = {
        SpeedModifier = 1, 
        BonusPercentFromHealAmount = 0.2, 
        BonusDecayDelay = 10, 
        BonusDecayRate = 30
    }, 
    ["Padded Soles"] = {
        TotalVolumeMod = 0.5, 
        CrouchDistanceMod = 0.05
    }, 
    Clown = {}, 
    __RandomEventBroadcastPerks = {
        "Military Event Radio"
    }, 
    ["Military Event Radio"] = {
        BroadcastConfig = {
            ["Heli Crashes"] = 99, 
            ["Military Blockade"] = 99, 
            ["Military Convoy"] = 99, 
            ["Special Forces Crash"] = 99, 
            ["C-123 Provider Event"] = 99
        }, 
        BroadcastSound = "Utility.Military Field Radio Utility Notification", 
        BroadcastDelay = {
            0, 
            0
        }
    }, 
    ["Blood Vial"] = {
        HealAmount = 5, 
        EventZombieBonus = 5, 
        CitadelBonus = 0
    }
};
return function(v3, v4) --[[ Line: 222 ]]
    -- upvalues: v2 (copy)
    local v5 = v2[v3];
    if v4 then
        return v5[v4];
    else
        return v5;
    end;
end;