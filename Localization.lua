-- Hear Kitty  by Vger-Azjol-Nerub
-- 
-- English resources

------------------------------------------------------------


local Locale = GetLocale()
if Locale ~= "ptBR" and Locale ~= "frFR" and Locale ~= "deDE" and Locale ~= "esES" and Locale ~= "esMX" and Locale ~= "ruRU" then

KittyLocal =
{
	DefaultSoundPackName = "Marcato",
	DisabledCommand = "off",
	DisabledMessage = "Hear Kitty sounds are disabled.",
	EnabledCommand = "on",
	EnabledMessage = "Hear Kitty sounds are enabled.",
	NeedNewerVgerCoreMessage = "Hear Kitty needs a newer version of VgerCore.  Please use the version of VgerCore that came with Hear Kitty.",
	Usage = [=[
Hear Kitty by Vger-Azjol-Nerub
www.vgermods.com
 
/hearkitty -- Show the Hear Kitty options.
/hearkitty [on | off] -- Turn Hear Kitty sound effects on (default) or off.
]=],
	UI = {
		AboutTranslation = "Official English version",
		AboutVersion = "Version %s",
		OptionsDoubleCrits = "Play multiple tones on a crit",
		OptionsDoubleCritsTooltip = [=[Plays multiple tones when you gain more than one resource at once.

|cffffffffOn:|r  When you gain two combo points simultaneously due to a critical hit, play two tones.  (default)

|cffffffffOff:|r  Only play one tone per attack, even if more than one combo point is gained.]=],
		OptionsEnableSounds = "Play sounds",
		OptionsEnableSoundsTooltip = [=[Master control to turn on and off all Hear Kitty sounds.

|cffffffffOn:|r  Hear Kitty will play sounds as you gain and spend combo points and other resources.

|cffffffffOff:|r  Hear Kitty won't do anything for this character.

Shortcuts:
/hearkitty on
/hearkitty off]=],
		OptionsHeader = "Hear Kitty options",
		OptionsOnlyPlay5 = "Only play a tone when resource is maxed",
		OptionsOnlyPlay5Tooltip = [=[Reduces the number of sounds that Hear Kitty plays.

|cffffffffOff:|r Tones are played for each resource gained.  (default)

|cffffffffOn:|r  Tones are only played when your resource is full (five combo points, four chi, etc.) and when you exhaust your combo points.]=],
		OptionsSoundPack = "Sound pack:",
		OptionsSoundPackTooltip = "If you install additional sound packs, you can pick a new set of sounds for Hear Kitty to use.",
		OptionsSoundsDisabledWarning = "All Hear Kitty sounds are disabled.  The following options will not take effect:",
		OptionsSubheader = "These options let you control the sounds that Hear Kitty makes.",
		OptionsUseEffectsChannel = "Control Hear Kitty sound volume the same as in-game sounds",
		OptionsUseEffectsChannelTooltip = [=[Enable this option to allow the Sound volume slider and the Sound Effects option to also affect Hear Kitty sounds.

|cffffffffOff:|r Only the Master volume setting affects Hear Kitty sounds.  Hear Kitty sounds will play even if in-game sound effects are disabled.  (default)

|cffffffffOn:|r Both the Master and Sounds volume settings affect Hear Kitty sounds.  This will make the sounds quieter if the Sound volume slider is lower than 100%.  If in-game sound effects are muted, Hear Kitty sounds will be muted too.]=],
	},
}

end
