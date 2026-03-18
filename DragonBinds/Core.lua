local addonName, _RE = ...

_G.DragonBinds = {
    state = { isEnabled = false, autoMode = true },
    frame = CreateFrame("Frame", "DragonBindsHandler", UIParent),
    
    -- Universal mapping for dynamic flight
    ACTION_MAP = {
        ["MOVEFORWARD"]  = "PITCHDOWN",
        ["MOVEBACKWARD"] = "PITCHUP",
        ["STRAFELEFT"]   = "TURNLEFT",
        ["STRAFERIGHT"]  = "TURNRIGHT",
        ["TURNLEFT"]     = "TURNLEFT",
        ["TURNRIGHT"]    = "TURNRIGHT",
    },
    
    -- Standard movement actions to track
    MOVEMENT_ACTIONS = { 
        "MOVEFORWARD", "MOVEBACKWARD", "STRAFELEFT", 
        "STRAFERIGHT", "TURNLEFT", "TURNRIGHT" 
    }
}