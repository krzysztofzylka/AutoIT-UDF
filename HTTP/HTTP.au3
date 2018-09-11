#include-once
#include "../IP.au3"
#include "../_Time.au3"
#include "../FileEx.au3"
#include <String.au3>
#include <Array.au3>

#Region Global variable
Global $_HTTP_Socket = Null ;Socket serwera
Global $_HTTP_IP, $_HTTP_Port ;adres ip oraz port
Global $_HTTP_MaxClient = 150, $_HTTP_CountClient = 0 ;maksymalna ilosc uzytkownikow i zliczanie podlaczonych
Global $_HTTP_MaxLen = 1028 * 128 ;maksymalna ilosc odebranych danych w bitach (128kb)
Global $_HTTP_Client[$_HTTP_MaxClient][2] ;tablica z uzytkownikami
Global $_HTTP_ServerName = "AutoIT/HTTP/0.1Alpha" ;nazwa serwera
Global $_HTTP_Location = ""
Global $_HTTP_ScriptDir = Null ;nazwa folderu z kodem do wysłania dla klienta
#EndRegion Global variable

#cs Function List
	_HTTP_ServerStart - Uruchamianie serwera HTTP
	_HTTP_SetConnection - Zmiana adresu IP oraz Portu dla serwera
	_HTTP_MainLoop - Główna pętla wykonująca polecenia
	_HTTP_MainUserLoop - Główna funkcja oczekująca na użytkowników

	__HTTP_SendDataMain - Główna funkcja wysyłająca informacje do klienta
	_HTTP_SendData - Główna funkcja wysyłająca dane do przeglądarki klienta
	_HTTP_SendFile - Główna funkcja wysyłająca plik do przeglądarki klienta

	_HTTP_CloseSerwer - Wyłączenie serwera
#ce Function List

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_SetConnect
; Description ...: Zmiana adresu IP oraz Portu dla serwera
; Syntax ........: _HTTP_SetConnect()
; Parameters ....:
; Return values .: bool
; @error ........: 1 - Błędny adres IP
;				   2 - Błędy port
; ===============================================================================================================================
Func _HTTP_SetConnection($ip, $port = 80)
	If $ip == "localhost" Then $ip = "127.0.0.1"
	If _IP_check($ip) == False Then Return SetError(1)
	If $port < 0 Or $port > 65535 Then Return SetError(2)
	$_HTTP_IP = $ip
	$_HTTP_Port = $port
EndFunc   ;==>_HTTP_SetConnection

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_ServerStart
; Description ...: Uruchamianie serwera HTTP
; Syntax ........: _HTTP_ServerStart()
; Parameters ....:
; Return values .: bool
; @error ........: 1 - Błąd uruchamiania serwera TCP
;				   2 - Błędny adres IP
;				   3 - Błędy port
; ===============================================================================================================================
Func _HTTP_ServerStart()
	If $_HTTP_Socket <> Null Then Return False
	TCPStartup()
	If @error Then Return SetError(1)
	$_HTTP_Socket = TCPListen($_HTTP_IP, $_HTTP_Port)
	If Not @error Then
		Return True
	Else
		Switch @error
			Case 1
				Return SetError(2)
			Case 2
				Return SetError(3)
		EndSwitch
	EndIf
EndFunc   ;==>_HTTP_ServerStart

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_MainLoop
; Description ...: Główna pętla wykonująca polecenia
; Syntax ........: _HTTP_MainLoop()
; Parameters ....:
; Return values .:
; @error ........:
; ===============================================================================================================================
Func _HTTP_MainLoop()
	If $_HTTP_Socket == Null Then Return
	For $x = 0 To $_HTTP_MaxClient - 1
		If $_HTTP_Client[$x][0] == Null Then Return
		If $_HTTP_Client[$x][0] < 0 Then Return
		Local $bufor = TCPRecv($_HTTP_Client[$x][0], $_HTTP_MaxLen)
		If @error Then
			$_HTTP_Client[$x][0] = Null
			$_HTTP_CountClient -= 1
		Else
			__HTTP_SendDataMain($_HTTP_Client[$x][0], $bufor)
		EndIf
	Next
EndFunc   ;==>_HTTP_MainLoop

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_MainUserLoop
; Description ...: Główna funkcja oczekująca na użytkowników
; Syntax ........: _HTTP_MainUserLoop()
; Parameters ....:
; Return values .: <bool> / <int> 503
; @error ........:
; ===============================================================================================================================
Func _HTTP_MainUserLoop()
	If $_HTTP_Socket == Null Then Return
	Local $Sock = TCPAccept($_HTTP_Socket)
	If $Sock < 0 Then Return
	If $_HTTP_CountClient < $_HTTP_MaxClient Then
		For $x = 0 To $_HTTP_MaxClient - 1 Step 1
			If $_HTTP_Client[$x][0] = Null Then
				$_HTTP_Client[$x][0] = $Sock
				$_HTTP_CountClient += 1
				Return True
				ExitLoop
			EndIf
		Next
	Else
		;send error 503
		Return 503
	EndIf
