-- Hear Kitty  by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2026 Travis Spomer.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.
-- 
-- Main non-UI code
------------------------------------------------------------

HearKittyVersion = 1.1201

-- Hear Kitty requires this version of VgerCore:
local KittyVgerCoreVersionRequired = 1.21

-- Timer
local KittyLoadTime = GetTime()
local KittyTimerCountdown = 0

-- Other
local KittyEverHadBuffCharges = false
local KittyEverHadHolyPowerCharges = false
local KittyEverHadChi = false
local KittyThisResourceDecays = false -- Does this resource decay over time?  (For example, Holy Power.  Not counting expiring buffs.)
local KittyLastSoundPlayed = 0
local KittyQueueActive = false
local KittySoundOnTimer = nil
local KittyRequeuesOnTimer = 0
local KittyIsInArenaPreparation = false
local KittyIsFirstBuffChange = true
local KittyLastComboPoints = 0 -- not to be confused with KittyLastSoundPlayed

-- Sound packs (the default sound pack is actually registered later in the file)
local KittySoundPacks = { }
KittyDefaultSoundPackInternalName = "Default"

local KittyDefaultSoundPack =
{
	LocalizedName = KittyLocal.DefaultSoundPackName,
	Credits = KittyUIFrame_AboutHeaderLabel_Text,
	SoundDelay = 0.35,
	LongSoundDelay = 1, -- for transitioning from 0 to 1

	Combo7StackSound0 = "Interface\\AddOns\\HearKitty\\Marcato\\0.ogg",
	Combo7StackSound1 = "Interface\\AddOns\\HearKitty\\Marcato\\1.ogg",
	Combo7StackSound2 = "Interface\\AddOns\\HearKitty\\Marcato\\2.ogg",
	Combo7StackSound3 = "Interface\\AddOns\\HearKitty\\Marcato\\3.ogg",
	Combo7StackSound4 = "Interface\\AddOns\\HearKitty\\Marcato\\3a.ogg",
	Combo7StackSound5 = "Interface\\AddOns\\HearKitty\\Marcato\\4.ogg",
	Combo7StackSound6 = "Interface\\AddOns\\HearKitty\\Marcato\\4a.ogg",
	Combo7StackSound7 = "Interface\\AddOns\\HearKitty\\Marcato\\5.ogg",

	Combo6StackSound0 = "Interface\\AddOns\\HearKitty\\Marcato\\0.ogg",
	Combo6StackSound1 = "Interface\\AddOns\\HearKitty\\Marcato\\1.ogg",
	Combo6StackSound2 = "Interface\\AddOns\\HearKitty\\Marcato\\2.ogg",
	Combo6StackSound3 = "Interface\\AddOns\\HearKitty\\Marcato\\3.ogg",
	Combo6StackSound4 = "Interface\\AddOns\\HearKitty\\Marcato\\3a.ogg",
	Combo6StackSound5 = "Interface\\AddOns\\HearKitty\\Marcato\\4.ogg",
	Combo6StackSound6 = "Interface\\AddOns\\HearKitty\\Marcato\\5.ogg",

	Combo5StackSound0 = "Interface\\AddOns\\HearKitty\\Marcato\\0.ogg",
	Combo5StackSound1 = "Interface\\AddOns\\HearKitty\\Marcato\\1.ogg",
	Combo5StackSound2 = "Interface\\AddOns\\HearKitty\\Marcato\\2.ogg",
	Combo5StackSound3 = "Interface\\AddOns\\HearKitty\\Marcato\\3.ogg",
	Combo5StackSound4 = "Interface\\AddOns\\HearKitty\\Marcato\\4.ogg",
	Combo5StackSound5 = "Interface\\AddOns\\HearKitty\\Marcato\\5.ogg",

	Combo4StackSound0 = "Interface\\AddOns\\HearKitty\\Marcato\\0.ogg",
	Combo4StackSound1 = "Interface\\AddOns\\HearKitty\\Marcato\\1.ogg",
	Combo4StackSound2 = "Interface\\AddOns\\HearKitty\\Marcato\\3.ogg",
	Combo4StackSound3 = "Interface\\AddOns\\HearKitty\\Marcato\\4.ogg",
	Combo4StackSound4 = "Interface\\AddOns\\HearKitty\\Marcato\\5.ogg",

	Combo3StackSound0 = "Interface\\AddOns\\HearKitty\\Marcato\\0.ogg",
	Combo3StackSound1 = "Interface\\AddOns\\HearKitty\\Marcato\\2.ogg",
	Combo3StackSound2 = "Interface\\AddOns\\HearKitty\\Marcato\\4.ogg",
	Combo3StackSound3 = "Interface\\AddOns\\HearKitty\\Marcato\\5.ogg",
}


------------------------------------------------------------
-- Hear Kitty events
------------------------------------------------------------

