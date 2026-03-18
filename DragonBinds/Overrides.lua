local DB = _G.DragonBinds

-- Applies flight keybind overrides
function DB.Apply()
    if InCombatLockdown() or DB.state.isEnabled then return end
    
    ClearOverrideBindings(DB.frame)
    
    -- 1. Scan and override standard movement keys (WASD/ESDF)
    for _, action in ipairs(DB.MOVEMENT_ACTIONS) do
        local k1, k2 = GetBindingKey(action)
        if k1 then SetOverrideBinding(DB.frame, true, k1, DB.ACTION_MAP[action]) end
        if k2 then SetOverrideBinding(DB.frame, true, k2, DB.ACTION_MAP[action]) end
    end

    -- 2. Override the custom PvP key (default: S)
    local pvpKey = (DragonBindsSettings and DragonBindsSettings.backKey) or "S"
    SetOverrideBinding(DB.frame, true, pvpKey, "PITCHUP")
    
    DB.state.isEnabled = true
    print("|cFF74D06C[DragonBinds]|r Overrides: |cFF00FF00ACTIVE|r")
end

-- Removes flight keybind overrides
function DB.Remove()
    if not DB.state.isEnabled then return end
    ClearOverrideBindings(DB.frame)
    DB.state.isEnabled = false
    print("|cFF74D06C[DragonBinds]|r Overrides: |cFFFF0000DISABLED|r")
end

-- Slash Commands
SLASH_DRAGONBINDS1 = "/db"
SlashCmdList["DRAGONBINDS"] = function(msg)
    local cmd, arg = msg:match("^(%S*)%s*(%S*)$")
    
    if cmd == "bind" and arg ~= "" then
        DragonBindsSettings.backKey = arg:upper()
        print("|cFF74D06C[DragonBinds]|r PvP Key set to: " .. arg:upper())
        if DB.state.isEnabled then DB.Apply() end
        
    elseif cmd == "auto" then
        DragonBindsSettings.autoMode = not DragonBindsSettings.autoMode
        DB.state.autoMode = DragonBindsSettings.autoMode
        print("|cFF74D06C[DragonBinds]|r Auto Mode: " .. (DB.state.autoMode and "ON" or "OFF"))
        
    else
        if DB.state.isEnabled then DB.Remove() else DB.Apply() end
    end
end