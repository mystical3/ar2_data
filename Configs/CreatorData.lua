local v0 = nil;
v0 = if game:GetService("RunService"):IsServer() then require(game:GetService("ServerScriptService").Framework) else require(game:GetService("ReplicatedFirst").Framework);
local v1 = v0.require("Configs", "Globals");
local v2 = v0.require("Configs", "ItemData");
local v3 = {};
local function v6(v4, v5) --[[ Line: 13 ]] --[[ Name: switch ]]
    -- upvalues: v1 (copy)
    if v1.isProdPlace() then
        return v5;
    else
        return v4;
    end;
end;
v3.HairColor = v1.isProdPlace() and 5631482 or 39647625;
v3.SWATBundle = v1.isProdPlace() and 1278858699 or 1278858795;
v3.Marshal = v1.isProdPlace() and 439516253 or 1256785700;
v3.FigherAce = v1.isProdPlace() and 439515310 or 1256785795;
v3.Football = v1.isProdPlace() and 439517976 or 1256785837;
v3.Lumberjack = v1.isProdPlace() and 439517406 or 1256785884;
v3.Mobster = v1.isProdPlace() and 439517055 or 1256785919;
v3.Tracksuit = v1.isProdPlace() and 439516048 or 1256785973;
v3.Tuxedo = v1.isProdPlace() and 439517245 or 1256786034;
v3.NasaSuit = v1.isProdPlace() and 439515133 or 1256786075;
v3.Stuntman = v1.isProdPlace() and 439517598 or 1256786230;
v3.SpecOp = v1.isProdPlace() and 439515488 or 1256786297;
v3.GreenBeret = v1.isProdPlace() and 519394460 or 1256786326;
v3.TemplarKnight = v1.isProdPlace() and 588824407 or 1256786364;
v3.SovietOfficer = v1.isProdPlace() and 777079907 or 1256786408;
v3.Spetsnaz = v1.isProdPlace() and 945222452 or 1256786441;
v3.DivingSuit = v1.isProdPlace() and 1330895334 or 1330895172;
v3.FrenchMaid = v1.isProdPlace() and 1531740881 or 1531741196;
v3.Marauder = v1.isProdPlace() and 1842925293 or 1842925714;
v3.Frogman = v1.isProdPlace() and 2673090491 or 2673092250;
v6 = {
    Color3.fromRGB(255, 216, 185), 
    Color3.fromRGB(255, 207, 170), 
    Color3.fromRGB(255, 208, 160), 
    Color3.fromRGB(245, 197, 149), 
    Color3.fromRGB(234, 184, 146), 
    Color3.fromRGB(200, 156, 125), 
    Color3.fromRGB(175, 126, 91), 
    Color3.fromRGB(150, 104, 70), 
    Color3.fromRGB(100, 68, 46), 
    Color3.fromRGB(75, 50, 34)
};
local v7 = {
    Teal = "Paid", 
    White = "Paid", 
    Pink = "Paid", 
    Red = "Paid", 
    Lime = "Paid", 
    Blue = "Paid", 
    Purple = "Paid", 
    Yellow = "Paid", 
    DirtyBlonde = "Default", 
    LightBrown = "Default", 
    Gray = "Default", 
    Black = "Default", 
    Brown = "Default", 
    DarkBrown = "Default", 
    Blonde = "Default", 
    Ginger = "Default"
};
local v8 = {};
for v9, v10 in next, v2 do
    if v10.Type == "Hair" then
        v8[v9] = "Default";
    end;
