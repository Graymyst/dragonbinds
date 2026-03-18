local DB = _G.DragonBinds

local lastCheck = 0
DB.frame:SetScript("OnUpdate", function(self, elapsed)
    lastCheck = lastCheck + elapsed
    if lastCheck < 0.1 then return end -- 10Hz polling rate
    lastCheck = 0

    if InCombatLockdown() or not DB.state.autoMode then return end

    -- TRIGGER: Mounted and actively flying
    local isMounted = IsMounted()
    local isFlying = IsFlying()

    local shouldBeActive = isMounted and isFlying
    
    if shouldBeActive and not DB.state.isEnabled then
        DB.Apply()
    elseif not shouldBeActive and DB.state.isEnabled then
        DB.Remove()
    end
end)