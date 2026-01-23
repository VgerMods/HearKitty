# Hear Kitty

Hear Kitty plays soothing and distinct orchestral sounds as you gain and spend your combat resources. It's like having your own theme music! You'll hear tones as you gain combo points or stacks of your buffs, and when you hear the final note played, you'll know it's time for a finishing move. Never watch for little red dots or buff stacks again!

These classes and specs work with Hear Kitty:

* Unholy death knights: Shadow Infusion (Classic)
* Balance druids: astral power (Classic)
* Feral druids: combo points
* Evokers: essence
* Marksmanship hunters: Ready, Set, Aim, and Fire! (Classic)
* Arcane mages: arcane charges (Classic)
* Fire mages: Blessing of the Sun King (Classic)
* Frost mages with Glacial Spike: icicles (Classic)
* Monks: chi and Teachings of the Monastery (Classic)
* Paladins: holy power
* Discipline priests: evangelism (Classic)
* Shadow priests: insanity (Classic) and shadow orbs (Classic)
* Rogues: combo points
* Elemental and Enhancement shamans: maelstrom (Classic) and Rolling Thunder (Classic)
* Warlocks: soul shards
* Vehicles with combo points (such as the drakes in Eye of Eternity)

## Installing

Hear Kitty is installed like any other World of Warcraft addon. If you're not using a tool to manage your addons, extract the HearKitty folder from the zip file to your addons folder, which will be in a location like one of these:

```
C:\Users\Public\Games\World of Warcraft\_retail_\Interface\AddOns
C:\Program Files\World of Warcraft\_retail_\Interface\AddOns
C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns
```

### Installing sound packs

You can get new sound packs to change the sounds that Hear Kitty makes. They're installed like your other mods (including Hear Kitty), and once you install them, you can find them in Hear Kitty's options in the Interface Options window.

