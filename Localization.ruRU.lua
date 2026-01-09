-- Hear Kitty  translator ZamestoTV
-- 
-- Russian resources

------------------------------------------------------------


KittyLocal =
{
	DefaultSoundPackName = "Маркато",
	DisabledCommand = "выкл",
	DisabledMessage = "Звуки Hear Kitty отключены.",
	EnabledCommand = "вкл",
	EnabledMessage = "Звуки Hear Kitty включены.",
	NeedNewerVgerCoreMessage = "Для Hear Kitty требуется более новая версия VgerCore. Пожалуйста, используйте версию VgerCore, которая поставляется с Hear Kitty.",
	Usage = [=[
Hear Kitty от Vger-Azjol-Nerub
www.vgermods.com
 
/hearkitty — Показать настройки Hear Kitty.
/hearkitty [вкл | выкл] — Включить (по умолчанию) или отключить звуковые эффекты Hear Kitty.
]=],
	UI = {
		AboutTranslation = "Русская версия от ZamestoTV",
		AboutVersion = "Версия %s",
		OptionsDoubleCrits = "Воспроизводить несколько тонов при критическом ударе",
		OptionsDoubleCritsTooltip = [=[Воспроизводит несколько тонов, когда вы получаете более одного ресурса одновременно.

|cffffffffВкл:|r Когда вы одновременно получаете два очка комбо из-за критического удара, воспроизводится два тона. (по умолчанию)

|cffffffffВыкл:|r Воспроизводится только один тон за атаку, даже если получено более одного очка комбо.]=],
		OptionsEnableSounds = "Воспроизводить звуки",
		OptionsEnableSoundsTooltip = [=[Главный переключатель для включения и отключения всех звуков Hear Kitty.

|cffffffffВкл:|r Hear Kitty будет воспроизводить звуки при получении и трате очков комбо и других ресурсов.

|cffffffffВыкл:|r Hear Kitty не будет ничего делать для этого персонажа.

Быстрые команды:
/hearkitty вкл
/hearkitty выкл]=],
		OptionsHeader = "Настройки Hear Kitty",
		OptionsOnlyPlay5 = "Воспроизводить тон только при максимальном ресурсе",
		OptionsOnlyPlay5Tooltip = [=[Уменьшает количество звуков, воспроизводимых Hear Kitty.

|cffffffffВыкл:|r Тоны воспроизводятся для каждого полученного ресурса. (по умолчанию)

|cffffffffВкл:|r Тоны воспроизводятся только при полном ресурсе (пять очков комбо, четыре чи и т.д.) и при исчерпании очков комбо.]=],
		OptionsSoundPack = "Звуковой пакет:",
		OptionsSoundPackTooltip = "Если вы установите дополнительные звуковые пакеты, вы сможете выбрать новый набор звуков для Hear Kitty.",
		OptionsSoundsDisabledWarning = "Все звуки Hear Kitty отключены. Следующие настройки не будут применяться:",
		OptionsSubheader = "Эти настройки позволяют управлять звуками, которые воспроизводит Hear Kitty.",
		OptionsUseEffectsChannel = "Управлять громкостью звуков Hear Kitty так же, как громкостью игровых звуков",
		OptionsUseEffectsChannelTooltip = [=[Включите эту опцию, чтобы ползунок громкости звука и настройка звуковых эффектов также влияли на звуки Hear Kitty.

|cffffffffВыкл:|r На звуки Hear Kitty влияет только настройка общей громкости. Звуки Hear Kitty будут воспроизводиться, даже если игровые звуковые эффекты отключены. (по умолчанию)

|cffffffffВкл:|r На звуки Hear Kitty влияют настройки общей громкости и громкости звуков. Это сделает звуки тише, если ползунок громкости звука ниже 100%. Если игровые звуковые эффекты отключены, звуки Hear Kitty также будут отключены.]=],
	},
}
