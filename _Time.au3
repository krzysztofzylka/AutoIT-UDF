#include-once
#include <Date.au3>
#include <String.au3>

#cs Function List
	_Time_FullGTM() - Czas GTM
	_Time() - Czas w sekundach
#ce Function List

; #INDEX# =======================================================================================================================
; Title .........: Czas GTM
; Description ...: Zwraca czas w GTM np. Sat, 09 Sep 2018 08:36:05 GMT
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _Time_FullGTM()
	Local $mon[] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
	Local $day[] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fir", "Sat"]
	Local $tLocal = _Date_Time_GetLocalTime()
	Local $tSystem = _Date_Time_TzSpecificLocalTimeToSystemTime(DllStructGetPtr($tLocal))
	Local $data = _StringExplode(_Date_Time_SystemTimeToDateTimeStr($tSystem), " ")
	Local $date = _StringExplode($data[0], "/")
	Local $wday = _DateToDayOfWeek($date[2], $date[0], $date[1])
	Return $day[Int($wday) - 1] & ", " & $date[1] & " " & $mon[Int($date[0])] & " " & $date[2] & " " & $data[1] & " GMT"
EndFunc   ;==>_Time_FullGTM

; #INDEX# =======================================================================================================================
; Title .........: Czas w sekundach
; Description ...: Zwraca czas w sekundach (od 01/01/1970 00:00:00)
; Author(s) .....: Krzysztof Żyłka
; ===============================================================================================================================
Func _Time()
	Local $tLocal = _Date_Time_GetLocalTime()
	Local $tSystem = _Date_Time_TzSpecificLocalTimeToSystemTime(DllStructGetPtr($tLocal))
	Local $data = _StringExplode(_Date_Time_SystemTimeToDateTimeStr($tSystem), " ")
	Local $date = _StringExplode($data[0], "/")
	Return _DateDiff('s', '1970/01/01 00:00:00', $date[2] & '/' & $date[0] & '/' & $date[1] & ' ' & $data[1])
EndFunc   ;==>_Time
