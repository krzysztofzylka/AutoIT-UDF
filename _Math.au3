#cs Function List
	_Math_SquareField - pole kwadratu
	_Math_GetPercent - procent jakiej jednej liczby jest druga
	_Math_ByteTransform - Zamiana bitów na większe jednostki
#ce Function List

; #INDEX# =======================================================================================================================
; Title .........: Pole kwadratu
; Description ...: Pole kwadratu
; Author(s) .....: Krzysztof Żyłka
; Error .........: 1 - bok nie moze byc mniejszy lub równy 0
; ===============================================================================================================================
Func _Math_SquareField($side)
	If $side <= 0 Then Return SetError(1)
	Return $side * $side
EndFunc   ;==>_Math_SquareField

; #INDEX# =======================================================================================================================
; Title .........: Procent
; Description ...: Zwraca procent której jednej liczby jest liczba druga
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _Math_GetPercent($int1, $int2)
	Return ($int2 * 100) / $int1
EndFunc   ;==>_Math_GetPercent

; #INDEX# =======================================================================================================================
; Title .........: Zamiana bitów na większe jednostki
; Description ...: Zamiana bitów na większe jednostki
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _Math_ByteTransform($bytes)
	If Not IsInt($bytes) Then Return False
	Local $count = 0, $str = ""
	Local $arr[] = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']
	While $bytes > 1023
		$count += 1
		$bytes /= 1024
	WEnd
	If $count < UBound($arr) Then $str = " " & $arr[$count]
	Return $bytes & $str
EndFunc   ;==>_Math_ByteTransform
