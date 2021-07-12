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
			MountSourceTooltipDatabase[1503] = {
				["name"] = "Hand of Nilganihmaht",
				["source"] = "|cFFFFD200Zone: The Maw|r|n|cFFFFD200WH Guide: https://bit.ly/3dZVsX5|r",
				["spellID"] = 354354,
			}
			MountSourceTooltipDatabase[1039] = {
				["name"] = "Mighty Caravan Brutosaur",
				["source"] = "|cFFFFD200Black Market Auction House|r",
				["spellID"] = 264058,
			}
			MountSourceTooltipDatabase[885] = {
				["name"] = "Highlord's Golden Charger",
				["source"] = "|cFFFFD200Quest: Stirring in the Shadows|r|n|cFFFFD200Class: |cFFF48CBAPaladin|r |TINTERFACE\\ICONS\\CLASSICON_PALADIN.BLP:0|t",
				["spellID"] = 231435,
			}
		end
	end
end)