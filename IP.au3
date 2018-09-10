#include-once
#include <String.au3>

#cs Function List
	_IP_check - Sprawdzanie poprawności adresu IP
#ce Function List

; #FUNCTION# ====================================================================================================================
; Name ..........: _IP_check
; Description ...: Sprawdzanie poprawności adresu IP
; Syntax ........: _IP_check($ip)
; Parameters ....:
; Return values .: bool
; ===============================================================================================================================
Func _IP_check($ip)
	$explode = _StringExplode($ip, ".")
	If Not IsArray($explode) Then Return False
	If UBound($explode) <> 4 Then Return False
	For $x = 0 To 3
		If $explode[$x] > 255 Or $explode[$x] < 0 Then Return False
	Next
	Return True
EndFunc