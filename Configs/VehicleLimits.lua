local v0 = {
    Military = 5, 
    Emergency = 5, 
    Civilian = 10, 
    Rural = 5, 
    Farm = 2, 
    Commerical = 3, 
    Armored = 1, 
    Industrial = 2, 
    Utility = 3, 
    Boat = 8, 
    EmergencyBoat = 1, 
    MilitaryBoat = 1, 
    SportBoat = 1, 
    Rebel = 0, 
    Winter = 0
};
local v1 = {
    Military = {
        "Barracks Truck", 
        "Humvee", 
        "Military Pickup"
    }, 
    Rebel = {
        "Barracks Truck Derelict", 
        "Humvee Derelict", 
        "Military Pickup Derelict", 
        "Pickup Truck Derelict"
    }, 
    Emergency = {
        "Ambulance", 
        "Firetruck", 
        "Police CUV", 
        "Police Car"
    }, 
    Winter = {
        "SnowMobile"
    }, 
    EmergencyBoat = {
        "Lifeboat"
    }, 
    MilitaryBoat = {
        "Patrol Boat"
    }, 
    Civilian = {
        "Caprice", 
        "Chevy Blazer", 
        "Chevy Suburban", 
        "Corvette", 
        "Jeep", 
        "Mustang", 
        "Quad", 
        "Sedan", 
        "Station Wagon", 
        "Pickup Truck"
    }, 
    Rural = {
        "Pickup Truck", 
        "Chevy Blazer", 
        "Jeep", 
        "Quad"
    }, 
    Farm = {
        "Tractor"
    }, 
    Armored = {
        "Armored Truck"
    }, 
    Industrial = {
        "Semi Truck"
    }, 
    Commerical = {
        "Cargo Van", 
        "Box Truck", 
        "Delivery Van"
    }, 
    Utility = {
        "Box Truck", 
        "Utility Truck"
    }, 
    Boat = {
        "Rubber Dinghy", 
        "Fishing Boat", 
        "Aluminum Boat", 
        "Swing Keel Boat", 
        "Speed Boat"
    }, 
    SportBoat = {
        "Speed Boat"
    }
};
local v2 = {
    ["Aluminum Boat"] = 6, 
    ["Fishing Boat"] = 2, 
    Lifeboat = 1, 
    ["Patrol Boat"] = 1, 
    ["Rubber Dinghy"] = 2, 
    ["Speed Boat"] = 1, 
    ["Swing Keel Boat"] = 2, 
    Ambulance = 2, 
    ["Armored Truck"] = 1, 
    ["Barracks Truck"] = 2, 
    ["Barracks Truck Derelict"] = 1, 
    Caprice = 4, 
    ["Cargo Van"] = 2, 
    ["Chevy Blazer"] = 2, 
    ["Chevy Suburban"] = 2, 
    ["Delivery Van"] = 0, 
    ["Box Truck"] = 0, 
    Firetruck = 2, 
    Corvette = 0, 
    Humvee = 2, 
    ["Humvee Derelict"] = 1, 
    Jeep = 4, 
    ["Military Pickup"] = 2, 
    ["Military Pickup Derelict"] = 1, 
    Mustang = 1, 
    ["Pickup Truck"] = 4, 
    ["Pickup Truck Derelict"] = 2, 
    ["Police CUV"] = 1, 
    ["Police Car"] = 2, 
    Quad = 4, 
    Sedan = 2, 
    ["Semi Truck"] = 2, 
    ["Station Wagon"] = 4, 
    Tractor = 2, 
    SnowMobile = 14, 
    ["Utility Truck"] = 2
};
return {
    Categories = v1, 
    CategoryLimits = v0, 
    VehicleLimits = v2
};