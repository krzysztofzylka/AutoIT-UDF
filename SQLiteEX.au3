#include <SQLite.au3>

; #INDEX# =======================================================================================================================
; Title .........: Polaczenie z baza danych
; Description ...: Laczenie z baza danych i zwracanie danych z _SQLite_Open
; Author(s) .....: Krzysztof Zylka
; ===============================================================================================================================
Func SQLiteEx_Connect($dbPath, $dllPath="")
	_SQLite_Startup($dllPath)
	If @error Then
		MsgBox(16, "Blad bazy danych", "Blad podczas proby polaczenia z baza danych" & @CRLF & "Blad pliku DLL")
		Exit
	EndIf
	ConsoleWrite("Poprawie zainicjonowano sqlite > wersja bazy " & _SQLite_LibVersion() & @CRLF)
	_SQLite_SafeMode(False)
	Local $db = _SQLite_Open($dbPath)
	If @error Then
		MsgBox(16, "Blad bazy danych", "Blad podczas proby polaczenia z baza danych" & @CRLF & "Blad pliku bazy danych" & @CRLF & "Numer bledu: " & @error & @CRLF & "Sciezka bazy danych: " & $dbPath)
		Exit
	EndIf
	Return $db
EndFunc