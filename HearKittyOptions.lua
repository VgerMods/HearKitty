-- Hear Kitty by Vger-Azjol-Nerub
-- See Readme.htm for more information.

------------------------------------------------------------

local KittyUICancelOptions = nil

------------------------------------------------------------
-- Interface Options
------------------------------------------------------------

function KittyUI_OnLoad()
	-- Register the Interface Options page.
	KittyUIFrame.name = "Hear Kitty"
	KittyUIFrame.default = KittyUI_OnDefaults
	KittyUIFrame.cancel = KittyUI_OnCancel
	InterfaceOptions_AddCategory(KittyUIFrame)
	-- Update the version display.
	local Version = GetAddOnMetadata("HearKitty", "Version")
	if Version then 
		KittyUIFrame_AboutVersionLabel:SetText(string.format(KittyUIFrame_AboutVersionLabel_Text, Version))
	end
end

function KittyUI_Show()
	InterfaceOptionsFrame_OpenToCategory(KittyUIFrame)
end

function KittyUI_OnShow()
	-- When the Hear Kitty Interface Options window is shown, update the state of controls based on current Hear Kitty options.
	KittyUIFrame_EnableSoundsCheck:SetChecked(KittyOptions.Enabled)
	UIDropDownMenu_SetWidth(KittyUIFrame_SoundPackDropDown, 140)
	UIDropDownMenu_Initialize(KittyUIFrame_SoundPackDropDown, KittyUIFrame_SoundPackDropDown_Initialize)
	UIDropDownMenu_SetSelectedValue(KittyUIFrame_SoundPackDropDown, KittyGetSelectedSoundPackName())
	KittyUIFrame_SoundPackCreditsLabel:SetText(KittyGetSelectedSoundPackCredits())
	KittyUIFrame_UseEffectsChannelCheck:SetChecked(KittyOptions.Channel == "SFX")
	KittyUIFrame_DoubleCritsCheck:SetChecked(KittyOptions.DoubleCrits)
	KittyUIFrame_OnlyPlay5Check:SetChecked(KittyOptions.OnlyPlay5)
	if KittyOptions.Enabled then
		KittyUIFrame_DisabledWarningLabel:Hide()
	else
		KittyUIFrame_DisabledWarningLabel:Show()
	end
	if KittyOptions.OnlyPlay5 then
		KittyUIFrame_DoubleCritsCheck:Disable()
	else
		KittyUIFrame_DoubleCritsCheck:Enable()
	end
	-- Also, save a copy of their current options so that they can be reset if the user clicks Cancel.
	KittyUICancelOptions = { }
	KittyUICancelOptions.Enabled = KittyOptions.Enabled
	KittyUICancelOptions.DoubleCrits = KittyOptions.DoubleCrits
	KittyUICancelOptions.OnlyPlay5 = KittyOptions.OnlyPlay5
	KittyUICancelOptions.Channel = KittyOptions.Channel
end

function KittyUI_OnHide()
	KittyUICancelOptions = nil
end

function KittyUI_OnCancel()
	-- Reset all Hear Kitty options to the state they were in when the UI was first launched.
	if KittyUICancelOptions then
		KittyOptions.Enabled = KittyUICancelOptions.Enabled
		KittyOptions.DoubleCrits = KittyUICancelOptions.DoubleCrits
		KittyOptions.OnlyPlay5 = KittyUICancelOptions.OnlyPlay5
		KittyOptions.Channel = KittyUICancelOptions.Channel
	else
		-- Looks like the user closed Interface Options without even getting to the Hear Kitty options, so do nothing.
	end
end

function KittyUI_OnDefaults()
	-- Reset all Hear Kitty options to their defaults.
	KittyResetOptions()
	KittyUI_OnShow()
end

