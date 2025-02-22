local v0 = {
    ["Kill Volume Instant"] = {
        InitialDamage = 0, 
        TickDamage = 1000, 
        DamageCorners = false, 
        Message = nil, 
        DamageSound = nil
    }, 
    ["Kill Volume Quick"] = {
        InitialDamage = 0, 
        TickDamage = 20, 
        DamageCorners = true, 
        Message = "was killed by lava", 
        DamageSound = nil
    }, 
    ["Kill Volume Volcano Quick"] = {
        InitialDamage = 0, 
        TickDamage = 20, 
        DamageCorners = true, 
        Message = "was killed by lava", 
        DamageSound = "Footsteps.Lava.Impact.01"
    }, 
    ["Kill Volume Slow"] = {
        InitialDamage = 0, 
        TickDamage = 1, 
        DamageCorners = true, 
        Message = nil, 
        DamageSound = nil
    }, 
    ["Kill Electricity 5"] = {
        InitialDamage = 25, 
        TickDamage = 5, 
        DamageCorners = true, 
        Message = "was killed by electricity", 
        DamageSound = nil
    }, 
    ["Kill BarbedWire 5"] = {
        InitialDamage = 20, 
        TickDamage = 5, 
        DamageCorners = true, 
        Message = "was killed by barbed wire", 
        DamageSound = nil
    }, 
    ["Kill Volume Instant Portal"] = {
        InitialDamage = 0, 
        TickDamage = 1000, 
        DamageCorners = false, 
        Message = "succumbed to the void", 
        DamageSound = nil
    }, 
    ["Kill Volume Quick Goop"] = {
        InitialDamage = 0, 
        TickDamage = 20, 
        DamageCorners = true, 
        Message = "was absorbed by the goop", 
        DamageSound = nil
    }, 
    ["Kill Volume Axe Trap"] = {
        InitialDamage = 40, 
        TickDamage = 0, 
        DamageCorners = true, 
        Message = "was cut down by an axe trap", 
        DamageSound = "Melee.Melee Meaty Impact 1"
    }, 
    ["Kill Volume Spear Trap"] = {
        InitialDamage = 40, 
        TickDamage = 0, 
        DamageCorners = true, 
        Message = "was impaled by a spear trap", 
        DamageSound = "Melee.Melee Meaty Impact 1"
    }, 
    ["Heal Volume Potion Vat"] = {
        InitialDamage = 0, 
        TickDamage = -5, 
        DamageCorners = true, 
        Message = "died to healing. this is not supposed to happen.", 
        DamageSound = nil
    }, 
    ["Kill Volume Frost"] = {
        InitialDamage = 0, 
        TickDamage = 5, 
        DamageCorners = true, 
        Message = "froze to death.", 
        DamageSound = nil
    }, 
    ["Kill Volume Ice Forge"] = {
        InitialDamage = 20, 
        TickDamage = 40, 
        DamageCorners = true, 
        Message = "was smelted", 
        DamageSound = "Footsteps.Lava.Impact.01"
    }
};
local v1 = {
    [Enum.Material.Concrete] = "Concrete", 
    [Enum.Material.Pavement] = "Concrete", 
    [Enum.Material.Slate] = "Concrete", 
    [Enum.Material.Marble] = "Linoleum", 
    [Enum.Material.Granite] = "Linoleum", 
    [Enum.Material.Brick] = "Concrete", 
    [Enum.Material.Cobblestone] = "Concrete", 
    [Enum.Material.SmoothPlastic] = "Linoleum", 
    [Enum.Material.Plastic] = "Linoleum", 
    [Enum.Material.Wood] = "Wood", 
    [Enum.Material.WoodPlanks] = "Wood", 
    [Enum.Material.CorrodedMetal] = "Metal", 
    [Enum.Material.DiamondPlate] = "Metal", 
    [Enum.Material.Foil] = "Ice", 
    [Enum.Material.Metal] = "Metal", 
    [Enum.Material.Grass] = "Grass", 
    [Enum.Material.Ice] = "Ice", 
    [Enum.Material.Fabric] = "Carpet", 
    [Enum.Material.Pebble] = "Gravel", 
    [Enum.Material.Sand] = "Sand", 
    [Enum.Material.Glacier] = "Meat", 
    [Enum.Material.Basalt] = "Concrete", 
    [Enum.Material.Sandstone] = "Concrete", 
    [Enum.Material.CrackedLava] = "Concrete", 
    [Enum.Material.Limestone] = "Concrete", 
    [Enum.Material.Rock] = "Concrete", 
    [Enum.Material.Glass] = "Glass", 
    [Enum.Material.Snow] = "Snow", 
    [Enum.Material.Mud] = "Mud", 
    [Enum.Material.Salt] = "Salt"
};
local v2 = {
    ["Step Sound Carpet"] = "Carpet", 
    ["Step Sound Concrete"] = "Concrete", 
    ["Step Sound Grass"] = "Grass", 
    ["Step Sound Linoleum"] = "Linoleum", 
    ["Step Sound Metal"] = "Metal", 
    ["Step Sound Sand"] = "Sand", 
    ["Step Sound Water"] = "Water", 
    ["Step Sound Wood"] = "Wood", 
    ["Step Sound Gravel"] = "Gravel", 
    ["Step Sound Glass"] = "Glass", 
    ["Step Sound Lava"] = "Lava"
};
local v3 = {
    Carpet = "Light", 
    Ceramic = "Light", 
    Concrete = "Light", 
    Gravel = "Heavy", 
    Linoleum = "Light", 
    Meat = "Heavy", 
    Metal = "Light", 
    Sand = "Heavy", 
    Wood = "Light"
};
return {
    FloorDamageMap = v0, 
    DustMaterials = v3, 
    MaterialsToSounds = v1, 
    TagsToSounds = v2
};