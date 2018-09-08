#include <Array.au3>

#cs Function List
	_String_GenerateString - Generowanie ciągu znaków
	_String_Trim - Czyszczenie ciągu
#ce Function List

; #INDEX# =======================================================================================================================
; Title .........: Generowanie ciągu znaków
; Description ...: Zwraca wygenerowany ciąg znaków
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _String_GenerateString($charcount = 10)
	Local $string = Null, $chr = Null
	Local $char[] = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm']
	For $i = 1 To $charcount
		$chr = $char[Random(0, Round(UBound($char)))]
		If Round(Random()) == 1 Then $chr = StringUpper($chr)
		$string &= $chr
	Next
	Return $string
EndFunc   ;==>_String_GenerateString

; #INDEX# =======================================================================================================================
; Title .........: Czyszczenie ciągu
; Description ...: Usuwa zbędne znaki ze zmiennej
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _String_Trim($string)
	Local $chr[] = ["  ", " ", @CRLF, @CR, @LF, @TAB]
	If _ArraySearch($chr, StringLeft($string, 1)) > -1 Then $string = StringRight($string, StringLen($string) - 1)
	If _ArraySearch($chr, StringRight($string, 1)) > -1 Then $string = StringLeft($string, StringLen($string) - 1)
	Return $string
EndFunc