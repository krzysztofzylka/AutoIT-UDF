#cs Function List
	_String_GenerateString - Generowanie ciągu znaków
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
