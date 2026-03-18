local DB = _G.DragonBinds

-- Initialize default settings if not present
local function InitSettings()
    if not DragonBindsSettings then
        DragonBindsSettings = { backKey = "S", autoMode = true }
    end
    DB.state.autoMode = DragonBindsSettings.autoMode
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(_, _, name)
    if name == "DragonBinds" then InitSettings() end
end)