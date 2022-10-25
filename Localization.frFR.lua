-- Hear Kitty  by Vger-Azjol-Nerub
-- 
-- French resources

------------------------------------------------------------


if GetLocale() == "frFR" then

KittyLocal =
{
	DefaultSoundPackName = "Marcato", -- Needs review
	DisabledCommand = "off", -- Needs review
	DisabledMessage = "Hear Kitty sons sont désactivés.", -- Needs review
	EnabledCommand = "on", -- Needs review
	EnabledMessage = "Hear Kitty sons sont activés.", -- Needs review
	NeedNewerVgerCoreMessage = "Hear Kitty a besoin d'une version plus récente de VgerCore. Veuillez utiliser la version de VgerCore qui est venu avec Hear Kitty.", -- Needs review
	Usage = [=[
Hear Kitty by Vger-Azjol-Nerub
www.vgermods.com
 
/hearkitty -- Show the Hear Kitty options.
/hearkitty [on | off] -- Turn Hear Kitty sound effects on (default) or off.
]=], -- Requires localization
	UI = {
		AboutTranslation = "Traduction française par Vger", -- Needs review
		AboutVersion = "Version %s", -- Needs review
		OptionsDoubleCrits = "Faire des tonalités multiples sur un coup critique", -- Needs review
		OptionsDoubleCritsTooltip = "Joue plusieurs tonalités lorsque vous avez plusieurs ressources à la fois.", -- Needs review
		OptionsEnableSounds = "Émettre des sons", -- Needs review
		OptionsEnableSoundsTooltip = "Contrôle maître pour activer ou désactiver tous les sons de Hear Kitty.", -- Needs review
		OptionsHeader = "Options de Hear Kitty", -- Needs review
		OptionsOnlyPlay5 = "Seulement faire une tonalité lorsque la ressource est agrandie", -- Needs review
		OptionsOnlyPlay5Tooltip = "Réduit le nombre de sons qui rend Hear Kitty.", -- Needs review
		OptionsSoundPack = "Pack de son :", -- Needs review
		OptionsSoundPackTooltip = "Si vous installez les packs de sons supplémentaires, vous pouvez vous procurer un nouvel ensemble de sons pour Hear Kitty à utiliser.", -- Needs review
		OptionsSoundsDisabledWarning = "Tous les sons de Hear Kitty sont désactivés. Les options suivantes ne prendront effet :", -- Needs review
		OptionsSubheader = "Ces options vous permettent de contrôler les sons qui rend Hear Kitty.", -- Needs review
		OptionsUseEffectsChannel = "Contrôler le volume sonore Hear Kitty identique à sons dans le jeu", -- Needs review
		OptionsUseEffectsChannelTooltip = "Activez cette option pour autoriser le curseur du volume sonore et des effets sonores peut aussi affecter des sons Hear Kitty.", -- Needs review
	},
}

end
