#include <Array.au3>
#include <_String.au3>

#Region Global Function
Global $_Stack[0][2]
#EndRegion Global Function

#cs Function List
	_Stack_create - Tworzenie stosu
	_Stack_push - Dodawanie elementu do stosu
	_Stack_isEmpty - Sprawdzenie czy stos jest pusty
	_Stack_pop - Pobieranie elementu
#ce Function List

; #FUNCTION# ====================================================================================================================
; Name ..........: Tworzenie stosu
; Description ...: Tworzenie stosu
; Syntax ........: _Stack_create()
; Parameters ....:
; Return values .: string - stack ID
; ===============================================================================================================================
Func _Stack_create()
	Local $name = Null
	While True
		$name = StringLower(_String_GenerateString(15))
		If _ArraySearch($_Stack, $name) == -1 Then ExitLoop
	WEnd
	Local $temp[0]
	Local $add_id = _ArrayAdd($_Stack, $name)
	$_Stack[$add_id][1] = $temp
	Return $name
EndFunc   ;==>_Stack_create

; #FUNCTION# ====================================================================================================================
; Name ..........: Dodawanie elementu
; Description ...: Dodawanie elementu do stosu
; Syntax ........: _Stack_push($stack, $value)
; Parameters ....: $stack - ID stosu
; 				   $value - wartość dodanego elementu
; Return values .: bool
; @error ........: 1 - wybrany stos nie istnieje
; ===============================================================================================================================
Func _Stack_push($stack, $value)
	Local $search = _ArraySearch($_Stack, $stack)
	If $search == -1 Then Return SetError(1)
	_ArrayAdd($_Stack[$search][1], $value)
EndFunc   ;==>_Stack_push

; #FUNCTION# ====================================================================================================================
; Name ..........: Sprawdzenie czy stos jest pusty
; Description ...: Sprawdzenie czy stos jest pusty
; Syntax ........: _Stack_isEmpty($stack)
; Parameters ....: $stack - ID stosu
; Return values .: bool
; @error ........: 1 - wybrany stos nie istnieje
; ===============================================================================================================================
Func _Stack_isEmpty($stack)
	Local $search = _ArraySearch($_Stack, $stack)
	If $search == -1 Then Return SetError(1)
	If UBound($_Stack[$search][1]) > 0 Then Return False
	Return True
EndFunc   ;==>_Stack_isEmpty

; #FUNCTION# ====================================================================================================================
; Name ..........: Pobieranie elementu
; Description ...: Pobieranie ostatnio dodanego elementu ze stosu
; Syntax ........: _Stack_pop($stack)
; Parameters ....: $stack - ID stosu
; Return values .: string
; @error ........: 1 - wybrany stos nie istnieje
;				   2 - stos jest pusty
; ===============================================================================================================================
Func _Stack_pop($stack)
	Local $search = _ArraySearch($_Stack, $stack)
	If $search == -1 Then Return SetError(1)
	If _Stack_isEmpty($stack) == True Then Return SetError(2)
	Local $stack_arr = $_Stack[$search][1]
	$read = $stack_arr[UBound($stack_arr) - 1]
	_ArrayDelete($_Stack[$search][1], UBound($stack_arr) - 1)
	Return $read
EndFunc   ;==>_Stack_pop