EndFunc   ;==>_HTTP_MainUserLoop

; #FUNCTION# ====================================================================================================================
; Name ..........: __HTTP_SendDataMain
; Description ...: Główna funkcja wysyłająca informacje do klienta
; Syntax ........: __HTTP_SendDataMain($socket, $data)
; Parameters ....: $socket - socket TCP
;				   $data - dane HTTP
; Return values .:
; @error ........:
; ===============================================================================================================================
Func __HTTP_SendDataMain($socket, $data)
	If $data == "" Then Return False
	Local $temp = _StringExplode($data, @CRLF)
	Local $header[1][2]
	$header[0][1] = $temp[0]
	For $x = 0 To UBound($temp) - 1
		$exp = _StringExplode($temp[$x], ": ", 2)
		If UBound($exp) >= 2 Then
			Local $add_id = _ArrayAdd($header, "")
			$header[$add_id][0] = $exp[0]
			$header[$add_id][1] = $exp[1]
		EndIf
	Next
	Local $method = _StringExplode($temp[0], " ")[0]
	If $method <> "POST" And $method <> "GET" Then Return
	Local $file = _StringExplode($temp[0], " ")[1]
	If $file = "/" Then $file = "index.html"
	$file = $_HTTP_ScriptDir & $file
	If $_HTTP_ScriptDir == Null Then Return _HTTP_SendData($socket, "<b>Fatal error!</b><br />You must set dir ($_HTTP_ScriptDir)")
	If Not FileExists($file) Then _HTTP_SendData($socket, "<b>Error 404</b><br />File not found", "text/html", "404 Not Found")
	_HTTP_SendFile($socket, $file)
EndFunc   ;==>__HTTP_SendDataMain

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_SendData
; Description ...: Główna funkcja wysyłająca dane do przeglądarki klienta
; Syntax ........: _HTTP_SendData($hSocket, $bData, $sMimeType, $sReply, $connection)
; Parameters ....: $hSocket - socket TCP
;				   $bData - dane HTTP
;				   $sMimeType - typ mime danych (domyslnie "text/html")
;				   $sReplay - status wysyłania (domyslnie "200 OK")
;				   $connection - co ma sie stac z polaczeniem (domyslnie "close")
; Return values .:
; @error ........:
; ===============================================================================================================================
Func _HTTP_SendData($hSocket, $bData, $sMimeType = "text/html", $sReply = "200 OK", $connection = "close")
	Local $sPacket = Binary("HTTP/1.1 " & $sReply & @CRLF & _
			"Server: " & $_HTTP_ServerName & @CRLF & _
			"Date: " & _Time_FullGTM() & @CRLF & _
			"Allow: POST, GET" & @CRLF & _
			"Connection: " & $connection & @CRLF & _
			"Location: " & $_HTTP_Location & @CRLF & _
			"Content-Lenght: " & StringLen($bData) & @CRLF & _
			"Content-Type: " & $sMimeType & @CRLF & _
			@CRLF)
	TCPSend($hSocket, $sPacket)
	TCPSend($hSocket, $bData)
	If $connection == "close" Then TCPCloseSocket($hSocket)
EndFunc   ;==>_HTTP_SendData

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_SendFile
; Description ...: Główna funkcja wysyłająca plik do przeglądarki klienta
; Syntax ........: _HTTP_SendFile($hSocket, $sFileLoc, $sMimeType, $sReply, $connection)
; Parameters ....: $hSocket - socket TCP
;				   $sFileLoc - nazwa pliku do pobrania dla klienta
;				   $sMimeType - typ mime danych (domyslnie automatyczne dobranie typu Mime)
;				   $sReplay - status wysyłania (domyslnie "200 OK")
;				   $connection - co ma sie stac z polaczeniem (domyslnie "close")
; Return values .:
; @error ........:
; ===============================================================================================================================
Func _HTTP_SendFile($hSocket, $sFileLoc, $sMimeType = Default, $sReply = "200 OK", $connection = "close")
	Local $hFile
	$hFile = FileOpen($sFileLoc, 16)
	$bFileData = FileRead($hFile)
	FileClose($hFile)
	If $sMimeType == Default Then $sMimeType = _FileEx_GetMimeType($sFileLoc)
	_HTTP_SendData($hSocket, $bFileData, $sMimeType, $sReply, $connection)
EndFunc   ;==>_HTTP_SendFile

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_CloseSerwer
; Description ...: Wyłączenie serwera
; Syntax ........: _HTTP_CloseSerwer()
; Parameters ....:
; Return values .:
; @error ........:
; ===============================================================================================================================
Func _HTTP_CloseSerwer()
	TCPShutdown()
	$_HTTP_Socket = Null
	For $x = 0 To $_HTTP_MaxClient - 1
		$_HTTP_Client[$x][0] = Null
	Next
EndFunc