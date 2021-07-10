--[[ TODO
]]--

--[[
	These variables are provided to the addon by Blizzard.
		addonName	: This is self explanatory, but it's the name of the addon.
		t			: This is an empty table. This is how the addon can communicate between files or local functions, sort of like traditional classes.
]]--
local addonName, t = ...
local e = CreateFrame("Frame")

e:RegisterEvent("ADDON_LOADED")

e:SetScript("OnEvent", function(self, event, addon)
	if (event == "ADDON_LOADED" and addon == "MountSourceTooltip") then
		-- If the saved variables is nil, likely from a new install, then make it an empty table.
		if (MountSourceTooltipDatabase) then
			MountSourceTooltipDatabase[0] = {
				["name"] = "Travel Form",
				["source"] = "|cFFFFD200Class: |r|cFFFF7C0ADruid|r |TINTERFACE\\ICONS\\CLASSICON_DRUID.BLP:0|t",
				["spellID"] = 783,
			}
		end
	end
end)