#include <String.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _NBP_Rates
; Description ...: Średni kurs walut wg. NBP
; Syntax ........: _NBP_Rates($code)
; Parameters ....: $code            - kod ISO 4217 waluty (https://en.wikipedia.org/wiki/ISO_4217#Active_codes)
; Return values .: int
; ===============================================================================================================================
Func _NBP_Rates($code)
	$read = BinaryToString(InetRead("http://api.nbp.pl/api/exchangerates/rates/A/"&$code&"/"))
	$read = _StringBetween($read, '"mid":', "}]}")
	If Not IsArray($read) Then Return False
	Return $read[0]
EndFunc