#include-once
#include <Constants.au3>

#cs Function List
	_CMD - Wykonywanie komendy w konsoli
#ce Function List

; #INDEX# =======================================================================================================================
; Title .........: Wykonywanie komendy w konsoli
; Description ...: Wykonywanie komendy w konsoli i zwraca orzymaną wartość
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _CMD($command)
	Local $iPID = Null, $sOutput = Null
	$iPID = Run(@ComSpec & " /c " & $command, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	While Not @error
		Sleep(10)
		$sOutput &= StdoutRead($iPID, False, False)
	WEnd
	If ProcessExists($iPID) Then ProcessClose($iPID)
	Return $sOutput
EndFunc   ;==>_CMD
