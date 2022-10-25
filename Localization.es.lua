-- Hear Kitty  by Vger-Azjol-Nerub
-- 
-- Spanish resources

------------------------------------------------------------


if GetLocale() == "esES" or GetLocale() == "esMX" then

KittyLocal =
{
	DefaultSoundPackName = "Marcato", -- Needs review
	DisabledCommand = "off", -- Needs review
	DisabledMessage = "Hear Kitty sonidos están desactivados.", -- Needs review
	EnabledCommand = "on", -- Needs review
	EnabledMessage = "Se activan sonidos Hear Kitty.", -- Needs review
	NeedNewerVgerCoreMessage = "Hear Kitty necesita una versión más reciente de VgerCore. Por favor utilice la versión de VgerCore que viene con Hear Kitty.", -- Needs review
	Usage = [=[
Hear Kitty by Vger-Azjol-Nerub
www.vgermods.com
 
/hearkitty -- Show the Hear Kitty options.
/hearkitty [on | off] -- Turn Hear Kitty sound effects on (default) or off.
]=], -- Requires localization
	UI = {
		AboutTranslation = "Traducción al español por Vger", -- Needs review
		AboutVersion = "Versión %s", -- Needs review
		OptionsDoubleCrits = "Hacer tonos múltiples en un impacto crítico", -- Needs review
		OptionsDoubleCritsTooltip = "Hace que los tonos múltiples cuando usted gana más de un recurso a la vez.", -- Needs review
		OptionsEnableSounds = "Hacer sonidos", -- Needs review
		OptionsEnableSoundsTooltip = "Control maestro para activar y desactivar todos los sonidos de Hear Kitty.", -- Needs review
		OptionsHeader = "Opciones de Hear Kitty", -- Needs review
		OptionsOnlyPlay5 = "Hacer sólo un tono cuando se maximizan los recursos", -- Needs review
		OptionsOnlyPlay5Tooltip = "Reduce el número de sonidos que hace Hear Kitty.", -- Needs review
		OptionsSoundPack = "Paquete de sonido:", -- Needs review
		OptionsSoundPackTooltip = "Si instala los paquetes de sonido adicionales, usted puede escoger un nuevo conjunto de sonidos para Hear Kitty a usar.", -- Needs review
		OptionsSoundsDisabledWarning = "Se desactivan todos los sonidos de Hear Kitty. Las siguientes opciones no tendrán efecto:", -- Needs review
		OptionsSubheader = "Estas opciones le permiten controlar los sonidos que hace Hear Kitty.", -- Needs review
		OptionsUseEffectsChannel = "Control de volumen de Hear Kitty igual que en el juego sonidos", -- Needs review
		OptionsUseEffectsChannelTooltip = "Habilitar esta opción para permitir el control deslizante de volumen de sonido y efectos de sonido puede también afectar los sonidos Hear Kitty.", -- Needs review
	},
}

end
