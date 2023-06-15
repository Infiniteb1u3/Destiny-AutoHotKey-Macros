#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 2
CoordMode, Pixel, Screen

Home:: Exitapp ; Force kills the script

`:: Pause, Toggle
Return



F4::

farbe := 0
send {e}
sleep 100
send {e down}
sleep 2000
send {e up}
sleep 500
loop
{
PixelGetColor, farbe, 891, 738
}
Until farbe = 0xFFFFFF
send {e down}
sleep 500
send {e}
Return

F5::

Toggle := !Toggle
loop
	{
    If not toggle
		{
		break
		}
	else
		{
		farbe := 0
		send {e}
		sleep 100
		send {e down}
		sleep 2000
		send {e up}
		sleep 500
		loop
			{
			PixelGetColor, farbe, 891, 738
			}
		Until farbe = 0xFFFFFF
		send {e down}
		sleep 500
		send {e}
		sleep 1500
		}
	}
Return

F8::

Toggle := !Toggle
loop 5
	{
    If not toggle
		{
		break
		}
	else
		{
		farbe := 0
		send {e}
		sleep 100
		send {e down}
		sleep 2000
		send {e up}
		sleep 500
		loop
			{
			PixelGetColor, farbe, 891, 738
			}
		Until farbe = 0xFFFFFF
		send {e down}
		sleep 500
		send {e}
		sleep 1500
		}
	}
Return