-- Called when an event that Hear Kitty cares about is fired.
function KittyOnEvent(self, Event, arg1, arg2)
	local PetHasInterestingBuffs
	if VgerCore.IsCataclysm then
		local _, Class = UnitClass("player")
		if Class == "DEATHKNIGHT" then PetHasInterestingBuffs = true end
	end

	if Event == "UNIT_POWER_UPDATE" and (arg1 == "player" or arg1 == "vehicle") and arg2 == "COMBO_POINTS" then
		KittyOnComboPointsChange(arg1)
	elseif Event == "UNIT_POWER_UPDATE" and arg1 == "player" then
		if arg2 == "MANA" then
			-- Very common case that we want to ignore
			local ignore
		elseif arg2 == "HOLY_POWER" then
			KittyOnHolyPowerChange()
		elseif arg2 == "CHI" then
			KittyOnChiChange()
		elseif arg2 == "MAELSTROM" then
			KittyOnMaelstromChange()
		elseif arg2 == "SOUL_SHARDS" then
			KittyOnSoulShardsChange()
		elseif arg2 == "INSANITY" then
				KittyOnInsanityChange()
		elseif arg2 == "LUNAR_POWER" then
				KittyOnAstralPowerChange()
		elseif arg2 == "ARCANE_CHARGES" then
			KittyOnArcaneChargesChange()
		elseif arg2 == "ESSENCE" then
			KittyOnEssenceChange()
		end
	elseif Event == "UNIT_AURA" and (arg1 == "player" or (PetHasInterestingBuffs and arg1 == "pet")) then
		KittyOnBuffsChange()
	elseif Event == "PLAYER_SPECIALIZATION_CHANGED" then
		KittyOnSpecChange()
	elseif Event == "VARIABLES_LOADED" then
		KittyInitialize()
	end
end

-- Initializes Hear Kitty after all saved variables have been loaded.
function KittyInitialize()

	-- Check the current version of VgerCore.
	if (not VgerCore) or (not VgerCore.Version) or (VgerCore.Version < KittyVgerCoreVersionRequired) then
		if DEFAULT_CHAT_FRAME then DEFAULT_CHAT_FRAME:AddMessage("|cfffe8460" .. KittyLocal.NeedNewerVgerCoreMessage) end
		message(KittyLocal.NeedNewerVgerCoreMessage)
		return
	end

	SLASH_HEARKITTY1 = "/hearkitty"
	SlashCmdList["HEARKITTY"] = KittyCommand

	-- If they don't have any options set yet (no saved variable), reset them.  If they upgraded
	-- from a previous version and are missing one or more options, fill them in with defaults.
	KittyFillMissingOptions()

end

-- When the player's spec changes, reset some of what we know about the character.
function KittyOnSpecChange()
	KittyLastSoundPlayed = 0
	KittyStopTimer()
end

