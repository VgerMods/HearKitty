-- Hear Kitty  by Vger-Azjol-Nerub
-- 
-- Russian resources

------------------------------------------------------------


if GetLocale() == "ruRU" then

KittyLocal =
{
	DefaultSoundPackName = "Маркато", -- Needs review
	DisabledCommand = "off", -- Needs review
	DisabledMessage = "Звуки Hear Kitty отключены.", -- Needs review
	EnabledCommand = "on", -- Needs review
	EnabledMessage = "Hear Kitty звуки активированы.", -- Needs review
	NeedNewerVgerCoreMessage = "Hear Kitty нуждается в новой версии VgerCore. Пожалуйста, используйте версию VgerCore, которые пришли с Hear Kitty.", -- Needs review
	Usage = [=[
Hear Kitty by Vger-Azjol-Nerub
www.vgermods.com
 
/hearkitty -- Show the Hear Kitty options.
/hearkitty [on | off] -- Turn Hear Kitty sound effects on (default) or off.
]=], -- Requires localization
	UI = {
		AboutTranslation = "Русский перевод по Vger", -- Needs review
		AboutVersion = "Версия %s", -- Needs review
		OptionsDoubleCrits = "Сделать несколько тонов на критический удар", -- Needs review
		OptionsDoubleCritsTooltip = "Делает несколько тонов, когда вы получаете более одного ресурса одновременно.", -- Needs review
		OptionsEnableSounds = "Звуки", -- Needs review
		OptionsEnableSoundsTooltip = "Мастер управления, чтобы включать и выключать все звуки Hear Kitty.", -- Needs review
		OptionsHeader = "Hear Kitty параметры", -- Needs review
		OptionsOnlyPlay5 = "Только сделать тон, когда ресурс развернут", -- Needs review
		OptionsOnlyPlay5Tooltip = "Уменьшает количество звуков, которые Hear Kitty делает.", -- Needs review
		OptionsSoundPack = "Звук пакет:", -- Needs review
		OptionsSoundPackTooltip = "Если вы устанавливаете дополнительные звуковые пакеты, вы можете выбрать новый набор звуков для Hear Kitty использования.", -- Needs review
		OptionsSoundsDisabledWarning = "Отключаются все звуки Hear Kitty. Следующие опции не вступят в силу:", -- Needs review
		OptionsSubheader = "Эти параметры позволяют управлять звуки, которые Hear Kitty делает.", -- Needs review
		OptionsUseEffectsChannel = "Контроль громкости звука Hear Kitty же, как в игре звуки", -- Needs review
		OptionsUseEffectsChannelTooltip = "Включите этот параметр, чтобы разрешить бегунок громкости и звуковые эффекты опция также влияют на Hear Kitty звуки.", -- Needs review
	},
}

end