end;
local v11 = {
    ["U.S. Marshal"] = {
        Price = 400, 
        DevProductId = v3.Marshal, 
        LoadoutName = "U.S. Marshal", 
        DisplayName = "U.S. Marshal", 
        Description = "Old West Marshal outfit with a unique belt and hat.", 
        Equipment = {
            Belt = "Belt Marshal", 
            Hat = "Hat Marshal", 
            Bottom = "Pants Marshal 01", 
            Top = "Shirt Marshal 01"
        }
    }, 
    ["Fighter Ace"] = {
        Price = 750, 
        DevProductId = v3.FigherAce, 
        LoadoutName = "Figher Ace", 
        DisplayName = "WWII Fighter Ace", 
        Description = "Vintage leather pilot jacket, helmet with goggles, and a vest rig.", 
        Equipment = {
            Vest = "Vest WWII Pilot", 
            Hat = "Hat Pilot Helmet", 
            Top = "Shirt WWII Pilot 01", 
            Bottom = "Pants WWII Pilot 01"
        }
    }, 
    ["Football Player"] = {
        Price = 100, 
        DevProductId = v3.Football, 
        LoadoutName = "Football", 
        DisplayName = "Football Player", 
        Description = "American football outfit with a matching helmet.", 
        Equipment = {
            Hat = "Hat Football Helmet", 
            Bottom = "Pants Football 01", 
            Top = "Shirt Football 01"
        }
    }, 
    Lumberjack = {
        Price = 200, 
        DevProductId = v3.Lumberjack, 
        LoadoutName = "Lumberjack", 
        DisplayName = "Lumberjack", 
        Description = "Red flannel and jeans with a matching cap.", 
        Equipment = {
            Hat = "Hat Lumberjack", 
            Top = "Shirt Lumberjack 01", 
            Bottom = "Pants Lumberjack 01"
        }
    }, 
    Mobster = {
        Price = 300, 
        DevProductId = v3.Mobster, 
        LoadoutName = "Mobster", 
        DisplayName = "Mobster", 
        Description = "Stylish suit with a matching fedora.", 
        Equipment = {
            Hat = "Hat Mobster", 
            Top = "Shirt Mobster 01", 
            Bottom = "Pants Mobster 01"
        }
    }, 
    Tracksuit = {
        Price = 500, 
        DevProductId = v3.Tracksuit, 
        LoadoutName = "Tracksuit", 
        DisplayName = "Tracksuit", 
        Description = "Matching tracksuit top and bottom with a European flatcap.", 
        Equipment = {
            Top = "Shirt SlavTracksuit 01", 
            Bottom = "Pants SlavTracksuit 01", 
            Hat = "Hat Slav Flat Cap"
        }
    }, 
    Tuxedo = {
        Price = 300, 
        DevProductId = v3.Tuxedo, 
        LoadoutName = "Tuxedo", 
        DisplayName = "Tuxedo", 
        Description = "Neat tuxedo with classic shades.", 
        Equipment = {
            Bottom = "Pants Tuxedo 01", 
            Top = "Shirt Tuxedo 01", 
            Accessory = {
                ["1"] = "Accessory Tuxedo Glasses"
            }
        }
    }, 
    ["NASA Launch Suit"] = {
        Price = 750, 
        DevProductId = v3.NasaSuit, 
        LoadoutName = "Launch Suit", 
        DisplayName = "Launch Entry Suit", 
        Description = "Airtight NASA suit and helmet used during the Space Shuttle program.", 
        Equipment = {
            Hat = "Hat Space Launch Helmet", 
            Bottom = "Pants SpaceLaunch 01", 
            Top = "Shirt SpaceLaunch 01"
        }
    }, 
    Stuntman = {
        Price = 100, 
        DevProductId = v3.Stuntman, 
        LoadoutName = "Stuntman", 
        DisplayName = "Stuntman", 
        Description = "Patriotic jumpsuit with a matching dirt bike helmet.", 
        Equipment = {
            Hat = "Hat Stuntman Helmet", 
            Bottom = "Pants Stuntman 01", 
            Top = "Shirt Stuntman 01"
        }
    }, 
    ["Special Forces Operator"] = {
        Price = 750, 
        DevProductId = v3.SpecOp, 
        LoadoutName = "Operator", 
        DisplayName = "Spec. Forces Operator", 
        Description = "Unique special forces outfit with matching helmet, vest, and cosmetic NVGs.", 
        Equipment = {
            Top = "Shirt Operator 01", 
            Bottom = "Pants Operator 01", 
            Vest = "Vest Operator Webbing", 
            Hat = "Hat Operator Helmet", 
            Accessory = {
                ["1"] = "Accessory Operator NVG"
            }
        }
    }, 
    ["Green Beret"] = {
        Price = 500, 
        DevProductId = v3.GreenBeret, 
        LoadoutName = "Green Beret", 
        DisplayName = "Green Beret", 
        Description = "Tiger stripe camouflage with a webbing and green beret.", 
        Equipment = {
            Top = "Shirt TigerStripe 01", 
            Bottom = "Pants TigerStripe 01", 
            Vest = "Vest Green Beret", 
            Hat = "Hat Green Beret"
        }
    }, 
    ["Templar Knight"] = {
        Price = 500, 
        DevProductId = v3.TemplarKnight, 
        LoadoutName = "Templar Knight", 
        DisplayName = "Templar Knight", 
        Description = "Holy knight with chainmail armor and belt, with a great helm.", 
        Equipment = {
            Bottom = "Pants Templar 01", 
            Top = "Shirt Templar 01", 
            Belt = "Belt Templar", 
            Hat = "Hat Templar"
        }
    }, 
    ["Soviet Infantry Officer"] = {
        Price = 400, 
        DevProductId = v3.SovietOfficer, 
        LoadoutName = "Soviet Officer", 
        DisplayName = "Soviet Officer", 
        Description = "Soviet infantry officer parade uniform with a holster and cap.", 
        Equipment = {
            Bottom = "Pants Soviet Officer 01", 
            Top = "Shirt Soviet Officer 01", 
            Vest = "Vest Soviet Officer", 
            Hat = "Hat Soviet Officer"
        }
    }, 
    Spetsnaz = {
        Price = 750, 
        DevProductId = v3.Spetsnaz, 
        LoadoutName = "Spetsnaz", 
        DisplayName = "Spetsnaz", 
        Description = "Russian special forces gorka with an altyn helmet and vest.", 
        Equipment = {
            Bottom = "Pants Gorka 01", 
            Top = "Shirt Gorka 01", 
            Vest = "Vest Spetsnaz", 
            Hat = "Hat Altyn Helmet"
        }
    }, 
    ["SWAT Olive"] = {
        Price = 1000, 
        DevProductId = v3.SWATBundle, 
        LoadoutName = "Olive SWAT Officer", 
        DisplayName = "Olive SWAT Officer", 
        Description = "SWAT officer outfit with a unique vest, accessory, and hat.", 
        Equipment = {
            Hat = "Hat SWAT Helmet ShieldUp Olive", 
            Vest = "Vest SWAT Webbing Olive", 
            Bottom = "Pants SWAT Olive 01", 
            Top = "Shirt SWAT Olive 01", 
            Accessory = {
                ["1"] = "Accessory Head Wrap Olive"
            }
        }
    }, 
    ["SWAT Black"] = {
        Price = 1000, 
        DevProductId = v3.SWATBundle, 
        LoadoutName = "Black SWAT Officer", 
        DisplayName = "Black SWAT Officer", 
        Description = "SWAT officer outfit with a unique vest, accessory, and hat.", 
        Equipment = {
            Hat = "Hat SWAT Helmet ShieldUp Black", 
            Vest = "Vest SWAT Webbing Black", 
            Bottom = "Pants SWAT Black 01", 
            Top = "Shirt SWAT Black 01", 
            Accessory = {
                ["1"] = "Accessory Head Wrap Black"
            }
        }
    }, 
    ["SWAT Navy"] = {
        Price = 1000, 
        DevProductId = v3.SWATBundle, 
        LoadoutName = "Navy SWAT Officer", 
        DisplayName = "Navy SWAT Officer", 
        Description = "SWAT officer outfit with a unique vest, accessory, and hat.", 
        Equipment = {
            Hat = "Hat SWAT Cap Navy", 
            Vest = "Vest SWAT Webbing Navy", 
            Bottom = "Pants SWAT Navy 02", 
            Top = "Shirt SWAT Navy 02", 
            Accessory = {
                ["1"] = "Accessory Head Wrap Navy"
            }
        }
    }, 
    ["Diving Suit"] = {
        Price = 400, 
        DevProductId = v3.DivingSuit, 
        LoadoutName = "Diving Suit", 
        DisplayName = "Diving Suit", 
        Description = "Vintage diving suit, helmet, and weighted diving vest.", 
        Equipment = {
            Hat = "Hat Diving Dress Helmet Copper", 
            Vest = "Vest Diving Dress Brown", 
            Bottom = "Pants Diving Dress Tan 01", 
            Top = "Shirt Diving Dress Tan 01"
        }
    }, 
    ["French Maid"] = {
        Price = 500, 
        DevProductId = v3.FrenchMaid, 
        LoadoutName = "French Maid", 
        DisplayName = "French Maid", 
        Description = "French maid uniform dress with bonnet headpiece.", 
        Equipment = {
            Hat = "Hat Maid Bonnet", 
            Bottom = "Pants Maid Dress 01", 
            Top = "Shirt Maid Dress 01"
        }
    }, 
    ["Marauder Black"] = {
        OffSale = true, 
        Price = 800, 
        DevProductId = v3.Marauder, 
        LoadoutName = "Black Marauder Armor", 
        DisplayName = "Black Marauder Armor", 
        Description = "Black Marauder vest and belt armor, helmet combo, and faceplate accessory.", 
        Equipment = {
            Hat = "Hat Marauder Helmet Full Black", 
            Vest = "Vest Marauder Heavy Armor Black", 
            Belt = "Belt Marauder Heavy Utility Grenade Black", 
            Accessory = {
                ["1"] = "Accessory Marauder Face Wrap Black", 
                ["2"] = "Accessory Marauder Faceplate Heavy Black"
            }
        }
    }, 
    ["Marauder Green"] = {
        OffSale = true, 
        Price = 800, 
        DevProductId = v3.Marauder, 
        LoadoutName = "Green Marauder Armor", 
        DisplayName = "Green Marauder Armor", 
        Description = "Green Marauder vest and belt armor, helmet combo, and faceplate accessory.", 
        Equipment = {
            Hat = "Hat Marauder Helmet Full Black", 
            Vest = "Vest Marauder Heavy Armor Green", 
            Belt = "Belt Marauder Heavy Utility Grenade Green", 
            Accessory = {
                ["1"] = "Accessory Marauder Face Wrap Green", 
                ["2"] = "Accessory Marauder Faceplate Heavy Black"
            }
        }
    }, 
    ["Marauder Tan"] = {
        Price = 800, 
        OffSale = true, 
        DevProductId = v3.Marauder, 
        LoadoutName = "Tan Marauder Armor", 
        DisplayName = "Tan Marauder Armor", 
        Description = "Tan Marauder vest and belt armor, helmet combo and faceplate accessory.", 
        Equipment = {
            Hat = "Hat Marauder Helmet Full Black", 
            Vest = "Vest Marauder Heavy Armor Tan", 
            Belt = "Belt Marauder Heavy Utility Grenade Tan", 
            Accessory = {
                ["1"] = "Accessory Marauder Face Wrap Tan", 
                ["2"] = "Accessory Marauder Faceplate Heavy Black"
            }
        }
    }, 
    ["Frogman Black"] = {
        Price = 1000, 
        OffSale = false, 
        DevProductId = v3.Frogman, 
        LoadoutName = "Black Frogman Wetsuit", 
        DisplayName = "Black Frogman Wetsuit", 
        Description = "Black Frogman vest, veil, and wetsuit", 
        Equipment = {
            Bottom = "Pants Frogman Black 01", 
            Top = "Shirt Frogman Black 01", 
            Vest = "Vest Frogman Black", 
            Accessory = {
                ["1"] = "Accessory Frogman Veil Black"
            }
        }
    }, 
    ["Frogman Navy"] = {
        Price = 1000, 
        OffSale = false, 
        DevProductId = v3.Frogman, 
        LoadoutName = "Navy Frogman Wetsuit", 
        DisplayName = "Navy Frogman Wetsuit", 
        Description = "Navy Frogman vest, veil, and wetsuit", 
        Equipment = {
            Bottom = "Pants Frogman Navy 01", 
            Top = "Shirt Frogman Navy 01", 
            Vest = "Vest Frogman Navy", 
            Accessory = {
                ["1"] = "Accessory Frogman Veil Navy"
            }
        }
    }, 
    ["Frogman Olive"] = {
        Price = 1000, 
        OffSale = false, 
        DevProductId = v3.Frogman, 
        LoadoutName = "Olive Frogman Wetsuit", 
        DisplayName = "Olive Frogman Wetsuit", 
        Description = "Olive Frogman vest, veil, and wetsuit", 
        Equipment = {
            Bottom = "Pants Frogman Olive 01", 
            Top = "Shirt Frogman Olive 01", 
            Vest = "Vest Frogman Olive", 
            Accessory = {
                ["1"] = "Accessory Frogman Veil Olive"
            }
        }
    }, 
    ["Frogman Tan"] = {
        Price = 1000, 
        OffSale = false, 
        DevProductId = v3.Frogman, 
        LoadoutName = "Tan Frogman Wetsuit", 
        DisplayName = "Tan Frogman Wetsuit", 
        Description = "Tan Frogman vest, veil, and wetsuit", 
        Equipment = {
            Bottom = "Pants Frogman Tan 01", 
            Top = "Shirt Frogman Tan 01", 
            Vest = "Vest Frogman Tan", 
            Accessory = {
                ["1"] = "Accessory Frogman Veil Tan"
            }
        }
    }, 
    ["Frogman White"] = {
        Price = 1000, 
        OffSale = false, 
        DevProductId = v3.Frogman, 
        LoadoutName = "White Frogman Wetsuit", 
        DisplayName = "White Frogman Wetsuit", 
        Description = "White Frogman vest, veil, and wetsuit", 
        Equipment = {
            Bottom = "Pants Frogman White 01", 
            Top = "Shirt Frogman White 01", 
            Vest = "Vest Frogman White", 
            Accessory = {
                ["1"] = "Accessory Frogman Veil White"
            }
        }
    }
};
local v12 = {
    {
        Outfits = {
            "SWAT Olive", 
            "SWAT Navy", 
            "SWAT Black"
        }, 
        BonusItems = {
            "Hat SWAT Helmet Black", 
            "Hat SWAT Helmet Olive", 
            "Hat SWAT Cap Black", 
            "Hat SWAT Cap Olive"
        }, 
        BonusText = {
            "+ Black Helmet\n+ Olive Helmet\n+ Black Cap\n+ Olive Cap"
        }
    }, 
    {
        OffSale = true, 
        Outfits = {
            "Marauder Black", 
            "Marauder Green", 
            "Marauder Tan"
        }, 
        BonusItems = {
            "Hat Marauder Heavy Sun Hat Black", 
            "Hat Marauder Helmet Heavy Black", 
            "Accessory Marauder Face Wrap White", 
            "Accessory Marauder Face Wrap Brown", 
            "Accessory Marauder Face Wrap Navy", 
            "Vest Marauder Heavy Plate Carrier Black", 
            "Vest Marauder Heavy Plate Carrier Tan", 
            "Vest Marauder Heavy Plate Carrier Green"
        }, 
        BonusText = {
            "+ Sun Hat & Helmet variant\n+ 3 Vests & Face Wraps"
        }
    }, 
    {
        OffSale = false, 
        Outfits = {
            "Frogman Black", 
            "Frogman Navy", 
            "Frogman Olive", 
            "Frogman Tan", 
            "Frogman White"
        }, 
        BonusItems = {}, 
        BonusText = {
            "+ 4 other color variants"
        }
    }
};
local v13 = {
    HairColors = v3.HairColor
};
return {
    Body = {
        Colors = v6
    }, 
    Hair = {
        Styles = v8, 
        Colors = v7
    }, 
    Outfits = v11, 
    Bundles = v12, 
    Gamepasses = v13
};