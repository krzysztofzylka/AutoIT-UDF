#cs Function List
	_EMail_Check - Sprawdzenie e-mail
#ce Function List

; #INDEX# =======================================================================================================================
; Title .........: Sprawdzenie e-mail
; Description ...: Sprawdzenie poprawności adresu e-mail
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _EMail_Check($email)
	Local $check = StringRegExp($email, "^([a-zA-Z0-9_\-])([a-zA-Z0-9_\-\.]*)@(\[((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}|" & _
			"((([a-zA-Z0-9\-]+)\.)+))([a-zA-Z]{2,}|(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\])$")
	If $check = 1 Then Return True
	Return False
EndFunc