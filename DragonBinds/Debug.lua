local DB = _G.DragonBinds

print("|cFF00FFFF[DragonBinds]|r Debug Module Loaded.")

local debugFrame = CreateFrame("Frame")
local timer = 0

debugFrame:SetScript("OnUpdate", function(self, elapsed)
    timer = timer + elapsed
    if timer < 1 then return end
    timer = 0

    local isMounted = IsMounted()
    local isFlying = IsFlying()
    local active = DB.state.isEnabled
    
    if isMounted then
        print(string.format("|cFF00FFFF[DB]|r Flying: %s | Addon: %s", 
            tostring(isFlying), 
            active and "|cFF00FF00ON|r" or "|cFFFF0000OFF|r"))
    end
end)