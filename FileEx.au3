#include-once
#include <String.au3>
#include <Array.au3>

#cs Function List
	_FileEx_GetMimeType - Zwraca typ mime pliku
	_FileEx_GetExtension - Zwrócenie rozszerzenia pliku
	_FileEx_GetFileName - Zwraca nazwę pliku ze ścieżki
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

; #FUNCTION# ====================================================================================================================
; Name ..........: _FileEx_GetFileName
; Description ...: Zwraca nazwę pliku ze ścieżki
; Syntax ........: _FileEx_GetFileName($path)
; Parameters ....: $path - pełna ścieka
; Return values .: string
; @error ........: 1 - brak nazwy pliku w ścieżce
; ===============================================================================================================================
Func _FileEx_GetFileName($path)
	If Not StringInStr($path, ".") Then Return SetError(1)
	$path = StringReplace($path, "\", "/")
	$path = _StringExplode($path, "/")
	Return $path[UBound($path)-1]
EndFunc