--[[ TODO
]]--

--[[
	These variables are provided to the addon by Blizzard.
		addonName	: This is self explanatory, but it's the name of the addon.
		t			: This is an empty table. This is how the addon can communicate between files or local functions, sort of like traditional classes.
]]--
local addonName, t = ...
local e = CreateFrame("Frame")

-- Event Registrations
e:RegisterEvent("ADDON_LOADED")

-- Functions
local function GetMountInfo()
	C_Timer.After(0, function()
		C_Timer.After(5, function()
			local mountName, mountSpellID, mountSourceText
			local mountIDs = C_MountJournal.GetMountIDs()
			for i, mountID in pairs(mountIDs) do
				mountName, mountSpellID = C_MountJournal.GetMountInfoByID(mountID)
				_, _, mountSourceText = C_MountJournal.GetMountInfoExtraByID(mountID)
				MountSourceTooltipDatabase[mountID] = { name = mountName, spellID = mountSpellID, source = mountSourceText }
			end
		end)
	end)
end

-- Logic
e:SetScript("OnEvent", function(self, event, addon)
	if (event == "ADDON_LOADED" and addon == "MountSourceTooltip") then
		-- If the saved variables is nil, likely from a new install, then make it an empty table.
		if (MountSourceTooltipDatabase == nil) then
			MountSourceTooltipDatabase = {}
			-- Druid's Travel Form isn't considered a mount, so let's add it manually.
		end
		
		-- Let's not attempt to repull all the mounts on every addon load unless the build version
		-- of the client is different than the last check. More mounts might have been added.
		local _, build = GetBuildInfo()
		if (MountSourceTooltipDatabase["build"]) then
			if (build > MountSourceTooltipDatabase["build"]) then
				MountSourceTooltipDatabase["build"] = build
				GetMountInfo()
			end
		else
			MountSourceTooltipDatabase["build"] = build
			GetMountInfo()
		end
	end
end)

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
	if (UnitIsPlayer("target")) then -- The player targeted another player.
		local spellID = 0
		for i = 1, 10, 1 do -- Incrementing to the maximum number of auras a player can have.
			spellID = select(10, UnitAura("target", i, "HELPFUL"))
			if (spellID) then
				for mountID, mountInfo in pairs(MountSourceTooltipDatabase) do
					if (spellID == mountInfo.spellID) then
						self:AddLine(mountInfo.source)
						self:Show()
						break
					end
				end
			end
		end
	end
end)