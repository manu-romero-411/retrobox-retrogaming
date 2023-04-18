#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#Include XInput.ahk 

XInput_Init()
Loop {
    If State := XInput_GetState(0) {
        If (State.wButtons&XINPUT_GAMEPAD_A) {
            Send, a
	        return
        }
    }
    Sleep, 100
}