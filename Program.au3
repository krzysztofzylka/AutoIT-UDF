#cs Function List
	_Program_Restart - resetowanie programu
	_Program_IsRunning - Sprawdzanie czy program jest juz uruchomiony
#ce Function List

; #FUNCTION# ====================================================================================================================
; Name ..........: Resetowanie programu
; Description ...: Resetowanie programu
; Syntax ........: _Program_Restart()
; Parameters ....:
; Return values .:
; ===============================================================================================================================
Func _Program_Restart()
	If @Compiled Then
		Run(FileGetShortName(@ScriptFullPath))
	Else
		Run(FileGetShortName(@AutoItExe) & " " & FileGetShortName(@ScriptFullPath))
	EndIf
	Exit
EndFunc   ;==>_KyluProgram_Restart

; #FUNCTION# ====================================================================================================================
; Name ..........: Sprawdzanie czy program jest juz uruchomiony
; Description ...: Sprawdzanie czy program jest juz uruchomiony
; Syntax ........: _Program_IsRunning()
; Parameters ....:
; Return values .: bool
; ===============================================================================================================================
Func _Program_IsRunning()
	Local $list = ProcessList()
	For $x = 0 To UBound($list) - 1
		If $list[$x][0] = @ScriptName Then
			Return True
		EndIf
	Next
	Return False
EndFunc   ;==>_KyluProgram_IsRunning