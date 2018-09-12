#include-once
#include <String.au3>
#include <Array.au3>

#cs Function List
	_FileEx_GetMimeType - Zwraca typ mime pliku
	_FileEx_GetExtension - Zwrócenie rozszerzenia pliku
#ce Function List

; #FUNCTION# ====================================================================================================================
; Name ..........: _FileEx_GetMimeType
; Description ...: Zwraca typ mime pliku
; Syntax ........: _FileEx_GetMimeType($file)
; Parameters ....: $file - nazwa pliku
; Return values .: string
; ===============================================================================================================================
Func _FileEx_GetMimeType($file)
	Local $extension = _FileEx_GetExtension($file)
	Local $mime_list[][2] = [['txt', 'text/plain'], ['htm', 'text/html'], ['html', 'text/html'], ['js', 'application/javascript'], ['css', 'text/css'], ['png', 'image/png'], ['jpe', 'image/jpeg'], ['jpeg', 'image/jpeg'], ['jpg', 'image/jpeg']]
	$search = _ArraySearch($mime_list, $extension)
	If $search > -1 Then Return $mime_list[$search][1]
	Return Null
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _FileEx_GetExtension
; Description ...: Zwrócenie rozszerzenia pliku
; Syntax ........: _FileEx_GetExtension($file)
; Parameters ....: $file - nazwa pliku
; Return values .: string
; ===============================================================================================================================
Func _FileEx_GetExtension($file)
	Local $explode = _StringExplode($file, ".")
	Return $explode[UBound($explode)-1]
EndFunc