-- Called whenever the player's buffs change.
function KittyOnBuffsChange()
	-- Look for stacks of the various buffs we care about.
	local BuffCharges, _
	local _, Class = UnitClass("player")
	local Spec
	if GetSpecialization then Spec = GetSpecialization() end

	-- Check for the Preparation and Arena Preparation buffs.
	KittyIsInArenaPreparation = false
	BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 44521) -- Preparation
	if BuffCharges ~= nil then -- BuffCharges will be 0 when the buff exists and nil when it isn't
		KittyIsInArenaPreparation = true
	else
		BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 32727) -- Arena Preparation
		if BuffCharges ~= nil then
			KittyIsInArenaPreparation = true
		end
	end
	BuffCharges = nil -- otherwise we'll skip checks for the real buffs

	-- Frost mages' Icicles, only with Glacial Spike talent
	if BuffCharges == nil and VgerCore.IsMainline and Class == "MAGE" and Spec == 3 then
		local _, _, _, HasGlacialSpike = GetTalentInfo(7, 3, 1) -- Row 7, Column 3, Primary (1) spec (surprisingly, this still works in 10.0 where it's no longer in that position)
		if HasGlacialSpike then
			BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 205473)
			if BuffCharges then
				KittyThisResourceDecays = true
				KittyCurrentMaxStacks = 5
			end
		end
	end

	-- Fire mages' Blessing of the Sun King talent
	if BuffCharges == nil and VgerCore.IsMainline and Class == "MAGE" and Spec == 2 then
		local Blessings = KittyAuraStacks("player", "PLAYER HELPFUL", 383883)
		if Blessings then
			-- The eighth and final stack is actually a separate buff.
			Blessings = 8
		else
			Blessings = KittyAuraStacks("player", "PLAYER HELPFUL", 383882)
		end
		-- Count 5 tones from 4 to 8 stacks
		if Blessings and Blessings > 3 then
			KittyThisResourceDecays = false
			BuffCharges = Blessings - 3
			KittyCurrentMaxStacks = 5
		end
	end

	-- Enhancement shamans' Maelstrom Weapon
	if BuffCharges == nil and VgerCore.IsMainline and Class == "SHAMAN" and Spec == 2 then
		BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 344179)
		if BuffCharges then
			KittyThisResourceDecays = false
			-- In 9.0.2, Maelstrom Weapon worked similarly to Anticipation combo points: it stacks up to 10, but you only spend up to 5.
			-- KittyCurrentMaxStacks = 5
			-- As of 11.0, you should never spend before 5, 8 is the recommended minimum, and 10 is the ideal max.
			KittyCurrentMaxStacks = 3
			if BuffCharges < 5 then
				BuffCharges = 0
			elseif BuffCharges < 8 then
				BuffCharges = 1
			elseif BuffCharges < 10 then
				BuffCharges = 2
			else
				BuffCharges = 3
			end
		end
	elseif BuffCharges == nil and (VgerCore.IsWrath or VgerCore.IsCataclysm) and Class == "SHAMAN" then
		-- Maelstrom Weapon (enhancement)
		BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 53817)
		if BuffCharges then
			KittyThisResourceDecays = false
			KittyCurrentMaxStacks = 5
		else
			-- Lightning Shield (elemental)
			BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 324)
			if BuffCharges then
				-- If we've never had more than 3 stacks of Lightning Shield due to the Rolling Thunder talent,
				-- we should ignore all stacks of Lightning Shield less than 5.
				if BuffCharges < 5 and not KittyEverHadRollingThunderCharges then
					BuffCharges = nil
				else
					if BuffCharges < 5 then
						BuffCharges = nil
					else
						BuffCharges = BuffCharges - 4
					end
					KittyThisResourceDecays = true -- when hit!
					KittyCurrentMaxStacks = 5
					KittyEverHadRollingThunderCharges = true
				end
			end
		end
	end

	-- Mistweaver Monk: Teachings of the Monastery
	if BuffCharges == nil and Class == "MONK" and Spec == 2 then
		BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 202090)
		if BuffCharges then
			KittyThisResourceDecays = false
			-- Prior to 11.0 / The War Within this was 3 stacks.
			KittyCurrentMaxStacks = 4
		end
	end

	-- Unholy death knight: Shadow Infusion (Classic)
	if BuffCharges == nil and VgerCore.IsCataclysm and Class == "DEATHKNIGHT" then
		BuffCharges = KittyAuraStacks("pet", "PLAYER HELPFUL", 91342)
		if BuffCharges then
			KittyThisResourceDecays = false
			KittyCurrentMaxStacks = 5
		end
	end

	-- Discipline priest: Evangelism (Classic)
	if BuffCharges == nil and VgerCore.IsCataclysm and Class == "PRIEST" then
		-- Evangelism is 81661. Dark Evangelism is 87118 but is for shadow priests which
		-- already have shadow orbs to track, so we ignore Dark Evangelism.
		BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 81661)
		if BuffCharges then
			KittyThisResourceDecays = false
			KittyCurrentMaxStacks = 5
		end
	end

	-- Shadow priest: Shadow Orb (Classic)
	if BuffCharges == nil and VgerCore.IsCataclysm and Class == "PRIEST" then
		BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 77487)
		if BuffCharges then
			KittyThisResourceDecays = false
			KittyCurrentMaxStacks = 3
		end
	end

	-- Marksmanship hunter: Ready, Set, Aim and Fire! (Classic)
	if BuffCharges == nil and VgerCore.IsCataclysm and Class == "HUNTER" then
		BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 82926)
		if BuffCharges then
			-- Five stacks is a different buff, Fire!
			BuffCharges = 5
		else
			-- One through four is Ready, Set, Aim.
			BuffCharges = KittyAuraStacks("player", "PLAYER HELPFUL", 82925)
		end
		if BuffCharges then
			KittyThisResourceDecays = false
			KittyCurrentMaxStacks = 5
		end
	end

	-- If we didn't find any buffs, it's possible that we've already had a buff before and it's worn off.
	if BuffCharges == nil then BuffCharges = 0 end

	if (BuffCharges > 0 or KittyEverHadBuffCharges) and (BuffCharges ~= KittyLastSoundPlayed) then
		-- Buff charges may have changed.  Play the new sound effect.
		-- (No-op if the number actually hasn't changed.)
		KittyComboSound(BuffCharges)
		KittyEverHadBuffCharges = BuffCharges > 0
	end

end

function KittyOnHolyPowerChange()
	if UnitLevel("player") < 2 then return end -- Can't spend holy power before level 2, so don't play any sounds.
	local HolyPowerCharges = UnitPower("player", Enum.PowerType.HolyPower)
	if (HolyPowerCharges > 0 or KittyEverHadHolyPowerCharges) and (HolyPowerCharges ~= KittyLastSoundPlayed) then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = UnitPowerMax("player", Enum.PowerType.HolyPower)
		KittyThisResourceDecays = true
		KittyComboSound(HolyPowerCharges)
		KittyEverHadHolyPowerCharges = true
	end
end

function KittyOnChiChange()
	if UnitLevel("player") < 3 then return end -- Can't spend chi before level 3, so don't play any sounds.
	local Chi = UnitPower("player", Enum.PowerType.Chi)
	if (Chi > 0 or KittyEverHadChi) and (Chi ~= KittyLastSoundPlayed) then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = UnitPowerMax("player", Enum.PowerType.Chi) -- usually 4, but can be 5 with the talent Ascension
		KittyThisResourceDecays = true
		KittyComboSound(Chi)
		KittyEverHadChi = true
	end
end

function KittyOnSoulShardsChange()
	local SoulShards = UnitPower("player", Enum.PowerType.SoulShards)
	if SoulShards ~= KittyLastSoundPlayed then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = UnitPowerMax("player", Enum.PowerType.SoulShards)
		KittyThisResourceDecays = true
		KittyComboSound(SoulShards)
	end
end

function KittyOnArcaneChargesChange()
	local ArcaneCharges = UnitPower("player", Enum.PowerType.ArcaneCharges)
	if ArcaneCharges ~= KittyLastSoundPlayed then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = UnitPowerMax("player", Enum.PowerType.ArcaneCharges)
		KittyThisResourceDecays = true
		KittyComboSound(ArcaneCharges)
	end
end

function KittyOnMaelstromChange()
	local Maelstrom = UnitPower("player", Enum.PowerType.Maelstrom)
	if GetSpecialization and GetSpecialization() == 1 then
		-- Elemental
		if Maelstrom >= 60 then -- Earth Shock and Earthquake available
			Maelstrom = 5
		elseif Maelstrom >= 50 then
			Maelstrom = 4
		elseif Maelstrom >= 40 then
			Maelstrom = 3
		elseif Maelstrom >= 30 then
			Maelstrom = 2
		elseif Maelstrom >= 20 then
			Maelstrom = 1
		else
			Maelstrom = 0
		end
	end

	if (Maelstrom ~= KittyLastSoundPlayed) then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = 5
		KittyThisResourceDecays = true
		KittyComboSound(Maelstrom)
	end
end

function KittyOnInsanityChange()
	-- If the player is in Voidform, only play tones for when Insanity reaches 0.  Otherwise, it's spammy and annoying.
	local Insanity = UnitPower("player", Enum.PowerType.Insanity)
	if Insanity > 0 and KittyAuraStacks("player", "PLAYER HELPFUL", 194249) ~= nil then return end

	if Insanity >= 100 then
		Insanity = 5
	elseif Insanity >= 70 then -- 70 is the trigger for Legacy of the Void
		Insanity = 4
	elseif Insanity >= 50 then
		Insanity = 3
	elseif Insanity >= 30 then
		Insanity = 2
	elseif Insanity >= 7 then
		Insanity = 1
	else
		Insanity = 0
	end

	if (Insanity ~= KittyLastSoundPlayed) then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = 5
		KittyThisResourceDecays = true
		KittyComboSound(Insanity)
	end
end

function KittyOnAstralPowerChange()
	local AstralPower = UnitPower("player", Enum.PowerType.AstralPower)

	-- Druids do not need Astral Power change sounds unless in Balance spec. Astral power updates started firing in 11.0 for non-balance specs when using the Elune's Chosen hero class or the Convoke the Spirits talent.
	-- Also, ignore astral power changes when in cat form in any spec, since we can only track one resource at a time.
	local _, Class = UnitClass("player")
	if Class ~= "DRUID" or not GetSpecialization or GetSpecialization() ~= 1 or GetShapeshiftFormID() == 1 then return end

	-- Get the relevant talent and Eclipse states.
	local _, _, _, SoulOfTheForestSelected = GetTalentInfo(5, 1, 1) -- (surprisingly, this still works in 10.0 where it's no longer in that position)
	local SolarActive = KittyAuraStacks("player", "PLAYER HELPFUL", 48517) ~= nil
	local LunarActive = KittyAuraStacks("player", "PLAYER HELPFUL", 48518) ~= nil

	-- Set APGainOffset based on talents and auras, from highest to lowest possible. Considered getting this based on active cast, but didn't want the value jumping around.
	local APGainOffset
	if (SolarActive == true and SoulOfTheForestSelected == true) then
		APGainOffset = 9
	elseif LunarActive == true then
		APGainOffset = 8
	elseif (SolarActive == true and SoulOfTheForestSelected == false) then
		APGainOffset = 6
	else
		APGainOffset = 0 -- We shouldn't see this, but if we can't work out the offset, just use the whole value
	end

	-- Play a tone before hitting each multiple of 30AP (Starsurge), and when our next cast will cap us
	if AstralPower >= 100 - APGainOffset then
		AstralPower = 5
	elseif AstralPower >= 90 - APGainOffset then
		AstralPower = 4
	elseif AstralPower >= 60 - APGainOffset then
		AstralPower = 3
	--[[ elseif AstralPower >= 50 - APGainOffset then
		AstralPower = 2 ]]-- Uncomment for a tone when Starfall (50AP) is up.
	elseif AstralPower >= 30 - APGainOffset then
		AstralPower = 1
	else
		AstralPower = 0
	end

	if (AstralPower ~= KittyLastSoundPlayed) then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = 5
		KittyThisResourceDecays = true
		KittyComboSound(AstralPower)
	end
end

function KittyOnComboPointsChange(Unit)
	local ComboPoints

	-- Ignore combo point changes for druids not in cat form, such as when combo points decay after leaving cat form, or when the Convoke the Spirits uses cat form abilities in other forms.
	local _, Class = UnitClass("player")
	if Class == "DRUID" and GetShapeshiftFormID() ~= 1 then return end

	if GetComboPoints and Unit == "vehicle" then
		-- WoW 7.0 has a bug where vehicle combo points raise the UNIT_POWER event, but can only be retrieved with the legacy GetComboPoints.
		ComboPoints = GetComboPoints(Unit)
	else
		ComboPoints = UnitPower(Unit, Enum.PowerType.ComboPoints)
	end
	if KittyDebug then VgerCore.Message("KITTYONCOMBOPOINTSCHANGE with Previous: " .. KittyLastComboPoints .. ", now: " .. ComboPoints .. ", last sound: " .. KittyLastSoundPlayed) end
	if (ComboPoints ~= KittyLastComboPoints) then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = UnitPowerMax(Unit, Enum.PowerType.ComboPoints)
		VgerCore.Assert(KittyCurrentMaxStacks ~= nil and KittyCurrentMaxStacks > 0, "Hear Kitty: UnitPowerMax for combo points failed")
		KittyThisResourceDecays = true
		if KittyCurrentMaxStacks == 10 then
			 -- Rogue talent Anticipation allows up to 5 (was 3 before 7.1.5) spare combo points but only 5 at a time; Deeper Strategem allows 6 full combo points.
			KittyCurrentMaxStacks = 5
			if KittyLastComboPoints > 5 and ComboPoints == KittyLastComboPoints - 5 then
				-- They previously had some Anticipation charges stored up, and they just got converted to combo points.  Play the zero sound.
				if KittyDebug then VgerCore.Message("Combo points just converted to Anticipation charges") end
				 -- Override these so we'll start from 0 and then play up to the current total
				KittyThisResourceDecays = false
				KittyLastSoundPlayed = 10
			end
		end
		KittyLastComboPoints = ComboPoints
		KittyComboSound(ComboPoints)
	end
end

function KittyOnEssenceChange()
	local Essence = UnitPower("player", Enum.PowerType.Essence)
	if Essence > 0 and Essence ~= KittyLastSoundPlayed then
		-- (No-op if the number actually hasn't changed.)
		KittyCurrentMaxStacks = UnitPowerMax("player", Enum.PowerType.Essence)
		KittyThisResourceDecays = true
		KittyComboSound(Essence)
	end
end

-- Handles timer updates.  Called once per video frame.
function KittyOnUpdate(self, Elapsed)
	KittyTimerCountdown = KittyTimerCountdown - Elapsed
	if KittyTimerCountdown <= 0 then
		-- Was there a sound on the timer?  If not, then the timer can now be shut off.
		if KittySoundOnTimer == nil then
			KittyStopTimer()
			return
		end
		-- Play this sound effect.
		KittyPlayOneSound(KittySoundOnTimer)
		-- Then, queue the next sound if there is one, or queue the "sounds are done" timer.
		KittyTimerCountdown = KittyTimerCountdown + KittyGetSoundDelay()
		if KittyRequeuesOnTimer > 0 then
			KittySoundOnTimer = KittySoundOnTimer + 1
			KittyRequeuesOnTimer = KittyRequeuesOnTimer - 1
		else
			KittySoundOnTimer = nil
		end
	end
end

------------------------------------------------------------
-- Hear Kitty methods
------------------------------------------------------------

-- Resets all Hear Kitty options.  Used to set the saved variable to a default state.
function KittyResetOptions()
	KittyOptions = nil
	KittyFillMissingOptions()
end

-- Adds default values for any Hear Kitty options that are missing.  This can happen after an upgrade.
function KittyFillMissingOptions()
	if not KittyOptions then KittyOptions = {} end

	if KittyOptions.Enabled == nil then KittyOptions.Enabled = true end
	if KittyOptions.SoundPack == nil then KittyOptions.SoundPack = KittyDefaultSoundPackInternalName end
	if KittyOptions.Channel == nil then KittyOptions.Channel = "Master" end
	if KittyOptions.DoubleCrits == nil then KittyOptions.DoubleCrits = true end
	if KittyOptions.OnlyPlay5 == nil then KittyOptions.OnlyPlay5 = false end
end

-- Starts the timer counting down from a specified duration.
function KittyStartTimer(Duration)
	KittyQueueActive = true
	KittyTimerCountdown = Duration
	KittyCoreFrame:SetScript("OnUpdate", KittyOnUpdate)
end

-- Immediately stops the timer from firing.  Does not clear any other state information.
function KittyStopTimer()
	KittyQueueActive = false
	KittyTimerCountdown = nil
	KittySoundOnTimer = nil
	KittyCoreFrame:SetScript("OnUpdate", nil)
end

-- Processes a Hear Kitty slash command.
function KittyCommand(Command)
	local Lower = strlower(Command)
	if Lower == "" or Lower == nil then
		KittyUI_Show()
	elseif Lower == KittyLocal.EnabledCommand then
		KittyEnable(true)
		KittySayIfOn()
	elseif Lower == KittyLocal.DisabledCommand then
		KittyEnable(false)
		KittySayIfOn()
	else
		KittyUsage()
	end
end

-- Enables or disables Hear Kitty sound effects.
function KittyEnable(Enabled)
	VgerCore.Assert(Enabled == true or Enabled == false, "New value should be true or false.")
	KittyOptions.Enabled = Enabled
	KittyStopTimer()
end

-- Sets the channel that Hear Kitty sound effects play through.
function KittySetSoundChannel(Channel)
	VgerCore.Assert(Channel ~= nil, "Usage: KittySetSoundChannel(\"Channel\"), where Channel can be Master, SFX, Music, or Ambience.")
	KittyOptions.Channel = Channel
end

-- Prints a message stating whether or not Hear Kitty is enabled.
function KittySayIfOn()
	if KittyOptions.Enabled then
		VgerCore.Message(VgerCore.Color.Blue .. KittyLocal.EnabledMessage)
	else
		VgerCore.Message(VgerCore.Color.Blue .. KittyLocal.DisabledMessage)
	end
end

-- Enables or disables double crit sounds.
function KittyEnableDoubleCrits(Double)
	VgerCore.Assert(Double == true or Double == false, "New value should be true or false.")
	KittyOptions.DoubleCrits = Double
end

-- Enables or disables "only play 5" mode.
function KittyEnableOnlyPlay5(OnlyPlay5)
	VgerCore.Assert(OnlyPlay5 == true or OnlyPlay5 == false, "New value should be true or false.")
	KittyOptions.OnlyPlay5 = OnlyPlay5
end

-- Plays the appropriate sound effect for when the number of combo points changes.
-- This method does not check if sounds are currently enabled.
function KittyComboSound(ComboPoints)
	if KittyDebug then VgerCore.Message("KITTYCOMBOSOUND(" .. ComboPoints .. ") out of " .. KittyCurrentMaxStacks .. " and last sound " .. KittyLastSoundPlayed) end
	if ComboPoints < 0 then ComboPoints = 0 elseif ComboPoints > KittyCurrentMaxStacks then ComboPoints = KittyCurrentMaxStacks end
	-- Don't replay the same sound we played last.
	if ComboPoints == KittyLastSoundPlayed then
		if KittyDebug then VgerCore.Message("Bailing out because we just played sound #" .. ComboPoints) end
		return
	end

	-- Ignore the very first buff event that happens within 30 seconds, so we don't play a bunch of sounds right when logging in if you happen to have a bunch of Lightning
	-- Shield stacks saved up, for example.
	if KittyIsFirstBuffChange then
		KittyIsFirstBuffChange = nil
		if GetTime() < (KittyLoadTime + 30) then
			KittyLastSoundPlayed = ComboPoints
			if KittyDebug then VgerCore.Message("Bailing out because we just started") end
			return
		end
	end

	-- If they have the double crits option disabled, this is all very easy.  Never queue.
	-- (Enabling "only play 5" forces double crits off.)
	if KittyOptions.DoubleCrits == false or KittyOptions.OnlyPlay5 then
		if (not KittyOptions.OnlyPlay5) or ComboPoints == 0 or ComboPoints == KittyCurrentMaxStacks then
			KittyPlayOneSound(ComboPoints)
		end
		KittyLastSoundPlayed = ComboPoints
		if KittyDebug then VgerCore.Message("Bailing out due to options") end
		return
	end

	-- What we do next depends on whether we've increased or decreased combo points.
	if ComboPoints < KittyLastSoundPlayed then
		-- If the number of combo points has decreased, then they must have spent some.  Play the zero
		-- sound effect.  Then, if they have more than zero, they must have also gained some, so queue
		-- additional sounds.
		KittyStopTimer()
		if KittyThisResourceDecays then
			-- Special case for Holy Power and Chi (resources that decay over time)
			if ComboPoints > 0 and KittyLastSoundPlayed - ComboPoints == 1 and not InCombatLockdown() then
				-- They lost one of the resource since last time and aren't in combat, so the resource probably just decayed.
				-- Don't play a sound.

				-- REVIEW: This still isn't perfect for combo points; it's possible to, for example, have 4 combo points, then
				-- deselect your target, and then have 2 by the time a new target is selected.  UNIT_COMBO_POINTS doesn't
				-- fire between the 4 and 2, so it appears that the combo points were spent and 2 more were generated.
				-- Maybe I need to save the unit ID of the target to catch that case.  Needs more investigation.  (As of 6.0)
				if KittyDebug then VgerCore.Message("Staying quiet because points decayed to " .. ComboPoints) end
			else
				-- They lost more than one of the resource since last time, OR they are now completely
				-- out of their resource, so play the sound.
				if KittyDebug then VgerCore.Message("Playing single sound " .. ComboPoints) end
				KittyPlayOneSound(ComboPoints)
			end
		else
			if KittyDebug then VgerCore.Message("Playing a range from 0 to " .. ComboPoints) end
			KittyPlaySoundRange(0, ComboPoints, KittyGetSoundDelay(true))
		end
	elseif ComboPoints > KittyLastSoundPlayed then
		-- If the number of combo points increased, play the new range of sounds.  If one's already queued,
		-- we'll just queue more instead of playing anything immediately.
		if KittyDebug then VgerCore.Message("Playing a range from " .. (KittyLastSoundPlayed + 1) .. " to " .. ComboPoints) end
		KittyPlaySoundRange(KittyLastSoundPlayed + 1, ComboPoints)
	else
		if KittyDebug then VgerCore.Message("Didn't play anything because new combo points were last sound played") end
	end

	-- Remember the last number played from this function so we can play the correct sounds next time.
	KittyLastSoundPlayed = ComboPoints
end

-- Plays a range of sounds, queueing as necessary.  Optionally specifies the duration for the first sound queue;
-- subsequent sounds will use the standard duration.
function KittyPlaySoundRange(Start, End, FirstDuration)
	VgerCore.Assert(Start <= End, "Start should be less than or equal to End.")
	if Start > End then return end

	-- If there are other sounds waiting in the queue, just add to the queue and don't play anything immediately.
	if KittyQueueActive then
		if KittySoundOnTimer then
			-- There are other actual sounds waiting in the queue.
			KittyRequeuesOnTimer = End - KittySoundOnTimer
		else
			-- There are no sounds waiting in the queue, but we just finished playing the last one.
			KittySoundOnTimer = Start
			KittyRequeuesOnTimer = End - Start - 1
		end
		return
	end

	-- Play the starting sound.
	KittyPlayOneSound(Start)

	-- Finally, queue other sounds as necessary.
	if Start == End then
		-- We don't need to queue other sounds, but we do need to put "nothing" on the queue so that the next sound
		-- played still has to wait its turn.
		KittySoundOnTimer = nil
		KittyRequeuesOnTimer = 0
	else
		KittySoundOnTimer = Start + 1
		KittyRequeuesOnTimer = End - Start - 1
	end
	if FirstDuration == nil then FirstDuration = KittyGetSoundDelay() end
	KittyStartTimer(FirstDuration)
end

-- Immediately plays one combo point sound effect.  (Contrast with KittyComboSound.)
-- Pass in EvenIfOff to play the sound effect even if sounds are disabled.
function KittyPlayOneSound(ComboPoints, EvenIfOff)
	VgerCore.Assert(KittyCurrentMaxStacks, "KittyCurrentMaxStacks should be set.")

	if (not EvenIfOff) and (KittyIsInArenaPreparation or not KittyOptions.Enabled) then return end

	-- Look in the current sound pack for the appropriate sound to play. If it's not present, see if it's something
	-- we can guess a decent sound for. If THAT'S not present, just use the sound from the default sound pack.
	local SoundKey = "Combo" .. KittyCurrentMaxStacks .. "StackSound" .. ComboPoints
	local Filename = KittyCurrentSoundPack()[SoundKey]
	if not Filename then
		-- This sound pack doesn't have a sound defined for this situation. See if we can pick a decent one from the
		-- basic set of 5-point sounds.
		local AltSoundKey
		if KittyCurrentMaxStacks == 3 then
			if ComboPoints == 0 then
				AltSoundKey = "Combo5StackSound0"
			else
				AltSoundKey = "Combo5StackSound" .. (ComboPoints + 2)
			end
		elseif KittyCurrentMaxStacks == 4 then
			if ComboPoints < 3 then
				AltSoundKey = "Combo5StackSound" .. ComboPoints
			else
				AltSoundKey = "Combo5StackSound" .. (ComboPoints + 1)
			end
		elseif KittyCurrentMaxStacks == 6 then
			if ComboPoints == 0 then
				AltSoundKey = "Combo5StackSound0"
			elseif ComboPoints == 1 then
				AltSoundKey = "Combo5StackSound2"
			else
				AltSoundKey = "Combo5StackSound" .. (ComboPoints - 1)
			end
		elseif KittyCurrentMaxStacks == 7 then
			if ComboPoints < 3 then
				AltSoundKey = "Combo5StackSound" .. ComboPoints
			else
				AltSoundKey = "Combo5StackSound" .. (ComboPoints - 2)
			end
		end
		if AltSoundKey then
			if KittyDebug then VgerCore.Message("[" .. ComboPoints .. "/" .. KittyCurrentMaxStacks .. "]  No sound defined to trying alternate:") end
			Filename = KittyCurrentSoundPack()[AltSoundKey]
		end
	end
	if not Filename then Filename = KittyDefaultSoundPack[SoundKey] end
	if not Filename then
		VgerCore.Fail("Hear Kitty has no sound defined for " .. tostring(ComboPoints) .. "/" .. tostring(KittyCurrentMaxStacks) .. ".  Did an ability change?")
		Filename = "Combo5StackSound1"
	end
	if KittyDebug then VgerCore.Message("[" .. ComboPoints .. "/" .. KittyCurrentMaxStacks .. "]  "  .. Filename) end
	PlaySoundFile(Filename, KittyOptions.Channel)
end

-- Returns the currently selected sound pack if available, or the default one if the selected one
-- isn't installed.
function KittyCurrentSoundPack()
	return KittySoundPacks[KittyOptions.SoundPack] or KittyDefaultSoundPack
end

-- Gets the length of the sounds in the current sound pack.  If Long is true, returns the special length
-- of the "0" sound effect.
function KittyGetSoundDelay(Long)
	local SoundPack = KittyCurrentSoundPack()
	if Long then
		return SoundPack.LongSoundDelay or KittyDefaultSoundPack.LongSoundDelay
	else
		return SoundPack.SoundDelay or KittyDefaultSoundPack.SoundDelay
	end
end

-- Displays Hear Kitty usage information.
function KittyUsage()
	VgerCore.Message(" ")
	VgerCore.MultilineMessage(KittyLocal.Usage, VgerCore.Color.Blue)
	VgerCore.Message(" ")
end

-- Based on a unit, spell ID, and filters, return stack information for a specific spell.
-- Parameters:
--    Unit: The unit to check, such as "player".
--    Filters: Filters to specify which types of auras to look at, such as "PLAYER HELPFUL".  (See C_UnitAuras.GetAuraDataByIndex documentation for specifics.)
--    SpellID: The spell ID to look for, such as 123456.
-- Returns:
--    Stacks: The stack information, which could be:
--        nil: The buff isn't present.
--        0: The buff is present, but doesn't stack.
--        1+: The buff is present, and has this many stacks. 
function KittyAuraStacks(Unit, Filters, SpellID)
	-- Starting in Midnight, we no longer have access to buff information during combat.
	if VgerCore.IsMidnight then return nil end

	local i
	for i = 1, BUFF_MAX_DISPLAY do
		local AuraData = C_UnitAuras.GetAuraDataByIndex(Unit, i, Filters)
		if not AuraData then break end -- We ran out of buffs
		if AuraData.spellId == SpellID then return AuraData.applications end
		--VgerCore.Message(Unit .. " #" .. i .. ": " .. AuraData.name .. " " .. tostring(AuraData.spellId) .. " x " .. tostring(AuraData.applications))
	end
end

------------------------------------------------------------
-- Hear Kitty sound packs
------------------------------------------------------------

-- Registers a new Hear Kitty sound pack for use.
function KittyRegisterSoundPack(Name, Options)
	if not Name or not Options then
		VgerCore.Fail("Usage: KittyRegisterSoundPack(\"Name\", { LocalizedName = \"Localized name\", ... })")
		return
	end
	if KittySoundPacks[Name] then
		VgerCore.Fail("Couldn't install this Hear Kitty sound pack because another one with the name \"" .. Name .. "\" has already been registered.")
		return
	end

	Options.Name = Name
	KittySoundPacks[Name] = Options
end

-- Selects a new sound pack based on its internal name.  (Register it first with KittyRegisterSoundPack.)
function KittySelectSoundPack(Name)
	if not KittySoundPacks[Name] then
		VgerCore.Fail("Usage: KittySelectSoundPack(\"Name\").  Name is the internal name of the sound pack, not the localized name.")
		return
	end

	KittyOptions.SoundPack = Name
end

-- Returns the internal name of the currently selected sound pack.
function KittyGetSelectedSoundPackName()
	VgerCore.Assert(KittyOptions.SoundPack, "KittyGetSelectedSoundPackName shouldn't be called before Hear Kitty finishes initializing.")
	if KittySoundPacks[KittyOptions.SoundPack] then
		return KittyOptions.SoundPack
	else
		-- If the currently selected sound pack isn't actually installed anymore, return the name
		-- of the default sound pack instead.
		return KittyDefaultSoundPackInternalName
	end
end

-- Returns the credits information for the currently selected sound pack.
function KittyGetSelectedSoundPackCredits()
	local SoundPack = KittyCurrentSoundPack()
	return SoundPack.Credits
end

-- Returns the live table of sound pack information.  Don't change it or Hear Kitty will scratch your eyes out!
function KittyGetSoundPacks()
	local TableCopy = { }

	local Name, Options
	for Name, Options in pairs(KittySoundPacks) do
		tinsert(TableCopy, Options)
	end
	sort(TableCopy, KittyLocalizedNameComparer)

	return TableCopy
end

-- Function used to sort a table of tables alphabetically by the inner tables' LocalizedName property values.
function KittyLocalizedNameComparer(a, b)
	return strlower(a.LocalizedName) < strlower(b.LocalizedName)
end

------------------------------------------------------------

-- Core frame setup
if not KittyCoreFrame then
	KittyCoreFrame = CreateFrame("Frame", "KittyCoreFrame")
end

KittyCoreFrame:SetScript("OnEvent", KittyOnEvent)

KittyCoreFrame:RegisterEvent("VARIABLES_LOADED")
KittyCoreFrame:RegisterEvent("UNIT_AURA")
KittyCoreFrame:RegisterEvent("UNIT_POWER_UPDATE")
if VgerCore.SpecsExist then
	KittyCoreFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
end

-- Register the default sound pack
KittyRegisterSoundPack(KittyDefaultSoundPackInternalName, KittyDefaultSoundPack)
