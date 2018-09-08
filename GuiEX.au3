#cs Function List
	_GuiEX_SetGuiChild - Dodanie GUI do innego GUI
#ce Function List

; #INDEX# =======================================================================================================================
; Title .........: Dodanie GUI do innego GUI
; Description ...: Dodanie GUI do innego GUI
; Author(s) .....: Krzysztof Żyłka
; DLL's .........: user32
; ===============================================================================================================================
Func _GuiEX_SetGuiChild($hChild, $hParent)
	DllCall("user32.dll", "int", "SetParent", "hwnd", WinGetHandle($hChild), "hwnd", WinGetHandle($hParent))
EndFunc