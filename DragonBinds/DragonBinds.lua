local _G = _G
local _, RE = ...
_G.DragonBinds = RE

local GetCurrentBindingSet = _G.GetCurrentBindingSet
local GetBindingKey = _G.GetBindingKey
local GetBindingAction = _G.GetBindingAction
local SetBinding = _G.SetBinding
local SaveBindings = _G.SaveBindings

function DragonBinds.Toggle()
	local BindSet = GetCurrentBindingSet()
	if BindSet ~= 1 and BindSet ~= 2 then
		return
	end

	-- local PVPType = GetZonePVPInfo()
	-- local _, ZoneType = IsInInstance()

	local ForwardKey = GetBindingKey("PITCHDOWN")
	if ForwardKey == nil then
		ForwardKey = GetBindingKey("MOVEFORWARD")
	end

	local BackwardKey = GetBindingKey("PITCHUP")
	if BackwardKey == nil then
		BackwardKey = GetBindingKey("MOVEBACKWARD")
	end

	local Leftkey = GetBindingKey("TURNLEFT")
	if Leftkey == nil then
		Leftkey = GetBindingKey("STRAFELEFT")
	end

	local Rightkey = GetBindingKey("TURNRIGHT")
	if Rightkey == nil then
		Rightkey = GetBindingKey("STRAFERIGHT")
	end

	local CurrentBind
	if ForwardKey then
		CurrentBind = GetBindingAction(ForwardKey)
	end

    if CurrentBind ~= "PITCHDOWN" then
    	local Success
		if ForwardKey == nil then
			Success = true
		else
			Success = SetBinding(ForwardKey, "PITCHDOWN")
		end
		if BackwardKey then
			SetBinding(BackwardKey, "PITCHUP")
		end
		if Leftkey then
			SetBinding(Leftkey, "TURNLEFT")
		end
		if Rightkey then
			SetBinding(Rightkey, "TURNRIGHT")
		end
		if Success then
			SaveBindings(BindSet)
			print("\124cFF74D06C[DragonBinds]\124r Dragon Mode")
		-- else
		-- 	RE.Fail = true
		end			
	else
		if CurrentBind ~= "MOVEFORWARD" then
			local Success
			if ForwardKey == nil then
				Success = true
			else
				Success = SetBinding(ForwardKey, "MOVEFORWARD")
			end
			if BackwardKey then
				SetBinding(BackwardKey, "MOVEBACKWARD")
			end
			if Leftkey then
				SetBinding(Leftkey, "STRAFELEFT")
			end
			if Rightkey then
				SetBinding(Rightkey, "STRAFERIGHT")
			end
			if Success then
				SaveBindings(BindSet)
				print("\124cFF74D06C[DragonBinds]\124r Normal Mode")

			-- else
			-- 	RE.Fail = true
			end
		end
	end
end