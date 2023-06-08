#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 2

; KEY ASSIGNMMENT

sh:= "click" ; shoot
ad:= "click down right" ; Aim down sight start
us:= "click up right" ; Aim down sight stop
re:= "r" ; "Reload"
gn:= "q" ; Grenade
ml:= "v" ; Charged melee Ability
ca:= "c" ; Class Ability (Rift, dodge, Barricade)

Home:: Exitapp ; Force kills the script
`:: Pause, Toggle

f5:: ; proxy knife radiant hunter

loop
{
send, %ml%
Sleep 300
Send {a down}
sleep 2000	
send {a up}
sleep 1000
send, %ml%
sleep 400
Send {s down}
sleep 3000
send {s up}
}

Return

F8:: ; Fusion Ashen Wake Titan

loop
{
send, %gn%
Sleep 300
Send {a down}
sleep 2000	
send {a up}
sleep 1000
send, %gn%
Sleep 300
Send {s down}
sleep 2000
send {s up}
sleep 1000
}

Return

f9:: ; arc warlock

loop
	{
	send, %gn%
	sleep 3400
	send, %ca%
	Send {s down}
	sleep 3400
	send {s up}
	send, %ml%
	Send {a down}
	sleep 3400
	send {a up}
	}
Return
