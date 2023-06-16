;========================================================================
; 	STARTUP SECTION
;========================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 2
CoordMode, Pixel, Screen

HasVal(haystack, needle) {
    for index, value in haystack
        if (value = needle)
            return index
    if !(IsObject(haystack))
        throw Exception("Bad haystack!", -1, haystack)
    return 0
}

masterarray := ["3840 x 2160","2560 x 1600","2560 x 1440","2048 x 1536","1920 x 1440","1920 x 1200","1920 x 1080","1680 x 1050","1600 x 1200","1600 x 1024","1600 x 900","1440 x 900","1366 x 768","1360 x 768","1280 x 1024","1280 x 960","1280 x 800","1280 x 768","1280 x 720"]
xarray := [3840,2560,2560,2048,1920,1920,1920,1680,1600,1600,1600,1440,1366,1360,1280,1280,1280,1280,1280]
yarray := [2160,1600,1440,1536,1440,1200,1080,1050,1200,1024,900,900,768,768,1024,960,800,768,720]
BaseX1 := 0.461
BaseX2 := 0.471
BaseY := 0.684

gosub, inicheck
Return

;========================================================================
; 	SUBROUTINE SECTION
;========================================================================

inicheck:
if fileexist("FishingSettings.ini")
	{
		if (if InStr(fileexist("FishingSettings.ini"), "R"))
			{
			
			settingsstatus := 2
			gosub, SettingsRead
			if Hidestartup = 0
				{
				msgbox, 
			 (
			File is Read Only settings CANNOT be changed
Resolution :	%mp%
Interact Keybind:	%it%
		
Controls:
F4:		Fish once
F5:		Toggle fishing loop
F9:		Display current settings
F10:		Change settings
Home:		Force quit
			)
				}
			else
				{
				}
			return
			}
		else
			{
			settingsstatus := 1
			gosub, SettingsRead
			if Hidestartup = 0
				{
				gosub, currentsettingsdisplay
				}
			else
				{
				}
			return
			}
	}
else
	{
		msgbox Settings file does not exist, Starting setup
		gosub, defaultsetting
		gosub, settingsgui
		return
	}
return

defaultsetting:
gosub, defaultreso
gosub, defaultinteract
Return

defaultreso:
resox:= A_screenwidth
resoy:= A_screenHeight
nm := HasVal(masterarray, A_ScreenWidth " x " A_ScreenHeight)
gosub, setguicurrent
Return

defaultinteract:
it := "e"
Return

setguicurrent:
mp := masterarray[nm]
resox := xarray[nm]
resoy := yarray[nm]
gosub, scancalc
Return

scancalc:
mathx1 := BaseX1 * resox
mathx2 := BaseX2 * resox
mathy := BaseY * resoy
locationX1 := round(mathx1)
locationX2 := round(mathx2)
locationY := round(mathy)
Return

SettingsWrite:	
IniWrite, %resox%, FishingSettings.ini, Resolution, Resofullx
IniWrite, %resoy%, FishingSettings.ini, Resolution, Resofully
IniWrite, %nm%, FishingSettings.ini, Resolution, Resofullpointer
Iniwrite, %mp%, FishingSettings.ini, Resolution, Resoscreen
Iniwrite, %it%, FishingSettings.ini, Keybinds, Interact
Iniwrite, %Hidestartup%, FishingSettings.ini, Prefrences, Hidestartup
Return

SettingsRead:
iniread, resox, FishingSettings.ini, Resolution, Resofullx
iniread, resoy, FishingSettings.ini, Resolution, Resofully
iniread, nm, FishingSettings.ini, Resolution, Resofullpointer
iniread, mp, FishingSettings.ini, Resolution, Resoscreen
iniread, it, FishingSettings.ini, Keybinds, Interact
iniread, Hidestartup, FishingSettings.ini, Prefrences, Hidestartup, 0
gosub, setguicurrent
Return

fish:
	
send %it%
sleep 100
Send % "{" it " down}"
sleep 2000
Send % "{" it " up}"
sleep 500
loop
	{
	PixelSearch, x, y, locationX1, locationY, locationX2, locationY, 0xffffff,, Fast
	found := !ErrorLevel
	If !found
	sleep 100
	}
Until found
Send % "{" it " down}"
sleep 500
Send % "{" it " up}"
sleep 1500
Return
	
;========================================================================
; 	GUI SECTION
;========================================================================

currentsettingsdisplay:
msgbox, 
(
Resolution :	%mp%
Interact Keybind:	%it%
		
Controls:
F4:		Fish once
F5:		Toggle fishing loop
F9:		Display current settings
F10:		Change settings
Home:		Force quit
)
Return



settingsgui:
Gui Add, Text, x35 y8 w55 h23 +0x200, Resolution:
Gui Add, DropDownList, x120 y8 w90 +altsubmit choose%nm% vnm, 3840 x 2160|2560 x 1600|2560 x 1440|2048 x 1536|1920 x 1440|1920 x 1200|1920 x 1080|1680 x 1050|1600 x 1200|1600 x 1024|1600 x 900|1440 x 900|1366 x 768|1360 x 768|1280 x 1024|1280 x 960|1280 x 800|1280 x 768|1280 x 720
Gui Add, Button, x220 y7 w50 h23 , Auto
Gui Add, Text, x35 y40 w72 h16 +0x200, Interact:
Gui Add, Edit, x120 y40 w150 h21 vit, %it%
Gui Add, CheckBox,x35 y72 Checked%Hidestartup% vHidestartup , Hide prompts on start up
Gui Add, Button, x32 y98 w102 h24 , Reset all
Gui Add, Button, x168 y98 w102 h24 , Cancel
Gui Add, Button, x32 y124 w239 h24 +Default, Save

Gui Show, w300 , Settings
Return
	
ButtonSave:
gui, Submit
gosub, setguicurrent
gosub, currentsettingsdisplay
gosub, SettingsWrite
Gui, Destroy
Return
	
ButtonCancel:
Gui, Cancel
Gui, Destroy
return

ButtonAuto:
gosub, defaultreso
gui, destroy
gosub, settingsgui
return

ButtonResetAll:
gosub, defaultreso
gui, destroy
gosub, settingsgui
return

GuiClose:
Gui, Cancel
Gui, Destroy
return

GuiEscape:
Gui, Cancel
Gui, Destroy
Return

Return
	
;========================================================================
; 	FUNCTION SECTION
;========================================================================
	
F4:: ;run once

gosub, fish

Return

F5:: ;loop fishing

Toggle := !Toggle
loop
	{
    If not toggle
		{
		break
		}
	else
		{
		gosub, fish
		}
	}
Return


F10::

If (settingsstatus > 1)
	{
	if (if InStr(fileexist("FishingSettings.ini"), "R"))
	{
	msgbox, 
(
Settings are set to READ ONLY, settings cannot be changed
Resolution :	%mp%
Interact Keybind:	%it%
)
	}
	else
	{
	settingsstatus :=1
	gosub, settingsgui
	}
	return
	}
Else	
	{
	gosub, settingsgui
	}

	
Return

F9::
gosub, currentsettingsdisplay
Return

Home::
Exitapp
return
