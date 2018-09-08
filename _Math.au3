#cs Function List
	_Math_SquareField - pole kwadratu
	_Math_GetPercent - procent jakiej jednej liczby jest druga
#ce Function List

; #INDEX# =======================================================================================================================
; Title .........: Pole kwadratu
; Description ...: Pole kwadratu
; Author(s) .....: Krzysztof Żyłka
; Error .........: 1 - bok nie moze byc mniejszy lub równy 0
; ===============================================================================================================================
Func _Math_SquareField($side)
	If $side <= 0 Then Return SetError(1)
	Return $side*$side
EndFunc

; #INDEX# =======================================================================================================================
; Title .........: Procent
; Description ...: Zwraca procent której jednej liczby jest liczba druga
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _Math_GetPercent($int1, $int2)
	Return ($int2 * 100) / $int1
EndFunc   ;==>_KyluInt_GetPercent