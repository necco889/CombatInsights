CombatInsightsFightData = {
    name = 'CombatInsightsFightData',
    variableVersion = 1,
	addonVersion = 10101,
	defaults = {
		fights = {}
	}
}
local self = CombatInsightsFightData

local function PurgeOldData()
	-- for _,f in pairs(self.SV.fights) do
	-- 	for k,_ in pairs(f.damageTrackers) do
	-- 		f.damageTrackers[k] = nil
	-- 	end
	-- end
end

local function OnAddOnLoaded(event, addOnName)
    if addOnName ~= self.name then return end
    EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_ADD_ON_LOADED);
    self.SV = ZO_SavedVars:NewAccountWide("CombatInsightsFightDataSV", self.variableVersion, nil, self.defaults)
	PurgeOldData()
end

EVENT_MANAGER:RegisterForEvent(self.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
