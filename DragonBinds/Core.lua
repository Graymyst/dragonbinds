local addonName, _RE = ...
local _G = _G

-- Table globale
_G.DragonBinds = {
    state = { isEnabled = false },
    frame = CreateFrame("Frame", "DragonBindsHandler", UIParent)
}
local DB = _G.DragonBinds

-- Mapping Universel (S'adapte à toutes les touches : ZQSD, ESDF, etc.)
local ACTION_MAP = {
    ["MOVEFORWARD"]  = "PITCHDOWN",
    ["MOVEBACKWARD"] = "PITCHUP",
    ["STRAFELEFT"]   = "TURNLEFT",
    ["STRAFERIGHT"]  = "TURNRIGHT",
    ["TURNLEFT"]     = "TURNLEFT",
    ["TURNRIGHT"]    = "TURNRIGHT",
}

local MOVEMENT_ACTIONS = { 
    "MOVEFORWARD", "MOVEBACKWARD", "STRAFELEFT", 
    "STRAFERIGHT", "TURNLEFT", "TURNRIGHT" 
}

-- 1. INITIALISATION DES RÉGLAGES
local function GetBackKey()
    if DragonBindsSettings and DragonBindsSettings.backKey then
        return DragonBindsSettings.backKey
    end
    return "S" -- Par défaut S si rien n'est configuré
end

-- 2. MÉCANIQUE D'ACTIVATION
function DB.Apply()
    if InCombatLockdown() or DB.state.isEnabled then return end
    
    ClearOverrideBindings(DB.frame)
    
    -- AUTO-DETECTION : On scanne ce que l'utilisateur utilise (ZQSD ou ESDF)
    for _, action in ipairs(MOVEMENT_ACTIONS) do
        local k1, k2 = GetBindingKey(action)
        if k1 then SetOverrideBinding(DB.frame, true, k1, ACTION_MAP[action]) end
        if k2 then SetOverrideBinding(DB.frame, true, k2, ACTION_MAP[action]) end
    end

    -- FORCE LA TOUCHE PVP (ex: S ou D)
    local pvpKey = GetBackKey()
    SetOverrideBinding(DB.frame, true, pvpKey, "PITCHUP")
    
    DB.state.isEnabled = true
    print("|cFF74D06C[DragonBinds]|r Vol : |cFF00FF00ACTIF|r (Touche " .. pvpKey .. " hijackée)")
end

function DB.Remove()
    if not DB.state.isEnabled then return end
    ClearOverrideBindings(DB.frame)
    DB.state.isEnabled = false
    print("|cFF74D06C[DragonBinds]|r Mode Normal : |cFFFF0000RESTAURÉ|r")
end

-- 3. LE TRIGGER (Basé sur IsMounted uniquement - Ultra Stable)
local lastCheck = 0
DB.frame:SetScript("OnUpdate", function(self, elapsed)
    lastCheck = lastCheck + elapsed
    if lastCheck < 0.2 then return end
    lastCheck = 0

    if InCombatLockdown() then return end

    -- On vérifie juste si on est sur une monture
    -- (L'utilisateur a confirmé que IsMounted() est le seul trigger fiable)
    local isMounted = IsMounted() 
    
    if isMounted and not DB.state.isEnabled then
        DB.Apply()
    elseif not isMounted and DB.state.isEnabled then
        DB.Remove()
    end
end)

-- 4. COMMANDES
SLASH_DRAGONBINDS1 = "/db"
SlashCmdList["DRAGONBINDS"] = function(msg)
    local cmd, arg = msg:match("^(%S*)%s*(%S*)$")
    
    if cmd == "bind" and arg ~= "" then
        if not DragonBindsSettings then DragonBindsSettings = {} end
        DragonBindsSettings.backKey = arg:upper()
        print("|cFF74D06C[DragonBinds]|r Touche PvP définie sur : " .. arg:upper())
        if DB.state.isEnabled then DB.Remove() DB.Apply() end
    else
        if DB.state.isEnabled then DB.Remove() else DB.Apply() end
    end
end

-- Initialisation sécurisée
local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(_, _, name)
    if name == addonName then
        if not DragonBindsSettings then DragonBindsSettings = { backKey = "S" } end
        print("|cFF74D06C[DragonBinds]|r v1.4.1 chargé. /db pour switch manuel.")
    end
end)