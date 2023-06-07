#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Home:: Exitapp ; Force kills the script

F5:: ; tractor cannon

loop 21
{
		Send {click}
		Sleep 9900
}

Return

F7:: ; Darci Jolt with pulse nades needs artifact grenade recharge
Toggle := !Toggle
send {click down right}
loop
	{
    If not toggle
        {
		break
		}
	else
		loop 6
		{
		Send {click}
		Sleep 8800
		}
		
		Send {click}
		sleep 500
		send {r}
		send {click up right}
		Sleep 3500
		send {click down right}
		Sleep 4500
		send {q}
		sleep 8800
	}
Return

F8:: ; Darci Jolt
Toggle := !Toggle
send {click down right}
loop
	{
    If not toggle
        {
		break
		}
	else
		sleep 900
		loop 6
		{
		Send {click}
		Sleep 8800
		}
		
		Send {click}
		sleep 500
		send {r}
		send {click up right}
		Sleep 3500
		send {click down right}
		Sleep 4500
	
	}
Return

F9:: ; Wither only

Toggle := !Toggle

loop
	{
    If not toggle
        {
		break
		}
	else
		Sleep 500
		Send {click}
		Sleep 500
		Send {2}
		Sleep 1000
		Send {Click}
		Sleep 500
		Send {1}
		Sleep 5000
	}
Return

F10:: ; Wither with smoke 100 STR with 3 melee kick start hunters

Toggle := !Toggle

loop
	{
    If not toggle
        {
		break
		}
	else
		loop 5
		{
		Sleep 500
		Send {click}
		Sleep 500
		Send {2}
		Sleep 1000
		Send {Click}
		Sleep 500
		Send {1}
		Sleep 5000
		}
		sleep 500
		send {click}
		sleep 500
		send {2}
		sleep 500
		send {v} ; melee key
		sleep 500
		send {click}
		Sleep 500
		Send {1}
		Sleep 5000
	}
Return