function KittyUIFrame_EnableSoundsCheck_OnClick()
	KittyEnable(KittyUIFrame_EnableSoundsCheck:GetChecked())
	if KittyOptions.Enabled then
		KittyUIFrame_DisabledWarningLabel:Hide()
	else
		KittyUIFrame_DisabledWarningLabel:Show()
	end
	-- Play a sound to illustrate the effects of this option.
	if KittyOptions.Enabled then
		KittyStopTimer()
		KittyCurrentMaxStacks = 5
		if KittyOptions.OnlyPlay5 then
			KittyPlayOneSound(5, true)
		else
			KittyPlayOneSound(0, true)
		end
	end
end

function KittyUIFrame_SoundPackDropDown_Initialize()
	local Options, _
	for _, Options in pairs(KittyGetSoundPacks()) do
		UIDropDownMenu_AddButton({
			func = KittyUIFrame_SoundPackDropDown_ItemClicked,
			value = Options.Name,
			text = Options.LocalizedName,
		})
	end
end

function KittyUIFrame_SoundPackDropDown_ItemClicked(self)
	KittySelectSoundPack(self.value)
	UIDropDownMenu_SetSelectedValue(KittyUIFrame_SoundPackDropDown, self.value)
	KittyUIFrame_SoundPackCreditsLabel:SetText(KittyGetSelectedSoundPackCredits())
	-- Play sounds to help them pick the right one.
	KittyStopTimer()
	KittyCurrentMaxStacks = 5
	KittyPlaySoundRange(1, 5)
end

function KittyUIFrame_UseEffectsChannelCheck_OnClick()
	if KittyUIFrame_UseEffectsChannelCheck:GetChecked() then
		KittySetSoundChannel("SFX")
	else
		KittySetSoundChannel("Master")
	end
	-- Play a sound to illustrate the effects of this option.
	if KittyOptions.Enabled then
		KittyStopTimer()
		KittyCurrentMaxStacks = 5
		if KittyOptions.OnlyPlay5 then
			KittyPlayOneSound(5)
		else
			KittyPlayOneSound(0)
		end
	end
end

function KittyUIFrame_DoubleCritsCheck_OnClick()
	KittyEnableDoubleCrits(KittyUIFrame_DoubleCritsCheck:GetChecked())
	-- Play a sound to illustrate the effects of this option.
	if KittyOptions.Enabled then
		KittyStopTimer()
		KittyCurrentMaxStacks = 5
		if KittyOptions.DoubleCrits then
			KittyPlaySoundRange(1, 2)
		else
			KittyPlayOneSound(2)
		end
	end
end

function KittyUIFrame_OnlyPlay5Check_OnClick()
	KittyEnableOnlyPlay5(KittyUIFrame_OnlyPlay5Check:GetChecked())
	if KittyOptions.OnlyPlay5 then
		KittyUIFrame_DoubleCritsCheck:Disable()
	else
		KittyUIFrame_DoubleCritsCheck:Enable()
	end
	-- Play a sound to illustrate the effects of this option.
	if KittyOptions.Enabled then
		KittyStopTimer()
		KittyCurrentMaxStacks = 5
		if KittyOptions.OnlyPlay5 then
			KittyPlayOneSound(5)
		else
			KittyPlaySoundRange(1, 5)
		end
	end
end

------------------------------------------------------------
-- Other Hear Kitty UI methods
------------------------------------------------------------

-- Shows a tooltip for a given control if available.
-- The tooltip used will be the string with the name of the control plus "_Tooltip" on the end.
-- The title of the tooltip will be the text on a control with the same name plus "_Label" on the
-- end if available, or otherwise the actual text on the control if there is any.  If the tooltip text
-- OR title is missing, no tooltip is displayed.
function KittyUI_TooltipOn(this)
	local TooltipText = getglobal(this:GetName() .. "_Tooltip")
	if TooltipText then
		local Label
		local FontString = getglobal(this:GetName() .. "_Label")
		if FontString then
			Label = FontString:GetText()
		elseif this.GetText and this:GetText() then
			Label = this:GetText()
		end
		if Label then
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:AddLine(Label, 1, 1, 1, 1)
			GameTooltip:AddLine(TooltipText, nil, nil, nil, 1, 1)
			GameTooltip:Show()
		end
	end
end

-- Hides the game tooltip.
function KittyUI_TooltipOff()
	GameTooltip:Hide()
end