* [Find more sound packs on CurseForge](https://www.curseforge.com/wow/addons/hear-kitty-alt-volume)

## Contacting the author

* [See all of my addons](https://www.vgermods.com)
* You can reach me on [Facebook](https://www.facebook.com/vgermods)
* Leave a comment on [CurseForge](https://www.curseforge.com/wow/addons/hear-kitty)
* Email vger at vgermods.com

## Hear Kitty Options

To change Hear Kitty options, open Interface Options, click the AddOns tab, and then choose Hear Kitty from the list.

### Play sounds

You can disable all Hear Kitty sounds by unchecking this option.

### Sound pack

If you install additional Hear Kitty sound packs, you can choose which set of sounds you'd like to hear from this list. 

### Control Hear Kitty sound volume the same as in-game sounds

Normally, Hear Kitty sounds will play even if game sounds are disabled, and they ignore the Sound effects volume setting, so you can only control the volume with the Master volume slider. Enable this option to make Hear Kitty respect the volume settings for in-world sound effects.

### Only play a tone when resource is maxed

Check this option to cause Hear Kitty to skip the sounds for combo points 1-4 so you only hear a sound when your combo points are maxed out.

### Play multiple tones on a crit

Certain talents can cause you to score two combo points instead of one when you crit with an ability. By default, Hear Kitty will play both sound effects when this happens. For example, if you had one combo point already, and then got a crit that scored you two combo points, you'd normally hear the "two combo points" sound quickly followed by the "three combo points" sound. With this option checked (the default), you'd hear both sounds. If you uncheck it, you'll only hear the "three combo points" sound in this situation.

## Slash commands

Hear Kitty supports a couple slash commands that you can use in macros.

### Showing the Hear Kitty configuration UI

Use `/hearkitty` to go directly to the Hear Kitty options panel, without having to find it in Interface Options. 

### Turning Hear Kitty sounds on or off entirely

Use `/hearkitty off` to turn off all Hear Kitty sounds. Use `/hearkitty on` to turn them back on. (This is the same as the "Play sounds" checkbox in the Hear Kitty options.)

## Customizing Hear Kitty

There are a couple things that you can do to customize Hear Kitty to your liking.

### Changing the volume

By default, the volume of Hear Kitty's sounds is controlled by the Master Volume setting on the Sound options screen, and Hear Kitty sounds will play even if in-game sounds are muted. You can raise or lower the volume of music and ambience to make Hear Kitty's sound quieter or louder, depending on your preference. If you'd like Hear Kitty to respect your in-game sound volume settings, check the "Control Hear Kitty sound volume the same as in-game sounds" option in the Hear Kitty options.

There is also a sound pack available for download at [CurseForge](https://www.curseforge.com/wow/addons/hear-kitty-alt-volume) that includes both quieter and louder versions of the Symphony sound pack that you can select from the Hear Kitty options once it's installed.

### Developing your own sound packs

If you'd like to develop your own sound pack for Hear Kitty, [fork this template repo on GitHub](https://github.com/VgerMods/HearKitty_SoundPackTemplate) and use it as a starting point. (Or, just use the Download button there or browse the files manually.)

* Rename the folder and .toc file to the same thing. I suggest "HearKitty_" and then the name of your sound pack.
* Edit the .toc file to give your sound pack a friendly and recognizable name.
* Edit the .lua file to give your sound pack two names: an "internal" name that never shows up in the UI, and the localized name that your users will see. Both should be unique.
* You can also choose how the Hear Kitty options will credit you when the user selects your sound pack.
* Change the paths in the .lua file to point to your sound pack's sound files. For best results, save the sounds in Ogg Vorbis (.ogg) format and put them in the same folder as your sound pack, or a subfolder. (However, World of Warcraft also supports .wav and .mp3 sounds.) You can convert a wide variety of different sound files to Ogg Vorbis files, as well as adjust volume and perform other edits, using the free [Audacity](http://audacity.sourceforge.net/download/) software. (There are many different free sound editors available.)
* After you've done all that, you'll have a folder containing a WoW addon that adds new sounds to Hear Kitty. Put that folder in with your other addons.
* Then, start up WoW, and your new addon should be ready for use. When you log into a character and then go to the Hear Kitty options, you'll see it there.

### Disabling Hear Kitty sounds when you're in a raid

Another one of Vger's mods, "Gyro: Get Your Raid On!", lets you set up macros that are run whenever you join or leave a raid. If you want to set up Hear Kitty so that sounds don't play when you're in a raid, first download Gyro from your favorite mod site (or [vgermods.com](https://www.vgermods.com/)). Then, add `/hearkitty off` to your GyroStartRaid macro, and `/hearkitty on` to your GyroEndRaid macro. For more information, see the readme that comes with the Gyro mod.

## Release history

### Version 1.12.3

### Version 1.12.2

* The War Within and Midnight: Hear Kitty no longer supports balance druids, shadow priests, or elemental shamans due to the new Midnight restrictions on addons providing combat help.

### Version 1.12.1

* Slightly improved addon loading time.
* Hear Kitty will look a little nicer in your addons list now.

### Version 1.12.0

* Midnight: Hear Kitty now works on Midnight and the 12.0 pre-patch. Midnight no longer allows addons to know about the state of your buffs and debuffs during combat, so some specs that Hear Kitty supported in earlier versions of the game such as frost mages with the Glacial Spike talent will no longer work in Midnight.

### Version 1.11.5

* Added a new Russian translation provided by ZamestoTV. (Thanks!)

### Version 1.11.4

* The War Within: For enhancement shamans, Hear Kitty will now play tones at 5 (minimum), 8 (lowest recommended), and 10 (ideal / max) stacks of Maelstrom Weapon instead of 1-5.

### Version 1.11.3

* The War Within: Fixed problems where druid talents like Convoke the Spirits could cause Hear Kitty to play sounds for combo points and astral power changes at unhelpful times. (Thanks Amadeus!)

### Version 1.11.2

* The War Within: Updated Teachings of the Monastery to stack 4 times. (Thanks Cullen!)

### Version 1.11.1

* The War Within: Hear Kitty is now available again in the game's Interface Options.

### Version 1.11.0

* The War Within and Cataclysm Classic: Hear Kitty now functions in these game versions.
* Cataclysm Classic: Added support for unholy death knights, balance druids, marksmanship hunters, paladins, discipline and shadow priests, and elemental and enhancement shamans.

### Version 1.10.6

* Dragonflight: Fixed a problem that could occur when showing Hear Kitty's version number on 10.1.0.

### Version 1.10.5

* Dragonflight: Sounds for paladins now work again in Dragonflight 10.1.

### Version 1.10.4

* Added support for fire mages' Blessing of the Sun King talent.

### Version 1.10.3

* Added support for mistweaver monks' Teachings of the Monastery talent, contributed by Erica. Thanks!

### Version 1.10.2

* Fixed a bug that I introduced in version 1.10.1 that caused Hear Kitty to no longer work for rogues and druids. Oops.

### Version 1.10.1

* Added support for evokers! (If you only want to use Hear Kitty on some of your characters and not others, you can turn the sounds on and off for each character in Options > AddOns > Hear Kitty.)

### Version 1.10.0

* For the first time ever, Hear Kitty comes with a new sound pack called Marcato! Marcato has more unique sounds than Symphony (the old default sound pack) in much higher audio quality.
    * If you decide that you'd like to go back to the old sounds, they're still available—install the [Hear Kitty official sound packs](https://www.curseforge.com/wow/addons/hear-kitty-alt-volume). Then, you can select Symphony from the Hear Kitty options in Interface Options.
    * Quiet and Loud versions of Marcato will be included in the official sound packs download at a future date.

### Version 1.9.6

* Added support for resources that stack 7 times, such as Subtlety rogues with the Deeper Strategem talent in Dragonflight / 10.0. (Thanks to cybern4ut for help testing.)
* When using a sound pack that doesn't support resources that count up to 3, 4, 6, or 7, Hear Kitty will now try to pick a different sound from that sound pack instead of playing the default "Symphony" sounds. (So, if there's an old sound pack you like, but it was made before rogues could have 7 combo points, you can keep using it without updating.)

### Version 1.9.5

* Added support for Maelstrom Weapon for enhancement shamans playing Wrath of the Lich King Classic.

### Version 1.9.4

* Added support for Burning Crusade Classic.

### Version 1.9.3

* Added support for Balance Druid, contributed by Hear Kitty fan Erica.

### Version 1.9.2

* Added support for the returning Maelstrom Weapon ability for enhancement shamans.

### Version 1.9.1

* WoW Classic: Worked around an incompatibility that was causing players to get an error message referencing PLAYER_SPECIALIZATION_CHANGED if they had another addon that was interfering with Hear Kitty.

### Version 1.9.0

* Hear Kitty now works in WoW Classic! (Thanks to GH05TWARR10R for help testing.)

### Version 1.8.3

* Fixed a problem where Hear Kitty wasn't working for frost mage Icicles, and was working differently than intended for shadow priests. (Special thanks to chiburrito!)

### Version 1.8.2

* Fixed a variety of errors and missing sounds for different classes and specs.

### Version 1.8.1

* Tones will now play sooner for elemental shamans, with the final tone playing at 60 Maelstrom when Earth Shock and Earthquake become available.

### Version 1.8

* Includes changes to allow Hear Kitty to work on Battle for Azeroth.

### Version 1.7.6

* When using the rogue talent Anticipation, and spending combo points when you have excess combo points in reserve (the smaller dots), Hear Kitty will now play tones as if you spent your 5 points and then immediately got new ones from your reserves. For example, if you had 8 combo points and then spent 5 of those, you'd hear the "finisher" (zero) tone, and then one, then two, then three.

### Version 1.7.5

* Fix for an error that would occur with the rogue talent Anticipation as of patch 7.1.5.
    * Anticipation still doesn't play as many sounds as I'd like—I'm still looking into that.

### Version 1.7.4

* Frost mages: Added support for Icicles when the Glacial Spike talent is chosen.

### Version 1.7.3

* Shadow priests: Tones will no longer play during Voidform, since your Insanity increases and decreases so frequently in that state.
* Shadow priests: I changed the Insanity thresholds at which tones will play to better work with the Legacy of the Void talent. The fourth tone will now play at 70 Insanity when Voidform activates with the talent, and the fifth plays at 100 when Insanity is capped.
* Elemental shamans: I changed the Maelstrom thresholds at which tones will play to convey more useful information. The first tone will now play at 20 Maelstrom when Flame Shock and Frost Shock are at their maximum power, and the second tone will now play at 50 Maelstrom when Earthquake activates.

### Version 1.7.2

* Removed support for WoW 6.2.x. This version should be slightly faster than the previous version.

### Version 1.7.1

* Fixed a problem where Hear Kitty was playing unnecessary sounds for rogues and feral druids on live realms.

### Version 1.7

This version is compatible with both the live 6.2.x realms and the Legion beta. (It will show up as "out of date" on the beta but it should work properly after you click the option to load out-of-date addons.)

* Adjusted the way that Hear Kitty tracks combo points on the Legion beta so that it will work again for feral druids and rogues.
* Added support for the new Maelstrom resource for elemental and enhancement shamans on the Legion beta. Support for lightning shield charges and Maelstrom Weapon charges is still in place for when using Hear Kitty on the live realms.
* Added support for the new Insanity resource for shadow priests on the Legion beta. Support for shadow orbs is still in place for when using Hear Kitty on the live realms.
* Added support for the sorta-new Soul Shards resource for all warlock specs on the Legion beta. Support for burning embers is still in place for when using Hear Kitty on the live realms.
* Adjusted the way that Hear Kitty tracks Arcane Charges on the Legion beta so that it will work again for arcane mages.
* Adjusted the way that Hear Kitty tracks combo points on the Wyrmrest Skytalon drakes in the Aces High! quest in Borean Tundra (and presumably also in Eye of Eternity) on the beta so that it will work again.
* The Hear Kitty features for Evangelism for discipline priests, Unholy Transformation for unholy death knights, and Frenzy for beast mastery hunters are no longer relevant on the Legion beta, so those specs will no longer play any tones on the beta.
* The Hear Kitty features for Holy Power for paladins and Chi for monks appear to be working with no necessary changes on the Legion beta.

### Version 1.6.2

* If you have Lightning Shield stacks up or any other counter that Hear Kitty tracks, Hear Kitty will now avoid playing an Inception-like musical blast right when you log in.
* For elemental shamans who are level 92+ and have learned Improved Lightning Shield, the final tone now isn't played until the 20th stack (up from 15).

### Version 1.6.1

* For rogues and cat form druids, Hear Kitty will no longer play lots of extra tones while your combo points decay on your target.

### Version 1.6

* Updated for WoW 6.0 and Warlords of Draenor.
* Added support for beast mastery hunters' Frenzy buff and Focus Fire ability.
* Elemental shamans' lightning shield charges now stack to 15, so Hear Kitty will play tones at 5, 10, 13, 14, and 15 charges.
* Removed code for marksmanship hunters' Ready, Set, Aim and Fire! buffs, since they've been removed from the game.

### Version 1.5.3

* For Arcane Charges, Hear Kitty will play the proper tones. (Previously it treated Arcane Charges as if they counted to six; now it counts to four.)

### Version 1.5.2

* Fixed a bug where Hear Kitty could repeatedly play sounds when the "only play a sound when the resource is maxed" option is on, if you played a class where the resource being tracked was a buff (like Maelstrom Weapon).

### Version 1.5.1

* Fixed a bug where Hear Kitty would play extra sounds for shadow priests if they had previously been discipline spec.

### Version 1.5

* All Hear Kitty features, classes, and specs should now work for German, Spanish, French, Portuguese, and Russian players. Those languages also include a machine-translated UI. Some Hear Kitty features (but not all classes and specs) will work in other languages.
    * If you have any suggestions or corrections to the existing machine translations, or would like to translate Hear Kitty into a different language, please let me know!
* Added support for arcane mages (Arcane Charge stacks).
* Changed the way that holy power and chi work: previously Hear Kitty would not play a sound when spending only 1 of those resources, since it can't tell the difference between a resource that was spent and one that expired. That behavior was weird for Tiger Palm, which costs 1 chi and is used frequently. The new behavior is that Hear Kitty will continue to play sounds when 1 chi is lost if you're in combat, or if it was your last chi, but not if you're out of combat and you still have some chi left. This behavior should be more pleasant and predictable.
* Hear Kitty will no longer play sounds for gaining and losing holy power, chi, and shadow orbs when your level is too low to use those resources.
* Hear Kitty will no longer play sounds during the preparation phase of a battleground or arena.
* Fixed a bug where Hear Kitty would play sounds even when its sounds were disabled for classes other than druid and rogue.

### Version 1.4.3

* Updated the monk support for patch 5.1. (Chi used to be called "Light force" in the Blizzard code and that's what Hear Kitty tracked. Now it's called a more sensible "Chi".)

### Version 1.4.2

* Hear Kitty will no longer play sounds for guardian druids who get Lightning Shield from a shaman through Symbiosis. (Please consider this bug payback for all those times I got your stupid Prowl ability in return.)
* Updated Ready, Set, Aim... (marksmanship hunters) for 5.0 so that it properly counts to 3 stacks now.

### Version 1.4.1

* Changed the behavior of Holy Power and Chi and other resources that decay over time) so that their sound effects won't slowly count down when you're just soloing, waiting for the tank to pull, or otherwise letting your resources decay, since probably you're already annoyed by not killing things and Hear Kitty reminding you that you haven't killed things in a while is extra annoying.

### Version 1.4

* This version of Hear Kitty is for World of Warcraft 5.0 only. It will not work properly for all classes and specs on old versions of World of Warcraft.
* Changes were made to the following classes and specs to make them work in 5.0:
    * Shadow priests (didn't work at all in 5.0 since shadow orbs are now a resource and not a buff)
    * Elemental shamans (didn't play the correct sounds in 5.0 since Lightning Shield stacks to 7 and not 9)
    * Paladins (holy power now holds 5 charges instead of 3)
    * Warlocks (new support for burning embers in Hear Kitty 1.4) (special thanks to Derrek-Cairne)
    * Monks, all specs (new support for the chi resource in Hear Kitty 1.4)
* Note that older Hear Kitty sound packs will not work properly for elemental shamans and monks when using Hear Kitty 1.4. Be sure to upgrade your sound packs too!

### Version 1.3.2

* Now plays the finishing (drums) sound again when Dark Transformation ends on an unholy death knight's ghoul.

### Version 1.3.1

* Fixed a minor bug that could occur when spellstealing a buff from an NPC that had the same name as one that Hear Kitty normally tracks (such as Lightning Shield) but more charges than the normal player version (such as 20).

### Version 1.3

* Added support for unholy death knights (Shadow Infusion stacks on ghouls).
* Added support for elemental shamans (extra Lightning Shield charges due to Rolling Thunder, starting at the fifth stack).
* Added support for discipline priests (Evangelism stacks). Only stacks of Evangelism are counted, not Dark Evangelism. The tones for the stacks are played regardless of whether Archangel is off cooldown.
* Added support for shadow priests (Shadow Orb stacks).
* Added support for marksmanship hunters (Ready, Set, Aim... and Fire! stacks).
* When you choose a new sound pack and then later uninstall that sound pack, Hear Kitty will now return to the default set of sounds (Symphony) instead of failing to play any sounds at all.

### Version 1.2.1

* Fixed a bug where the currently selected sound pack would sometimes appear as "Custom" when opening the Hear Kitty options.
* Sound pack authors can now have their names appear in the Hear Kitty options when the sound pack is selected.

### Version 1.2

* Hear Kitty now supports installable sound packs to customize the Hear Kitty sounds to your liking without having to manually replace files each time you update Hear Kitty. You can change your sound pack in the Hear Kitty options.
* Added a new option to let you control the volume and muting of Hear Kitty sounds using the in-game Sound Effects volume settings. This was the behavior of Hear Kitty since patch 4.0 until now. This option is off by default, so the Sound Effects volume and muting settings don't affect Hear Kitty, which was the behavior before patch 4.0.
* Fixed some minor UI issues that occurred when clicking Cancel in the Hear Kitty options.

### Version 1.1.8

* The "only play a sound at five combo points" option has been renamed and also now allows you to set up Hear Kitty so that it only plays a tone when you reach three Holy Power, and stays silent on the first two charges.

### Version 1.1.7

* Fixed an error message that occurred if you tried to set Hear Kitty options and hadn't gained any combo points yet since logging in.
* Increased the volume of the sound effects.

### Version 1.1.6

* Supports the paladin resource of Holy Power, and plays sound effects for holy power charges as if they were combo points.
* Worked around the problem on WoW 4.0 where sounds would play extremely quietly.

### Version 1.1.5

* Update for the Cataclysm beta and the 4.0 PTR.

### Version 1.1.4

* Fixed the sporadic issue some people were experiencing with Hear Kitty getting randomly turned off after using the Interface Options window.

### Version 1.1.3

* Supports the enhancement shaman ability Maelstrom Weapon, and plays sound effects for maelstrom charges as if they were combo points.
* Added an option to only play a tone when hitting 5 combo points (or MW charges), rather than for each combo point 1-4.

### Version 1.1.2

* Added support for vehicles and mounts with combo points. The only quest that I'm aware of where you use such a vehicle is [Aces High!](http://www.wowhead.com/?quest=13414), but there may be more.)

### Version 1.1.1

* Updated for patch 3.0.

### Version 1.1

* Hear Kitty now has a UI for changing options in the AddOns section of Interface Options. You can also get to it by typing /hearkitty.
* Now supports playing a longer string of sound effects on when gaining more than two combo points. For example, if you had one combo point and gained three more from one attack, sounds 2, 3, and 4 would be played by default.
* Now supports talents that give you a combo point on a finishing move (Ruthlessness). For example, if you had two combo points and then did a finishing move that gave you a bonus combo point, sounds 0 and 1 would be played by default.
* Fixed an occasional bug where if you gained two combo points in rapid succession but not at the exact same time, the two sounds would play at the same time and sound like a single chord.

### Version 1.0.1

* Now displays a more readable error message when the embedded mod VgerCore is missing or failed to load.

### Version 1.0

* Hear Kitty is now version 1.0! It now includes VgerCore 1.0 embedded within the mod, so you don't need a separate VgerCore folder in your AddOns folder.

### Version 0.2.1

* Now checks to make sure that a usable version of VgerCore is installed when Hear Kitty is loaded.
* Localization changes to make it easier to translate Hear Kitty into another language.

### Version 0.2

* Added support for playing both sounds when you score two combo points on a critical hit. See **/hearkitty double crits** under "Slash commands" for more information.

### Version 0.1

* Initial released version, compatible with patch 2.0.

---
by Vger-Azjol-Nerub—[www.vgermods.com](https://www.vgermods.com)

© 2006-2026 Travis Spomer. This mod is released under the Creative Commons [Attribution-NonCommercial-NoDerivs 3.0](http://creativecommons.org/licenses/by-nc-nd/3.0) license. By using the mod you agree to the terms of the license.
